Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EAE4B2090
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348172AbiBKIt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:49:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiBKItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:49:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B13E88
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:49:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FCCC61E34
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB841C340E9;
        Fri, 11 Feb 2022 08:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644569391;
        bh=S2Y36/twRcpdy7KwX8ESbgBJ1NXAZ68hbpX+eK5lM7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syl6wOVp/4MjkURgOojQvtu3FIlGF9UzO2C9qGefrtuzAPP/YMepMTVI6dTg5tCt6
         T4gBmwJsK0/HhuM75GyGmpoC2+lBmcYjtHv8ojJMToEDGykfDZSDNd7EakmUnUntUv
         PPkiijYOoN4Uh/UowU61Fa3n9L4TCSMIDr3kBAtF56Eo+6KBXduEo9v5iMaSLAtoKo
         qVetNeLRpObe+Prvsug5tAEr7qdQ3qDkN7tHxkhtvcf1ltmNtHjCePzkK/wAAeGvVO
         tAq97bEb6BIjgg4NgcrkDeFhMOlYJIADWlCJFQLe6/XHleGNO4QUUJWfiklhFFbFEZ
         Vtamsmnq7eIVQ==
Date:   Fri, 11 Feb 2022 16:49:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/12] arm64: defconfig: enable verdin-imx8mm relevant
 drivers as modules
Message-ID: <20220211084943.GQ4909@dragon>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
 <20220128160100.1228537-11-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128160100.1228537-11-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 05:00:58PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Enable various drivers which support peripherals as found on the
> Verdin iMX8M Mini et al. computer/system on modules:
> 
> - CONFIG_CAN_MCP251XFD
> At least one Microchip MCP2518FDT SPI CAN controller which this driver
> also supports may be found on the Verdin iMX8M Mini computer/system on
> module.
> 
> - CONFIG_BT_HCIUART_MRVL, CONFIG_BT_MRVL, CONFIG_BT_MRVL_SDIO and
>   CONFIG_MWIFIEX_SDIO
> The AzureWave AW-CM276NF which these Bluetooth and Wi-Fi drivers also
> support may be found on the Verdin iMX8M Mini (as well as the Apalis
> iMX8, Colibri iMX8X and Verdin iMX8M Plus for that matter) computer/
> system on module.
> 
> - CONFIG_SENSORS_LM75
> The TI TMP75C temperature sensor which this driver also supports may be
> found on the Verdin iMX8M Mini (as well as the Verdin iMX8M Plus for
> that matter) computer/system on module.
> 
> - CONFIG_SND_SOC_NAU8822
> The Nuvoton Technology Corporation (NTC) NAU88C22YG which this driver
> also supports may be found on the Verdin Development Board a carrier
> board for the Verdin family of computer/system on module which the
> Verdin iMX8M Mini (as well as the Verdin iMX8M Plus for that matter)
> may be mated in.
> 
> - CONFIG_TI_ADS1015
> The TLA2024 ADC which this driver also supports may be found on the
> Verdin iMX8M Mini (as well as the Verdin iMX8M Plus for that matter)
> computer/system on module.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied #1 ~ #10, thanks!
