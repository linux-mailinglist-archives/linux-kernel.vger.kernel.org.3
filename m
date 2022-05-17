Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9852987A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 06:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiEQEDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 00:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiEQEDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 00:03:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500F746653
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:03:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i10so29094796lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLuh6iim4/H/XbPkV7FBYvTzbDgx426YXgEZpo+wCs8=;
        b=h/uB1SJQjYPxqpCmzRGCV2+SA9pB9F6Y0DBV8COwWi5dC//eegFBMmdUp31Vzeg5rx
         qbj6Ndes5JT36T5eDBKKlnwqTcLujVuy6MUsE0UiR8HvIgcJoy4vOrnohnSlUiLSUCek
         0CCOEfoVUuQpGA0bNr5nufd18cgI8ucnw1ywLq3hK0bR/J9sMNmHEoxkq6Vdvj8gCUAa
         gIJVbCwWfslgMs9YsTz8mYUMp1IjbSaertxKqsWJkGEZ+LcROg0eJ3s9HKZgicdeWqgG
         RlfMjmrGCN7+YytXWVX0Njm0vRnLllUZjGVOutuR8kkKjM1EU0IBixCA8ETedpIKxrJA
         FLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLuh6iim4/H/XbPkV7FBYvTzbDgx426YXgEZpo+wCs8=;
        b=wk1g0728LO6MvKFLy3KLOIHg//6iEU6eZAAQQHzUhwDlIPf/2Y1Xz6gSNxcKWbIVCk
         884IJScltIcmtuWeUNNOMmoWKjklAr5lzYW8QPIX4G5OQsl9HnnqDhUe36myBKjer3hr
         xYikX6LyiyU66ZUrf3AQqTDYa2+C/0TEGf0jwXmtPBWGe/AgCexunTzZzu/jQXSWCzl0
         uRwxic6R+9AYa9NjPMicsveppw6Imh+OMhaSb5lYXWOWUx0yYfW1ZD5vg0vlcClo6qJN
         Co7U5u0pa17VbzkYEW1Y6R1TIFufnIOOtuc0I2FIC8DXNEvDZRjtuTuhR7ta2tdcVU9P
         bWgg==
X-Gm-Message-State: AOAM530lEzVUY2xaNf2Ae4a2LJLh3UsjZ0IK1VyMIFlsVAHL+jAJCJij
        F2AWopadmGBA+XUp5/WIA10oibooxImFDvnp5ezMTg==
X-Google-Smtp-Source: ABdhPJzDGKq4CvrYRIjO/1+pCqdoDGroAy2iSOeVL+38mDlDjSUyOGj/dvqYTcf7drbGhM4n16FSkfgysnhBO474F6Y=
X-Received: by 2002:a05:6512:309:b0:477:a8c7:96d8 with SMTP id
 t9-20020a056512030900b00477a8c796d8mr142603lfp.41.1652760179523; Mon, 16 May
 2022 21:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220508160749.984-1-jszhang@kernel.org> <20220508160749.984-3-jszhang@kernel.org>
 <CAK9=C2Xinc6Y9ue+3ZOvKOOgru7wvJNcEPLvO4aZGuQqETXi2w@mail.gmail.com>
 <YnkoKxaPbrTnZPQv@xhacker> <CAOnJCU+XR5mtqKBQLMj3JgsTPgvAQdO_jj2FWqcu7f9MezNCKA@mail.gmail.com>
 <YoCollqhS93NJZjL@xhacker> <CAAhSdy3_av5H-V_d5ynwgfeZYsCnCSd5pFSEKCzDSDBbD+pGLA@mail.gmail.com>
 <YoKIv2ATRdQfYbBf@xhacker>
In-Reply-To: <YoKIv2ATRdQfYbBf@xhacker>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 17 May 2022 09:31:50 +0530
Message-ID: <CAK9=C2VJ-+bu20+QOfKrq6cEBE93Yi21U=zU9AKOSQi1GGHWiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] riscv: introduce unified static key mechanism for
 CPU features
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
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

On Mon, May 16, 2022 at 11:02 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Sun, May 15, 2022 at 08:19:37PM +0530, Anup Patel wrote:
> > On Sun, May 15, 2022 at 12:54 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> > >
> > > On Wed, May 11, 2022 at 11:29:32PM -0700, Atish Patra wrote:
> > > > On Mon, May 9, 2022 at 7:50 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > > >
> > > > > On Mon, May 09, 2022 at 09:17:10AM +0530, Anup Patel wrote:
> > > > > > On Sun, May 8, 2022 at 9:47 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > > > > >
> > > > > > > Currently, riscv has several features why may not be supported on all
> > > > > > > riscv platforms, for example, FPU, SV48 and so on. To support unified
> > > > > > > kernel Image style, we need to check whether the feature is suportted
> > > > > > > or not. If the check sits at hot code path, then performance will be
> > > > > > > impacted a lot. static key can be used to solve the issue. In the past
> > > > > > > FPU support has been converted to use static key mechanism. I believe
> > > > > > > we will have similar cases in the future.
> > > > > >
> > > > > > It's not just FPU and Sv48. There are several others such as Svinval,
> > > > > > Vector, Svnapot, Svpbmt, and many many others.
> > > > > >
> > > > > > Overall, I agree with the approach of using static key array but I
> > > > > > disagree with the semantics and the duplicate stuff being added.
> > > > > >
> > > > > > Please see more comments below ..
> > > > > >
> > > > > > >
> > > > > > > Similar as arm64 does(in fact, some code is borrowed from arm64), this
> > > > > > > patch tries to add an unified mechanism to use static keys for all
> > > > > > > the cpu features by implementing an array of default-false static keys
> > > > > > > and enabling them when detected. The cpus_have_*_cap() check uses the
> > > > > > > static keys if riscv_const_caps_ready is finalized, otherwise the
> > > > > > > compiler generates the bitmap test.
> > > > > >
> > > > > > First of all, we should stop calling this a feature (like ARM does). Rather,
> > > > > > we should call these as isa extensions ("isaext") to align with the RISC-V
> > > > > > priv spec and RISC-V profiles spec. For all the ISA optionalities which do
> > > > > > not have distinct extension name, the RISC-V profiles spec is assigning
> > > > > > names to all such optionalities.
> > > > >
> > > > > Same as the reply a few minutes ago, the key problem here is do all
> > > > > CPU features belong to *ISA* extensions? For example, SV48, SV57 etc.
> > > > > I agree with Atish's comments here:
> > > > >
> > > > > "I think the cpu feature is a superset of the ISA extension.
> > > > > cpu feature != ISA extension"
> > > > >
> > > >
> > > > It seems to be accurate at that point in time. However, the latest
> > > > profile spec seems to
> > > > define everything as an extension including sv48.
> > > >
> > > > https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#623-rva22s64-supported-optional-extensions
> > > >
> > > > It may be a redundant effort and confusing to create two sets i.e.
> > > > feature and extension in this case.
> > > > But this specification is not frozen yet and may change in the future.
> > > > We at least know that that is the current intention.
> > > >
> > > > Array of static keys is definitely useful and should be used for all
> > > > well defined ISA extensions by the ratified priv spec.
> > > > This will simplify this patch as well. For any feature/extensions
> > > > (i.e. sv48/sv57) which was never defined as an extension
> > > > in the priv spec but profile seems to define it now, I would leave it
> > > > alone for the time being. Converting the existing code
> > > > to static key probably has value but please do not include it in the
> > > > static key array setup.
> > > >
> > > > Once the profile spec is frozen, we can decide which direction the
> > > > Linux kernel should go.
> > > >
> > >
> > > Hi Atish, Anup,
> > >
> > > I see your points and thanks for the information of the profile
> > > spec. Now, I have other two points about isa VS features:
> > >
> > > 1. Not all isa extenstions need static key mechanism, so if we
> > > make a static key array with 1:1 riscv_isa <-> static key relationship
> > > there may be waste.
> > >
> > > For example, the 'a', 'c', 'i', 'm' and so on don't have static
> > > key usage.
> >
> > Not all isa extensions but a large number of them will need a static
> > key. It's better to always have one static key per ISA extension
> > defined in cpufeatures.c
>
> Currently, RISCV_ISA_EXT_MAX equals to 64 while the base ID is 26.
> In those 26 base IDs, only F/D and V need static key, it means
> we waste at least 24 static keys.

If you want to save space of unused static keys then there are other
ways.

For example, you can create a small static key array which has
many-to-one relation with the ISA extension numbers. For ISA extension
which are always ON or always OFF, we can use fixed FALSE and
TRUE keys. Something like below.

enum riscv_isa_ext_key {
    RISCV_ISA_EXT_KEY_FALSE = 0,
    RISCV_ISA_EXT_KEY_TRUE,
    RISCV_ISA_EXT_KEY_FLOAD, /* For 'F' and 'D' */
    RISCV_ISA_EXT_KEY_VECTOR, /* For all vector extensions */
    RISCV_ISA_EXT_KEY_SVINVAL,
    RISCV_ISA_EXT_KEY_SSCOFPMT,
    RISCV_ISA_EXT_KEY_MAX,
};

extern unsigned char __riscv_isa_ext_id2key[RISCV_ISA_EXT_ID_MAX];
extern struct static_key_false __riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_MAX];

static __always_inline bool __riscv_isa_extension_keycheck(unsigned int ext)
{
    if (RISCV_ISA_EXT_ID_MAX <= ext)
        return false;
    return static_branch_unlikely(&__riscv_isa_ext_keys[__riscv_isa_ext_id2key[ext]]);
}
#define riscv_isa_extension_keycheck(ext)    \
    __riscv_isa_extension_keycheck(RISCV_ISA_EXT_##ext)

>
> >
> > For example, F, D, V, Sstc, Svinval, Ssofpmt, Zb*, AIA, etc.
> >
> > >
> > > 2.We may need riscv architecture static keys for non-isa, this is
> > > usually related with the linux os itself, for example
> > > a static key for "unmap kernelspace at userspace".
> > > static keys for "spectre CVE mitigations"
> > > etc.
> >
> > These things look more like errata or workarounds so better
> > to use that framework instead of ISA extensions (or features).
>
> Currently, the errata workarounds are implemented with ALTERNATIVEs
> but I believe sometime we may need static key to implement the
> workarounds. However this can be checked later. Now I worried about
> the static key waste above.

That's a separate topic and for now what we need is a simple
and extensible approach to have static keys for ISA extensions.

Regards,
Anup

>
> Thanks
