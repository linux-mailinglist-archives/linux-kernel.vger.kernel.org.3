Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902AA4F7899
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242448AbiDGH7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242408AbiDGH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B7510DA50;
        Thu,  7 Apr 2022 00:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7323D61E59;
        Thu,  7 Apr 2022 07:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA8EC385A5;
        Thu,  7 Apr 2022 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649318267;
        bh=Ww1dxa+3bAwj5Iok8ViSt3VRfDANMYAW8WjVDv/Vg50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R3wXsf7IdmT3qfxmc9PfyS342yh65B4d9KWZXK0OgfCmRmwJPdbVRlJGzKR3lajqW
         YpPiAyabUo62zVXM5bX7v1ZIOs2p9CGmGlitEdtB2d2Dv5Z/yjViG3843CAra/1IBv
         iBL8mjSv+nUIENJRpS5tOxstcriye5A61a2ZFE9+dvFDIoHYnb2Bv01PKi8Oum1COF
         D9pNNoWkTJBchHc1MD6OhMO17OeBTPk01Z7J8YM6dMf8DG+8uh5L7fRSy6me+pKVy7
         iuCTTAbQhun4i8EVPTHE38lLmdhR4jajZN7P+VNMDPSld+4ue3ZkaqCeA+YE5a7Fz/
         arG+St2Lk/weQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ncN1U-002Ou6-VB; Thu, 07 Apr 2022 08:57:45 +0100
MIME-Version: 1.0
Date:   Thu, 07 Apr 2022 08:57:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] arm64: dts: Add Pensando Elba SoC support
In-Reply-To: <20220406233648.21644-12-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-12-brad@pensando.io>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9c08f621be28dba65e811bc9cdedc882@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: brad@pensando.io, linux-arm-kernel@lists.infradead.org, arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com, broonie@kernel.org, fancer.lancer@gmail.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net, dac2@pensando.io, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-07 00:36, Brad Larson wrote:
> Add Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Changed to dual copyright (GPL-2.0+ OR MIT)
> - Minor changes from review input
> 
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/pensando/Makefile         |   3 +
>  arch/arm64/boot/dts/pensando/elba-16core.dtsi | 189 ++++++++++++++++++
>  .../boot/dts/pensando/elba-asic-common.dtsi   |  98 +++++++++
>  arch/arm64/boot/dts/pensando/elba-asic.dts    |  28 +++
>  .../boot/dts/pensando/elba-flash-parts.dtsi   | 106 ++++++++++
>  arch/arm64/boot/dts/pensando/elba.dtsi        | 189 ++++++++++++++++++
>  7 files changed, 614 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/pensando/Makefile
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi
> 

[...]

> diff --git a/arch/arm64/boot/dts/pensando/elba.dtsi
> b/arch/arm64/boot/dts/pensando/elba.dtsi
> new file mode 100644
> index 000000000000..10e06eb8cda6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba.dtsi

[...]

> +		gic: interrupt-controller@800000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			interrupt-controller;
> +			reg = <0x0 0x800000 0x0 0x200000>,	/* GICD */
> +			      <0x0 0xa00000 0x0 0x200000>;	/* GICR */

You are still missing the GICV and GICH regions that are
provided by the CPU. I already pointed that out in [1].

The Cortex-A72 TRM will tell you where to find them (at
an offset from PERIPHBASE).

Please fix this.

         M.

[1] 
https://lore.kernel.org/all/a20805de16e1196c2ed46dd949473c9a@kernel.org
-- 
Jazz is not dead. It just smells funny...
