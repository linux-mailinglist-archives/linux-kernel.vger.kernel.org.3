Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055E84FE398
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353448AbiDLOVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiDLOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:21:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0C047ADF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:19:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bn33so24252404ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQyhcpmuoxubOTeJc5FbJZSd/FqD2XuPIEYRCS1ggmw=;
        b=ydG+eEZexNQfagzFvxoj4FD97ilHqxwQqCPkORhS5G/hJ0xwxgXdQZbamWtyEwi1aC
         yOU7dgTfSLJUpRDyR7IedOV/kpj2RKsfEAJ8VnhCk/vmebRcBHjnQLmFARBt/57VbpZ6
         qple/wrZ7mV6dOki1hZPjlcMd9FDcXZJZb/ezzjKTbhtX4FgmdlT2hXEHu0MFk06qI2d
         m52WMMuSoMEwDIcuSIgVH/BUaCF+fKMFc0PDyiVrrqD+nPWzCIjCRhQSewtovaVV/Dah
         mxt41+nsFKqD4mCj75quu7rgmMmUfuScOGJC8LF8reSmu0cAZAd8u6SxxV4h/PbHNT3j
         fmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQyhcpmuoxubOTeJc5FbJZSd/FqD2XuPIEYRCS1ggmw=;
        b=cwvCwb4N2oupiTmzVOmNWh3QHwjIuXIOUtKsw9A/rxhGimJAFAIGfTZZaDC1VlXEBj
         DvllVufr2hoCX7WnlR01lJX09IOZVnkys+eUhv5ZXR/dqx4syantXykQSv4qoCD1iPNA
         LzsuBF2bjO4Wf5MDgPF8uxQtbRsk+b0KHEJOzruo7S0z56u67XPJ4ZJMIjkiZo2miNfp
         dtDpq7rMU8NfAGQEhktJElRyxnKFZBxWGmx34qGfwAjxZBD5w0j+1vwdaiJX7stYUQhG
         uXVUiA84WYVp5h3Vo50ncSUR9LFT7YVITGFEkFUuyyEz9Kv6SFQczGJ8S1LcjwQeHU9v
         laMg==
X-Gm-Message-State: AOAM5306p1dVOS6Cz6QLMxZgAJmbcU2XiWzgGLEGt9BKNiV0aj/gcVIh
        NypAtphKtCYjx18eIgpVEtYDcjBOE5MQUQ9cL38s1A==
X-Google-Smtp-Source: ABdhPJybcpvxTKB+Nbs/AV1PA14+uH0q480UoHl1NeG/zKAVRWlPeSSnikUgTyII0O0N9vSECYon0Eo8hlDT0BXQCos=
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id
 e10-20020a05651c090a00b002495d82fe9cmr23873129ljq.300.1649773157120; Tue, 12
 Apr 2022 07:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <1649759528-15125-1-git-send-email-quic_c_sbhanu@quicinc.com> <1649759528-15125-2-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1649759528-15125-2-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Apr 2022 16:18:40 +0200
Message-ID: <CAPDyKFrJDVBdyu4=0dXaBs8FhsF5jvcLKGgfjjbB-rVztxmgqg@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: mmc: sdhci-msm: Add gcc resets strings
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
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

+ Bhupesh

On Tue, 12 Apr 2022 at 12:33, Shaik Sajida Bhanu
<quic_c_sbhanu@quicinc.com> wrote:
>
> Add gcc hardware reset supported strings for qcom-sdhci controller.
>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>

As stated earlier, I would really like to see the binding being
converted to the yaml format first. It seems like Bhupesh is working
on the conversion [1].

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-arm-msm/msg107809.html


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 6216ed7..9f02461 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -76,6 +76,7 @@ Optional Properties:
>                 "cpu-sdhc".
>                 Please refer to Documentation/devicetree/bindings/
>                 interconnect/ for more details.
> +- resets: Phandle and reset specifier for the device's reset.
>
>  Example:
>
> @@ -98,6 +99,8 @@ Example:
>                                 <&qnoc MASTER_CPU_ID &qnoc SLAVE_SDCC_ID>;
>                 interconnect-names = "sdhc-ddr","cpu-sdhc";
>
> +               resets = <&gcc GCC_SDCC1_BCR>;
> +
>                 qcom,dll-config = <0x000f642c>;
>                 qcom,ddr-config = <0x80040868>;
>         };
> @@ -118,6 +121,8 @@ Example:
>                 clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
>                 clock-names = "core", "iface";
>
> +               resets = <&gcc GCC_SDCC2_BCR>;
> +
>                 qcom,dll-config = <0x0007642c>;
>                 qcom,ddr-config = <0x80040868>;
>         };
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
