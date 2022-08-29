Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FCA5A4F28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiH2O07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiH2O0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:26:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45B5804B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:26:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e18so2850641edj.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GIk/xkbPv4LgXcBVD6Hp47oriRMLTxoq4XVelR6765w=;
        b=BSMoWKn4oRS9sT/rH1cFhlHkePfwvcU7/ud7uTEpVJ/DBoiOPF6OQ6qd1ChG8h27N0
         FjvYWe+r1/5GS6H9yn8UnMsxqi469U8Seo87WzovbJPI2rfOEmEA6GkoP4u1GVtb9Gw/
         Tfq19RCdG7SLePWpS9FiJFWN4vsHbjOjD3durT0Rd4ACkkSQF5dP9CmzeA1LTh/ChLCH
         nDTXPmAwbGRCLN7C7kqKpF7vNbOGWBH2KwpPGh5EU68IImNxa8SrHKLe6+TFZO7u9w6u
         HTWt9c4sRiVHfC8TUYuAxfoLctSdD3sfJ5zeHO5kYhgmITSa91Cwy0grpaBzc0rzhPX+
         2eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GIk/xkbPv4LgXcBVD6Hp47oriRMLTxoq4XVelR6765w=;
        b=vy1bN/8+00oLCmQGnSIQ5xw2cCG26mKfZVBrTH/MXzEN+8V/L1gHcOfLlAs9joQN3s
         OXlrUSquRmJoB2Q4FBzoEkK2eK0XOQREDUAZcW+vb8IfFN3sxDJcEhYI0R2VYf/DvVfS
         UEFBhAXoFhgjjEx3ZLZPttnWjYGJW/YJIu7OIgam1EKce8vY3zMAabNBcapgZeXr5wcT
         mW/O5NcvRXPV/OOoH0x5CFGjFLqkMDXNo0EK5Z1OamB+o1UHxsdcjjXYpgcfTstCnP9z
         HooYS6+l5aLSilXmz3TZwa0/508+oQaK2VDB7G5K6vWCydSAQm/Y6r6dipzu+Ad+ygo/
         5ldQ==
X-Gm-Message-State: ACgBeo1flp+9uF29CRLQRgDOv38gfgOShZd+4pbIBbu5VM3bsZxQyVGt
        4rp6T3pOr2ICu2ykDUCr7hQ1xbE2xI4rxu/6bu2Fgw==
X-Google-Smtp-Source: AA6agR5hDRCKM756jRF+1WFTznbKy1uj1tle9cnUNV0EFYxwrOnIBw7YN9Pw+gaRfTgFU895UlBIYWkDOdO7yVBfQVU=
X-Received: by 2002:aa7:d846:0:b0:447:d664:8409 with SMTP id
 f6-20020aa7d846000000b00447d6648409mr13081244eds.159.1661783212482; Mon, 29
 Aug 2022 07:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220802153947.44457-1-krzysztof.kozlowski@linaro.org> <20220802153947.44457-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220802153947.44457-3-krzysztof.kozlowski@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 29 Aug 2022 16:26:41 +0200
Message-ID: <CAG3jFytBmVLh8dgNnLVpfN3qqzBcarVRfyF7ojdGw2_UOy_xKw@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sdm845-db845c: drop gpios from CCI
 I2C sensors
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022 at 17:40, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The OV7251 and OV8856 camera sensor bindings do not allow
> property "gpios" and Linux driver does not parse it.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Not tested on hardware.
> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index b9304f81290a..f313f6964810 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -1214,8 +1214,6 @@ camera@10 {
>                 reset-gpios = <&tlmm 9 GPIO_ACTIVE_LOW>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&cam0_default>;
> -               gpios = <&tlmm 13 0>,
> -                       <&tlmm 9 GPIO_ACTIVE_LOW>;
>
>                 clocks = <&clock_camcc CAM_CC_MCLK0_CLK>;
>                 clock-names = "xvclk";
> @@ -1256,8 +1254,6 @@ camera@60 {
>                 enable-gpios = <&tlmm 21 0>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&cam3_default>;
> -               gpios = <&tlmm 16 0>,
> -                       <&tlmm 21 0>;
>
>                 clocks = <&clock_camcc CAM_CC_MCLK3_CLK>;
>                 clock-names = "xclk";
> --
> 2.34.1

Reviewed-by: Robert Foss <robert.foss@linaro.org>
