Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40854C616
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbiFOK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348534AbiFOK2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:28:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DEB38DA1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:28:39 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l3so6490566qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5AvCzV/qAuI7bWpBXxG/Nqj5ArEGXpfhZRBeCyeuUgQ=;
        b=B7T3jGhOh96+HQqjFaBvXx5Qblxeyq2/IWkCavhwANY5BJ082XVB/INkKlWXB2CWjM
         +wlATX9xcmkvr9bgTz9LIjzi1KhAnGxma+tTljwi/THilaWMX8L/THptViEqmg7swLtl
         fAHBVQTt/eqdmjZBVO25k3eDG9BIisH5JsrbFucnPeNMpkXhaPwfwGnLmOVrFXl+8Ax+
         cvcidu0blDozQMvNgEYs/+lcWAc5fKXjB8iIhNAELyHTGRCRP0+LSghteu5x6XPWQu2C
         rqEm8E0t9Z+niFwJvrgoQ5UHrViJRpmS2fEaSLFFWaAL5id2aEXRu/DxAO+EfAcYGtmV
         hdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AvCzV/qAuI7bWpBXxG/Nqj5ArEGXpfhZRBeCyeuUgQ=;
        b=dWou3GrgjYeBxwvzGxw1Isx2hi4ciP9pL71k90dhqBwVa3kXcGcOvIiNPTEHXWeZEb
         OSZ9o58Ksb01AsQYGROlXAgnbD0HtpQmFgEBpSJacga0o77XpsffvaapMFE2x59mKlc7
         MXrDMRupZlT1ZQir+md/PRsKw6raJJXEI6KwmctEF7rRQPlV6R2v/CZ5AMbvQsbSI124
         RvDHVNPmlA64JKr4eO9ECRa9iq3wm76ANtwcWronZIcW/+3vlNowI/EhYKWqAf8MnITB
         C6tXucuq0OmylqhColRL3myx/gOlEfL/DU67ouV+iC4FsMh59gKtAUB3qq+T49H8n7/+
         wrSw==
X-Gm-Message-State: AOAM532XnUEr8mZ4XgVxjykf+vIewn+rOJ4iE5SvJPgZoltIzEQCtgwt
        Al4wARTRVRRP3v76tXtajcDchSNIN8nX0JoA4o6aXA==
X-Google-Smtp-Source: ABdhPJwt4UdjNNMt5RFrBj0SVHw/NJX+pbEHJb1fSV0Rp+uVukRrCUveQlDV6O8j1EkY3e+RuatpMex07QktOP5CpMg=
X-Received: by 2002:ac8:598f:0:b0:305:8f8:2069 with SMTP id
 e15-20020ac8598f000000b0030508f82069mr8202247qte.370.1655288918492; Wed, 15
 Jun 2022 03:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220614230136.3726047-1-emma@anholt.net>
In-Reply-To: <20220614230136.3726047-1-emma@anholt.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Jun 2022 13:28:27 +0300
Message-ID: <CAA8EJpqs8ooZL43gCV=+rR7TdRJhOLrPSBrUfStkZkH4igCL7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu: arm-smmu-impl: Add 8250 display compatible to
 the client list.
To:     Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
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

On Wed, 15 Jun 2022 at 02:01, Emma Anholt <emma@anholt.net> wrote:
>
> Required for turning on per-process page tables for the GPU.
>
> Signed-off-by: Emma Anholt <emma@anholt.net>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index d8e1ef83c01b..bb9220937068 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -233,6 +233,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>         { .compatible = "qcom,sc7280-mdss" },
>         { .compatible = "qcom,sc7280-mss-pil" },
>         { .compatible = "qcom,sc8180x-mdss" },
> +       { .compatible = "qcom,sm8250-mdss" },
>         { .compatible = "qcom,sdm845-mdss" },
>         { .compatible = "qcom,sdm845-mss-pil" },
>         { }
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
