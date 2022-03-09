Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF574D3DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiCIXyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiCIXyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:54:15 -0500
X-Greylist: delayed 1469 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 15:53:13 PST
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.151.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC6C74607
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:53:13 -0800 (PST)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 7305B13116
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:25:25 -0600 (CST)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id S5gLnMD1G9AGSS5gLncIOB; Wed, 09 Mar 2022 17:25:25 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j2oKgn9eLs375qgfE96Bspnkel26NAPBR0e3aVigLuw=; b=VCjIdmK58ynNO/iJx0ibGOYrGa
        Xz6VUjXhlFYjVIKSabx4AgiaYKW/pZuFAINqpRTo1en+nDXx8LaG7u095SUH7ntqjrjQEVQcPLSpB
        mjExvyJQ+k36LQfCMBZQN4C3mDnIUdcPki3diEXSZ9WjOz5r5rQ6Jo6P4llFXS3JAKVmFk/BfonG7
        IMzq0DZa62vEuUy2PVzwIh2pxz9dhTHIWiQpNLUFL9QyPAm46dG2jhEjyWcAhDSC8XT9G7Mk4LZDc
        w3jffoxYlBhkZe1nDzeWZraDQp4ffh64VwFQwPBNUS6Sj3UNYlgDIAz3INC2gNW3qYrC33qOES3eo
        zaj0V5hg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57414 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nS5gK-000V88-Nj; Wed, 09 Mar 2022 23:25:24 +0000
Date:   Wed, 9 Mar 2022 15:25:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: mt7986: Add reset-controller
 header file
Message-ID: <20220309232523.GA3804043@roeck-us.net>
References: <20220105100456.7126-1-sam.shih@mediatek.com>
 <20220105100456.7126-2-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105100456.7126-2-sam.shih@mediatek.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nS5gK-000V88-Nj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57414
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 86
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:04:55PM +0800, Sam Shih wrote:
> Add infracfg, toprgu, and ethsys reset-controller header file
> for MT7986 platform.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  include/dt-bindings/reset/mt7986-resets.h | 55 +++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mt7986-resets.h
> 
> diff --git a/include/dt-bindings/reset/mt7986-resets.h b/include/dt-bindings/reset/mt7986-resets.h
> new file mode 100644
> index 000000000000..af3d16c81192
> --- /dev/null
> +++ b/include/dt-bindings/reset/mt7986-resets.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Sam Shih <sam.shih@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT7986
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT7986
> +
> +/* INFRACFG resets */
> +#define MT7986_INFRACFG_PEXTP_MAC_SW_RST	6
> +#define MT7986_INFRACFG_SSUSB_SW_RST		7
> +#define MT7986_INFRACFG_EIP97_SW_RST		8
> +#define MT7986_INFRACFG_AUDIO_SW_RST		13
> +#define MT7986_INFRACFG_CQ_DMA_SW_RST		14
> +
> +#define MT7986_INFRACFG_TRNG_SW_RST		17
> +#define MT7986_INFRACFG_AP_DMA_SW_RST		32
> +#define MT7986_INFRACFG_I2C_SW_RST		33
> +#define MT7986_INFRACFG_NFI_SW_RST		34
> +#define MT7986_INFRACFG_SPI0_SW_RST		35
> +#define MT7986_INFRACFG_SPI1_SW_RST		36
> +#define MT7986_INFRACFG_UART0_SW_RST		37
> +#define MT7986_INFRACFG_UART1_SW_RST		38
> +#define MT7986_INFRACFG_UART2_SW_RST		39
> +#define MT7986_INFRACFG_AUXADC_SW_RST		43
> +
> +#define MT7986_INFRACFG_APXGPT_SW_RST		66
> +#define MT7986_INFRACFG_PWM_SW_RST		68
> +
> +#define MT7986_INFRACFG_SW_RST_NUM		69
> +
> +/* TOPRGU resets */
> +#define MT7986_TOPRGU_APMIXEDSYS_SW_RST		0
> +#define MT7986_TOPRGU_SGMII0_SW_RST		1
> +#define MT7986_TOPRGU_SGMII1_SW_RST		2
> +#define MT7986_TOPRGU_INFRA_SW_RST		3
> +#define MT7986_TOPRGU_U2PHY_SW_RST		5
> +#define MT7986_TOPRGU_PCIE_SW_RST		6
> +#define MT7986_TOPRGU_SSUSB_SW_RST		7
> +#define MT7986_TOPRGU_ETHDMA_SW_RST		20
> +#define MT7986_TOPRGU_CONSYS_SW_RST		23
> +
> +#define MT7986_TOPRGU_SW_RST_NUM		24
> +
> +/* ETHSYS Subsystem resets */
> +#define MT7986_ETHSYS_FE_SW_RST			6
> +#define MT7986_ETHSYS_PMTR_SW_RST		8
> +#define MT7986_ETHSYS_GMAC_SW_RST		23
> +#define MT7986_ETHSYS_PPE0_SW_RST		30
> +#define MT7986_ETHSYS_PPE1_SW_RST		31
> +
> +#define MT7986_ETHSYS_SW_RST_NUM		32
> +
> +#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT7986 */
