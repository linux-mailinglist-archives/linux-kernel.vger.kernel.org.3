Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D14D1B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbiCHP0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiCHPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:25:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF36C473B2;
        Tue,  8 Mar 2022 07:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646753103; x=1678289103;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=obCCS3BdzrwExG9xpWAFThjRl4GzkZv81IRkCSJcDnA=;
  b=pRyZGQDaNEZQlN649mHIkktJsEI+lOKKo4f3EXDRD3zjwmoNwl/DEv5A
   SbW+PKx2Fh7N2GaZJaYlZPDCF+Zsm1rMGWEJn1MXRLtBoqGvAA5naborV
   qx8ehenIE73VGDu3kAcRcfzb8RRLK+y2P65wpP+Sx/iJdPEVaiNRIdQf6
   4V5RHtrhv+k/wHyZ/1kk21afSk+xrIyBKlEXEMJfdEajvL26kztZsDmA6
   036UdU1NqTTizBj/yStn/mXJSkUbLknnIirrTLEqF38IcqKuUGlqlFN7m
   wDysKbzTfuDiKMRru7nE0kv3wesYUW6Y1fz5Oj3YnKBbtsji/TzI5WZ/B
   A==;
X-IronPort-AV: E=Sophos;i="5.90,165,1643698800"; 
   d="scan'208";a="155667355"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 08:25:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 08:25:02 -0700
Received: from [10.12.73.60] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 08:25:00 -0700
Message-ID: <487711a7-baca-6992-6e5e-1ff19d54ad0b@microchip.com>
Date:   Tue, 8 Mar 2022 16:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: COMMON_CLK_LAN966X should depend on SOC_LAN966
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <eb102eae05e5667b9bd342a0c387f7f262d24bda.1645716471.git.geert+renesas@glider.be>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <eb102eae05e5667b9bd342a0c387f7f262d24bda.1645716471.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2022 at 16:29, Geert Uytterhoeven wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The LAN966x Generic Clock Controller is only present on Microchip
> LAN966x SoCs.  Hence add a dependency on SOC_LAN966, to prevent asking
> the user about this driver when configuring a kernel without LAN966x SoC
> support.
> 
> Fixes: 54104ee023333e3b ("clk: lan966x: Add lan966x SoC clock driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Horatiu, Kavyasree,
We probably need your view on this.

Best regards,
   Nicolas

> ---
>   drivers/clk/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c390e26dadf471f5..1c82a3e1129d4342 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -232,6 +232,7 @@ config COMMON_CLK_GEMINI
> 
>   config COMMON_CLK_LAN966X
>          bool "Generic Clock Controller driver for LAN966X SoC"
> +       depends on SOC_LAN966 || COMPILE_TEST
>          help
>            This driver provides support for Generic Clock Controller(GCK) on
>            LAN966X SoC. GCK generates and supplies clock to various peripherals
> --
> 2.25.1
> 


-- 
Nicolas Ferre
