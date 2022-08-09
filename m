Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950C158D858
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiHILpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242879AbiHILpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:45:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5521E13
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:45:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id l10so8116114lje.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zUYPLrsI2jiauKzG2M7v5iOa2wbC7ozeiUu0l4qgI+w=;
        b=c7tJt01hfgCM3eVG34V8C3/1/MVeYqu2TxvqhJ40kl5/oT81KhKRDS2VoiEwQsfD2R
         AI1f43V5NjI/YBAdSUOtrA/f5Y216fN1kQVBpUJVbayKCaPJD6MK4UwzNBaOPSZuThV6
         cARWDyz4l0x4i8Gclnn+5K6cbj7seJloZ4WZmFDkq4z2YXtU3zxtUciloyud003+mTp+
         Hj49JgIdG6rDLBZCFyunxvl9A2gvkGMyiiIiTo9c3tC/G7e/73w2mT1cniJrFzjWxJMc
         wjFdYkvQjLdukxsNxQvU6aeOpZkxvo0lFUJGzUOtknBnJhy80CSKehQQH9vpBb3RA7tl
         ZdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zUYPLrsI2jiauKzG2M7v5iOa2wbC7ozeiUu0l4qgI+w=;
        b=HSB5RjeEzC80vjvPO46Hr13mnkzwJxIyIdN8VdBMu//CkGUNGay7i/ORoPbb1WXxxo
         zIvJHWfdQfFKi/Baab7MR+Glp6Pfo+uyrbDiGZngWI7JoTFXvvq4PL2MiwmI+IABRQyo
         LaQfp6JG6kydJj5PoXkRchemU/eeSz/RxHihiG1Jna8r2vHRBNK+gOCJaYEhUxeR7tBo
         V4sIT4KBe92ysZde1mFoNbxuxOXmPPiSJL5gqigz5h0GPGYygS/t5JHgJ9l/SRgbMu6V
         CRiFd0X3KnkzF2E00y4sUXo23TxkFB4HbEeOs3ZGWy6+aFOlILzXARH6Ma7ye0oAzFmn
         xzow==
X-Gm-Message-State: ACgBeo3tZNZy9yEipZZKYddWmkNoft9S7nsFn94fLBqXwamdsKTiwZgu
        A6lhF7ggKmNMVeU2k1q1CXm0M2Db5RjUF76Qj3DBtw==
X-Google-Smtp-Source: AA6agR6xzLjWyUFZQ9pgjFN8td8td7t9e2m7P04bImaQQqG/sXobBxAJTALBV0Pp5hY/l0hahcUvZbFdlCM9pimnrdg=
X-Received: by 2002:a2e:aaa2:0:b0:25e:5083:eb9a with SMTP id
 bj34-20020a2eaaa2000000b0025e5083eb9amr7078976ljb.283.1660045544571; Tue, 09
 Aug 2022 04:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220808201724.27831-1-semen.protsenko@linaro.org>
In-Reply-To: <20220808201724.27831-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 9 Aug 2022 14:45:33 +0300
Message-ID: <CAPLW+4kdgrVyE5jTXPRWCKdr_A+C_EGLLp1AjSe3OfHoX8jEvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: dts: exynos850: Add cmu and sysmmu nodes
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, 8 Aug 2022 at 23:17, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Now that all clock domains needed for SysMMUs are implemented [1]
> (pending), and the basic SysMMU v7 support is ready as well [2], let's
> add all related CMU and SysMMU nodes to Exynos850 SoC device tree.
>
> All those SysMMU instances were tested with "emulated translation"
> driver [4] on E850-96 board: both the emulated translation and fault
> handling were verified.
>
> This patch series depends on [1], so it must be taken into the account
> when merging it.
>
> [1] https://lkml.org/lkml/2022/8/8/752
> [2] https://lkml.org/lkml/2022/7/14/1215
> [3] https://lkml.org/lkml/2022/7/26/950
> [4] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu
>
> Sam Protsenko (2):
>   arm64: dts: exynos: Add CMU_AUD, CMU_IS and CMU_MFCMSCL for Exynos850
>   arm64: dts: exynos: Add SysMMU nodes for Exynos850
>
>  arch/arm64/boot/dts/exynos/exynos850.dtsi | 83 +++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> --
> 2.30.2
>

This patch series is superseded by v2 here: [1].

[1] https://lkml.org/lkml/2022/8/9/328
