Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D815157F693
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiGXSo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGXSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:44:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB75110FDD
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:44:22 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o21so7161597qkm.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uqLCtj81FzXR1rhJvIs1w4M+P+JCKpBnNBBvGjMwhkY=;
        b=b5RRwEQx9QQiM2iteB1J9tDEhxTHRFV9M2mhDG+mWfrbuIpuUzbCT2yguT0ZX8Xz74
         mzowjZAAnR0twZciOuTIMIvaNedFOYbmnb30yydFpDsPFXbjV9NoRvRxHUjH4H7ufAkw
         VU1J3nWeFiEyLm6Y1zX4hCfKzvL4s9/jfcDUo3a0ICeZ90PT7jkQEEaU51rbQG99OvMm
         gwCkH9wCz1aOJ05n9BcIBdtm4LvX4Vv7kUOpevhUY/S5E7dpPLoQU+eQpMuFzKq3//RS
         q9DRJNxOt/y2Fq9NCbCERrFQCZCr9z78GLNkJSZM97gY11rCIwaipfRmJUemucK6AgH3
         pzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uqLCtj81FzXR1rhJvIs1w4M+P+JCKpBnNBBvGjMwhkY=;
        b=Vl3FGaMxnFoQ4G5Lhkal7vKV/2PywNgjyHDWWxzv8DGlNaMs7VCFYGL1ZZNPI7PCy8
         n4nfzy+iIbXHttsLU9gVgjkKuL0+EuHN6d8xBKXt/XHgW5aOutmwCWu+GWuES/WtyHV2
         3mwBuX/5pG2mNSi0ir0cTONPea2eFqBRhPSsj5VTFdVg34QpirK96DK22eAZmY2bJuwN
         MEIeIJbLQeqV1TwJR8Tzbt5VHebb6sXHXJOrSxYOptehzZm1mRP4Jx/m73f4EzdCOyue
         sOG0yVSqeP//+s3Lq89WgyhXcXveEKI6NB0VjIozxsvBegcy78KdRPjPC4AO2ce0vTvz
         avXQ==
X-Gm-Message-State: AJIora8c9ev5Lr8kb5O/dFlOPyPtvLo0xpAJ1KwykzEPG+RcEx109LzN
        tmpSk6ZuKN5BOMBA0e7b1WwYFv77HF/GKwOpmftBc3lXRY2vjA==
X-Google-Smtp-Source: AGRyM1vUDgkdDdsy8580QybhfJAvFu+1i9OFoHQ5vdHGHRp/oVSD1FiSHUQDYvIBh9xS6RcwZBGF9eySc2sErRzDKvM=
X-Received: by 2002:ae9:f311:0:b0:6b6:30a9:1bb1 with SMTP id
 p17-20020ae9f311000000b006b630a91bb1mr6795622qkg.30.1658688261879; Sun, 24
 Jul 2022 11:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220724172442.87830-1-matti.lehtimaki@gmail.com> <20220724172442.87830-2-matti.lehtimaki@gmail.com>
In-Reply-To: <20220724172442.87830-2-matti.lehtimaki@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 24 Jul 2022 21:44:11 +0300
Message-ID: <CAA8EJpqwpO3gu4XD8cHju=9avGb-1YGN8r1cHwgLOFVKpOFBrQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: qcom: pm8226: Add node for the GPIOs
To:     =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 at 20:25, Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.c=
om> wrote:
>
> The PM8226 provides 8 GPIOs. Add a node to support them.
>
> Signed-off-by: Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> (no changes since v2)


--=20
With best wishes
Dmitry
