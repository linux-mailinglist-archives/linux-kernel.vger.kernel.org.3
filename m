Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447B2525E66
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378889AbiEMJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358383AbiEMJJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:09:12 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315D916A5C4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:09:10 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9D70F2222E;
        Fri, 13 May 2022 11:09:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652432947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=drZBafNRRD8o2yUqVkUuztMcj8KnB3eY+uXj1DTr0JU=;
        b=JFRPd4T1Fz0NxydMSCyko8YTPuQsSjL9HQC/mhBHroZGL0VfB8vCwHd0Xhr8ip/XUAeWy0
        IicXViO3jJirz1Uj10XkEVRxXXZb+eFxIDU8G2VNtJw/cjnPYaGUq9mn2J49I/9rARZc3f
        Ok9l3hmFIzScf1fWAw3jszgTNvdHRlY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 May 2022 11:09:07 +0200
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     linux@armlinux.org.uk, linus.walleij@linaro.org,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Manohar.Puri@microchip.com
Subject: Re: [PATCH v3] ARM: at91: debug: add lan966 support
In-Reply-To: <20220513075035.18663-1-kavyasree.kotagiri@microchip.com>
References: <20220513075035.18663-1-kavyasree.kotagiri@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8f5c894ee9670c991e7d2897ef7c84aa@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-05-13 09:50, schrieb Kavyasree Kotagiri:
> Add support for low-level debugging on FLEXCOM USART of
> LAN966 SoC.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  arch/arm/Kconfig.debug | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 0c9497d549e3..b8a2364df9c1 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -210,6 +210,26 @@ choice
>  		  Say Y here if you want kernel low-level debugging support
>  		  on the FLEXCOM3 port of SAMA7G5.
> 
> +	config DEBUG_AT91_LAN966_FLEXCOM
> +		bool "Kernel low-level debugging on LAN966 FLEXCOM USART"
> +		select DEBUG_AT91_UART
> +		depends on SOC_LAN966x

depends on SOC_LAN966

With that fixed:
Reviewed-by: Michael Walle <michael@walle.cc>
Tested-by: Michael Walle <michael@walle.cc>

-michael
