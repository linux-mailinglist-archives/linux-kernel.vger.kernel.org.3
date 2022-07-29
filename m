Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27A2584F38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiG2Ktt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Jul 2022 06:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiG2Ktr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:49:47 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9FF5B52
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:49:46 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-502i-sN2NTO6hUvOzNcbVA-2; Fri, 29 Jul 2022 12:49:41 +0200
X-MC-Unique: 502i-sN2NTO6hUvOzNcbVA-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0261.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:38::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.12; Fri, 29 Jul 2022 10:49:39 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f%7]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 10:49:39 +0000
Date:   Fri, 29 Jul 2022 12:49:38 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1 0/2] arm64: dts: imx8mm-verdin: update CAN clock and
 interrupt type
Message-ID: <20220729104938.GA93488@francesco-nb.int.toradex.com>
References: <20220708124205.59564-1-andrejs.cainikovs@toradex.com>
In-Reply-To: <20220708124205.59564-1-andrejs.cainikovs@toradex.com>
X-ClientProxiedBy: MR1P264CA0138.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::19) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 953bd025-8b26-44e5-e8ad-08da71500919
X-MS-TrafficTypeDiagnostic: GVAP278MB0261:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: FCNVNcmsFWj6a75P1ncGB2e3DoSSnPROsrHVL5Fai2VHyLAV0TEEQnmn6qLA4rG6k7stiP1RY7rzybrl+g/YkMKtORylOvSMDyxd9IILQxe3oHEKSM/imTBNjaMJddDw8XGKhQn/AdCra/ZMLM9OTJ4vUlhUCjcIzR9JELCByZeRMLXROP1SLbwlvq+UjyyyIxDzjNWiGWGi7L4ndcGCfLZo4RmA7RrLmgzndiWcu37zabN0plVFZXENWn2874vyN76e6NMrDdeKQK3EZoq5x4rbu7+oAW9cI+Pj5F4pz5Yr205NEugEbdHmlet6r1i3qh3a1QDGEcSKrjaNDOl4rIeXCyRW8A8IhD+HRQtncKZTL2uQYB8SOn2eWHExf4XO4XTzD8hMbaQv4iQrqvDOCzG706Nytt3M4lxjiqIjdSezUmpvj10BhztRj6h/QHuOfoTSZUSOgfNPW/FJxjEFQg8Xgbp3/EBN+kDup+CMUNv7uhBqzLTpesFLw98TJGXZaE/+dLZUZjPjWBWL/p2DH8sIBCeTktQd6wzufWk1QP4kzsq2XCABsnj7QF99NefsfNcTl1ijXlb4ht2cbxs41kRm/REjKl09TJElM/smaejSeRLgXrGO1XZ8Sl4KalktJQ0nZEetTY2t2eEDD0H2w6HU6UQQYqrDUyYhPFtBDZWneThIT6wIgKWKieAEDNhYtbsVFKYZgUkCHrsmCNvnEgk2CRWZO9ubhO53HieS0+UYb/vhnvmaim2bpC+CWfK1RudEkgpBlXZ0mHf2SMexnwutkFBu4PIHNDjgUmkizv0ejohQWrUfQi4jALMuSLgha3llaV7stSlIgIGbR1NBNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(366004)(396003)(376002)(136003)(346002)(38350700002)(38100700002)(41300700001)(6486002)(8936002)(7416002)(5660300002)(478600001)(83380400001)(66946007)(4326008)(8676002)(66556008)(66476007)(316002)(1076003)(186003)(52116002)(6506007)(54906003)(6916009)(26005)(6512007)(4744005)(2906002)(44832011)(86362001)(107886003)(33656002)(15650500001)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2ltT2DfVOQTYkscph1X9NNzqwR9C0DxZP66JJsEOKmd7dbrexSvdDaGutp5?=
 =?us-ascii?Q?76E0LSdzfgjGHKoLOn1iJSTeaHtYMbmx3k+wyXa+PCxiNH/ZDbl4O066Ik3f?=
 =?us-ascii?Q?ckN0OULyqYXOtyZS0DWiG8Zfjcks8ynhI+jb/Vy2kUAoFNAFKUQZbuIC5jp+?=
 =?us-ascii?Q?dGc5Kpr3+aUrat0n+wrXdFSeUyxjbPGfY7VeuqZCjX3obVmdwaCP/s8/ZW27?=
 =?us-ascii?Q?tLOzzHNgMY8M0iaX7F0obboyDWpCs4ppMs9Je0c4ow81s8vn5MQZ21y3/A9c?=
 =?us-ascii?Q?9a+6K5a/5gpR1QUOmUaTFVDPz886o81yGUaG5bO4ctsoKnQXwLUZAp+D1m3d?=
 =?us-ascii?Q?mWX2MPObGSbN5NfRCJ6JT1D/Vv+TdV0J0ZBeVTlqCpsEoH/KBUf1/s3eygKi?=
 =?us-ascii?Q?nXWAqc9jNfMWciW78VSt6fWsseL+EiVNQAucpsOviEpNKBNmdy8NHDNWxa+m?=
 =?us-ascii?Q?vRvKWGk/TEeBHIFf65h5kKYtYmPn3vrFy3P0RC6VR//VR1IlLAqR3MzbZZOF?=
 =?us-ascii?Q?RslqwUrNycqJ1CDZiaiDV5brVIr0esOTcviujuWvGo861Z0rqgct81g8C0/C?=
 =?us-ascii?Q?oPFKVGFZCZ58QOLEFUwaBAYj4X/e6pPkmsrzXJI8S04D3TlSkbfntvSpBiYy?=
 =?us-ascii?Q?GSwcJp9xbAtv35T5LA0MbH4vK5gdp3ELHZyn412ZAIMAs21IDrZM82nGy1tI?=
 =?us-ascii?Q?eHP/6TQzwolklxb9J/6od7RmmnpFmRwLuS70HS9c/QGIX7InlbZWBOx1fDY1?=
 =?us-ascii?Q?AlYaMiMcP1WDrhV8C3NEdQQVZsJkbB9xi7nCOGavFjDrS1V3zBEY+/TOzRBE?=
 =?us-ascii?Q?EI1c7qYc59V/iYEzG3qH0XGmk9wUCrH3b8nXma34gGDkdwWrMOpi3C3FHh6V?=
 =?us-ascii?Q?hUrECDVR7vKINg22PgHVu4fUImameLN4IOEdePIa0oE6u0l/OasFx83LJuHq?=
 =?us-ascii?Q?htlTSSyivCkWBm4lpD44qzNREMr4OvaOOYATFfxX/oB1cDFvt3truwL2oWKG?=
 =?us-ascii?Q?DBW4/KO7/2YJk5YaG/64M3uafXiBYXs/Ek3DWmC0iFw/zcdUccVRN+DlzYUs?=
 =?us-ascii?Q?8Q9VXJJRg3CKHC2WXgdzEYINUmeejzAj88q9fOuzc3+hi6fSl9HTbWDu2D8U?=
 =?us-ascii?Q?nDhEiOB722VTQbPLayGH3t4KpLwDNH5tOAZTn5WGcB95qw4Jd4llUqjmyzOt?=
 =?us-ascii?Q?2a7gy39+wRfezv45+b6XOLbTBj+KsthMo/Mgy7XDSHCb+Hdl40Z1zc548g8j?=
 =?us-ascii?Q?hwg+0Pba2IlzOSKov54xWbcVy19MVDP24uimFb4kEyasIfmQNvA0j+h1xGdv?=
 =?us-ascii?Q?YM7ry2/g84QGt84uuvAKpzeS1PPzg+HS1b661ztJslm8CXteWH3OPlyv+zsI?=
 =?us-ascii?Q?DKoi47DgjvdnX9L4f7VDlY1Dwn5XiIunchhwgzXyN/1ofuo7w/cTmFGNv4AI?=
 =?us-ascii?Q?8kap16Z+8fZyVdKtrSi74o2iHOTEtYjVwfTke5jRWRqLPiYnKZe+Z0Z4J2C2?=
 =?us-ascii?Q?DR1fawzs3Z6WQ28GVx0zHwoTJnedknTAW+h40P6hGanr0cCjpO4ucdbu0m6B?=
 =?us-ascii?Q?h+K1FzNgsM7YYX9oGodQudnw3SMDThVzck1zqshjI9mfQ5zt+7JE2FKlG06U?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953bd025-8b26-44e5-e8ad-08da71500919
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 10:49:39.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7u1j0CEt+bk1LXDLD/cCbp+SsVSMesXweUrH2iX1CUtaywTBpDDcmxoyDzdSrO/tRo4YTWn7fRUfBMqzwF9vxHj3SpW7JokZCOPVhlXadQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0261
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,
just a gently ping.

On Fri, Jul 08, 2022 at 02:42:03PM +0200, Andrejs Cainikovs wrote:
> This patch set updates CAN controller clock and changes interrupt type.
> 
> Andrejs Cainikovs (2):
>   arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
>   arm64: dts: imx8mm-verdin: use level interrupt for mcp251xfd
> 
>  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

It's too late for the merge window? These 2 commits do not have a fixes
tag, but they are really fixes (we just did not bother having those
backported initially).

Francesco

