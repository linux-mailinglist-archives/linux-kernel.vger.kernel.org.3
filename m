Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65875AB163
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiIBN2f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Sep 2022 09:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiIBN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:27:58 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A30813F901
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:06:50 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-46-Vuv77KofOH-pwINw9Aup7Q-2; Fri, 02 Sep 2022 14:50:43 +0200
X-MC-Unique: Vuv77KofOH-pwINw9Aup7Q-2
Received: from GV0P278MB0484.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:33::8) by
 GV0P278MB0147.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Fri, 2 Sep 2022 12:50:42 +0000
Received: from GV0P278MB0484.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a4b9:1240:bb28:fc94]) by GV0P278MB0484.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a4b9:1240:bb28:fc94%9]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 12:50:42 +0000
Date:   Fri, 2 Sep 2022 14:50:40 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-verdin: board regulators: add
 always-on
Message-ID: <20220902125040.GA5699@francesco-nb.int.toradex.com>
References: <20220901110422.1859621-1-max.oss.09@gmail.com>
 <YxD5+RCYtzcxEdjj@pendragon.ideasonboard.com>
 <YxD9m7sELdTUFFZ3@sirena.org.uk>
In-Reply-To: <YxD9m7sELdTUFFZ3@sirena.org.uk>
X-ClientProxiedBy: MR2P264CA0096.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::36) To GV0P278MB0484.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:33::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56aa0979-4c5b-418d-b777-08da8ce1be79
X-MS-TrafficTypeDiagnostic: GV0P278MB0147:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: I1/+PZbFwieuU7+QozoZ0kyYmb8eaFgpIwcZ76wl6A1TzWPzTpUK7u7Y6EIhQZOADGEenI4AN7nvCMVG8fUxbxFPzcRx+32328YLNdMGlYQeSloSOPlxVRfGznMVauMD0Vlfn7qfzv0VUNOJ9BjQscxYilQE/880ZRKiawouul1GGKOFPzx8bKZ1D28ZjIA5NXDfl0MYG+XAeOMPBwo+L1GTrItKAQjIN8oV1JYxTRE0ojcibHea+Dc1yak20GbrCTUwSIU/WbpIDtraMWCNhXKYJUt7SK22QVk7/Olu14S9V5y67N0O7X/v4WPICu8Nj8lG+11foTDnkj+6IgMEWA3tzEglZHkD6hJo62C34aF5Zqa4lc2pjttPQCpCj49fE7tCn7M+fWd8yRI6ktA1kufUlzw5jF8CQkhCVryrWhiuaNk9+jrFNpYFTRToJ5Qct1kqPGbHZN0RYNz3wpdsM04jRmukv9L6JMbzQ9gbN0+vgcBWqV2Cw7BffDM7Rr/ZolxnpENkxSEb528G0Zc6tW8LYqIX/IgPkRshueVoZ83PsvEKgYu7tLlx03PcxwEC12ZerMJ4KP7WJeRhffGryqAE3W5bI8SC+tZmZEOMR7VfGe82fHM3zIRJInJaN+lGTW6bKSS+uQZgxdpP6hdrFARYAxmqbNs1eUSM/IpDbLSTs1F1HtULocpAr0Uwp/PmMKJ+EfGtq+o1hzegEW/IfnNF2dFBLBDwgc/w6xJf5ltzE/pfslbMvTYM0rYIJkphTerErZj4y3Aff071ThRtB6WusPGDCZ/2vRdYmg4M8sY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0484.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(52116002)(26005)(6506007)(1076003)(186003)(7416002)(6512007)(44832011)(5660300002)(8936002)(86362001)(33656002)(6486002)(41300700001)(478600001)(83380400001)(38350700002)(66476007)(66556008)(8676002)(66946007)(38100700002)(2906002)(54906003)(316002)(110136005)(4326008)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amogJAbD1PRMUL8LekCmeR6TVBtZSN+5QdPjOvttEuVoGX1WytDNcM65RBP4?=
 =?us-ascii?Q?cIUorbbFECcBVeL7HSSOk2tL1XdSi9YZGFUvQxT+zrGSvgoMDjdHaCKiqIuc?=
 =?us-ascii?Q?5EJwtWUqaYoJxvqQiPgWEemSsJrc/Z4Fo0VFsq8QyxwXe2tUpncqAYbSnguh?=
 =?us-ascii?Q?JLlFTOj+ApfhGthvvYu30NtgPtUrHeZZMYDEzMEf1K6m2+BI4ey+AxU7HNHG?=
 =?us-ascii?Q?e2fWtvFVf2+Lvp7Jx06U8EJqsLp8dXcthrHzekJQTzx0nqOIu88VoqJXuhuS?=
 =?us-ascii?Q?uUDFCuYVTy1Pzf756DQLHzR/Z959mTZ/yygWOVezjGQ+Gf0QTsYJrut1CSps?=
 =?us-ascii?Q?tEekDoqL6wWw3kpdo/sHghIumZ8M7OlfFuHt0PGtGb1wCyYYaAO8udUvyAtI?=
 =?us-ascii?Q?7rAYZDYjmi8HEdwT+0gcO69ZEGrtlO4ldi9kokX+ogL+JBB9VUyHZWiH04qX?=
 =?us-ascii?Q?FuUk/KYd7yGh2ge8CmiDsNhZ9H8NXX6OkxWIYknsGeuc9s73Wcl9E+/BE+Xw?=
 =?us-ascii?Q?+fXG4oznmkEwxZpAC5ZZWkbn76KBCKorABUp3X3geZ3O3muVYBrJBJr9h5qB?=
 =?us-ascii?Q?zubJfgbbw+HUbws1YCyf3W70K69ijwN7Q76vVWTuIc9fQNfSDetS6sfJpC9c?=
 =?us-ascii?Q?6ndDBLOLexCE/vSUsgcQmgTzSqCpDszWVESGdDGU1xpT83gNzrDV+FtKKfP0?=
 =?us-ascii?Q?l5Aij60dOf73uP9qAaJ0vYsgJrQ1Qjv6h6n3c0jRkRbLEJUxY/RqQg3CUf6a?=
 =?us-ascii?Q?QiKwqgNR8ep3vvq6NIatNfQ/uMnbSjwPypJvorMce0fZPuK+BmgC643w2aRE?=
 =?us-ascii?Q?9LnCJ/QVLhMF8cNgEHuHt5vwjmWcpdwsUP8wTkyAVNJDxYQ24XbIstL1yVS+?=
 =?us-ascii?Q?+XP+LP7HCkvtYuP25yFltckkpM4ch5NNIBw1HrEzWTmDajY1vmZbtYNai3rz?=
 =?us-ascii?Q?eFpB14h93vDXPGqZnWYIn5lUMVR8qDEJrN1HB9ctpmGshxRRK157HL66vdjL?=
 =?us-ascii?Q?atXH0qg4dUUKh51cDgCTPgGNIO079ynZvW6cViatqvxlRbTDKKyTG9LpOGea?=
 =?us-ascii?Q?08LdThDOPPj8MOrj/37oPBYua4Ozorky3FYa4V03w0uHwcijp74VBsG8ID3l?=
 =?us-ascii?Q?bARvOy8AZ1S3y1DJA3VOi9OKapAeaoJ+nniOGAYxhoc0sJVSXerKeWATeLaO?=
 =?us-ascii?Q?uE6lK3XRPYQEO8Ghsz8O2r4mmF3mJtsbxWf431thvnCIE+ClHzXVDC/4iJY4?=
 =?us-ascii?Q?IsP5+XmU2hS0OiW1F6yt9HFrYsC4MaoTfKTqIXgm6v7SNvnTTqlW4vFyDmLa?=
 =?us-ascii?Q?ELsFbCUjzUJ8PE2nsR5gJkPi6At8sWdv87vBbggr81nIW28I96+9Q4LA/tra?=
 =?us-ascii?Q?/bvgEjxpaKA+c2r6xl6WpT6PqZt4aCSaZFAOGjwIybpjB/7KlNR4eiQntbK+?=
 =?us-ascii?Q?LoJqiBpnxBYZ36u8haQ1hPkckM3Q5U0efWs/4jwKirj5iqKaVdd7q1JD+CpK?=
 =?us-ascii?Q?+6QoGVBPb09V0lv6b7vcw1/Z5q6BsCkMWYTDIHZs9S6cPGHLXaTVh8V7/rvn?=
 =?us-ascii?Q?urbw7zKMMY5cv+0sqCRQQtFzr1tA4xyPARsi8QFgasuHs7enOwhDfEFSas5Z?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56aa0979-4c5b-418d-b777-08da8ce1be79
X-MS-Exchange-CrossTenant-AuthSource: GV0P278MB0484.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 12:50:41.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ys9CrAXmrGbOwk0uypC+LntdBf6438GzhVCs8gawVtn3MAsXZt3pKQ6t3dGutfMm2cu5g+dGwBwcP9AEozH0ihiygdyuQl+nmy9rs8UfmjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0147
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

On Thu, Sep 01, 2022 at 07:44:43PM +0100, Mark Brown wrote:
> On Thu, Sep 01, 2022 at 09:29:13PM +0300, Laurent Pinchart wrote:
> > On Thu, Sep 01, 2022 at 01:04:22PM +0200, Max Krummenacher wrote:
> > > From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> > > These regulators are switched on by HW during power up and can not
> > > be influenced by SW.
> > > Set the always-on property.
> > 
> > Is this needed ? When a fixed regulator has no control GPIO or clock, as
> > is the case here, I would expect the driver and/or regulator core to
> > understand that it's always on, as the alternative is always-off, which
> > is pointless :-) Mark, Liam, what do you think ?
> 
> If there's no physical control setting always-on does nothing.

The patch was posted because of a warning on trying to disable an unused
regulator.

However this was changed with
  261f06315cf7 ("regulator: Flag uncontrollable regulators as always_on").

Max was testing with a kernel without this patch in and forgot to verify
on latest upstream kernel.

Just disregard this.

Francesco

