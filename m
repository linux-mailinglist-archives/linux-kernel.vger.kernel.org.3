Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E62550155
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347609AbiFRAcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiFRAcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:32:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AECA5AEDD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:32:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h192so5325403pgc.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wVNpDYWpyZPJrYzzrQ5li1/Ptc6vTF4u416LkJD1v9s=;
        b=qkE5xNfYDkCsPhFrXdQgXwtrEDw+GQHYRs8SU3FIyNb+VMtro48oMMW8v6on3syij2
         stV9w6v7KzaGEqCIrvxaQbn8sPgHVTTPWio1YEvmnYYlnimeo2z78datsnkNY6atHSVi
         gqf+FO/U3fZbekveGQ1Ewxoqog9rowJnDWzkFtqTrh2bq9ciYhl+yK0OiXwt8MoT8I1h
         PYnmOSX8/pWFuNtvixKKtBKR+YOYfObcteHcZ4SqU9NDxvFBvUT26n1yUXxJC3Bzm64h
         cp66v7y67qRGwR1cxuSMUPCYmp/h8ux0NxvxY7/huxt1qg2ZWy52ffX0183kekduIe91
         Pd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wVNpDYWpyZPJrYzzrQ5li1/Ptc6vTF4u416LkJD1v9s=;
        b=vGNoLSYiAtlNx5ceFrmhJUI0MpWhy+EprgDu0WsJP7Rcn/5wvPWGOZOh3hX9NMSezr
         l4H1ObS7Jd2h5YDCK+IZNYov+8/OLITryqFq76D4jvj72R+c5+yU5RW6vl9baHgA9I1c
         ijQrpTbd77JAdWjIP0A7ldZyxfuso3a78+H7wqKvwvYk+Fkhnlbn1tACxU1zEgVid1lR
         fPXMhrHFAp9HYhPyCNTEy2aIUBNVn0yotfm4uqKQ2b2Kd1YUZ1Qf4xBXPiMcvaHq0fKd
         n921q5VOCB6+e8W6Trwwkx40ab0Jf1lsjemah/wS/8btUUQ3+Wc9z1ud9VbQ2TgZh+Y0
         oU4Q==
X-Gm-Message-State: AJIora/lmaoxjagEhQl6SRxDZJxswTqQCPAzl+DLMWd84lsFjr3u/2yO
        AbvOtAVNvA8vmSBd5awB4PQpYQ==
X-Google-Smtp-Source: AGRyM1szhd81aS/0lyO2FJLxO1IsTYStSnUgjmcZ4CVPZdrIlNLVjrXFjKKDlqqeJ4tIxZUzY+81Zg==
X-Received: by 2002:a05:6a00:2148:b0:4fa:92f2:bae3 with SMTP id o8-20020a056a00214800b004fa92f2bae3mr12777140pfk.69.1655512341025;
        Fri, 17 Jun 2022 17:32:21 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709026b4100b001635f7a54e8sm4126616plt.1.2022.06.17.17.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 17:32:20 -0700 (PDT)
Message-ID: <a664b2a9-3cfa-9e8d-039a-bdd3b7448170@linaro.org>
Date:   Fri, 17 Jun 2022 17:32:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v8 1/5] arm64: dts: qcom: sc7180: Add wormdingler dts
 files
Content-Language: en-US
To:     "Joseph S. Barrera III" <joebar@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220617164000.v8.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220617164000.v8.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 16:40, Joseph S. Barrera III wrote:
> Wormdingler is a trogdor-based board, shipping to customers as the
> Lenovo IdeaPad Chromebook Duet 3. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with the camera
> (sc7180-trogdor-mipi-camera.dtsi) #include removed.
> 
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> 
> ---
> 
> (no changes since v7)
> 
> Changes in v7:
> - Incorporated changes from Stephen's "Simplify!" series.
> 
> Changes in v5:
> - Replaced _ in node name with -
> - Ordered nodes by name
> 
> Changes in v4:
> - Cleaned up rt5682s files
> - Restored camcc definition
> - Added missing version history
> 
> Changes in v3:
> - Removed camcc definition
> 
> Changes in v2:
> - Word wrapped patch description.
> - Removed "Author" from patch description.
> - Fixed whitespace around "en_pp3300_dx_edp"
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   6 +
>  .../sc7180-trogdor-wormdingler-rev0-boe.dts   |  22 +
>  .../sc7180-trogdor-wormdingler-rev0-inx.dts   |  22 +
>  .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  53 +++
>  ...0-trogdor-wormdingler-rev1-boe-rt5682s.dts |  29 ++
>  .../sc7180-trogdor-wormdingler-rev1-boe.dts   |  28 ++
>  ...0-trogdor-wormdingler-rev1-inx-rt5682s.dts |  29 ++
>  .../sc7180-trogdor-wormdingler-rev1-inx.dts   |  22 +
>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 408 ++++++++++++++++++
>  9 files changed, 619 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2f8aec2cc6db..e4114e22548a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -81,6 +81,12 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-boe.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-inx.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
> new file mode 100644
> index 000000000000..d6ed7d0afe4a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Wormdingler board device tree source
> + *
> + * Copyright 2021 Google LLC.
> + *
> + * SKU: 0x10 => 16
> + *  - bits 7..4: Panel ID: 0x1 (BOE)
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7180-trogdor-wormdingler-rev0.dtsi"
> +
> +/ {
> +	model = "Google Wormdingler rev0 BOE panel board";
> +	compatible = "google,wormdingler-rev0-sku16", "qcom,sc7180";

There was a v6 a second ago, now it is v8... It's confusing. Don't send
too often, especially without incorporating actual review.

You need to document the compatibles. Please base on Doug's patches
adding the compatibles for existing boards.


Best regards,
Krzysztof
