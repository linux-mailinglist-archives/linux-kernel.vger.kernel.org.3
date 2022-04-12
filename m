Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7124FE3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356522AbiDLO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351633AbiDLO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:28:28 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF8F57B2C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:26:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r18so8630976ljp.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9Y0Dxo+q6yQbzDxJ/ULmzM1Yxju629VRSmpegysqN8=;
        b=twWeTn+wbEgNDoLKArv4PJZiTp6oZnld1mH8i8kfifUjKs0iQRcaZ+kHoABKm7/Scd
         3US+3G/CYRtfNcu/VWgVjD/mESRcSvcIiq5CsdjiRaS38+bj+pDt7bnKHFiZZyy820Iy
         aZmrwQNZT0Cu/zCKNZ/XbB/VTX3yMBgV3zXiAj/E2WNiWAicWfSc75KIq+78hwogMpYJ
         ar+m0WvCjAayOJzwqk4Bqj093B/gBIHVlORyh3lXABeP2HsUVwwix5DW5QTogpeQrC+D
         CGX3bGHd2uSBpxWDWvtTv2aV5r8qht5nyXVwZlMD8pbXO7nAPZ1j77itunZ4WducbwKT
         zxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9Y0Dxo+q6yQbzDxJ/ULmzM1Yxju629VRSmpegysqN8=;
        b=JTzrPyjcRB3wAiFfJr20s80VfEJHXN4xR3IWCCmdpPF7W+HA7L0XCTtv7ta+XMkgtL
         AGgobA3CVS2LgrTHzTulzpqIxzQqjaSp/Md+J9D9TR3fbctKzh26DBbuuQmrQjMQ5B7h
         5KAqR8o0RcCvXIcIiU+0pbRGRQy6gLw6ivyi7r3gw03lAlGZUd6fU1kDXrfmQHHKjW/W
         nNpfV8psXo2Rk6e1N+PJ9LIuX9YzM18lwYe4XHoOnPs2Wky0JzUrYFW7RgNI+LArUuuS
         /Trhk7u/zzcK+CSOAT699Wx2fBS/opEA2Cd9Vdnzh3nXnWlQvOw7pYCgdM+o/qyA3jPn
         70vQ==
X-Gm-Message-State: AOAM532jRLA4Rx7553hmvas0AxGMuV5wxb5pVysPtgqvOC6a7nQncygt
        sao4onBFypwj+ztCr2/nTuyTQx3yx9zftZPGsRxqeQ==
X-Google-Smtp-Source: ABdhPJyaj7tFxdrLYCr2zY8LfreX76pb3X9XmGkW2cSHqy2L9vVwR4doSIMzzrLhQfMLm15Cp7vZ1XdvlfGpOmv0uxY=
X-Received: by 2002:a2e:3e05:0:b0:24b:5df0:6388 with SMTP id
 l5-20020a2e3e05000000b0024b5df06388mr8356865lja.367.1649773569043; Tue, 12
 Apr 2022 07:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com> <1649670615-21268-3-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1649670615-21268-3-git-send-email-quic_rohiagar@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Apr 2022 16:25:32 +0200
Message-ID: <CAPDyKFrU0hQzs3xL8Jf1E22cS9DWuorLgcVF9+m80+Osw8=odg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Shaik, Bhupesh


On Mon, 11 Apr 2022 at 11:50, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> The SDHCI controller on SDX65 is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

As stated in a couple of other threads for patches extending these
bindings, I would really like to see the binding being converted to
the yaml format first.

It seems like Bhupesh is working on the conversion [1]. If not, please
help him to get this done.

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-arm-msm/msg107809.html

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 6216ed7..e7dec8a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -25,6 +25,7 @@ Required properties:
>                 "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
>                 "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
> +               "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
>                 "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
>         NOTE that some old device tree files may be floating around that only
>         have the string "qcom,sdhci-msm-v4" without the SoC compatible string
> --
> 2.7.4
>
