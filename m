Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6C254B467
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356688AbiFNPRQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Jun 2022 11:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFNPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:17:08 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F9A8419A2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:17:07 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2049.outbound.protection.outlook.com [104.47.22.49]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-QW1tHaevPq-LlvItB8SVLA-2; Tue, 14 Jun 2022 17:16:56 +0200
X-MC-Unique: QW1tHaevPq-LlvItB8SVLA-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0030.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:14::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.14; Tue, 14 Jun 2022 15:16:54 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 15:16:54 +0000
Date:   Tue, 14 Jun 2022 17:16:52 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>
Subject: Re: [PATCH v2 00/24] ARM: dts: imx7-colibri: device tree improvements
Message-ID: <20220614151652.GA288006@francesco-nb.int.toradex.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
 <20220611091613.GH254723@dragon>
 <CAL_JsqJ5VhU+_QXejPYRSOpkC8Q=gJ7BzYHwqaTw9Pb1Wa04tg@mail.gmail.com>
In-Reply-To: <CAL_JsqJ5VhU+_QXejPYRSOpkC8Q=gJ7BzYHwqaTw9Pb1Wa04tg@mail.gmail.com>
X-ClientProxiedBy: MR1P264CA0156.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::17) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c297cbf0-9fbe-4367-064b-08da4e18ea11
X-MS-TrafficTypeDiagnostic: ZRAP278MB0030:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB0030C1B44F29B9F018A0A6E2E2AA9@ZRAP278MB0030.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 2x0XfwQicobclF0nIr4ISQtM9shJjyAxRf8L6icQ03IcNk81lwScnqncawC7MGDX49eRuNUSzcCxk1i/XVSCkore0WWaKJtXHHAOE2XG+lmDcsChlK4Ee/gqdArLewfBE+prdkZbWJykJ3CYu8HnzSyM4zPDGmNNS+7Mlq2aZFqQ//c2r97Pia2rD1SqqGcfZbxy5jAO5BnFkefSZ6M4GuY+pIeembSkDEciW2SCVi5mzsF7NYK5gdCsVaYwXKqVxWum8w9SrKbqzLNo9WqY+4BjDfePdWI0kwS+kSQD2srHh1EB1Tk52JdPqVxMwuEn73sDq+mmKzDFQn09mvVmRYmsrWiOwdyQTwKf8c7cWweCeW2nx77nh1jGX8KzrICB1iC+YQaSJ8iJw1HIIZbnm8EYrJkpAcWhMhqFH62YG1Jf4TJNr2QaGXSOBWe/KizdW7eiz1UUHN79bz8lLJ0ki4JGlzfCMT5rQvK98hCDiozvS8IPDV3wNbxlgJ2GVRDDpITXd0cXMhyqlN6hV/hhz9SvB+kFcRmyhILWRGea0m1IkOxXD1s9PuXCB4C16ts36C48qY/JavJTldVXEFAhIb8So80xGOnpkmjGDniZP7JvUwLDca6At6iZX/cj/Rs4vRLXSajr0TlusYJfwGVbT/nZU2xnqJlNE/Um2nDRcmTsbJoWwMeJh/sfEu2QRW01tvVYVpiH7Gwa17WijlI+Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39850400004)(346002)(136003)(396003)(8936002)(66476007)(6486002)(2906002)(66556008)(66946007)(4326008)(8676002)(508600001)(5660300002)(86362001)(44832011)(4744005)(7416002)(33656002)(38350700002)(1076003)(186003)(316002)(6506007)(110136005)(53546011)(52116002)(54906003)(26005)(83380400001)(41300700001)(6512007)(38100700002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BB6Wb3gW/S0BS+bd4fjX+bU5CoGKeA85lcONDVpLyRaQA8rKQzagW1Zr54sB?=
 =?us-ascii?Q?IqYEtgZndKxrIGyIw4eZWW4uh9wQgIQEon4H9Q5xm8ZTc6T+AJa017E06ce7?=
 =?us-ascii?Q?hvGQ80HKs0msXz6gNo+iW89wnQHGV7Yxxav5pklyQAbnU1PNYyI7Suh47qN/?=
 =?us-ascii?Q?16IL+DfkUgocDT++45fUq6hMth/CRF4JtlYkCmZUyEsSWm6tq6YwAgqGNkhI?=
 =?us-ascii?Q?fil33szcN8TBmVnbSmMxvEcC5SI1nbsot6pO0hVhC/elQYBaJezD3Ik57z4y?=
 =?us-ascii?Q?qCEGA7tX809hXMta7yyxzLt9/MxTpE1yUfwPTul9TVa0D5SyJAnVrTLes6DP?=
 =?us-ascii?Q?DRON1bKT9s5iGxAKsQhnbpO1e5FeYJFpiMgXMgtl7/SdbL0x2JUcX3IBWC4u?=
 =?us-ascii?Q?6I60ye6qAQ6Kx1JlgUv67thRXLUA1BXalkINYTXlCZ/5yJMCmw0WFiQLEO84?=
 =?us-ascii?Q?RgQQzjfVhUKV+s5s08KxtoOoEvO+GsGkMLOiwwBG6ZEotYaymcTnMvcrPaR8?=
 =?us-ascii?Q?70uHccFcGOalIGk1QHtbXdp0/ogP7ZJGc6gn5N5/eHFZdhzY9nRv3oWwkSAA?=
 =?us-ascii?Q?xXecEv+cVIQIp6zQKBRVS4J3MpToP7uU5T/Shg5WSCs0TyvO+0ptltCqA42I?=
 =?us-ascii?Q?3m7SfmjavOXTk1dtaDJVdqfPlNen5XedkB/LlUYqIgXOmNqxawg6Wry23xde?=
 =?us-ascii?Q?u8iplZRZJx22r9lmPmo9B0Jaaiogkz9RwH4+l7hqBPF7EhSX58kDySsvwBAB?=
 =?us-ascii?Q?Lj1mjFhnfqe+k/2CiBjPH5XtiVZ58HinR6Uo3RFOvRUWlTKWCSP6QrVXK9/v?=
 =?us-ascii?Q?Avh/Vq9Em/qoXWN/MIYu3RbW6tQVM1vtRUAX2ZWPE66oPIdFWMe5e30Y6hyL?=
 =?us-ascii?Q?wONf3yJJw7OuMLQoQuzFk5JnJy6YRi5MCVGusC50utNtncVBONHfxkNiGfMH?=
 =?us-ascii?Q?MwqVTuUnKl1mziC2eK0LNuTV0VBnjmCs2zB1YX7MPXk1+5P5o1Vbuf5JwOIc?=
 =?us-ascii?Q?pBy4EAExx2DJ3gmPYtadAE0yb+NdOdKcxkh/o9vs4mhffLpp1rYm3BoAmIvX?=
 =?us-ascii?Q?TopEVuWSMEEes9UTIvmBELbeTzaTy+AMTUtLaGdMtR2ULSoOOSEhrGM9ETFZ?=
 =?us-ascii?Q?yjuP7JIiNX/UJXCf4mB8qIE76eqjtO+lhki9zdbAyqzh4O4cMqcvQbTb2jEp?=
 =?us-ascii?Q?6AzphF7Xznz/CF54FVKUpfGXfIxuevLkrfXtnohmHIAr565sPSIAls25V+aQ?=
 =?us-ascii?Q?4Y72l6mUZ2x/spgQ07y6a3r3R+DqUR14JaPibwbTUJSjJxvJRp0C7NDTDR9i?=
 =?us-ascii?Q?85Q7inWXBgTsC9PicOwbWEtbTUXwOZ8DumjjYEflNI+fLn34YGoOnP2JPqmm?=
 =?us-ascii?Q?+GXUG14PENrRbIRxgL13b25O9ud9eytcamljC2ZxDiNSJASPAlR3hbdYV71c?=
 =?us-ascii?Q?Vm3Iie7svfoOjgPMjranf5jc04+4xIsQXRkgB6aXC8dNBDgQNUpr51yNgcpI?=
 =?us-ascii?Q?JyT4LlUpcc9qo2XPkUJNuaZsHNaONQWjLi8t/brR1PkHLAqtqW3Vdjww5d+j?=
 =?us-ascii?Q?7E7ko2Jvey8U8hJKm0f/p0qrkT7NS8mmT+W2Qk3pwhrfOVEa+BagGWrE9w/C?=
 =?us-ascii?Q?sSqKZ60lBRG5j+qp7nAtN/0Z+TOxGOraaLtWMVM4mfDQgKyTaeh6YLEqMUq8?=
 =?us-ascii?Q?nNfD2s0g2Z4iyZ0GXjPCe8OQeiLNMD83meQ4V9b38c8ovp7BLOnUcuEouR7n?=
 =?us-ascii?Q?IQhnojd0LVsOIySSzx7k4WpG6XgJzHQ=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c297cbf0-9fbe-4367-064b-08da4e18ea11
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 15:16:54.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yreuuvo+1jdasOfW0tJqB6r1cKAo+3bQ5sPdqn6mbSplMEZ5TAMReDEWvadr4uEJnX0AVzuq3MzNA/Tb/UG8ku2otZOKnhoLHOSbIZ1zIOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0030
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 09:00:26AM -0600, Rob Herring wrote:
> On Sat, Jun 11, 2022 at 3:16 AM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Mon, May 16, 2022 at 03:47:10PM +0200, Marcel Ziswiler wrote:
> > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > >
> > >
> > > This is a general update of the Colibri iMX7 device tree files.
...
> > Applied all, thanks!
> 
> Not completely sure, but I think this series adds a warning to linux-next:
> 
> ./Documentation/devicetree/bindings/arm/fsl.yaml:684:111: [warning]
> line too long (111 > 110 characters) (line-length)

The warning is from

  bb0fa1533715 ("dt-bindings: arm: fsl: correct 1g vs. 1gb in toradex,colibri-imx6ull-*")

that is already merged in master/torvalds, not related to this series.

We (Toradex) introduced it, and I guess we can easily fix it, Marcel?
We'll send a patch.

Francesco

