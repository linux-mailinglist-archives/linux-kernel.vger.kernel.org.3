Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF3E52D156
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbiESLWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiESLWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:22:10 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA83EB9F;
        Thu, 19 May 2022 04:22:09 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id y20so4309976qvx.3;
        Thu, 19 May 2022 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BdjFDXDnxUjm7j6k5q7Kxu4c2cwbFqYPCxZS6zuqxo=;
        b=hMKm6jsKzjqEdOGCZHwzBQGiShlBMZDUYRYcrKTYGTi4eL7ik6xnF1uVrU2MqRdwGl
         4SeGSen+5/FFe+xbHzwlrAWsjksnoMUB4D6g+IaveRs7Kdus1hiyz7Cr0ILUTS/kXzh+
         4rrAvGPRPCYo/1VHnb2C9sZqA1SL5z8KaAZFNUEodWgnVVmQJfBZQyuP1UfWfBfBOr/7
         rB9Ppq5D4vDRV0xJaTeaEWc8SZKbR0IkcAW1DweFeOncjiOT5Gzle+D2hr8RkyriIuxr
         7MtIWxdJH43PLAk+49MXfFdECCTNSXifgWEk4KRwBagsa2GFES1mvH6y5EIxevHzNzoy
         /stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BdjFDXDnxUjm7j6k5q7Kxu4c2cwbFqYPCxZS6zuqxo=;
        b=JtueDx0gPyep8hsztLa1JRqmdq8/7gdArmYwWQn68skI1NwSRoX7ihqewIEXYjN5AM
         7pwxKiHSHJmGI+C0sn3NN3Z1Qh/E1iT+P8vqs6r5E/bjGbzSWr6lR/KEdd9D9ielvDMg
         TbKz7VRhOSxXgwqob6eHs8GLxhlkMmxCCyTqv+KU9YtKKP+N/mBWrJXRFozOyeaNRY9b
         8+OR9hM8uyp1G6e+vKmyoLRRR8mPl6z+wALEwZW/T6/lUBV2dcZF+SmAJqekH8BJ7jFw
         TgbXN5JekjbXHHMc+HuOdqMXMniWaS4ArxHo12Hpq886ccEnKQqifMvm4rCBNPSXKSgk
         5Agg==
X-Gm-Message-State: AOAM532VIrziIje/XApV77YSA316CGz5ZNDEnitzY/J3mNRpmgnjxib6
        oIiM71IW5LjKGaPPn06Je5J3DrP9+tTEIYlN7oM=
X-Google-Smtp-Source: ABdhPJxLhdpP5H29s1X67RNrL/m+5o9e0OA57DOxQ1UYzD82HkG4/G++oXvkN3CyBMkVW6rslRr7hPgK/Q/zvRMRtmg=
X-Received: by 2002:a05:6214:48f:b0:461:d4fe:4eed with SMTP id
 ay15-20020a056214048f00b00461d4fe4eedmr3434798qvb.48.1652959328792; Thu, 19
 May 2022 04:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220518184825.1034976-1-robimarko@gmail.com> <20220518184825.1034976-6-robimarko@gmail.com>
 <015c60e9-78f6-f0f0-5af0-733a78fbdf65@linaro.org>
In-Reply-To: <015c60e9-78f6-f0f0-5af0-733a78fbdf65@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 19 May 2022 13:21:57 +0200
Message-ID: <CAOX2RU4--VULzvc9NGc4zWV4jpD+riM+9Ff8mqU834a6vQFc5Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: Add PMP8074 DTSI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 at 13:07, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/05/2022 20:48, Robert Marko wrote:
> > PMP8074 is a companion PMIC to the Qualcomm IPQ8074 series that is
> > controlled via SPMI.
> >
> > Since we now have support for the regulators inside of it add DTSI
> > for it.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/pmp8074.dtsi | 38 +++++++++++++++++++++++++++
>
> This file is not referenced by anything, thus not possible to compile
> nor verify.

That is correct, I can include it on HK01 which has an SDHCI controller
and thus can consume L11 for VQMMC so that HS200 and higher work.

I wanted to include the nodes directly in the SoC DTSI and set L11 as VQMMC
for SDHCI there as this is a companion PMIC and always present, but
the established
procedure is for the PMIC to have its own DTSI and then be included per board.

Regards,
Robert
>
>
> Best regards,
> Krzysztof
