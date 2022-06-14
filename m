Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB7854B6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351309AbiFNQwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350611AbiFNQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:52:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03EF4615D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:51:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w21so9130914pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IpKFsD+1tEk3s9hJ6xzfzDtWD7HVpF/lca9fvrNKegc=;
        b=iI5ZxggjQ2737BFqG8GNo5vnJ2xudApylqc5UouOihlbGRBrBF/o/9pgjSQG5Rs1ed
         EB0H1Y68OP86RDJlVJTySoKSQ0SVPtpSD7CrqW47iOSu0WnQdw2Jix5H76JqnYIzqUoo
         bWHIN3Zhhug89kpKxMmaf/qKWV+8Vxw7qApFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IpKFsD+1tEk3s9hJ6xzfzDtWD7HVpF/lca9fvrNKegc=;
        b=JvdadDSLE8NfPfhuhi44HiyYJ9sZlVvc6Myv8CkZfQtMIli6RQCKxhjqKCbTFxT8uY
         dhIryVAvJwPFuUWNRPaSE8FJMUYlGHoMgZGUSImM0y36A60+iN+t/K29y8YW/E0wAvn4
         s3VSY+HvzBPrgKv1xpTpCSgP7nWn7h6H31jbd0tPDqt5+IYkzTger8x8I7RzjMMFgM7o
         BeCQTuWpo3rul8dnZfyroCMbT2FgrMVBzgQxaEPoc3uM5/3b0/0Xp8tx65BKX7bdhzo+
         lEnFakK69exxT4oKRummlCK1e8JXQl2OKcHhgatLdc0NgIVU7xrGqhkgmcezoRWO3fZF
         2k7Q==
X-Gm-Message-State: AJIora8GbSGTXCq13K9rF/9bUTUIm6HwNzjJcJyrJGDQvwdoxirnqeNC
        rLhVn5Qz+ZEhBfnWxau4Ng+rkg==
X-Google-Smtp-Source: AGRyM1u1QhuNDAKEW9h6e8VgfxHcd/SUvrdV6HFDLVSGWGS12ivI1CWbZRfbs3JHaTUOXoBc3vNHEw==
X-Received: by 2002:a05:6a00:1da6:b0:51b:fad1:c610 with SMTP id z38-20020a056a001da600b0051bfad1c610mr5205655pfw.25.1655225519070;
        Tue, 14 Jun 2022 09:51:59 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e2d5:2b03:9fb1:ce40])
        by smtp.gmail.com with UTF8SMTPSA id t4-20020a1709027fc400b00163fa4b7c12sm7530736plb.34.2022.06.14.09.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:51:58 -0700 (PDT)
Date:   Tue, 14 Jun 2022 09:51:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Update lpassaudio clock
 controller for resets
Message-ID: <Yqi8rcs95CEEjGY4@google.com>
References: <20220614161118.12458-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220614161118.12458-1-quic_tdas@quicinc.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 09:41:18PM +0530, Taniya Das wrote:
> The lpass audio supports TX/RX/WSA block resets. The LPASS PIL clock
> driver is not supported and mark it disabled. Also to keep consistency
> update lpasscore to lpass_core.

There is a driver for "qcom,sc7280-lpasscc", what does it mean that is
isn't supported?

IIUC one problem is that 'lpasscc@3000000' and 'lpass_aon / clock-controller@3380000'
have overlapping register ranges, so they can't be used together.

You could just say 'Disable the LPASS PIL clock by default, boards
can enable it if needed'.

> Fixes: 9499240d15f2 ("arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index e66fc67de206..180cfd2765b9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2174,6 +2174,7 @@
>  			clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
>  			clock-names = "iface";
>  			#clock-cells = <1>;
> +			status = "disabled";
>  		};
> 
>  		lpass_audiocc: clock-controller@3300000 {
> @@ -2185,6 +2186,7 @@
>  			power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>  			#clock-cells = <1>;
>  			#power-domain-cells = <1>;
> +			#reset-cells = <1>;
>  		};
> 
>  		lpass_aon: clock-controller@3380000 {
> @@ -2198,7 +2200,7 @@
>  			#power-domain-cells = <1>;
>  		};
> 
> -		lpasscore: clock-controller@3900000 {
> +		lpass_core: clock-controller@3900000 {
>  			compatible = "qcom,sc7280-lpasscorecc";
>  			reg = <0 0x03900000 0 0x50000>;
>  			clocks =  <&rpmhcc RPMH_CXO_CLK>;
> --
> 2.17.1
> 
