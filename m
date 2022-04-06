Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF464F662B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiDFQ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiDFQ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:57:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF2184278
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:54:12 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b43so3546731ljr.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1xhe1hOFAkXA525Rq3XOWwhSA0DHEVv+3E5iLs6qgQ=;
        b=tspW005OPBxR+ZMlu03A0boY2M62lp6g6YNgoTvv6v/KYHreyQnN5dmKHMfnFpzTpQ
         PVr4s0vd/qIMOM/oFYeX9FURNeJkoRw2g6ndopnW4COOyPGCoDfFkHnosk0krbSe9Iol
         1PGkMVjFk5EhHl0Dl1FggaaXTLIVUbVGCLOjSYD6KEf10lOty0GTULIK8kdKHRnnyOHl
         ESpb43gy8pe1sJbU1fk1mIMIjZqIc8KsZkjJ0Ul80z394RVPOEtYAEMBddZVSobtYwIN
         jWhDfA11K19pAEe51Ig0i8sT2IU2lSIIvIkAqHaOGqYUwX+npjrY2OBUBv7kAIztq3wa
         KWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1xhe1hOFAkXA525Rq3XOWwhSA0DHEVv+3E5iLs6qgQ=;
        b=bbC9E8iFuz2CyB709KxKih63F50uXv0tpImcMdat6pGtv5XUOa17ybQIFjug7DulGt
         n8TLpDXAs+siLG92vHqsXOOI/5FLISOKFNbGHea7vPZCrqA1+4KXbvENZtVYJTO0nERx
         JwmLR+hMIazOlmwtAQHa73XjqredMS3YYYa2S+aWu8HC+jrqFeBO3rK53zYuIsXU+JGe
         ZRF95yC+/XGN2EhlqKkTwFlse6B6FHdcwc1UP3SXrVm0jQh9wGMYXX1eNlaUykCeeavV
         VpAehJr+GQxmob7toPj/VRPPR2LMIBXXi9zcWT5K7DsTjqUS+ejo7+GzvJuPryYjb+eh
         shng==
X-Gm-Message-State: AOAM531H4NWCBTkgHd8HIAH6WduT+5AMUoy7KIK8tboLu8TG64q42+KQ
        R4iFKJK+wWNOJyDllt/6NXpKcpa1U0PBTjDFejpcwA==
X-Google-Smtp-Source: ABdhPJw6Rb9PTYA18fciCJa0mLjW77O/slOI6A0bJzY2u6WIFtnMtLTFL1vWalImn+T5p5DF5++fg9LaZdhoFiO6AUQ=
X-Received: by 2002:a05:651c:1783:b0:249:43a8:b6f9 with SMTP id
 bn3-20020a05651c178300b0024943a8b6f9mr5416176ljb.273.1649256851127; Wed, 06
 Apr 2022 07:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <1647532165-6302-1-git-send-email-quic_c_sbhanu@quicinc.com> <1647532165-6302-3-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1647532165-6302-3-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Apr 2022 16:53:35 +0200
Message-ID: <CAPDyKFqhtFSy-fWJE+vA=sP+aVnQXygphaHNWq7sZgcY84EG_w@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] arm64: dts: qcom: sc7280: Add reset entries for
 SDCC controllers
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

+ Bhupesh Sharma


On Thu, 17 Mar 2022 at 16:49, Shaik Sajida Bhanu
<quic_c_sbhanu@quicinc.com> wrote:
>
> Add gcc hardware reset entries for eMMC and SD card.
>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>

As I just replied to Bhupesh Sharma, it would be nice to get all the
mmc DT bindings converted to the yaml format.

Would you mind having a look at doing the conversion first, thus prior
to extending the existing text-based docs?

Kind regards
Uffe

> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index c07765d..cd50ea3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -881,6 +881,10 @@
>                         mmc-hs400-1_8v;
>                         mmc-hs400-enhanced-strobe;
>
> +                       /* gcc hardware reset entry for eMMC */
> +                       resets = <&gcc GCC_SDCC1_BCR>;
> +                       reset-names = "core_reset";
> +
>                         sdhc1_opp_table: opp-table {
>                                 compatible = "operating-points-v2";
>
> @@ -2686,6 +2690,10 @@
>
>                         qcom,dll-config = <0x0007642c>;
>
> +                       /* gcc hardware reset entry for SD card */
> +                       resets = <&gcc GCC_SDCC2_BCR>;
> +                       reset-names = "core_reset";
> +
>                         sdhc2_opp_table: opp-table {
>                                 compatible = "operating-points-v2";
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
