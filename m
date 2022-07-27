Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0205827C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiG0NfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiG0NfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:35:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E8338A8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:35:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j7so2311885wrh.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJ2FnNxSmRb8UAb7jQjWYnnmc/G8CPHlMLuAUf0V/qc=;
        b=DnfSbIpPDdWocXmDLhFZP7gWezV+jOdviMPh+U4M6rSMhuaus/7BlhrkPdwj9F/jxA
         tE5H+DH16mFRIwWNTBj6ps6cZhh4sPX2O6W1BGtYWIcX3TvqOS2yPOCq2G7iarUqv0Xy
         e48w/+U3ejTJurqNiHTmLtEf7rf8khREuJ/JGQ6uqWwJbyfiJ3adhCUuNtCcTye2MpZO
         2cwWEqBSPFFY4VgNNg/HobJvUpYqJ/wlvovJBt93Hbf7twN5kZ+br+R+UOTAyfpmP3gi
         1GVBfb6ra8mXDiiuzzjuYYxlwSCb7sKBFxX8FyW6OdSFJdDOZc7wGVEXHv0xlgCKWruz
         Oq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJ2FnNxSmRb8UAb7jQjWYnnmc/G8CPHlMLuAUf0V/qc=;
        b=bcVwrF5bmKVuKQa3GskdDgQthm0HRhq82IG5aPQT9KYWl1kuYB6zHwIXOaJDCe3C5A
         CWN4ypjATR1BwDzKmPA0XlUDA9TY2CRKWIcFHYAQOC0vwYtewBSnyvF/377HquoOKdNP
         JVxtNpRNc8wWWGXImxPl9bk2e1J0mewclB4CBUWpHM2zj2bPJvsU5o1NzGzlvMgSlV5p
         entbN1GEwwl4gVEosgJW3LKeSm0hFsNHsg5rPi4Ko6w11dYdcoRawUX4zPy02HxTZiWG
         jHrFJy+te8FNTlafePxrbI5R+UWdBXouH0ZlVVkYcbw4C1npnrdzSvI7q6QP5LASU+gI
         Y5/g==
X-Gm-Message-State: AJIora+yIMvHnVCv4ln3roDbJH8kqgxRKQ7sL3ZuSZ4n2DwIafA+jWb1
        BPqK/O1Eqo03ObsSeL2bVNg+5YuVhvlynyZF9l8aBQ==
X-Google-Smtp-Source: AGRyM1uyWvpBoCBAvdlcKemv1yDPMEKUOaEXPjRCz1bUp2JNGpOumHFvwFUDXv3ojXs9fOEbhyIG5mqjIKcpAsbAlfM=
X-Received: by 2002:a05:600c:4fd5:b0:3a3:4664:6d55 with SMTP id
 o21-20020a05600c4fd500b003a346646d55mr3260914wmq.73.1658928909315; Wed, 27
 Jul 2022 06:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com> <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
 <CAK9=C2WjU+2cD7UZbja3TT++KCdRyWroT=50dw=fzi5mX30rcw@mail.gmail.com> <7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org>
In-Reply-To: <7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 27 Jul 2022 19:04:57 +0530
Message-ID: <CAAhSdy20p5bkVanKGkGyArn94hWJhwncztnX7U+4WkN9-v7NsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property riscv,timer-can-wake-cpu
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 6:05 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/07/2022 14:21, Anup Patel wrote:
> > On Wed, Jul 27, 2022 at 5:37 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 27/07/2022 13:43, Anup Patel wrote:
> >>> We add an optional DT property riscv,timer-can-wake-cpu which if present
> >>> in CPU DT node then CPU timer is always powered-on and never loses context.
> >>>
> >>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>> index d632ac76532e..b60b64b4113a 100644
> >>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>> @@ -78,6 +78,12 @@ properties:
> >>>        - rv64imac
> >>>        - rv64imafdc
> >>>
> >>> +  riscv,timer-can-wake-cpu:
> >>> +    type: boolean
> >>> +    description:
> >>> +      If present, the timer interrupt can wake up the CPU from
> >>> +      suspend/idle state.
> >>
> >> Isn't this a property of a timer, not CPU? IOW, your timer node should
> >> have "wakeup-source" property.
> >
> > Historically (since the early days), we never had a timer node in the
> > RISC-V world.
> >
> >>
> >> Now that's actual problem: why the RISC-V timer is bound to "riscv"
> >> compatible, not to dedicated timer node? How is it related to actual CPU
> >> (not SoC)?
> >
> > The RISC-V timer is always present on all RISC-V platforms because
>
> Timer is always present also on ARMv8 (and ARMv7) yet it has its node.
>
> > the "time" CSR is defined by RISC-V privileged specification. The method
> > to program per-CPU timer events in either using SBI call or Sstc CSRs.
>
> Timer is still not part of CPU. Otherwise you are claiming here that CPU
> can wakeup CPU...

The clocksource (i.e. "time" register) is part of the CPU but it is an
alias/copy
of a free running system counter whereas clockevent devices (i.e. "mtimecmp"
or "stimecmp" registers) are tightly coupled-with/part-of-the CPU.

Some of the CPU suspend/idle states may or may not preserve state of
timer registers so we might not get a timer interrupt to wake up the cpu
from idle state.

>
> >
> > Since, there is no dedicated timer node, we use CPU compatible string
> > for probing the per-CPU timer.
>
> Next time you add a properties:
> riscv,saata-can-wake-cpu
> riscv,usb-can-wake-cpu
> riscv,interrupt-controller-can-wake-cpu
>
> and so on and keep explaining that "historically" you did not define
> separate nodes, so thus must be in CPU node.

This is a one-of-case with RISC-V DeviceTree where we are living with
the fact that there is no timer DT node. If we add a timer DT node now
then we have to deal with compatibility for existing platforms.

>
> You need to properly reflect hardware in the DTS instead of such hacks.
>
> Best regards,
> Krzysztof

Regards,
Anup
