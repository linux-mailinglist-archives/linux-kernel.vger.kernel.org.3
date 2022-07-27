Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E4D582786
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiG0NTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiG0NTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:19:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA5432B9F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:19:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v17so5186214wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dibkbw64+uQcY04egPFlqnHwHsFqfmAeKYM6z+pWQOk=;
        b=Y/X9OjJkkL7iDYVukFb7bLpNmZgR1h2IcOwkq2eCmqjYacPrz37zhp0ZsbdiZVi/RV
         Xb/wNpkg0x4WAMbKdwVole23Tp5wqsEgSVNUSF+6leNzUbah8IRZpzLkhp8S3PjglWvq
         lu0hsbVN/SNET9UoO94QR18JsGrUpRvHcYX9j+ErHYRIDKreiAs98P1cZH23eZFhpByS
         vxCkePTSqWqN6i3Q1pAl21HvHQuEyibsLb3W3hZqJPOEMH9AMsGwXXi1IccwlFkUfgdJ
         p5lq2gpNzSF38Yiy7tN31a+bmGQuPmFJe9o9+meZ7oVM8797/AeQKdvQYp48aBbtHTi5
         yEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dibkbw64+uQcY04egPFlqnHwHsFqfmAeKYM6z+pWQOk=;
        b=As3iGTO2LuDHwzwxU7yEU1mdgU+g1XA1TcEOCWY1uxiChNjoKmTgJNu/HIitYrUZ5F
         kpxa4XQot0nY/teff7cx27ANuuh0aQ6xXW2Ve9XMo7ojTK/SG6cvrbk8svN9DM1tNfhf
         eZRTrfA9lF09F8n1aoyji10PvYVSD+Y9qHaPmv6w6IxbOzHzy/P7C05hYJmce9tsYzwS
         wV6qMvExRg2NVNpJr6vQ9y//kxwcwrQ8rAu/35wM/WtR4QeZXLeMI2wDf3vAghSimTlD
         poymgQALCmQhtXjb7MdJZHynqBWDiO5XJkCDfe/3CUqv0q93qdUWnDbRfnFQVTW92V2l
         T2sA==
X-Gm-Message-State: AJIora/80f2aOLLBaTDqpsAFpYFPmYUuqGs47TdT5EGiwOpyY8+TJTKD
        ZD15PKEyn60aKLW5X6xTiNgffHU2tfHM1eE776zVTg==
X-Google-Smtp-Source: AGRyM1to8HbWQ44clapjD+5JGTD4YIZugXsbUPGE3wnHGXlqx7QirS2COMcNXHJ8Gy7Ob3it50+Qnfk4bKm9iNKFwpk=
X-Received: by 2002:a5d:64ac:0:b0:21d:7832:ecf9 with SMTP id
 m12-20020a5d64ac000000b0021d7832ecf9mr14023296wrp.86.1658927974767; Wed, 27
 Jul 2022 06:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com> <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
 <20220727124556.owk3zlyzsg5uaa4t@bogus>
In-Reply-To: <20220727124556.owk3zlyzsg5uaa4t@bogus>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 27 Jul 2022 18:49:23 +0530
Message-ID: <CAAhSdy1guiVFxzU+r_7njH-E_hWUDy+r7P36YEf5OB80nDHuhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property riscv,timer-can-wake-cpu
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 6:16 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 27, 2022 at 02:07:50PM +0200, Krzysztof Kozlowski wrote:
> > On 27/07/2022 13:43, Anup Patel wrote:
> > > We add an optional DT property riscv,timer-can-wake-cpu which if present
> > > in CPU DT node then CPU timer is always powered-on and never loses context.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > index d632ac76532e..b60b64b4113a 100644
> > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > @@ -78,6 +78,12 @@ properties:
> > >        - rv64imac
> > >        - rv64imafdc
> > >
> > > +  riscv,timer-can-wake-cpu:
> > > +    type: boolean
> > > +    description:
> > > +      If present, the timer interrupt can wake up the CPU from
> > > +      suspend/idle state.
> >
> > Isn't this a property of a timer, not CPU? IOW, your timer node should
> > have "wakeup-source" property.
> >
>
> I agree on the concept that this is property of the timer and not CPU.
> However we generally don't need to use wakeup-source property for timer
> as we ideally use this for waking up from system sleep state and we don't
> want to be running timer when we enter the state.
>
> > Now that's actual problem: why the RISC-V timer is bound to "riscv"
> > compatible, not to dedicated timer node? How is it related to actual CPU
> > (not SoC)?
>
> We have "always-on" property for this on arm arch timer, and I also see
> "regulator-always-on" or something similar defined. So in absence of timer
> node probably "local-timer-always-on" make sense ? Thoughts ?

I agree.

In the v1 patch, I had named it "riscv,timer-always-on" but I chose a
more specific name in v2 based on comments from Samuel. I think
we should use more consistent naming between ARM and RISC-V
so "riscv,timer-always-on" makes more sense to me.

Regards,
Anup
