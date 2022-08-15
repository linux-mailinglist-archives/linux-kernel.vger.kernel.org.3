Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23D5933E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiHORLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiHORLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:11:16 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCAF1B7AC
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:11:15 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so5878478otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=fYHATjMloKIHDZRJFW62hZu0N9hKCcy6QlPPx8j2Wsw=;
        b=QpOrqpXkiohYH9sRsFq4JuVLY6o2HbkfIIjXY0wIMTaR7v1EI3uKidRzI4UcnoMKsB
         hqL5XJzeyPYwN9+ToEm9rTDfyuJ4oFaiSM6au2gHhAnG3jng7TE5xRp0U4VTaZhF/G3G
         0HTs8uCKnY9MVaBSPpuAhxk3f/Cic7bvdZAzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=fYHATjMloKIHDZRJFW62hZu0N9hKCcy6QlPPx8j2Wsw=;
        b=MT6JvTAmuCgtHYt+cnSZzzCeJtpu/k/hA4qJHJxHrwVIhhgGenDJ7Bz5UHdIZMCYUA
         rTAr+8n7MyqhbaCibdvK8QFt8VQ4gCiJn/77eRXss4NlbRGOe3SaKo8wWoBbsl9PXiFu
         rk1E8C1/bEgwRXLIrOFiOAKCvHPDmeJVuAiJe/TxQU8pqkkzls4jrP/CV0tcMyxV9ja4
         3Osj/LuM1YwBZv9s0FUcrjTWYEo2n6mAp2qlznUesripcg9x3CyNZvJ9ZHg5n5EC3Jgx
         +zZIIWLmZ1QXJGik+8FBcO0gvL6wh0zcV314ROHxcbHjLUWXm14vYLAZR/VmTXakKswH
         h9cQ==
X-Gm-Message-State: ACgBeo0sxs5eWb8KZl+gsPhsIaDSGbDvjNfpZtWlAu443/XI95xg3R14
        GfS3zHcbxChXC2NF2vnOtjL1oXxgTaA9I5E1P4fTYg==
X-Google-Smtp-Source: AA6agR5x05CXrLqAbvUNICaEmR9ND1oRovJs4sWatPKcE/0sJGZyA2A8wHJQoct/2ED/eNkQUa0l1ok3po+Ds1xEZPU=
X-Received: by 2002:a9d:738c:0:b0:638:9962:8cb6 with SMTP id
 j12-20020a9d738c000000b0063899628cb6mr2921869otk.73.1660583474974; Mon, 15
 Aug 2022 10:11:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Aug 2022 12:11:14 -0500
MIME-Version: 1.0
In-Reply-To: <20220815041804.583181-1-judyhsiao@chromium.org>
References: <20220815041804.583181-1-judyhsiao@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 15 Aug 2022 12:11:14 -0500
Message-ID: <CAE-0n52NxrXkdck+cFtK4FC_F_D_xEbSuw-=LUKOKoqXi1gQFw@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Use "PP1800_L2C" as the DMIC
 power source.
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Judy Hsiao (2022-08-14 21:18:04)
> Use "PP1800_L2C" as the DMIC power source.

Why? Is it fixing sound on villager? Or supporting sound on villager?
Was the power source wrong before?

>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

Is Srinivasa the author? There should either be a From up above or a
Co-developed-by tag here.

> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---
> This patch depends on:
> arm64: dts: qcom: sc7280: Add herobrine-villager-r1. [1]
>
> [1]
> https://patchwork.kernel.org/patch/12926099/
>
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
> index c03b3ae4de50..983defa7c76d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
> @@ -12,3 +12,31 @@ / {
>         model = "Google Villager (rev1+)";
>         compatible = "google,villager", "qcom,sc7280";
>  };
> +
> +&lpass_va_macro {
> +       vdd-micb-supply = <&pp1800_l2c>;
> +};

This is the subject of the patch.

> +
> +&sound {
> +       audio-routing =
> +                       "IN1_HPHL", "HPHL_OUT",
> +                       "IN2_HPHR", "HPHR_OUT",
> +                       "AMIC1", "MIC BIAS1",
> +                       "AMIC2", "MIC BIAS2",
> +                       "VA DMIC0", "vdd-micb",
> +                       "VA DMIC1", "vdd-micb",
> +                       "VA DMIC2", "vdd-micb",
> +                       "VA DMIC3", "vdd-micb",
> +                       "TX SWR_ADC0", "ADC1_OUTPUT",
> +                       "TX SWR_ADC1", "ADC2_OUTPUT",
> +                       "TX SWR_ADC2", "ADC3_OUTPUT",
> +                       "TX SWR_DMIC0", "DMIC1_OUTPUT",
> +                       "TX SWR_DMIC1", "DMIC2_OUTPUT",
> +                       "TX SWR_DMIC2", "DMIC3_OUTPUT",
> +                       "TX SWR_DMIC3", "DMIC4_OUTPUT",
> +                       "TX SWR_DMIC4", "DMIC5_OUTPUT",
> +                       "TX SWR_DMIC5", "DMIC6_OUTPUT",
> +                       "TX SWR_DMIC6", "DMIC7_OUTPUT",
> +                       "TX SWR_DMIC7", "DMIC8_OUTPUT";
> +
> +};

This part is not described.
