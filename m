Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10915A9DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiIARZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiIARZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:25:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564392E9E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:25:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z187so18073467pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=b7m23koJ1VppwfdVnRo0EjHn4J3Xyy4vt6H6+/PQAvc=;
        b=Mtu6yhsvW8qiKbyEly7EpT1duLSR1DH5Xjg+oh1zWg4osVtwVvkuniTTXCxk7YysNU
         /stFYJp+dxJTmgFqtMSuTLfClSNXUj1S+a4sBMJJ/6YePuflPUzI7lq3P+YvUDal9FB1
         K2FYWmgbKDpZld2MLf+NS/szmQ7c19keXbZcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=b7m23koJ1VppwfdVnRo0EjHn4J3Xyy4vt6H6+/PQAvc=;
        b=nz6kIXbQjeh75tLSMT7qRsLJPMs3mRwPvgay0sLy5SIv6Tp2/IrUIXIWnsTXlkZH6i
         1tsr/NF5kIGRpED223JfVwCGCUGkKx1V0CM8n0K1oPJOdAyx4bFicUw1UZIV0B2UVyXh
         xQtoN4dZkhN2T+6Xahn2eQTw3uWptDwl9t9o44mQNs8VcYDVkMgnL5cw8TDuWJX+u3CO
         G2jxx1+vv8emP+z744nzeHvr4pj7m0WjOj/rYm/BMvj4KVYcPUf6u/Fk8zJRCfE6GqFD
         CNAOwM/9zvNp4kH2xOhyl9vc1JgCY4p6lG4fQBRDK4gsbbIplQCt86D82FkbMLkehf4u
         WrDg==
X-Gm-Message-State: ACgBeo1vzRV8cGToXhkRAeGl6hzVAULorSM8Ul8IMgweJeT+LR0YBLyE
        WsgK/d9aFe01zLT7be51ILCo3w==
X-Google-Smtp-Source: AA6agR6lKIv9iH6jOojdIWEvRNKtfkVnpIQauHMaIBrvj9jiSNYExlbDTYtiTUYW1ZzzKIyOMj7qFA==
X-Received: by 2002:a05:6a00:a05:b0:534:b1ad:cfac with SMTP id p5-20020a056a000a0500b00534b1adcfacmr31672604pfh.35.1662053142874;
        Thu, 01 Sep 2022 10:25:42 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:34cd:3659:c11f:5d05])
        by smtp.gmail.com with UTF8SMTPSA id n6-20020a170903110600b0016ee26224a4sm9084805plh.305.2022.09.01.10.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 10:25:42 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:25:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Configure USB as wakeup source
Message-ID: <YxDrFUsWZvy7IUBs@google.com>
References: <20220901101658.1.I347ea409ee3134bd32a29e33fecd1a6ef32085a0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901101658.1.I347ea409ee3134bd32a29e33fecd1a6ef32085a0@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:17:03AM -0700, Matthias Kaehlcke wrote:
> The dwc3 USB controller of the sc7180 supports USB remote
> wakeup, configure it as a wakeup source.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 2d1f38342858..507718f309e1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -2780,7 +2780,9 @@ usb_1: usb@a6f8800 {
>  					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3 0>;
>  			interconnect-names = "usb-ddr", "apps-usb";
>  
> -			usb_1_dwc3: dwc3@a600000 {
> +			wakeup-source;
> +
> +			usb_1_dwc3: usb@a600000 {

Please disregard this version, it is based on a downstream branch which I used
for testing.

>  				compatible = "snps,dwc3";
>  				reg = <0 0x0a600000 0 0xe000>;
>  				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.37.2.789.g6183377224-goog
> 
