Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF558D9CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbiHINs5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Aug 2022 09:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244597AbiHINsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:48:46 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 245031AF09
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:48:44 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2044.outbound.protection.outlook.com [104.47.22.44]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-f_XtdghQN6mzjdIUhlBnEg-2; Tue, 09 Aug 2022 15:48:40 +0200
X-MC-Unique: f_XtdghQN6mzjdIUhlBnEg-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0367.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Tue, 9 Aug 2022 13:48:38 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 13:48:38 +0000
Date:   Tue, 9 Aug 2022 15:48:36 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: gpio: stmpe: Remove node name
 requirement
Message-ID: <20220809134836.GB44926@francesco-nb.int.toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-4-francesco.dolcini@toradex.com>
In-Reply-To: <20220712163345.445811-4-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0093.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::33) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d0023cb-8aad-495c-4692-08da7a0ddc88
X-MS-TrafficTypeDiagnostic: ZRAP278MB0367:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 8P7ZuVvT4TI3bq6Kpg5CVrN5HMlyPO44BkOYnkSL7/CZ6pXMKUdmViez6ViU+0t1LR5OuJjW8VoGr3JwIBtzNj4PvI2dqo9NGY3Ge7JLCNSwi9QQjVNdnzECasHFgZE2Q+p14VtJcfmK383pdArxhWCMH0C0LWzmRy3TfSq+Hfa+8iNhew0ANF+T75CGMFe0vJuw5o7giFK9alVrw18nZNvTewlCUJeM/o1WPP25RFtx0nj74Wn1dOsseeXb5sW+2iB3qixdRnAMdt/IFMVtMxpS4jt8V68JzGPDc/RbFjU67UWN6tP280dio5sXC0AP2YRCHbUBKhI0GJpoasj4Q1mLTiDB5qGX0DWZYI0zuvCxNJSEg1Em1LxFHfB89EYFyf3COI3JBhoGaNd+rKkea85rPQsaHeJD68yAhKgLQd76xEth420DS0M8waJFVrAE0mhQzy0R0Iy3RSGXfN53WXVDS+gOYNpagQrf+TBzRbPXbANkA4rYprAZVZVnAkdLoejDWAa8CQdlvHM04tDznowykD/iDxcyY+XPXrLi8jamLwezNT3a60nY6HbJQfFRN4gENyK8N3GRv0JHWiejQBvqZR4eve57lBMFAXkZDoHMFoWWVMcycn7VjsUuqGptOsawtxLIKcuSTzXONjELZwkWeH6dJPkvTxFAkcu/m/F1f5zFWLnqiUS0XMY4TA+jFBF4xioN9lodpZIDb9+bxiY6T+H6TDyasNLVcmzFMm1guza8YH/tfGbBKqNE0BKPbaEXe6I11OPbKe6bY69ouL4I9uRayMhg9FWgG+Z8+WQw2pJQFPXku1n+Qp8dPt46
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(366004)(136003)(396003)(376002)(2906002)(6486002)(478600001)(41300700001)(26005)(33656002)(52116002)(83380400001)(6512007)(186003)(1076003)(107886003)(54906003)(6506007)(66476007)(66556008)(5660300002)(8676002)(4326008)(66946007)(6916009)(316002)(38100700002)(38350700002)(86362001)(8936002)(7416002)(44832011);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PhzMTt3PkCXOClS2i4W2ZADQ6Dx1+ceV/c9nKd43v+KRiTFkVcTE46XP4gzw?=
 =?us-ascii?Q?a+9Qwx8mEW62KrEQ+wuN1TN4AkvaS4KpMXFfgrUnMLFBE1fEzA/fOzsx/xLS?=
 =?us-ascii?Q?98j8QardwSXpdHCmWHR52jURXHufRSbOxhlRsG5kDaNdU/NIAfjEUsQIz6+s?=
 =?us-ascii?Q?MvfrOC9G6KjK2qBaVwMsqLPiI/tAK6ULSFIDCBZT7cDb+f+qq0I6ejzVUhCL?=
 =?us-ascii?Q?SFULSpmak57Ot56OLk9a8Y5WiD+eO35sWacky7xhfU7TbrkDxmB0tpIQNBHe?=
 =?us-ascii?Q?u1REL5T3TDLiG25ioHKzgZlmxMseuB03dX2Cngiiw0wnJtJdr00jNvK/poCm?=
 =?us-ascii?Q?9PC88F/HVh9Q0kWdW+cLlR6DyJDvRuNamPESzEfREGU0IvwFggWdCDG4hGpa?=
 =?us-ascii?Q?nw3IbKfnTRj8nIukQA1ZjTolkdwZ+NOWgeJhOQDybdMICSUpasekqkd/wsdZ?=
 =?us-ascii?Q?cM/6dz1VswgxCY/mMQaiRM0+bkL7S75XnrOzWSgUhOwod2AEwZOSLjdplEc6?=
 =?us-ascii?Q?QuZ7Xx7tdqtF7ny21fyGmWNV4+xUDHTPn/4IX1W/naTWNnlE0ZXSBCoSpU4R?=
 =?us-ascii?Q?aNx++lpCuzKQ+REaueJxaRVDooLR+upihBAjOII1PAd8kvaKMxiTCbtOQ7yR?=
 =?us-ascii?Q?rtRVkRwlPKz6hKrE0b5aYTUPcIpsgwO2GaCpbCrHd4ZTlFhJsFtq8sNhFmEI?=
 =?us-ascii?Q?jX99V/ZMpGcT/3p8lhwtEOeU6gqpxbpfLUSKDH5nno01hJ+xF548J6tHx5RH?=
 =?us-ascii?Q?xBwYfOvWuqqCoQS/GCobsCBCRj0bDNpkYtZmViFcAJ9GbPZI6VbLjSFWWSG/?=
 =?us-ascii?Q?uoMCR3KnixRmROESty60J1cyTj6OaU4vImocgpkWgc2Q2tK0nzA6gIDe9Yyy?=
 =?us-ascii?Q?d45Jc2Dhw1D5aWsSmMKxYZoWGLjtEGufc/swJQ+hBBbQmR26rFjHUH2InlVB?=
 =?us-ascii?Q?J49IunOS0QgiQs9PvbO0DslkwCtki505TQ4LSxowBkPJcfthLNTeaWD9lvb8?=
 =?us-ascii?Q?a4t3yc/F3I7iqACY5hTd0ehO9XWzmzohJOZIqtfUQaVwKxWYKF+gc63rzlBj?=
 =?us-ascii?Q?DlZ430iRVg/5EMHAkE+O39f9DMVbGr1pQ1WeGHivwB1OmWAXayrder12crG7?=
 =?us-ascii?Q?HZCqoj1yE74iHvL0ZeYbzbHxjHFaemS32/PilYMIylOO05aMGQycuC7xXcNk?=
 =?us-ascii?Q?gkJXqA3jWW5HWVFemUsedLy48oPBn10Ui0aPm2BMYkvbuNrbsGK1Ip5s+KJP?=
 =?us-ascii?Q?7EoobtHgG/gh3oaNkeR6rytBQFiIVkpr/5AQUVFja5uZP91Or11oxs0DBWcp?=
 =?us-ascii?Q?toeQKv+A8TyI8R9e9TR1BWlu7KzcibbfivAq7S3KRiwIOf0Q5I+8BFR5LN4w?=
 =?us-ascii?Q?H3URM5oAKfOpExZiFyRHBBCtiIBrPgivYaMmOe7PaHwtXbt8dvd/sXwsles+?=
 =?us-ascii?Q?z2xnjj/WKJGNmepR++TX2Hyhlg+ZRCuOxwmn5BsrcJOqmWIEzMEphFAz/eOd?=
 =?us-ascii?Q?BYi6sJfg90U1yWvA61dGL6WPlmUJL/xCyCbTyCV0vuPy36YgfCcedDsrC+BE?=
 =?us-ascii?Q?uY4Si36zXtX/R5yThdJtQcamqu46Ux46UxYofZojGJiv5NKosRnWP4miYDxZ?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0023cb-8aad-495c-4692-08da7a0ddc88
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:48:38.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0P47+wF/aavBvealti9R4cnOb01a1LVadC5t7iIGNUDvmm66PG7OzJcJfot5OJS3uWRO7LMIzEhpDv6qZJaixtMx3Orc611AoYnpzPChy6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0367
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

Hello Bartosz, can you pick this? Patches 1 and 2 were applied to MFD
tree.

On Tue, Jul 12, 2022 at 06:33:43PM +0200, Francesco Dolcini wrote:
> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-stmpe.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt b/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
> index a0e4cf885213..b33f8f02c0d7 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
> @@ -8,8 +8,7 @@ Optional properties:
>   - st,norequest-mask: bitmask specifying which GPIOs should _not_ be requestable
>     due to different usage (e.g. touch, keypad)
>  
> -Node name must be stmpe_gpio and should be child node of stmpe node to which it
> -belongs.
> +Node should be child node of stmpe node to which it belongs.
>  
>  Example:
>  	stmpe_gpio {
> -- 
> 2.25.1
> 

