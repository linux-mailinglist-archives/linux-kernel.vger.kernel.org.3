Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37C59B768
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiHVCAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiHVCAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:00:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B2121826;
        Sun, 21 Aug 2022 19:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C2CBB80E77;
        Mon, 22 Aug 2022 02:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE2DC433C1;
        Mon, 22 Aug 2022 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661133604;
        bh=0CR07TBCHAzXtCkQ8IOk/kFPn2fqP1ze0B5t4Uy9Lkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fnrGFxAN7qNbIhrkwS/Kw9kV9W8Kb6TvXtXD0ij58zl+VsiqlrJAiH+LfqwaNRsxj
         nlxWFl9/zxo9PhlED624BZiY47NXbqBXwOdxFa36BnV3F4ebyat/FX/8wBBll4lPco
         oOdpojkqAuPBQfPDXZZmcvNfjZHbLAovffDU9cKG3zvSt+GnPZU+QAhvmBxvDkLS9A
         hSgv+aANh7JKDZb9Y4/e5uXGRW5CHUzSJFAXmkhe51+4CWMU0n3PykmzMDlLbXMr4V
         9VoaoRRxLVBRwg+6I/3kDQQnKdL/qTPEIjXAvj3Y5IPjBF2BASPNfUocqy0yGYBCzH
         eXy6fGsBgyevA==
Date:   Mon, 22 Aug 2022 09:59:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7902: fix UART1 CTS
Message-ID: <20220822015958.GK149610@dragon>
References: <20220812172526.14516-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812172526.14516-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 10:25:26AM -0700, Tim Harvey wrote:
> Configure the correct GPIO for UART1 CTS.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Not sure why you resent it, but it's been landed on mainline [1].

Shawn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9635b7134c292db0b6b4d278c88d21035dad4000

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> index 407ab4592b4c..6692e55df752 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> @@ -651,7 +651,7 @@ &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>, <&pinctrl_uart1_gpio>;
>  	rts-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
> -	cts-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
> +	cts-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
>  	uart-has-rtscts;
>  	status = "okay";
>  };
> -- 
> 2.25.1
> 
