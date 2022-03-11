Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273194D6223
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348804AbiCKNLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348803AbiCKNLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:11:45 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EE01C2DA0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:10:42 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b28so3276055lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1zLYRFICp/9YNZ3C/JM0L5WZ5qjBhMXFH4zYngCLz0k=;
        b=ipz8gco+55GK0rSfRsuzxgY9EQVCMIwj2GHWKxq3MizJnLDEkxPQljV15yw764Zm8F
         XmLgGYBG1v9yIcweK/5W8k2o7O4FpjTEZXoaYvL3FqwfXVRtz/KhaNphSB7gHFiub9Dm
         XGJMd22wCooz8mO0cXNEqoLu1lAp/DICy8o1EVFD5JRC4B+Q9GqoejI9zH7thQz/W6eS
         P/Pre2BkamthiLAyFOy5V0xMoVsHsTQDjTndFhyT8aH/0I3n1SBmGAov6GMpps1QKVW/
         sAuhPEUuBOpVXngOk45pQo6rui2tJNa6mQJmMU+M1jlzovIOAqjsPpEDmK+pex1Hh+gq
         FWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1zLYRFICp/9YNZ3C/JM0L5WZ5qjBhMXFH4zYngCLz0k=;
        b=WiZNlv7/EQXcpQmj2F238r30QUVqbMLz0g3/h0zWvg8BtdsthobadJGVrMM/KPjha4
         0OxDDLYK4ppO2u248d7Api7qigx6+hUTFc8lGXnytmVbWO8VzujJCDFGss3onsqb+PXx
         3v4YsOYt+L/YYgzIn7Ojc7oHBAFLHb887quBVxQZYCXojQFn6DD8hy1ulm0aqPaeL5AH
         Ur8/8P/sVUZD5/6l3Amp1rUu5RHXFPhIxnzaGQ552OABbOk8LfkQa2GH+AViUJf4FF9s
         fspnUdhfUqWTclR1H7sjq4ii238IIR3W0L2jTP4EAOH7ZufSVPjneU+m1Nc8qfXTRlaU
         orPg==
X-Gm-Message-State: AOAM5302SHXHksslv8N5VI6KVk4NtMtNDm7WbhiKk04UYDEf5+LHSgZQ
        WxlacIFbxjmC+O0GwF5+OAolR/CfTlOcPZKDFdla8A==
X-Google-Smtp-Source: ABdhPJw8d+Eupsr/72x4wRsKG4WURFHxUpziwGdPCq7z7GnXpzTcZkwbs48/yGlotHpniBkmpww0hE2GyL2F/8YcUyg=
X-Received: by 2002:ac2:4146:0:b0:441:efd2:365d with SMTP id
 c6-20020ac24146000000b00441efd2365dmr6194423lfi.100.1647004239469; Fri, 11
 Mar 2022 05:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20220222204811.2281949-1-atishp@rivosinc.com> <mhng-4593ea1e-503d-47df-8e55-d2ef06f01518@palmer-ri-x1c9>
 <CAHBxVyHaFk6mx_uTUcOG1d+XGokT_-Y3_Y1kVJixAnGGmLjAxg@mail.gmail.com> <d8d4fedad13ef063b672aadfe2ee0aff@mailhost.ics.forth.gr>
In-Reply-To: <d8d4fedad13ef063b672aadfe2ee0aff@mailhost.ics.forth.gr>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 11 Mar 2022 18:40:28 +0530
Message-ID: <CAK9=C2WZCp2aKnFTVN0iDqDxVgV6WMFzsM+a9a1Q8Go_n6iMkw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Provide a fraemework for RISC-V ISA extensions
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Atish Kumar Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 6:13 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2022-03-11 02:21, Atish Kumar Patra =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> > On Thu, Mar 10, 2022 at 3:50 PM Palmer Dabbelt <palmer@dabbelt.com>
> > wrote:
> >>
> >> On Tue, 22 Feb 2022 12:48:05 PST (-0800), Atish Patra wrote:
> >> > This series implements a generic framework to parse multi-letter ISA
> >> > extensions. This series is based on Tsukasa's v3 isa extension impro=
vement
> >> > series[1]. I have fixed few bugs and improved comments from that ser=
ies
> >> > (PATCH1-3). I have not used PATCH 4 from that series as we are not u=
sing
> >> > ISA extension versioning as of now. We can add that later if require=
d.
> >> >
> >> > PATCH 4 allows the probing of multi-letter extensions via a macro.
> >> > It continues to use the common isa extensions between all the harts.
> >> > Thus hetergenous hart systems will only see the common ISA extension=
s.
> >> >
> >> > PATCH 6 improves the /proc/cpuinfo interface for the available ISA e=
xtensions
> >> > via /proc/cpuinfo.
> >> >
> >> > Here is the example output of /proc/cpuinfo:
> >> > (with debug patches in Qemu and Linux kernel)
> >> >
> >> > # cat /proc/cpuinfo
> >> > processor     : 0
> >> > hart          : 0
> >> > isa           : rv64imafdch
> >> > isa-ext               : svpbmt svnapot svinval
> >>
> >> I know it might seem a bit pedantic, but I really don't want to
> >> introduce a new format for encoding ISA extensions -- doubly so if
> >> this
> >> is the only way we're giving this info to userspace, as then we're
> >> just
> >> asking folks to turn this into a defacto ABI.  Every time we try to do
> >> something that's sort of like an ISA string but not exactly what's in
> >> the spec we end up getting burned, and while I don't see a specific
> >> way
> >
> > I agree that this is an ABI change/improvement which is impossible to
> > modify later.
> > However, this is a Linux specific ABI. Do you think the RISC-V spec
> > will ever say anything about how /proc/cpuinfo is shown to the user ?
> >
>
> Actually there was a discussion on chairs at some point on how isa
> extensions will be represented as a single string. If I recall correctly
> they wanted a way to compare features between implementations so this
> was something the user should be able to read as well. I'm ccing Philipp
> from the Software HC in case he has more details on this.
>
> I also believe we need to discuss this a bit further, also I thought we
> agreed that having everything as a single string (riscv-isa) on the
> device tree doesn't scale, there were some other suggestions regarding
> for example mmu extensions being declared inside an mmu sub-node etc.
> This patch series will not only make it hard to change /proc/cpuinfo
> output in the future, but also establishes a device-tree binding for all
> isa extensions through the riscv-isa string that we also won't be able
> to modify later on.

Initially we can just follow the ISA string approach because this
is what RISC-V unpric spec defines.

Specifying ISA extensions via DT or ACPI, can be incrementally
done in future.

We have a lot of patches (Svpbmt, Sstc, Scofpmf, Zcboxyz, etc)
blocked because we don't have a way to detect multi-letter
extensions in Linux.

Regards,
Anup

>
> Regards,
> Nick
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
