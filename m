Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1967C519D37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348297AbiEDKmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348333AbiEDKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:42:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D32AC42
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:38:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l19so1119184ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0/S6UE8kVYqDNad7z3pjtRuJgpmgvfwcT2yCsHCfEM=;
        b=d6aE1Ig3kJW12Aq8yvux6ub9aoclrmtZQHodl+2SCNC1TTVIXN2a1xcOKMo477nJZM
         SYZJZnn/rjIOvYvEOSZT2kWMjKEd/8O9GrUloItb29+AVGSwuBw0s/OUfTYXbcaMixgr
         YNdnKaRQiFPHQ7yd004TWRlTGlB0KKgMZmgrAK40rawynkvyzNHrt1WmQDTyww2hh6T1
         0b5cqCZJLb3MbtQZRn/PlJnEglVfDAvFBFIL0iCsix5AuCHH0lYC3TxNE4GqR6oPAIeM
         7uvfx97tO7AaevpDLUPVRb3LwkpkblXSYQxj3xyFGg6TspgCo8DqCwfyq7yJZe63eq64
         1jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0/S6UE8kVYqDNad7z3pjtRuJgpmgvfwcT2yCsHCfEM=;
        b=FnH65ErO1u2ydpjynP5i6G0Ai7wg+2K/aaSKyYzWM5qDL1Ixrtz3iYRyM0JwY+1d0Q
         ACPLhQOzELZ2pqbIITFntYSu6k82L8GosCvOuawnxPLlu5LWSeEupwR20kj3Xsw0OA8l
         RoL7eyGis5HKMdeeiUtX9CWDjBGd1z2nJNKgrNgYaheBuYVxy3xQ5T5zBpVT3Lh4kIoo
         R94EavStbaE/oWxK8g0GJxhNC23aSufV7ixyvvoEmH36xKPrsG7/1JyHYqZb/cO7XtwO
         6RJQtoNk+TriA6H5HWepjAR651I52Wk5Ptf51qK4oohYciW65NI3DAesLud0AQG/oNA0
         v9kQ==
X-Gm-Message-State: AOAM530E5hJjN2KOge4s0QimoWhI9pz9uITz2Qux4gGrGJzVRjqwRHLJ
        WDi2GJkR8yYSwR8uoEFAF35qMZREAZMjIKVgX6NH9NcUVfE=
X-Google-Smtp-Source: ABdhPJxNdFWS/wru3JHuLyOEikz5IC7uPf4QUB9vcB6u578vrjN4goN8ah7xYQTsnbdk4O0TiH3kqranj+niTENGv8M=
X-Received: by 2002:a05:651c:988:b0:24a:c21f:7057 with SMTP id
 b8-20020a05651c098800b0024ac21f7057mr12487369ljq.16.1651660703238; Wed, 04
 May 2022 03:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com> <1651480665-14978-2-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1651480665-14978-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:46 +0200
Message-ID: <CAPDyKFqmPdzR-RrQUf2bkr6KnSNVUt4uS5Tj31ug+y95ZSXhxA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        adrian.hunter@intel.com, bhupesh.sharma@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
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

On Mon, 2 May 2022 at 10:38, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> The SDHCI controller on SDX65 is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index da42a88..e423633 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -33,6 +33,7 @@ properties:
>                - qcom,sdm630-sdhci
>                - qcom,sdm845-sdhci
>                - qcom,sdx55-sdhci
> +              - qcom,sdx65-sdhci
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
>                - qcom,sm8150-sdhci
> --
> 2.7.4
>
