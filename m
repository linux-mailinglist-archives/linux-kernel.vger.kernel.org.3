Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11BF578001
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiGRKnn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Jul 2022 06:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiGRKnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:43:41 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91AB31EC5E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:43:34 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2044.outbound.protection.outlook.com [104.47.22.44]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-lQ7POjJ9OjKiaGcSFSrp1Q-2; Mon, 18 Jul 2022 12:43:31 +0200
X-MC-Unique: lQ7POjJ9OjKiaGcSFSrp1Q-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0253.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:28::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Mon, 18 Jul 2022 10:43:29 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%8]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 10:43:29 +0000
Date:   Mon, 18 Jul 2022 12:43:28 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: gpio: stmpe: Remove node name
 requirement
Message-ID: <20220718104328.GA18450@francesco-nb.int.toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-4-francesco.dolcini@toradex.com>
In-Reply-To: <20220712163345.445811-4-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::31) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec061669-4ac4-4df9-450b-08da68aa5a63
X-MS-TrafficTypeDiagnostic: ZRAP278MB0253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: wN41uCMDgXs+6xMxOBAH/LkJ2AV+fpk5oCrCFqRk2p0rWMJpAf+4SDh+17QI77ydhqiYocMg0L8sxRoTV6qHl/1qh330qavbUZWfI1aLhSr6k2WR9wQ+kO2AGoNa2TaHMpOaaCBtBM2Opfy2k3y+cBGKz8iOs4lSj9V50TD8ujvEb9pMdsZLlwiIYfcAuzkQApiLcBC9ELuU4vbTQz6P45HKUH/V8AwbZEk/Vd0QogB2NglwsAYeQNdFHqyEMZfZ4jwt6max8sQhqWlZC+/rUOT9V+9WwtZ9znfS81jQD0rQGyYFRF+2yLqN4WIvNxolKVAt1Av9U3KnyoG+gANxmISMbmpkaHWDGIsYppIHwRIDZaYcS7ujUBS8qJzMRFyQk84xF+EEXB/V97+DNzWkgyFxwYfecpUuliKfu3MJ9t5kZkMncKshrGyqDQzZiHRS3YCvc0ZBTs9Q+OZEks/JZpexbYm281DCQkPcwpoetKFxafcRp5CfW8piEPy+DrTU9HuzjSQVjF8antOHt/6BlDx0kVyKX5gIvT/GFSIxeCPZFynvtKrvRh3uPkgkcW1UzB83y1m+Ll9rASYoqiki7fIqs5/gYvob5KAoSCpRCSifhKGtZKUXR8oRTj5o8NcaukOROT3yuwWXgHTh35gV8OH/s5j3PwMbrFxlthcWDaExwTJ/AJ5yPJtGd1KIb0yN7WTEEeaUjL8hunpcR1zxCBeK1R38h7kyvXIQIYbZQOB8oVcNecnYjx18WDOp0wkflWvGBbpQ6LBxiaDFDDfchJTnfF0PmRUi8q9GaHWqIt8SGVTPPfUfI8t2JCgHwrQwgq+PO4qzmoCOgTU9p5aWYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(39840400004)(376002)(966005)(186003)(83380400001)(66476007)(4326008)(110136005)(66556008)(66946007)(316002)(8676002)(54906003)(8936002)(6506007)(2906002)(52116002)(86362001)(6512007)(5660300002)(6486002)(1076003)(41300700001)(4744005)(44832011)(33656002)(26005)(7416002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DI42IpsX/NUGs6rDnzLC1Oxw/h3AUC6xslAaVK3P7qGivCDLiiK58MEYXUP5?=
 =?us-ascii?Q?qHngdHZ4Oobb1bWQaBk+cqxXcplM3/0Db4TkOc8zoUsVHKGoIk0ekjVd4Vv6?=
 =?us-ascii?Q?vHM3/CKEtH9JR6fuG/zOt7hdJNt2p4WQCP8yNmxwEhFjigq8Erkv57xgK40V?=
 =?us-ascii?Q?Hr3GiyV9QZPe/H54ibcAmvjYxtNr8PgCOFj70YertqKLtj0ZhSNOnbwtZLbr?=
 =?us-ascii?Q?HxyMkO0TS7DUEX6gJSaBLNWPN3FzEaLl4cuBi1qaqOEKxA91K0t82Ob5Bksh?=
 =?us-ascii?Q?j0d7mrXoNw+xx4phPm+ORkWvsLYUjjZGjTKrGKe1Pez4mIZBe3TbNipsuS/P?=
 =?us-ascii?Q?k+z5EAJvMVtw7yG2cEjPsXVYW9tqLV+8aQG28QDBTMVYLmYutegat+Jr/Sa+?=
 =?us-ascii?Q?QCIcInwqqO3n4G6EwuCXwCWVR8+gPd3th6tYOuHe60JfobTjCHzWBLiMhYdr?=
 =?us-ascii?Q?amEdZitmRCg7Kynsl2N7AWlMTFwUA7w92sGAjiwLSmIjpbYJF2GaXN3LgovS?=
 =?us-ascii?Q?Wz14d7s+ntYqfRSwClnWju6JjIFiJrmfUv+Lma3sVSPacizBpqSCZdzNXjHS?=
 =?us-ascii?Q?J+zqvsGRflUHc4WrFC7eKyYM1rvxB9jY6kagr/ym6BDZjaFZd50bfDQRJQPQ?=
 =?us-ascii?Q?xAOh+eaRC/J+BbtMCy6jVBqlL/cfYy1EAYBvDmxWFg8ie6cx6CmmEAeYQggH?=
 =?us-ascii?Q?ZKYUokhgNICVVX2VMM76ItJV/uWA88FN0mf8UEyzusJ26Oqwv0W7DHg6k4VF?=
 =?us-ascii?Q?0A4FMTfPGt8dSpZoowj3SNs/hbpAaP+Hltvbe/P+RWiMmGY/o2r3OHou2G1B?=
 =?us-ascii?Q?y1B8fdawJjBgTiNnuIcTu0U2wvGIWr0eW1rNoJM9hhyOd/HF2sjVQaaBSFS2?=
 =?us-ascii?Q?Z+VChbU7HMocMenambEaO+5Rryz4Okgf0JTzLpwSRiu2nPyEIa9tECyS/S8j?=
 =?us-ascii?Q?lHTwEx3YrRVtcVqQ7y4UgWBHLd1MPyfX3xNrKkHRx9SCiHW+A1zcEo+4nLkV?=
 =?us-ascii?Q?Px/xh/OyxV9nN6wzTkZPQ7Q2VcmSWIF+QiGCywSX05l4cmneTfStBHVTA0U4?=
 =?us-ascii?Q?NVmAPU/mZ0hW1osPfMeb6BjHp/N5rzw1Kdg2Ybbhqp06xbmDbt0GpGvcB926?=
 =?us-ascii?Q?vFupUwrK/kxxBNd84yeUWHSPu3vXxeCsHFwI5ujHarGXj3SZtFCYJw/oSga6?=
 =?us-ascii?Q?YsW2OPyRCikMuxkWXmaaxMioC/yPeOIlVgsxoHf2ptGU2NMRYJjGi+VZw2l+?=
 =?us-ascii?Q?avoYotuhZ5vDOuwM3mbJ3Y6B8nlUrB/IqsrkjV1hfxfYoxDdeuijAMVAJNb0?=
 =?us-ascii?Q?bEHRiZcvN1mHupx9WigIhqX7oFxTAZe8DbL9Sb8759Uu8T1ohbzrR7U/LHSz?=
 =?us-ascii?Q?MGLts5gb/PWIqwNMSYekSlzP8KrBc1Onhw2kBkPjtJzGBoWxUcCUEXbozj1X?=
 =?us-ascii?Q?K9i820THqHd40JpfXKGBDU5jvVtf8yy4nnKxjj/Lupc9rmqW8T4roKYgzGCB?=
 =?us-ascii?Q?GinPzK08YaNOLtcJKh1gN0qMkuhhFWOkHmtckB4+Tj+YFCovLBLFL9f8zVax?=
 =?us-ascii?Q?ZVtcGd1Ifn/4STcUKqimd6zK3fCk/7hO3aBe+0V/Kug63c4sGXeU5+qe6DO8?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec061669-4ac4-4df9-450b-08da68aa5a63
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 10:43:29.7155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oBhnJb1jNO/FdaJk+sEAIW2JpJ5sExObE15Nkxz24quzfy2/UqGzN425aPkZRG/2q3JMNEToSgvSB1Gvtfsn0T3X/QQIcXaSDct0FVAzms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0253
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 06:33:43PM +0200, Francesco Dolcini wrote:
> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

from v1 https://lore.kernel.org/all/CACRpkdZDRjadHc4TBHouWPSYhLoCAynXzKejKi+H98C5ioCW6A@mail.gmail.com/

