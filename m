Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EA64C3EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiBYH1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiBYH1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:27:13 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19793B7CA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:26:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e13so4088537plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CQB6vXrkENn/yTnxHJkeSSrw5TkI9BMFoKBxvUoIBfI=;
        b=zAcZyI1/7PMktYmGwmPp87KhO+hu/j5psZQUmRRPaHxlag0TbhViPUCc/t3SEHWBUO
         vUi4WwO39oVXaZVaEVvUSBdRntR7D4jE421Ikn9tVW5nDLDUgEdSSUBEVFP8NIgsI/py
         0Wbs56l/3ErksqXxyFpFPBFr/eGM96IrPRWZHM/GP1+JvEaAPG3IlwiAi4+VKCabNoji
         iSIUSk6M4GPPjr8t4u5uZr6CmmpJqGs0VCzjSXt+2y+93dCP6CXOznFsbRE2WtV5tHQ6
         dT27Diqi3J5BPkaOTH3IQJ9xtY84/rkgEfblL5ijzs9/A89UtBKeXxaWzGU31TNZuP8o
         rAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQB6vXrkENn/yTnxHJkeSSrw5TkI9BMFoKBxvUoIBfI=;
        b=m1eS3aK1O3fFyU2RdmXZEr8LluUjBp3knkRCfpczppvbvSOau/tuu7mbKn5i8+/tTX
         +s53rlgrAkXTL69WwmgvehDlDDZau64OvZJClcw5pmKir5TenVaoRQW9FYyfvcg7Z2Kz
         1DD1GYPd44GJbS3Yaab5YF28FZ8hk5bBtyV8zFkkVBgFtV9CYqfR9mVP4uxRLEJ0nkBc
         6GgWwwpLUgkIH0Iq3T2m8FYpIo0JMgCZ7VkE48TsaEhAoSpvvkymj66wKNaQYalnLDwV
         XCKdxj4R9Evx4E7Z4CV3hFv9p+V4qqDPrT20xR9Kz3Sl1n1NWzs05N/u+eyehMPaRTUo
         bjhQ==
X-Gm-Message-State: AOAM533cfWC7WZM2y2aKP7SUc7u/+HayBd+RKr5OOMMtIuE0KmHZcckG
        MwGj7OpzzCSgp2MNZGq8aDlJ3vxGi8NyaKY=
X-Google-Smtp-Source: ABdhPJycwXjskOfGGP1fRfS3gNZQ71n5J6k5lsRXeLsN/Rku6U/S2v2ikj8zlW686W7ki0HPYAuBYg==
X-Received: by 2002:a17:902:7c0e:b0:14d:3a2d:3a01 with SMTP id x14-20020a1709027c0e00b0014d3a2d3a01mr6484893pll.34.1645774000569;
        Thu, 24 Feb 2022 23:26:40 -0800 (PST)
Received: from thinkpad ([220.158.159.240])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0010c500b004e1b283a072sm1914163pfu.76.2022.02.24.23.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 23:26:40 -0800 (PST)
Date:   Fri, 25 Feb 2022 12:56:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] ARM: dts: qcom: sdx65: Add support for A7 PLL
 clock
Message-ID: <20220225072634.GC274289@thinkpad>
References: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com>
 <1645505785-2271-4-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645505785-2271-4-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 10:26:23AM +0530, Rohit Agarwal wrote:
> On SDX65 there is a separate A7 PLL which is used to provide high
> frequency clock to the Cortex A7 CPU via a MUX.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 653df15..ec80266 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -125,6 +125,14 @@
>  			      <0x17802000 0x1000>;
>  		};
>  
> +		a7pll: clock@17808000 {
> +			compatible = "qcom,sdx55-a7pll";
> +			reg = <0x17808000 0x1000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "bi_tcxo";
> +			#clock-cells = <0>;
> +		};
> +
>  		timer@17820000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -- 
> 2.7.4
> 
