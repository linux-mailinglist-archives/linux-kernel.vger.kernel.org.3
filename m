Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C51A572AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiGMBZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiGMBZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:25:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAABAF740;
        Tue, 12 Jul 2022 18:25:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n18so15053011lfq.1;
        Tue, 12 Jul 2022 18:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWrmSNqw7RNUpJXET/KeaD+M/fKJ2fs4iPsVi56Xzlc=;
        b=KJ3WTtZWy/gaqWn5D68477Fqo5MTFflVAPExDGJhWAAeEJMYFNc2SyuM0LGzFB/cLO
         0vjPZ6x6LzBaY/dZgdEMDDqbsdh9TAmR+HpPDzdZ1NqUlbKJF7lsDIDe3LSKpzg6ahXI
         exkNkhZxFM8EiZCBA0+pbOXL3XiG/3FiJFdZH1ZBuoot1+osh5ZOUoMa42Q8i1JL5GPg
         yufCSzOk7sgthAFQERz2yIRBc7ta1U3r9a1XpfY9AUruOk1PWPgTAcHCKQaHEbNhd8JA
         MGC+lPnA9pSD5g4B6Nkp61nZ7+8MJ4cjp05K2I4tv2I/JyZkrzsf+ALiCZJjJAd24lvo
         ygow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWrmSNqw7RNUpJXET/KeaD+M/fKJ2fs4iPsVi56Xzlc=;
        b=MNuwSCDAFB5xC+LpbntzfFyV6wN9z6BrYTn9eb8SHZkf0rShsMibl1wO6+hrtJXbR1
         Nw+yJ+5UzOMxkZpsBwfgEv3owO4519IDR4+SfNSvDNDr+XkVl7+TGw6zQ8LLngmVAdCM
         Dg1N9mBEg6pzYQe2JIOH3fiaeM36zylnjkN8c1Cm2l29zrjE6+xI9u1l+4GHab8E0ISz
         D8FOs984bn6w23mgT55wvDgw09gcirnr0/vuZ0QfkU4AaS9AJSqjhHCRK3KscP6TLDtQ
         wL2C1CbBH0fKABYRqZpYJirMhWH3YchTXPVTRBW42inBOiGEx4C2z7bhBu+tmAfamWL1
         VaUQ==
X-Gm-Message-State: AJIora8WWiOm4Bq+DAaPNnFs6PyAExtKmx9vlQi5flI0XrlrseGVHt2S
        CeINbsvd4WhuxZYGz+LDheyieuqp/KF1ey13Pjt5n+/NAQWxuAaU
X-Google-Smtp-Source: AGRyM1v5acsNboqgbK0uyTTlYszlcwZd4ryktxElVqCtXMMl6OJMeNv1mTDGlBeanoLf1mqWAwLyRJRsTHm2/WJJWQw=
X-Received: by 2002:a05:6512:398e:b0:481:154b:a92 with SMTP id
 j14-20020a056512398e00b00481154b0a92mr564768lfu.110.1657675538590; Tue, 12
 Jul 2022 18:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220712145139.9473-1-mollysophia379@gmail.com> <3a0d3e52-a403-36c5-fc39-f45dce94c1f8@linaro.org>
In-Reply-To: <3a0d3e52-a403-36c5-fc39-f45dce94c1f8@linaro.org>
From:   Molly Sophia <mollysophia379@gmail.com>
Date:   Wed, 13 Jul 2022 09:25:26 +0800
Message-ID: <CAK0UmJAdiSER0qUj3162ys4nxnni+6onY9-uVaq_=EdSnaC=CA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Mix2s bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
I will read that carefully. Sincerely apologize for the mistakes I have made.

Molly

On Tue, Jul 12, 2022 at 11:05 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/07/2022 16:51, Molly Sophia wrote:
> > Add documentation for "xiaomi,polaris" device.
> >
> > Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
>
> This is v6 and still not changelog. No cover letter either, which would
>  describe any dependencies.
>
> Sorry, you need to follow our process:
> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst
>
>
> Best regards,
> Krzysztof
