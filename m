Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC5553962
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiFUSIA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Jun 2022 14:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiFUSH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:07:58 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C819026D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:07:56 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-OjobX4JCNpa7FRiYEWSJow-2; Tue, 21 Jun 2022 20:07:51 +0200
X-MC-Unique: OjobX4JCNpa7FRiYEWSJow-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0205.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Tue, 21 Jun 2022 18:07:49 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%8]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 18:07:49 +0000
Date:   Tue, 21 Jun 2022 20:07:49 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
Message-ID: <20220621180749.GA22098@francesco-nb.int.toradex.com>
References: <20220512104019.19725-1-andrejs.cainikovs@toradex.com>
In-Reply-To: <20220512104019.19725-1-andrejs.cainikovs@toradex.com>
X-ClientProxiedBy: ZR0P278CA0032.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::19) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3740713f-a95e-4b48-1c54-08da53b0f3e0
X-MS-TrafficTypeDiagnostic: ZRAP278MB0205:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB0205B0BA45B8C22DC2C1A01EE2B39@ZRAP278MB0205.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: X1Wn/BUJ2cqUFo3+sf3eQGeoCMwktEao+QSxX9is+JcZIn89CzUS3MMVp6qNSJGHzRsw1NhesEVuuD+lXu4bU4oOdxzxhV5XzWSYXeGluBuNXbJV86t1hPHzNTRW3M5KR77y1+8cAyNHddvnODGhbu6+chqliaY4ipBon7gG6bNeCF2HVzhzqr31ViezRSWpcndHY8NKQGrm33ZoXfbvkHiYxswVW4WCBidrZZiM03dDUdTGzZkGXUXg9Xh0M8yFlAPm4ykk7WkceJtVr3P7Sq+Um1P/cezYVdTQxC3o4Nws9Pd94I20bo1RWh893UMPHlQxwFtdR6LH2Qld+VtxLz+bb2Tm2mScSX3r8xxYS/dOzpjBdGMJXBaVYo42yYyqd+E/DmPSfGZXkDUGo3oeOJBTRNGI384cf5Yu/wqo65/kwwJy2QnEK90mG8ANjh8TxoXfHtrAqQMgzNqL2uys9JMft15e7k7QYnE2TD2pdNHOO1PBQfl+d2CyYgbTFsAb36h88+pgOn/R11VOK/GRAFK0mKuVfl+/ow82ppdUYdgj9b2skndMAU+sL5MNnOdGI9Ezv5fserIhJbNdSbys/5VnHGnhr96aEUgcJZ5FZARG/+EuLGQh7DIAIKnfGxTUxD0Y2pxfVaZP9DZbz3FXoFI8+BeWfeT78qBbtAd7aQ0g67RiUyGZ9/6TkS2vNmBnrKu8nLA0F20SQXi1b1GuY6sB4MxyISsWmffpX8SmasU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39850400004)(396003)(376002)(366004)(6486002)(6916009)(8936002)(44832011)(7416002)(54906003)(66476007)(8676002)(66946007)(5660300002)(478600001)(316002)(86362001)(15650500001)(66556008)(4326008)(6506007)(52116002)(41300700001)(83380400001)(186003)(1076003)(2906002)(38100700002)(38350700002)(33656002)(26005)(6512007)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlbZF7BATbU7g/IQR1IJ/8qZ1GtXq3DPV1EI2f/zojpdOcA5GSvCvzqAKOLB?=
 =?us-ascii?Q?VnHqxQSMZLnnOHHf5rNieBjgwxd19wjBxZM29vPmQXzU4EYkyFFRbZW69oi0?=
 =?us-ascii?Q?7fY+YtZDNejQZu8n11bL1+MawAV+ZxMpwlN75J1waqKjXg1oq661Xr+LDVmc?=
 =?us-ascii?Q?IXKuw8aTrFiv74p7111QV2QO7HD8jdyr08OtL1nuK7iHbB6nvG/WQJ840V9Y?=
 =?us-ascii?Q?z5PdC63vm8dVoc8oU5Lak2F10KjMEv2itNdaiTzblqFecuQEiwtKfjdvFOLh?=
 =?us-ascii?Q?HkBwC8owM3TZJT1Lgb40vHWPQvQilFhvnHUheHejQbDyt9vDrK+AspVMpJaP?=
 =?us-ascii?Q?mxIVhtsRoxukiVAWl4LcLLcYFRWWI5J/BmoKZQzYoXGZ7D+To3oz0gDwNFeL?=
 =?us-ascii?Q?yPTtrfgLT1m5sROqnVBxRSwUfRa/A9eQ+4IhNRBxY2cxrWK/DKjlkbnyItQE?=
 =?us-ascii?Q?i7G3oNd1amDm3tPvuW2WYIMKc07wvXYY3os5o2Cd0DcObx7UERqgn/bPwgls?=
 =?us-ascii?Q?ZaX1hNqXa54HycqoDLSP5tUf83aG31lEj16toPiDVdgFb8jVOXkJiTCrihkS?=
 =?us-ascii?Q?doBQZ3+vXJpEO/jeOoiCWvvCByVTxAC+HY4Y8RLWyO/APQ9tI5bwTb29EGGK?=
 =?us-ascii?Q?A2VHINX3fsGESlZwNYHvtiSaVFUi5MnopoeBynYx9NlAYjDArr2M3vyrZjUQ?=
 =?us-ascii?Q?Ktwr1Tj2k1O+seueK35EtHUi/sO8Yi/3j9ba85IS+/XjTz1oHsL8/1FKs1Oi?=
 =?us-ascii?Q?T/OL6iwxjcNQyT2gP1lA0ZAODqvwr8jCkVHudWxMP7hjaJ2KEym0PiYOdKCx?=
 =?us-ascii?Q?cMMDMniGtolCL5Kzkmij3LQQCEQyLAuXVZRLfOeXXtSPOOUZA6MEOweIKcuE?=
 =?us-ascii?Q?GwS8SnQJRVMQDo+v4L6XKHuCljIvuhSFdQtpeChaJK7qbcyLNoURvuu31q2K?=
 =?us-ascii?Q?uKomeqAZtVRZdEx5arCs9/j/9tnNftc5VjBgJuFw9mrcJbT1xcc6eIlGIw7N?=
 =?us-ascii?Q?Mm6gERd69d4BByTxupWibDNVBqXlgMJums2dd5mRa0JqJ7sLT76LYO15c2bp?=
 =?us-ascii?Q?afa4RsPY8fczfnXNejNmNxSryToVMiQ08G0qp9ztm2f/buMHZk4lTwgQ3d5g?=
 =?us-ascii?Q?Et3gdqeoE5LFp51olqmE1NtgFwrt0mrmVt+EhTVg7Vw2YRLYW8xLJ3508aM9?=
 =?us-ascii?Q?+ugBXiWT0VWYR7Sv16k2vtfdCCmXhagpm7GB9V6ueOwHorlQjMVhQQ1qo7PO?=
 =?us-ascii?Q?RDSzPhuWdCd1yIejg2tHnuJPTQ6ZiPJC5Lc2k5VQoMPMkC6KmeOqa1pJR9LW?=
 =?us-ascii?Q?0okuvetDi1Vv+FxYmitXpieaxsJ5M4dP/mY9EISUzr8sSw4MWkmB3vsaCmd+?=
 =?us-ascii?Q?u9/88WZgU7rT+RlGbJRBPGsVU6PHeh6L8J4PoW5lWrqpa29hRGZuAik3G6ro?=
 =?us-ascii?Q?PRTeQONdBPab2rO0pjBr4HWatwaKk57AD5SA18UHpqcIpkos6hnILmQxypBa?=
 =?us-ascii?Q?wl5gM+wIHSVWyqdwPTYOlDratZrC4l7AuUaXgATD2E5HPqhnHzQO5Sjlx7LJ?=
 =?us-ascii?Q?G6l3YMWKrwJZXWZOAAYyyJhH3B3BBiG2adAZ1ssbwtNYnlBw1rrsJiFME4No?=
 =?us-ascii?Q?S18D08rF+6W7I65zro47AF2XxI4ZYD8Wx+kV+dNtq2xCjcjChF38guPSi6N1?=
 =?us-ascii?Q?GfJ62MdG4NGBqie4V2awBLLoAU+tNgCIUOF8z+RRNDni+02BE7HbL/MI4Czq?=
 =?us-ascii?Q?XJteWXYdMx46/v5uRGcESNTsp2HwbRg=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3740713f-a95e-4b48-1c54-08da53b0f3e0
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 18:07:49.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnf/Un7yW4XWWkAECswOgz0/alH3bhb0Tq5OnpS1MtWgqgix+NyGiHFY+BrPl8UcZFKHlBtQmeDaUYfP0zz+hQDVJcYgfStG6uI7qCcKUQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0205
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
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

Hello Shawn, just a ping on this.

Francesco

On Thu, May 12, 2022 at 12:40:19PM +0200, Andrejs Cainikovs wrote:
> Update SPI CAN controller clock to match current hardware design.
> 
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index 0d84d29e70f1..d309bc0ab8f6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -32,10 +32,10 @@ backlight: backlight {
>  	};
>  
>  	/* Fixed clock dedicated to SPI CAN controller */
> -	clk20m: oscillator {
> +	clk40m: oscillator {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> -		clock-frequency = <20000000>;
> +		clock-frequency = <40000000>;
>  	};
>  
>  	gpio-keys {
> @@ -194,7 +194,7 @@ &ecspi3 {
>  
>  	can1: can@0 {
>  		compatible = "microchip,mcp251xfd";
> -		clocks = <&clk20m>;
> +		clocks = <&clk40m>;
>  		interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_FALLING>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_can1_int>;
> -- 
> 2.34.1
> 

