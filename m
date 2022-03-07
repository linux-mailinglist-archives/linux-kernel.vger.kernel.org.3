Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA5C4D0639
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbiCGSTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbiCGSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:19:21 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5227E338B8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:18:22 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220307181820epoutp02a89372ee21ebea6f441761900c23fb39~aLBlA9Tfk2803428034epoutp02f
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:18:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220307181820epoutp02a89372ee21ebea6f441761900c23fb39~aLBlA9Tfk2803428034epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646677100;
        bh=yObe62eKRo79ogg4bdn+NppaRR+lNn+OUf+J6vKKSmU=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=BzGhHBYRslskUMrWfL8//G/HXN7NVKKbpvJE76QJE2DhGOB/0KGU3iDivInEKEwb9
         AMqbRo2FGOy5SjbE7YkyOf4Ai2vkjY3yltW2Bkv+pdgcjVk73XQ5l7XiH52FbPffe7
         TskuDIfVYHSnfcls+VVjklV6LK3FXYkDq9Zzxlb8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220307181819epcas5p12db7491cb53d87990d686e0fe4b8dd93~aLBjxCi-I2203522035epcas5p1E;
        Mon,  7 Mar 2022 18:18:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KC6CB1Ttbz4x9Pr; Mon,  7 Mar
        2022 18:18:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.FA.06423.66C46226; Tue,  8 Mar 2022 03:18:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220307181812epcas5p13b4f7c9739ff70f59ad805ef12df7837~aLBdtqLjH2203522035epcas5p1D;
        Mon,  7 Mar 2022 18:18:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220307181812epsmtrp2dbadacb0ab77879b3cb286ef87c6155d~aLBds7ejU0032100321epsmtrp2O;
        Mon,  7 Mar 2022 18:18:12 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-e0-62264c6683b6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.D1.29871.46C46226; Tue,  8 Mar 2022 03:18:12 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220307181811epsmtip2962ee939affb743a581043e119f34caf~aLBcb5xzR1136311363epsmtip2n;
        Mon,  7 Mar 2022 18:18:11 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Jiri Slaby'" <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220307080925.54131-2-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v2 3/7] tty: serial: samsung: constify
 s3c24xx_serial_drv_data
Date:   Mon, 7 Mar 2022 23:48:10 +0530
Message-ID: <000101d8324f$b4ccb770$1e662650$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGoAYk8Q04rU2h+MYSS22x/2RnCswKBz9v7AmtXGBGs7TLzsA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmhm6aj1qSwZftnBbNi9ezWbybK2Ox
        8e0PJotNj6+xWlzeNYfNYsb5fUwWZxb3sjuwe8xq6GXz2LSqk81j/9w17B6bl9R7fN4kF8Aa
        lW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SEkkJZ
        Yk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7
        Y8LpOWwFE+srLj7Rb2B8nt3FyMkhIWAi8ePpU9YuRi4OIYHdjBJ7Ns5ih3A+MUpseXOIDcL5
        xiix98AJVpiWZY13GCESexkl/jV9gWp5ySgxfeU3FpAqNgFdiR2L28DaRQQ2MElcujeVCSTB
        KeAu8a5hCzOILSwQIjHh6g02EJtFQEXiwpXXYM28ApYSPU8esEPYghInZz4BizMLyEtsfzuH
        GeIMBYmfT5eBnSQi4CSx7tcWVogacYmXR4+AXSQh0MohceriYqi7XST+7fzPBGELS7w6voUd
        wpaS+PxuL9ARHEB2tkTPLmOIcI3E0nnHWCBse4kDV+awgJQwC2hKrN+lD7GKT6L39xMmiE5e
        iY42IYhqVYnmd1ehOqUlJnZ3Qx3gITHp6gxoiF5nlOhYs4l5AqPCLCRfzkLy5Swk38xC2LyA
        kWUVo2RqQXFuemqxaYFhXmo5PMKT83M3MYLTqJbnDsa7Dz7oHWJk4mA8xCjBwawkwnv/vEqS
        EG9KYmVValF+fFFpTmrxIUZTYNBPZJYSTc4HJvK8knhDE0sDEzMzMxNLYzNDJXHe0+kbEoUE
        0hNLUrNTUwtSi2D6mDg4pRqY1q+emrzmYElh34uTezSWbNNMtbNa4fT411WtjjSG7/y+aYKv
        o57pLTSp/SBguuN03oXu6PIVz/X3a7r0/Ao+vv/m/EdndMO3rbp6MHs+T0VgRZXRitvvLN7q
        ZcV8DHdZ8vJ22mWubOf4dZN61RzPhvVN/b2N42Ul39YvP+5p/7W2810iv39l22sRLu1faiu3
        ybUELCvyNDnxIc7eceZfzZYToS4Vyu8CC058MU5x6XewfbrnameM67P5Oiu08jyC/mm8vigo
        5PztlV50VeeJGtVbOzbIsZe16Uy7MEeb99AnVc1Fbn28ycK3z5rGMYTEMwa++j0t8I2Mhsq+
        RVu16gXeS4VNmm7/Q+WX60EVJZbijERDLeai4kQAgxmc5SwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvG6Kj1qSwYU9OhbNi9ezWbybK2Ox
        8e0PJotNj6+xWlzeNYfNYsb5fUwWZxb3sjuwe8xq6GXz2LSqk81j/9w17B6bl9R7fN4kF8Aa
        xWWTkpqTWZZapG+XwJUx4fQctoKJ9RUXn+g3MD7P7mLk5JAQMJFY1niHsYuRi0NIYDejRPfW
        l4wQCWmJ6xsnsEPYwhIr/z1nhyh6zijx7PUrsASbgK7EjsVtbCC2iMAWJolF3+Igii4zStw5
        fAisiFPAXeJdwxZmEFtYIEii+dh2FhCbRUBF4sKV12A2r4ClRM+TB+wQtqDEyZlPgOIcHMwC
        ehJtG8EOYhaQl9j+dg4zxEEKEj+fLmOF2Oskse7XFlaIGnGJl0ePsE9gFJqFZNIshEmzkEya
        haRjASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4HjR0tzBuH3VB71DjEwcjIcY
        JTiYlUR4759XSRLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomD
        U6qByZz7W9+DOo/J7u2ss3cFBqtpyz3XOL7iktuR/+uOdCSsl72Qz3Vbp1j95rzH7T4zv20K
        vGTC/zr88LbwqInzfRJeJ/RuKArIXS5wdI0Ky0eFWcIqN3ksEjpnXr969KO8Y/CkPWsFJz1+
        1+tqLs//VKHUN8mnTnlLd85W9n8u1rs9nfVLpMru99S6zrGPDtQp3bvRa92ps/O7uTTCbj/1
        F/Sd/nJluEKq85mvk6QKLskbvni4jcH7Td8Tu76iChml+o6+2fIMl7/tE/xzsTF5+d8fyee/
        nU50a17y69M163ufDK9Nz08QeXVZoi6OW5qzuPVPVsr2rU6fmnl2fHjAIvv0y/kTR1iy79Yu
        3Wb9XYmlOCPRUIu5qDgRAAXVs04GAwAA
X-CMS-MailID: 20220307181812epcas5p13b4f7c9739ff70f59ad805ef12df7837
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307080950epcas5p1d9cfa929d372c012375f6b7d3d8bf8dc
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
        <CGME20220307080950epcas5p1d9cfa929d372c012375f6b7d3d8bf8dc@epcas5p1.samsung.com>
        <20220307080925.54131-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Monday, March 7, 2022 1:39 PM
>To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>serial@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [PATCH v2 3/7] tty: serial: samsung: constify
s3c24xx_serial_drv_data
>
>The driver data (struct s3c24xx_serial_drv_data) is only used to initialize
the
>driver properly and is not modified.  Make it const.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> drivers/tty/serial/samsung_tty.c | 130 +++++++++++++++----------------
> 1 file changed, 65 insertions(+), 65 deletions(-)
>
>diff --git a/drivers/tty/serial/samsung_tty.c
>b/drivers/tty/serial/samsung_tty.c
>index a9a75b5b9705..c4b13f2d6e26 100644
>--- a/drivers/tty/serial/samsung_tty.c
>+++ b/drivers/tty/serial/samsung_tty.c
>@@ -136,14 +136,14 @@ struct s3c24xx_uart_port {
> 	unsigned int			tx_mode;
> 	unsigned int			rx_mode;
>
>-	struct s3c24xx_uart_info	*info;
>+	const struct s3c24xx_uart_info	*info;
> 	struct clk			*clk;
> 	struct clk			*baudclk;
> 	struct uart_port		port;
>-	struct s3c24xx_serial_drv_data	*drv_data;
>+	const struct s3c24xx_serial_drv_data	*drv_data;
>
> 	/* reference to platform data */
>-	struct s3c2410_uartcfg		*cfg;
>+	const struct s3c2410_uartcfg	*cfg;
>
> 	struct s3c24xx_uart_dma		*dma;
>
>@@ -221,7 +221,7 @@ static inline void s3c24xx_clear_bit(struct uart_port
>*port, int idx,
> 	local_irq_restore(flags);
> }
>
>-static inline struct s3c24xx_uart_port *to_ourport(struct uart_port *port)
>+static inline struct s3c24xx_uart_port *to_ourport(const struct
>+uart_port *port)
> {
> 	return container_of(port, struct s3c24xx_uart_port, port);  } @@ -
>573,13 +573,13 @@ static void s3c24xx_serial_stop_rx(struct uart_port
*port)
> 	}
> }
>
>-static inline struct s3c24xx_uart_info
>+static inline const struct s3c24xx_uart_info
> 	*s3c24xx_port_to_info(struct uart_port *port)  {
> 	return to_ourport(port)->info;
> }
>
>-static inline struct s3c2410_uartcfg
>+static inline const struct s3c2410_uartcfg
> 	*s3c24xx_port_to_cfg(struct uart_port *port)  {
> 	struct s3c24xx_uart_port *ourport;
>@@ -594,7 +594,7 @@ static inline struct s3c2410_uartcfg  static int
>s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
> 				     unsigned long ufstat)
> {
>-	struct s3c24xx_uart_info *info = ourport->info;
>+	const struct s3c24xx_uart_info *info = ourport->info;
>
> 	if (ufstat & info->rx_fifofull)
> 		return ourport->port.fifosize;
>@@ -986,7 +986,7 @@ static irqreturn_t apple_serial_handle_irq(int irq,
void
>*id)
>
> static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)  {
>-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
> 	unsigned long ufstat = rd_regl(port, S3C2410_UFSTAT);
> 	unsigned long ufcon = rd_regl(port, S3C2410_UFCON);
>
>@@ -1405,7 +1405,7 @@ static void s3c24xx_serial_pm(struct uart_port
>*port, unsigned int level,
>
> static inline int s3c24xx_serial_getsource(struct uart_port *port)  {
>-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
> 	unsigned int ucon;
>
> 	if (info->num_clks == 1)
>@@ -1419,7 +1419,7 @@ static inline int s3c24xx_serial_getsource(struct
>uart_port *port)  static void s3c24xx_serial_setsource(struct uart_port
*port,
> 			unsigned int clk_sel)
> {
>-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
> 	unsigned int ucon;
>
> 	if (info->num_clks == 1)
>@@ -1438,7 +1438,7 @@ static unsigned int s3c24xx_serial_getclk(struct
>s3c24xx_uart_port *ourport,
> 			unsigned int req_baud, struct clk **best_clk,
> 			unsigned int *clk_num)
> {
>-	struct s3c24xx_uart_info *info = ourport->info;
>+	const struct s3c24xx_uart_info *info = ourport->info;
> 	struct clk *clk;
> 	unsigned long rate;
> 	unsigned int cnt, baud, quot, best_quot = 0; @@ -1522,7 +1522,7 @@
>static void s3c24xx_serial_set_termios(struct uart_port *port,
> 				       struct ktermios *termios,
> 				       struct ktermios *old)
> {
>-	struct s3c2410_uartcfg *cfg = s3c24xx_port_to_cfg(port);
>+	const struct s3c2410_uartcfg *cfg = s3c24xx_port_to_cfg(port);
> 	struct s3c24xx_uart_port *ourport = to_ourport(port);
> 	struct clk *clk = ERR_PTR(-EINVAL);
> 	unsigned long flags;
>@@ -1691,7 +1691,7 @@ static const char *s3c24xx_serial_type(struct
>uart_port *port)
>
> static void s3c24xx_serial_config_port(struct uart_port *port, int flags)
{
>-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>
> 	if (flags & UART_CONFIG_TYPE)
> 		port->type = info->port_type;
>@@ -1703,7 +1703,7 @@ static void s3c24xx_serial_config_port(struct
>uart_port *port, int flags)  static int  s3c24xx_serial_verify_port(struct
>uart_port *port, struct serial_struct *ser)  {
>-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>
> 	if (ser->type != PORT_UNKNOWN && ser->type != info->port_type)
> 		return -EINVAL;
>@@ -1873,9 +1873,9 @@
>s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
>  */
>
> static void s3c24xx_serial_resetport(struct uart_port *port,
>-				   struct s3c2410_uartcfg *cfg)
>+				     const struct s3c2410_uartcfg *cfg)
> {
>-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
> 	unsigned long ucon = rd_regl(port, S3C2410_UCON);
>
> 	ucon &= (info->clksel_mask | info->ucon_mask); @@ -1979,7 +1979,7
>@@ s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *port)
>static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
>{
> 	struct device *dev = ourport->port.dev;
>-	struct s3c24xx_uart_info *info = ourport->info;
>+	const struct s3c24xx_uart_info *info = ourport->info;
> 	char clk_name[MAX_CLK_NAME_LENGTH];
> 	unsigned int clk_sel;
> 	struct clk *clk;
>@@ -2021,7 +2021,7 @@ static int s3c24xx_serial_init_port(struct
>s3c24xx_uart_port *ourport,
> 				    struct platform_device *platdev)  {
> 	struct uart_port *port = &ourport->port;
>-	struct s3c2410_uartcfg *cfg = ourport->cfg;
>+	const struct s3c2410_uartcfg *cfg = ourport->cfg;
> 	struct resource *res;
> 	int ret;
>
>@@ -2156,7 +2156,7 @@ static const struct of_device_id
>s3c24xx_uart_dt_match[];
>
> static int probe_index;
>
>-static inline struct s3c24xx_serial_drv_data *
>+static inline const struct s3c24xx_serial_drv_data *
> s3c24xx_get_driver_data(struct platform_device *pdev)  {  #ifdef
>CONFIG_OF @@ -2419,7 +2419,7 @@ static struct uart_port *cons_uart;
>static int  s3c24xx_serial_console_txrdy(struct uart_port *port, unsigned
int
>ufcon)  {
>-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>+	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
> 	unsigned long ufstat, utrstat;
>
> 	if (ufcon & S3C2410_UFCON_FIFOMODE) {
>@@ -2615,7 +2615,7 @@ static struct console s3c24xx_serial_console = {
>#endif /* CONFIG_SERIAL_SAMSUNG_CONSOLE */
>
> #ifdef CONFIG_CPU_S3C2410
>-static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
>+static const struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
> 	.info = {
> 		.name		= "Samsung S3C2410 UART",
> 		.type		= TYPE_S3C24XX,
>@@ -2637,13 +2637,13 @@ static struct s3c24xx_serial_drv_data
>s3c2410_serial_drv_data = {
> 		.ufcon		= S3C2410_UFCON_DEFAULT,
> 	},
> };
>-#define S3C2410_SERIAL_DRV_DATA
>((kernel_ulong_t)&s3c2410_serial_drv_data)
>+#define S3C2410_SERIAL_DRV_DATA (&s3c2410_serial_drv_data)
> #else
>-#define S3C2410_SERIAL_DRV_DATA (kernel_ulong_t)NULL
>+#define S3C2410_SERIAL_DRV_DATA NULL
> #endif
>
> #ifdef CONFIG_CPU_S3C2412
>-static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
>+static const struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
> 	.info = {
> 		.name		= "Samsung S3C2412 UART",
> 		.type		= TYPE_S3C24XX,
>@@ -2666,14 +2666,14 @@ static struct s3c24xx_serial_drv_data
>s3c2412_serial_drv_data = {
> 		.ufcon		= S3C2410_UFCON_DEFAULT,
> 	},
> };
>-#define S3C2412_SERIAL_DRV_DATA
>((kernel_ulong_t)&s3c2412_serial_drv_data)
>+#define S3C2412_SERIAL_DRV_DATA (&s3c2412_serial_drv_data)
> #else
>-#define S3C2412_SERIAL_DRV_DATA (kernel_ulong_t)NULL
>+#define S3C2412_SERIAL_DRV_DATA NULL
> #endif
>
> #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
> 	defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2442) -
>static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
>+static const struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
> 	.info = {
> 		.name		= "Samsung S3C2440 UART",
> 		.type		= TYPE_S3C24XX,
>@@ -2697,13 +2697,13 @@ static struct s3c24xx_serial_drv_data
>s3c2440_serial_drv_data = {
> 		.ufcon		= S3C2410_UFCON_DEFAULT,
> 	},
> };
>-#define S3C2440_SERIAL_DRV_DATA
>((kernel_ulong_t)&s3c2440_serial_drv_data)
>+#define S3C2440_SERIAL_DRV_DATA (&s3c2440_serial_drv_data)
> #else
>-#define S3C2440_SERIAL_DRV_DATA (kernel_ulong_t)NULL
>+#define S3C2440_SERIAL_DRV_DATA NULL
> #endif
>
> #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410) -
>static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
>+static const struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
> 	.info = {
> 		.name		= "Samsung S3C6400 UART",
> 		.type		= TYPE_S3C6400,
>@@ -2726,13 +2726,13 @@ static struct s3c24xx_serial_drv_data
>s3c6400_serial_drv_data = {
> 		.ufcon		= S3C2410_UFCON_DEFAULT,
> 	},
> };
>-#define S3C6400_SERIAL_DRV_DATA
>((kernel_ulong_t)&s3c6400_serial_drv_data)
>+#define S3C6400_SERIAL_DRV_DATA (&s3c6400_serial_drv_data)
> #else
>-#define S3C6400_SERIAL_DRV_DATA (kernel_ulong_t)NULL
>+#define S3C6400_SERIAL_DRV_DATA NULL
> #endif
>
> #ifdef CONFIG_CPU_S5PV210
>-static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>+static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
> 	.info = {
> 		.name		= "Samsung S5PV210 UART",
> 		.type		= TYPE_S3C6400,
>@@ -2755,9 +2755,9 @@ static struct s3c24xx_serial_drv_data
>s5pv210_serial_drv_data = {
> 	},
> 	.fifosize = { 256, 64, 16, 16 },
> };
>-#define S5PV210_SERIAL_DRV_DATA
>((kernel_ulong_t)&s5pv210_serial_drv_data)
>+#define S5PV210_SERIAL_DRV_DATA (&s5pv210_serial_drv_data)
> #else
>-#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
>+#define S5PV210_SERIAL_DRV_DATA	NULL
> #endif
>
> #if defined(CONFIG_ARCH_EXYNOS)
>@@ -2784,33 +2784,33 @@ static struct s3c24xx_serial_drv_data
>s5pv210_serial_drv_data = {
> 		.has_fracval	= 1,				\
> 	}							\
>
>-static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
>+static const struct s3c24xx_serial_drv_data exynos4210_serial_drv_data
>+= {
> 	EXYNOS_COMMON_SERIAL_DRV_DATA(),
> 	.fifosize = { 256, 64, 16, 16 },
> };
>
>-static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
>+static const struct s3c24xx_serial_drv_data exynos5433_serial_drv_data
>+= {
> 	EXYNOS_COMMON_SERIAL_DRV_DATA(),
> 	.fifosize = { 64, 256, 16, 256 },
> };
>
>-static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
>+static const struct s3c24xx_serial_drv_data exynos850_serial_drv_data =
>+{
> 	EXYNOS_COMMON_SERIAL_DRV_DATA(),
> 	.fifosize = { 256, 64, 64, 64 },
> };
>
>-#define EXYNOS4210_SERIAL_DRV_DATA
>((kernel_ulong_t)&exynos4210_serial_drv_data)
>-#define EXYNOS5433_SERIAL_DRV_DATA
>((kernel_ulong_t)&exynos5433_serial_drv_data)
>-#define EXYNOS850_SERIAL_DRV_DATA
>((kernel_ulong_t)&exynos850_serial_drv_data)
>+#define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
>+#define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
>+#define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
>
> #else
>-#define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)NULL) -#define
>EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)NULL) -#define
>EXYNOS850_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
>+#define EXYNOS4210_SERIAL_DRV_DATA NULL #define
>+EXYNOS5433_SERIAL_DRV_DATA NULL #define
>EXYNOS850_SERIAL_DRV_DATA NULL
> #endif
>
> #ifdef CONFIG_ARCH_APPLE
>-static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
>+static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
> 	.info = {
> 		.name		= "Apple S5L UART",
> 		.type		= TYPE_APPLE_S5L,
>@@ -2832,39 +2832,39 @@ static struct s3c24xx_serial_drv_data
>s5l_serial_drv_data = {
> 		.ufcon		= S3C2410_UFCON_DEFAULT,
> 	},
> };
>-#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)&s5l_serial_drv_data)
>+#define S5L_SERIAL_DRV_DATA (&s5l_serial_drv_data)
> #else
>-#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
>+#define S5L_SERIAL_DRV_DATA NULL
> #endif
>
> static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
> 	{
> 		.name		= "s3c2410-uart",
>-		.driver_data	= S3C2410_SERIAL_DRV_DATA,
>+		.driver_data	=
>(kernel_ulong_t)S3C2410_SERIAL_DRV_DATA,
> 	}, {
> 		.name		= "s3c2412-uart",
>-		.driver_data	= S3C2412_SERIAL_DRV_DATA,
>+		.driver_data	=
>(kernel_ulong_t)S3C2412_SERIAL_DRV_DATA,
> 	}, {
> 		.name		= "s3c2440-uart",
>-		.driver_data	= S3C2440_SERIAL_DRV_DATA,
>+		.driver_data	=
>(kernel_ulong_t)S3C2440_SERIAL_DRV_DATA,
> 	}, {
> 		.name		= "s3c6400-uart",
>-		.driver_data	= S3C6400_SERIAL_DRV_DATA,
>+		.driver_data	=
>(kernel_ulong_t)S3C6400_SERIAL_DRV_DATA,
> 	}, {
> 		.name		= "s5pv210-uart",
>-		.driver_data	= S5PV210_SERIAL_DRV_DATA,
>+		.driver_data	=
>(kernel_ulong_t)S5PV210_SERIAL_DRV_DATA,
> 	}, {
> 		.name		= "exynos4210-uart",
>-		.driver_data	= EXYNOS4210_SERIAL_DRV_DATA,
>+		.driver_data	=
>(kernel_ulong_t)EXYNOS4210_SERIAL_DRV_DATA,
> 	}, {
> 		.name		= "exynos5433-uart",
>-		.driver_data	= EXYNOS5433_SERIAL_DRV_DATA,
>+		.driver_data	=
>(kernel_ulong_t)EXYNOS5433_SERIAL_DRV_DATA,
> 	}, {
> 		.name		= "s5l-uart",
>-		.driver_data	= S5L_SERIAL_DRV_DATA,
>+		.driver_data	= (kernel_ulong_t)S5L_SERIAL_DRV_DATA,
> 	}, {
> 		.name		= "exynos850-uart",
>-		.driver_data	= EXYNOS850_SERIAL_DRV_DATA,
>+		.driver_data	=
>(kernel_ulong_t)EXYNOS850_SERIAL_DRV_DATA,
> 	},
> 	{ },
> };
>@@ -2873,23 +2873,23 @@ MODULE_DEVICE_TABLE(platform,
>s3c24xx_serial_driver_ids);  #ifdef CONFIG_OF  static const struct
>of_device_id s3c24xx_uart_dt_match[] = {
> 	{ .compatible = "samsung,s3c2410-uart",
>-		.data = (void *)S3C2410_SERIAL_DRV_DATA },
>+		.data = S3C2410_SERIAL_DRV_DATA },
> 	{ .compatible = "samsung,s3c2412-uart",
>-		.data = (void *)S3C2412_SERIAL_DRV_DATA },
>+		.data = S3C2412_SERIAL_DRV_DATA },
> 	{ .compatible = "samsung,s3c2440-uart",
>-		.data = (void *)S3C2440_SERIAL_DRV_DATA },
>+		.data = S3C2440_SERIAL_DRV_DATA },
> 	{ .compatible = "samsung,s3c6400-uart",
>-		.data = (void *)S3C6400_SERIAL_DRV_DATA },
>+		.data = S3C6400_SERIAL_DRV_DATA },
> 	{ .compatible = "samsung,s5pv210-uart",
>-		.data = (void *)S5PV210_SERIAL_DRV_DATA },
>+		.data = S5PV210_SERIAL_DRV_DATA },
> 	{ .compatible = "samsung,exynos4210-uart",
>-		.data = (void *)EXYNOS4210_SERIAL_DRV_DATA },
>+		.data = EXYNOS4210_SERIAL_DRV_DATA },
> 	{ .compatible = "samsung,exynos5433-uart",
>-		.data = (void *)EXYNOS5433_SERIAL_DRV_DATA },
>+		.data = EXYNOS5433_SERIAL_DRV_DATA },
> 	{ .compatible = "apple,s5l-uart",
>-		.data = (void *)S5L_SERIAL_DRV_DATA },
>+		.data = S5L_SERIAL_DRV_DATA },
> 	{ .compatible = "samsung,exynos850-uart",
>-		.data = (void *)EXYNOS850_SERIAL_DRV_DATA },
>+		.data = EXYNOS850_SERIAL_DRV_DATA },
> 	{},
> };
> MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
>--
>2.32.0


