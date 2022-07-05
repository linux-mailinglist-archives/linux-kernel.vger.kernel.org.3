Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE9F567673
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiGES3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiGES2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:28:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A45E1EEC9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:28:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a5so4062400wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 11:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9k/+Uy5gv2PwrBOPSWl6WfKzfQjFC1FlW0/HaLsKvWU=;
        b=Ad9KuxJ93xIfVpPWWDBLUBldo4Hbaz+s+qVOb6jcG2ew4dXMSIrYT5caIHj2dTj/XL
         l7zK2mgyOky9viuWMHGoLSpy38DRT3LqhGMT4ZMCICL7/j6RqKuRRHXEvEAjL94Ijeyw
         qBH4g+TTFNMnqPUS19LLMGSolayXJkKOuifmhh4dw0JXUOh198Z1m64nkJhA+f7Kvz2i
         5XMimEDXhZNBQmvvvtj5z9JfOgc9M+FL/wqlIuG1N9YKPFtDgRgSWAF/ExFqd0RoX0bJ
         sWm0mlrzNikOfnv2LzPSBu6dfGotPkVgwwmyA7qfLz6Ba/m0+rbxfKOkC+uo2SJ7rYUI
         xm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9k/+Uy5gv2PwrBOPSWl6WfKzfQjFC1FlW0/HaLsKvWU=;
        b=zTaNxIqlD0LyrtI4U7uqNvNno709SUqsOuNiPhc/539IpUW5ftO1OZO1fjbScNIKoB
         rEPHGu3Nkjr5Wz1Yb9s9+LcbtygvgXw2HqzLlCpqXlncRGrGCcd8/C5/NvfqwCMVNS9q
         SgCI9XJV6bCZeICo+3oxM1gNsLPWomOnzVrPBcx8g/YYtBrCX5M0Yy1O7GsLZNmefFRA
         An+jaPfThkBcJaJlnMbyNIPCFm1VxphdvlbtO4OD6yAH7TOEExLsfnrvN4d3nuujRtaO
         nnj5U0HEByEvRTfQrZPRKosZOEqbwGkv7QiwqfdBx7dDlxCoqhQ8shEsYNluJSAXCNqz
         Zc3g==
X-Gm-Message-State: AJIora9LG1e6GhQ6ylgTNYAWd3/38Z66RbiEyyHTembSGknmZl9E94l7
        ZucTYpx4S2VBR81Kea2XyhRZ/ehDrJan0T5SwB2gvA==
X-Google-Smtp-Source: AGRyM1vlwsMCrFY5zIP4L9aRehYUA+yzd3Q8yGz7fWKQEi0MiKAE7oCYE2ebmTrutqhdfXEeIao4xTvx2rFDBYcHvIY=
X-Received: by 2002:a05:6000:192:b0:21a:3c91:df05 with SMTP id
 p18-20020a056000019200b0021a3c91df05mr35030207wrx.655.1657045720822; Tue, 05
 Jul 2022 11:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-8-brad@pensando.io>
 <eac223c5-a3d4-65e5-3753-1bd4033513f2@linaro.org> <CAK9rFnyRgj26MaurS_u83wnzgmq+18=UdZT_FLLZc3jnWD4uFQ@mail.gmail.com>
 <db82fe69-8caf-f142-0714-ff73ea6f65ec@linaro.org>
In-Reply-To: <db82fe69-8caf-f142-0714-ff73ea6f65ec@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Tue, 5 Jul 2022 11:28:30 -0700
Message-ID: <CAK9rFny-PWvwY8K6mpzhx8deX3w8q5gFp1nmwq9QsiOUF4m+bg@mail.gmail.com>
Subject: Re: [PATCH v5 07/15] dt-bindings: reset: amd,pensando-elbasr-reset:
 Add AMD Pensando SR Reset Controller bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, Jul 3, 2022 at 11:41 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/07/2022 01:50, Brad Larson wrote:
> >> Missing file:
> >> ls: cannot access 'include/dt-bindings/reset/amd,pensando-elba-reset.h':
> >> No such file or directory
> >>
> >>
> >> Send complete bindings, not parts of it. Did you test it? I am pretty
> >> sure that this did not happen. :(
> >
> > Its in patch v5-0015 with the driver
>
> Header is part of bindings, not driver.

That's the reason, the header was not with the bindings.

> ...
> So how this test could pass if there is no header file included in the
> example here? Are you sure you tested each commit separately (like it
> will be included in the kernel)?

and I had applied the patchset before running the checks.  I'll check
each commit separately for next version.

Regards,
Brad
