Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8F58C935
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiHHNQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiHHNQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:16:06 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE238A1
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:16:05 -0700 (PDT)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id AE4BC1F5A3;
        Mon,  8 Aug 2022 15:16:03 +0200 (CEST)
Date:   Mon, 8 Aug 2022 15:16:02 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg:
 introduce Xiaomi Poco F1 EBBG variant
Message-ID: <20220808131602.nv66ozm2q62obj5t@SoMainline.org>
References: <20220806210220.31565-1-joelselvaraj.oss@gmail.com>
 <20220806210220.31565-3-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806210220.31565-3-joelselvaraj.oss@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-07 02:32:20, Joel Selvaraj wrote:
> Introduce support for the Xiaomi Poco F1 EBBG variant. The EBBG variant
> uses EBBG FT8719 panel manufactured by EBBG.
> 
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>

Also after adding a distinct compatible to the new board file:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  arch/arm64/boot/dts/qcom/Makefile                      |  1 +
>  .../boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 02db413b228c..29f15031a199 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -106,6 +106,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-ebbg.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
> new file mode 100644
> index 000000000000..1e0be481b9da
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "sdm845-xiaomi-beryllium-common.dtsi"
> +
> +&display_panel {
> +	compatible = "ebbg,ft8719";
> +	status = "okay";
> +};
> -- 
> 2.37.1
> 
