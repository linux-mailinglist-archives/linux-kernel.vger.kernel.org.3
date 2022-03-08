Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4F4D1C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347997AbiCHPvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiCHPvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:51:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E6C4F451;
        Tue,  8 Mar 2022 07:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646754607; x=1678290607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uoonVeIcIw0ZF7CyzIEfJW8mtwFWH3uBfX/PSuQYy6c=;
  b=lENOGMPvY3FlhJOwKXaVnqVAm/w3qNBFPKLAEfUxqWFJ6l9XOvhodt57
   euzxHcsSSZyDDQwYnBvcMCZHK9CFSQSA1iRlv4azMWJuCL/593sRfxEPf
   NY8fAZYcpKvkCgIGcfY5QIp0MpTvbyOSCt8hdX+b9G8mKszr/yNK+Y91w
   GAejkdgXkM5veV4azo5uAxXGJJdlgllNkb9HxMVbrwuWl5w1jbwNhmmQE
   3jo6C1PDi3ljtfGnSjBGZ4YLhuCk/bamiel6g/ZZxCefwpUxHTGcvR+ea
   UXn2maBFybdEwCD9Y62DchKy7JYnojjnQo+r3WhlEhuVShSTHQjcIm4Tf
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,165,1643698800"; 
   d="scan'208";a="156124961"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 08:50:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 08:50:01 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 08:50:01 -0700
Date:   Tue, 8 Mar 2022 16:52:53 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Kavyasree Kotagiri" <kavyasree.kotagiri@microchip.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: COMMON_CLK_LAN966X should depend on SOC_LAN966
Message-ID: <20220308155253.aoedxrdke2l3homa@soft-dev3-1.localhost>
References: <eb102eae05e5667b9bd342a0c387f7f262d24bda.1645716471.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <eb102eae05e5667b9bd342a0c387f7f262d24bda.1645716471.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 02/24/2022 16:29, Geert Uytterhoeven wrote:
> 
> The LAN966x Generic Clock Controller is only present on Microchip
> LAN966x SoCs.  Hence add a dependency on SOC_LAN966, to prevent asking
> the user about this driver when configuring a kernel without LAN966x SoC
> support.

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> 
> Fixes: 54104ee023333e3b ("clk: lan966x: Add lan966x SoC clock driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/clk/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c390e26dadf471f5..1c82a3e1129d4342 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -232,6 +232,7 @@ config COMMON_CLK_GEMINI
> 
>  config COMMON_CLK_LAN966X
>         bool "Generic Clock Controller driver for LAN966X SoC"
> +       depends on SOC_LAN966 || COMPILE_TEST
>         help
>           This driver provides support for Generic Clock Controller(GCK) on
>           LAN966X SoC. GCK generates and supplies clock to various peripherals
> --
> 2.25.1
> 

-- 
/Horatiu
