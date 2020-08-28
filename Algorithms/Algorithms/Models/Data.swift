//
//  Data.swift
//  Algorithms
//
//  Created by Даниил Храповицкий on 04.08.2020.
//

import Foundation

let whatAreAlgorithms = """
Алгоритм — это некоторая последовательность операций для достижения какого-то результата. Например, рецепт приготовления блинов — это тоже алгоритм! 
"""


let carouselDataTypes: [HomeListType] = [
    HomeListType(name: "Массивы", image: "[ ]", isSystemImage: false, color: .red),
    HomeListType(name: "Очереди", image: "square.3.stack.3d", isSystemImage: true, color: .blue),
    HomeListType(name: "Списки", image: "arrow.right.arrow.left", isSystemImage: true, color: .green),
    HomeListType(name: "Деревья", image: "arrow.triangle.branch", isSystemImage: true, color: .purple),
    HomeListType(name: "Хэш-таблицы", image: "number", isSystemImage: true, color: .pink),
    HomeListType(name: "Множества", image: "list.number", isSystemImage: true, color: .orange),
    HomeListType(name: "Графы", image: "arrow.2.squarepath", isSystemImage: true, color: .yellow),
]

let infoDataStructures: [HomeListType] = [
    HomeListType(name: "Что такое структуры данных?", image: "info.circle", isSystemImage: true, color: .blue),
    HomeListType(name: "Организация данных", image: "arrow.down.to.line", isSystemImage: true, color: .red),
]

let arraysTypes: [HomeListType] = [
    HomeListType(name: "Двумерный массив", image: carouselDataTypes[0].image, isSystemImage: carouselDataTypes[0].isSystemImage, color: carouselDataTypes[0].color),
    HomeListType(name: "Bit Set", image: carouselDataTypes[0].image, isSystemImage: carouselDataTypes[0].isSystemImage, color: carouselDataTypes[0].color),
    HomeListType(name: "Массив фиксированного размера", image: carouselDataTypes[0].image, isSystemImage: carouselDataTypes[0].isSystemImage, color: carouselDataTypes[0].color),
    HomeListType(name: "Отсортированный массив", image: carouselDataTypes[0].image, isSystemImage: carouselDataTypes[0].isSystemImage, color: carouselDataTypes[0].color),
]

let queuesType: [HomeListType] = [
    HomeListType(name: "Стек", image: carouselDataTypes[1].image, isSystemImage: carouselDataTypes[1].isSystemImage, color: carouselDataTypes[1].color),
    HomeListType(name: "Очередь", image: carouselDataTypes[1].image, isSystemImage: carouselDataTypes[1].isSystemImage, color: carouselDataTypes[1].color),
    HomeListType(name: "Двусвязная очередь", image: carouselDataTypes[1].image, isSystemImage: carouselDataTypes[1].isSystemImage, color: carouselDataTypes[1].color),
    HomeListType(name: "Приоритетная очередь", image: carouselDataTypes[1].image, isSystemImage: carouselDataTypes[1].isSystemImage, color: carouselDataTypes[1].color),
    HomeListType(name: "Циклический буфер", image: carouselDataTypes[1].image, isSystemImage: carouselDataTypes[1].isSystemImage, color: carouselDataTypes[1].color),
]

let listsType: [HomeListType] = [
    HomeListType(name: "Список", image: carouselDataTypes[2].image, isSystemImage: carouselDataTypes[2].isSystemImage, color: carouselDataTypes[2].color),
    HomeListType(name: "Список с пропусками", image: carouselDataTypes[2].image, isSystemImage: carouselDataTypes[2].isSystemImage, color: carouselDataTypes[2].color),
]

let treesType: [HomeListType] = [
    HomeListType(name: "Дерево", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Двоичное дерево", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Двоичное дерево поиска", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Красно-черное дерево", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Splay-дерево", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Прошитое двоичное дерево", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Дерево отрезков", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Разреженная таблица", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Куча", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Фибоначчива куча", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Префиксное дерево", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "B-дерево", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Дерево квадрантов", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
    HomeListType(name: "Октодерево", image: carouselDataTypes[3].image, isSystemImage: carouselDataTypes[3].isSystemImage, color: carouselDataTypes[3].color),
]

let hashesType: [HomeListType] = [
    HomeListType(name: "Хэш-таблица", image: carouselDataTypes[4].image, isSystemImage: carouselDataTypes[4].isSystemImage, color: carouselDataTypes[4].color),
    HomeListType(name: "Хэш-функция", image: carouselDataTypes[4].image, isSystemImage: carouselDataTypes[4].isSystemImage, color: carouselDataTypes[4].color),
]

let setsType: [HomeListType] = [
    HomeListType(name: "Множество", image: carouselDataTypes[5].image, isSystemImage: carouselDataTypes[5].isSystemImage, color: carouselDataTypes[5].color),
    HomeListType(name: "Мультимножество", image: carouselDataTypes[5].image, isSystemImage: carouselDataTypes[5].isSystemImage, color: carouselDataTypes[5].color),
    HomeListType(name: "Частично упорядоченное множество", image: carouselDataTypes[5].image, isSystemImage: carouselDataTypes[5].isSystemImage, color: carouselDataTypes[5].color),
    HomeListType(name: "Фильтр Блума", image: carouselDataTypes[5].image, isSystemImage: carouselDataTypes[5].isSystemImage, color: carouselDataTypes[5].color),
]

let graphsType: [HomeListType] = [
    HomeListType(name: "Граф", image: carouselDataTypes[6].image, isSystemImage: carouselDataTypes[6].isSystemImage, color: carouselDataTypes[6].color),
    HomeListType(name: "Поиск в глубину", image: carouselDataTypes[6].image, isSystemImage: carouselDataTypes[6].isSystemImage, color: carouselDataTypes[6].color),
    HomeListType(name: "Поиск в ширину", image: carouselDataTypes[6].image, isSystemImage: carouselDataTypes[6].isSystemImage, color: carouselDataTypes[6].color),
    HomeListType(name: "Кратчайший путь", image: carouselDataTypes[6].image, isSystemImage: carouselDataTypes[6].isSystemImage, color: carouselDataTypes[6].color),
    HomeListType(name: "Минимальное остовное дерево", image: carouselDataTypes[6].image, isSystemImage: carouselDataTypes[6].isSystemImage, color: carouselDataTypes[6].color),
]

let infoAlgorithms: [HomeListType] = [
    HomeListType(name: "Что такое алгоритмы?", image: "info.circle", isSystemImage: true, color: .red, text: whatAreAlgorithms),
    HomeListType(name: "Построение алгоритмов", image: "hammer.fill", isSystemImage: true, color: .green),
    HomeListType(name: "Асимптотика алгоритмов", image: "arrow.triangle.pull", isSystemImage: true, color: .yellow),
]

let sortAlgorithms: [HomeListType] = [
    HomeListType(name: "Пузырьковая сортировка", image: "arrow.up.arrow.down", isSystemImage: true, color: .green),
    HomeListType(name: "Сортировка вставками", image: "arrow.up.arrow.down", isSystemImage: true, color: .green),
    HomeListType(name: "Сортировка слиянием", image: "arrow.up.arrow.down", isSystemImage: true, color: .green),
    HomeListType(name: "Быстрая сортировка", image: "arrow.up.arrow.down", isSystemImage: true, color: .green),
    HomeListType(name: "Анти-Быстрая сортировка", image: "arrow.up.arrow.down", isSystemImage: true, color: .green),
    HomeListType(name: "Пирамидальная сортировка", image: "arrow.up.arrow.down", isSystemImage: true, color: .green),
    HomeListType(name: "Сортировска подсчетом", image: "arrow.up.arrow.down", isSystemImage: true, color: .green),
    HomeListType(name: "Поразрядная сортировка", image: "arrow.up.arrow.down", isSystemImage: true, color: .green),
    HomeListType(name: "Топологическая сортировка", image: "arrow.up.arrow.down", isSystemImage: true, color: .green),
]

let searchAlgorithms: [HomeListType] = [
    HomeListType(name: "Линейный поиск", image: "magnifyingglass", isSystemImage: true, color: .blue),
    HomeListType(name: "Двоичный поиск", image: "magnifyingglass", isSystemImage: true, color: .blue),
    HomeListType(name: "K-ая порядковая статистика", image: "magnifyingglass", isSystemImage: true, color: .blue),
]

let stringSearchAlgorithms: [HomeListType] = [
    HomeListType(name: "Простой поиск подстроки в строке", image: "a.magnify", isSystemImage: true, color: .gray),
    HomeListType(name: "Префикс-функция, суффикс-функция и Z-функция", image: "a.magnify", isSystemImage: true, color: .gray),
    HomeListType(name: "Алгоритм Кута — Морисса — Пратта", image: "a.magnify", isSystemImage: true, color: .gray),
    HomeListType(name: "Алгоритм Рабина — Карпа", image: "a.magnify", isSystemImage: true, color: .gray),
    HomeListType(name: "Алгоритм Ахо — Корасик", image: "a.magnify", isSystemImage: true, color: .gray),
    HomeListType(name: "Наибольшая общая последовательность", image: "a.magnify", isSystemImage: true, color: .gray),
]

let graphsAlgorithms: [HomeListType] = [
    HomeListType(name: "Проверки графа", image: "point.fill.topleft.down.curvedto.point.fill.bottomright.up", isSystemImage: true, color: .orange),
    HomeListType(name: "Поиск кратчайшего пути", image: "point.fill.topleft.down.curvedto.point.fill.bottomright.up", isSystemImage: true, color: .orange),
    HomeListType(name: "Поиск кратчафшего пути от каждой вершины до каждой", image: "point.fill.topleft.down.curvedto.point.fill.bottomright.up", isSystemImage: true, color: .orange),
    HomeListType(name: "Построение минимального остовного дерева", image: "point.fill.topleft.down.curvedto.point.fill.bottomright.up", isSystemImage: true, color: .orange),
    HomeListType(name: "Максимальный поток", image: "point.fill.topleft.down.curvedto.point.fill.bottomright.up", isSystemImage: true, color: .orange),
]

let startingAlgorithms: [HomeListType] = [
    HomeListType(name: "Сложение двух чисел", image: "plus", isSystemImage: true, color: .pink),
    sortAlgorithms[0],
    sortAlgorithms[1],
    queuesType[0],
    queuesType[1],
    treesType[1],
    searchAlgorithms[1],
]
