Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B3B5AB640
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiIBQLH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Sep 2022 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiIBQKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:10:43 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C1A11B619
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:04:02 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2113.outbound.protection.outlook.com [104.47.22.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-X3KJga_XPDaUlSdM7Lobsg-2; Fri, 02 Sep 2022 17:57:23 +0200
X-MC-Unique: X3KJga_XPDaUlSdM7Lobsg-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0751.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:52::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Fri, 2 Sep 2022 15:57:21 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b%2]) with mapi id 15.20.5588.015; Fri, 2 Sep 2022
 15:57:21 +0000
Date:   Fri, 2 Sep 2022 17:57:20 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Max Krummenacher <max.oss.09@gmail.com>,
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
Message-ID: <20220902155720.GB5699@francesco-nb.int.toradex.com>
References: <20220901154051.1885509-1-max.oss.09@gmail.com>
 <YxD09SqpcbB3dt8I@pendragon.ideasonboard.com>
In-Reply-To: <YxD09SqpcbB3dt8I@pendragon.ideasonboard.com>
X-ClientProxiedBy: MR2P264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::24) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a463d93b-1fb0-45b6-def5-08da8cfbd1f3
X-MS-TrafficTypeDiagnostic: GV0P278MB0751:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 39Iv8wWzcFWmoqPhX3Sf2q/A27UqN3LqtzX14vwgRQa8+RplKzoQj5gKVAPFpRX52wWn2Q5Yb2Rz8mATGasspI3MxqfJI6W8VNka9RvbfxQBI1yQYyH9veTMce2U9xqd8rb8gj8NNS/reJw/A878ulIJtx5OSnhLTTuxqe/bcqZMhEShJy8ZjzyEarwFOiPEHBA0CEZJj6c9NNywtD2/OYX5u7v/zJEvOF0BGf8iKpomhpeghAD4GODPjn2SVi1qUkltnpE/VWg0saknRjffS3VTiGt68HL5TP2H8QcmAGWXUhqTjBI6mlTIFWdgLomje1o9Hp/sQKNA56CtmSuTbsNDgKDFzKuM1OXYVdOHbQHzZzpE/gf+7zSYnQAh76Z7yh9FEs7aCJAW6De9lssVCInm2bsGoIJ6vIbeNFWU07eg+QzLsYjDmb6reEKzpn/07pp4/frJSzXhIpBZNYfoJnH7RL1wC20j4n07rNVRC9xFVDNhv3vffeca7qiLqdsNOQd1N5PI4e0r/jWCEKPVm70H1vyYw8NU6ippWcKvQ16Q3R2lgGE2rgAXlBczJ+MjJyfTAUXscd2Bv4B4j2MW447YocAAx/pjxOCQc7tKNXDFLxgR/cyAxmo4MuGA50WcYz7Ou4ouyVdOwa9svSUBYOQJhEMkJVTpPqse0NUGmkUOF8/46Wc2qrdsc/aflmEMpEWseyOs28UPPSO8H6txx6I+8F772Nl9KDcdCsIm2PTINJhbPSa5by6lCZn+s4DV1dYTj9lfcdn/JSG7mEXHqRNHBC2J3UawdkYdhEj+CmAzsUHNUyGXjLdBOVip2mNk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(39850400004)(376002)(66946007)(8676002)(66556008)(4326008)(2906002)(66476007)(33656002)(5660300002)(7416002)(8936002)(86362001)(41300700001)(6506007)(316002)(44832011)(6916009)(966005)(6486002)(54906003)(478600001)(38100700002)(186003)(1076003)(26005)(6512007)(52116002)(38350700002)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ol2EcgsVAx7PMfA7ukCOMP1qCVmJsLnZsqXgiz1fBMd5VYOgWmsbX+Lsa9pu?=
 =?us-ascii?Q?2K8kBjlIorV2Vc+NnXDAtl1iK2TtLtVQ2RFWkfasotpo07QJCr9002W83SGc?=
 =?us-ascii?Q?lmtiPYCZGCVuZgWilmuThIuFvugx1lwZjprxYgqYUITRCwxeXihk5ovFowEI?=
 =?us-ascii?Q?RwTlCuQUGmPN+XdfMK4fcDrR0bSxRugRHwlAkOphqqCr1a1qdt2krLkY7YkE?=
 =?us-ascii?Q?7uq/D2R2IuaW2CQ0+QsCW7lClSD0wxQHXCOYeK2fPxMd0IzgzGAqeq1IzCvS?=
 =?us-ascii?Q?pHzj4I8GALpXPZcIGNkjzej2fp+2E2xQR0Pw9Qob4X5dttP3s+hUpnKnHkmF?=
 =?us-ascii?Q?uH2emOAcBQsRv7w6qClTGrxsPQPMgy6BSLa7MWALaHlXCpL7r1pEvynemQQX?=
 =?us-ascii?Q?BvWkpcbyJdEBGjpLRO5CXi8xyWEXk6HokPk/6iP778jrD+IcSWW7lUtPU4hN?=
 =?us-ascii?Q?9Bs9kTl9KA8DpSer1lXvsXC/pZE+WnK5HI8jiabZqiY2CnJgQ2h8WJS7scqe?=
 =?us-ascii?Q?aFk+elxIOEDd3pZzKWBQhRhaiE5GrFlHuZN7AiNKwGg5nNeJpjOm8FpTw9f0?=
 =?us-ascii?Q?Nph8LFEF3zT1QcN24+T7bWOyA6enKUxI7ef8kGN99aBrtfitzRJm9wOnz16z?=
 =?us-ascii?Q?aTPLzdsHCDC9vZD+ODK+E2BTz6eBpetoXyS3XH4yRJDmBYEJp/k/hMgGGFGl?=
 =?us-ascii?Q?ECwPdoWpbz4R5Jf2e35j+01Gn1jhOikMAr5F52U7bbnhRaI+MTNYcyh8I5nJ?=
 =?us-ascii?Q?3aKxkJ6uXEwEAWzETQtgSNw9Mg0Os1AjcejD4+DbBDWKv3l0O3CaaGJ3UH+C?=
 =?us-ascii?Q?Z4TsEXV+l9qa5pCRv/dkx6QprCP+aTwypt/hjb+gW58Sp6OP3rbBqzZmtNcJ?=
 =?us-ascii?Q?RL7PGHMi1jRxkYK4KTT/IxsdWNdvkI42MUMs/IOuupkHO2kdr8AwVfomZh7L?=
 =?us-ascii?Q?e0U3AneTUJAx4muhMiIVn3ClmKFNi33DlrHd7P0zOiZwswsHhQej/FwrPU+z?=
 =?us-ascii?Q?VKflKX2YuHxYNNqAw8X4Kr8N456qwPY7xx0YRBmZAcjkq2LxpAVYr53Qh8ke?=
 =?us-ascii?Q?BgQvbNSLt48hTjMfz8Zca1tGrs38AKwa0+2V29SF2Anv4pxWrqkoluksKQJH?=
 =?us-ascii?Q?uq8r0d9hiiwgVqxGGLVou0GWyDHhpaLOmuReQF/v/JVH5/crRPTujzG7C3zU?=
 =?us-ascii?Q?dSqEJ5K2EMw2EHgKzzdjWF5UprM/ynRT2V9GvuDcL2Y5d6XFUj9gZcYZmETZ?=
 =?us-ascii?Q?CNMLOifYdenE9mZkiHVoHQJPklnvk0YErqEPtH8hVqBB9v116Lj3FHBJy4FD?=
 =?us-ascii?Q?PHeZSuV5N2xFeoMgSLFPpx4f6IhEJcZKUnlIDg6dmW+jt4tjUqw7IcCm43Sj?=
 =?us-ascii?Q?xik4LJ/RUjf0q0kwilyx4BNmR5HTCKtqs+PjMGSpCv3yXE1lwsQaos0Di9BP?=
 =?us-ascii?Q?Jrl8eYVc82+fZhkj7CLE89uNAhHnyzii9MWf0pR/QO5/o/x7NMQc91iaRsUS?=
 =?us-ascii?Q?UePV1S09rKbGJlC31qvocScIOFppCReuwjcrXdhTnN1VNyFpSunjdgx+Mp2E?=
 =?us-ascii?Q?HcR7cnJYXhYNKm79xfJLOaC38y/WbavW6B00FS/9DZ3Qysc7yDaqcU6cHzec?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a463d93b-1fb0-45b6-def5-08da8cfbd1f3
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 15:57:21.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uv5jRZS1ZyTt6eS2aZSRWYhYSEnaLvdY/fOC4dGmSOhl/UNUHF4F0TvMcpj4QGfthGLTfkBrZt5T5wOxOCdAcRvOGcSne4vNaZW0upi6ykA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0751
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
answering here for both patches (1/2 and 2/2).

On Thu, Sep 01, 2022 at 09:07:49PM +0300, Laurent Pinchart wrote:
> On Thu, Sep 01, 2022 at 05:40:50PM +0200, Max Krummenacher wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> > 
> > Add the hdmi connector present on the dsi to hdmi adapter now
> > required by the upstream lontium bridge driver.
> > The dsi to hdmi adapter is enabled in an device tree overlay.
> 
> Shouldn't the connector also be in the overlay ? There's certainly no
> physical HDMI connector on the i.MX8MP Verdin SoM :-)

Toradex DTS include and overlay files structure so far has been a little
bit different and not following the expectation you just stated here,
you can just check the current *toradex*dts* files and you'll see that there
is other stuff that is not strictly part of the module.

Copying from a previous email thread on a very similar discussion [0]
some of the reasons:

 - The SoM dtsi representing not only the functionality implemented into
   the SoM, but the whole connector pinout to the carrier makes very easy
   to just include a different som.dtsi in the carrier board dts and just
   switch SoM, for example from a colibri-imx6 to a colibri-imx7.
 - We avoid code duplication

This is working for us pretty well so far and the majority of the users
of ours modules rely on this structure, we would prefer not to change that.

Francesco

[0] https://lore.kernel.org/all/20220413094449.GB118560@francesco-nb.int.toradex.com/

