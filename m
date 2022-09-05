Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F225ADAD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiIEVR0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Sep 2022 17:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIEVRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:17:22 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE592A278
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:17:18 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-4-nydSdGN-Wfi091Q1beeA-1; Mon, 05 Sep 2022 23:17:05 +0200
X-MC-Unique: 4-nydSdGN-Wfi091Q1beeA-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0148.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Mon, 5 Sep 2022 21:17:04 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b%2]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 21:17:03 +0000
Date:   Mon, 5 Sep 2022 23:17:03 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp-verdin: add dsi to hdmi
 functionality
Message-ID: <20220905211703.GA6180@francesco-nb.int.toradex.com>
References: <20220901154051.1885509-1-max.oss.09@gmail.com>
 <YxD09SqpcbB3dt8I@pendragon.ideasonboard.com>
 <20220902155720.GB5699@francesco-nb.int.toradex.com>
 <YxKe00H2S9AzF0Yi@pendragon.ideasonboard.com>
 <YxNM75ZtHVKDjTa/@livingston.pivistrello.it>
 <YxZNVoMKly9eQ2xE@pendragon.ideasonboard.com>
In-Reply-To: <YxZNVoMKly9eQ2xE@pendragon.ideasonboard.com>
X-ClientProxiedBy: ZR2P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::11) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e17bbf86-f956-4d1b-5f99-08da8f83fab0
X-MS-TrafficTypeDiagnostic: GV0P278MB0148:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 5pOKL82w3G4zFICp5ECySGk0Euugzjv/iw5q55Io7+xpN3gCH0gFW920Ib6tTGxESQJ2Ga0XtTO7S6Aq1TF/tqyIAQhmHAVoLaGcvM8/N++r40Bv0019xhmLx3ioSAcmt90TO5LpP1dw+1jbNjmn4SKuPMy+CFCoKJQ0vLVXIj4joRaABrg0RyBzMw17YKGKiHyz9Hf9l9/YjmP2Vbi56hJtgYNJxdr8ukyhxr+cImySqd26Q8escOMxkdTKSnjYi5RLy4HT9iGUWsYjvvDg4Ks0x4HDVh+OR9BNvvi+az1qoR0ngRCVxgTDewfoo6Iy36He9oXlUuRJaUzBh2dS60hydDbww3okltT7X43I1GflMGVt0DI9SAErTM2dhCF89VvVsbIjKytaNJZMxbI6tqO7Gz4dy62oqqmSiEwyi2qEkGI+3b8GycHBq1rqzWEyqJKXneH+gP17ulIjYlKH8+VNSXsa1ZLlhL7MvvJ2AUPoyyyxUaqf15Sk4UJmFJDv1W3LP7Ugv0vurw4cA5gM4thTsPq1fLsL+FsCZZHk3gVZCdkwzKtPTFTwy27IUnxefJ8EJwCyTCu+FUaOHYIOk5Wq8/2Uv00gCyjbJZYYk0kcpyxjWokkcpE9lWUz2KsGNhwedfW29tCkvU/ov9eMIO0JEB/GBn36Rt/8fzRXw6SWXrN5Cswd/czZr13CQt62Oy2Ec77nL4BZRYCRz81uaeQkxEaa+mPQiyoMda+i1BDEvp05wTJCIEhIwGIFZfiM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(136003)(366004)(376002)(346002)(396003)(4326008)(66556008)(8676002)(33656002)(66946007)(8936002)(5660300002)(7416002)(6506007)(83380400001)(52116002)(478600001)(6486002)(41300700001)(1076003)(186003)(86362001)(316002)(6916009)(54906003)(66476007)(2906002)(38100700002)(6512007)(44832011)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NS2pg3e12TRoWLkNE96juh7Va/ghs3YfR9qbAdiDsqcO87MUcaC/XZu4hYrp?=
 =?us-ascii?Q?VHSG2YnhC5CRmDGsmkI0svDHAYu3KXSVHRREwX8UdyWugvL90T8nOKowaMB2?=
 =?us-ascii?Q?JaogMurWzMizd6g9eDuC/koA2NEiSgm24c+0pLQwjpU621acI68TJfbgqhot?=
 =?us-ascii?Q?PKG8BpTPc6k71yxLu+JYvntupQK3CPAxWKtqAcLadkPRVMqjoXkqZ3Qevdx6?=
 =?us-ascii?Q?8A8pnmOiTj+GzxgiYmNUy3+PITXoortg12vTnVadkgJMEqMSeW2b+GEv/z0a?=
 =?us-ascii?Q?WZ1Uyfc4OmQ7cVIbVxgF7XMCtIDLnIZPXaxzpf+45dwe+HiBoDYzsaV+gF+A?=
 =?us-ascii?Q?5gzRvp83BIKPzyjtMfHW0Hi0GZm9qrVKP/kyhSTVrlWDe2dvflwK2aN8ZhYQ?=
 =?us-ascii?Q?fh0WJuDurHMJ1CFRHpITzVfLpRc5gYly64HE7LXo5knjx8Yzlvwy4oPRYPkk?=
 =?us-ascii?Q?TufTum5sm+zpy8INYGdJ4/g9zKI6+HOjiefahoqM4OHrbh7jsbyuDD27S617?=
 =?us-ascii?Q?vJbEslNBiqTVBeQuXrW+PMH14KqpSHK3RcZ9ECIsZSPDd4h5onitgGt6udOH?=
 =?us-ascii?Q?65aIZfMVygM14qFZq0dqnvknQ9Tjdh/dczYGtsCVYk/beticMbGPV6u8N3FN?=
 =?us-ascii?Q?gyNst41Qu00ln4dRQ1/O+0rxLiM6GEiCQxeS1ItpCNKR5LaPE96r6r3B23rn?=
 =?us-ascii?Q?GzmJIDfVLlyEsz0CfoUKItZNZFBL7JhiFnUaS7pcoLGGSWnOwODp95yd/2PQ?=
 =?us-ascii?Q?Akk/ZB+zh4dGZXJ9s8bdZWJmqRTtBD05nLPQ0ovFMsFd3P5FCz8eyPqPVVpz?=
 =?us-ascii?Q?U0JP2NG77fVO73ykaiG/TVMgOPmPyWRQrvsCy4gBXUQWDmcDQaMsrZjpIhzH?=
 =?us-ascii?Q?fDCWTbKJYT9eEGX9SBS/rjFuz1qqotRzG7y/uWs1cn1q8IHSQ85TtNIuTLo5?=
 =?us-ascii?Q?HQbUiZVI4qQfeh3CLBZnXO8b8odb4Afwlrjo2t4xlW/25e+OMKEdeOsVe+no?=
 =?us-ascii?Q?A4IBDaeDt6JgP8yFfD2Xw2Q5k9A4LRwrGzzohxeoxh+2R8423B5a4zNTWUDx?=
 =?us-ascii?Q?s1U8hMzHvP8B2OJyx0G4dRq545G6qS0zhkF9AiYAUSXW4vFRGYdfxVLGNVyL?=
 =?us-ascii?Q?4l6UtA0+Rk0dH3D+VOnN5dhq3Qgz0eIZNqs3bhmEb1wSRIpHj3pYHzzqtubs?=
 =?us-ascii?Q?w66PfWSHTz536LUywu5Ap1lI9y0gP697gYqR5IyY7zYCn8KzSqz0Cn7VKbcV?=
 =?us-ascii?Q?VPx/b2XwpYDomSfm20v7JNOfYjasF/Iks+vR7LlyUyf9U+45rQ6a3invEZPz?=
 =?us-ascii?Q?hqdGPidAhqkil/0gMTHJB5VLfz0oUJb1gewsc44XdHaw5PUiF8GxVL5frd3q?=
 =?us-ascii?Q?rvlDqsvZMerLymOTFW2sX9IebvpTrFsQJTFjD0WQDTyESEyirFX6yGijSwG3?=
 =?us-ascii?Q?2FEwPI4bxVQ6asx1oJK3MdA5UsZMqo4CAEfMhSS5fJzQE8IXXFPuTnuM7+N8?=
 =?us-ascii?Q?O4seKTN6VX0Q8tzUfSkfi1p9Kc80CYmbcY/MVygW15sDu/eKa1TmzlZQtCOF?=
 =?us-ascii?Q?p3YNd7FKEDQK5nZAEV4VQQ8pbelA7kVEkM6rfjU2ZJNj+Or66ANjf0vOfuSP?=
 =?us-ascii?Q?C+G9+qikr5K+M428DU0pAuOQw3GfQ0pS06vGiKGr0ae+bNS79rP5rYMlhbvv?=
 =?us-ascii?Q?TDPfcw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17bbf86-f956-4d1b-5f99-08da8f83fab0
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 21:17:03.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHs6d1bf4y9HIzBh7Veb9We+OgnHjwvUwM2aFmfkTlvdIglkjril35n6MtxJCowlnUUFYwYME/oXfDE5O7HjrhCgy0D2Ca7fYlJhqvC2EL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0148
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laurent,

On Mon, Sep 05, 2022 at 10:26:14PM +0300, Laurent Pinchart wrote:
> On Sat, Sep 03, 2022 at 02:47:43PM +0200, Francesco Dolcini wrote:
> > On Sat, Sep 03, 2022 at 03:24:51AM +0300, Laurent Pinchart wrote:
> > > On Fri, Sep 02, 2022 at 05:57:20PM +0200, Francesco Dolcini wrote:
> > > > On Thu, Sep 01, 2022 at 09:07:49PM +0300, Laurent Pinchart wrote:
> > > Someone can integrate a Verdin SoM with a carrier board that has no DSI
> > > to HDMI (or LVDS) bridge, there should thus be no such device in the
> > > device tree. The SoM has DSI signals present on its connector, that's
> > > what the SoM .dtsi should expose.
> > 
> > Just for the record Verdin i.MX8M Plus do have both HDMI and LVDS on the
> > connector (in addition to DSI) [1], of course we do have also the option to
> > have LVDS or HDMI using an external add-on DSI bridge as this patches are
> > about.
> > 
> > Said that it's true that sometime we describe peripherals that are part of the
> > SOM family into the SOM dtsi, this avoid quite a lot of duplications given the
> > amount of carrier board that are available on the market that use just the same
> > building blocks (and this was one of the 2 points I mentioned as a reasoning
> > for our current DTS files structure).
> 
> If those "SoM family" peripherals are on the carrier board, what's the
> issue with describing them in the carrier board .dtsi ? And if they're
> on an add-on board (such as, if I understand correctly, the DSI to HDMI
> encoder for the Dahlia carrier board), what's the issue with describing
> them in an overlay ?

These SOM family peripherals are in multiples(!) carrier boards AND on
accessories. The drawback of being strict as you are asking is that we
would end-up with a massive duplication of this small DTS building
blocks, therefore the decision in the past to put those in the base SOM
dtsi file.

Maybe adding something like imx8mp-verdin-dsi-hdmi.dtsi and
imx8mp-verdin-dsi-lvds.dtsi that can be included by both overlay and
carrier dts files as needed would solve both the need of being strict on
the board definition in the dts file and avoid duplications?
Not sure if that would work smoothly, it looks like adding some
complexity and maintenance overhead, but maybe is the correct solution.

Anyway, while I fully understand your reasoning, I'm still not happy to
change this for the current toradex products, since users of
our dts file currently rely on the expectations I tried to explain in
this email thread and Max patches are implementing (and this is
currently uniform over the whole toradex product range).

> Maybe I'm missing something ?
I tried to give more insights.

Francesco

