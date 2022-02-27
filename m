Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C003B4C5A7F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiB0KbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiB0Ka6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:30:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022734132C;
        Sun, 27 Feb 2022 02:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6C99B80B8E;
        Sun, 27 Feb 2022 10:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AB8C340F0;
        Sun, 27 Feb 2022 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645957819;
        bh=p42necgS2+w3IBbaZntG/drkpeKiZlOst3+ic3/i65o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T0dQwHEuLT+MFaX0055u645MrzOQtFLQNNSipuvu0FMiQ9VxwggjH/YawZO7uGYPP
         4HYqHPVq9Wh5reFTmoockrTYg4me5HlLJA4UFzFT132zzfYhrhxEh2C87FFtEyujPa
         gPIBTV9Cy5XA5Rwl/Fa+e7DPppy5UBEIsSGBsVPuexuIHvHiaF3iGkQpDV/AVhuoiv
         mCNT99BNWuSVtvL+tHwGYPCCp2opGePCMiVAKyRmr61lCH+hfp2FN5YeCh9QZi32C3
         AJ8TeQ8z8lQxmHbEBFQZmYpA48u6Q0+jjjOEqD/P0W7wzdFBPMfMgifjtLqBN+zUpU
         kZjYoG1FLnSOQ==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2db2add4516so45429797b3.1;
        Sun, 27 Feb 2022 02:30:19 -0800 (PST)
X-Gm-Message-State: AOAM532mHCp95nbV8Efto37FlUbEYyWjk/LaMuQeDPLE0Df8+LXomhpP
        G8i4Gf8PbC6rQor7SL7uKkZbUAuwbWDepksjyx4=
X-Google-Smtp-Source: ABdhPJxO8P+1OzSTTpqz5f5kWhQ7td57qQwAvhmRvaA0Nng+midAUx6XRjWW2njj/7SvQac67hmwav2LjtA0Cg2D+PQ=
X-Received: by 2002:a0d:cc58:0:b0:2d8:923:7e96 with SMTP id
 o85-20020a0dcc58000000b002d809237e96mr14505414ywd.60.1645957818120; Sun, 27
 Feb 2022 02:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20220226220639.1173594-1-Jason@zx2c4.com> <20220226220639.1173594-3-Jason@zx2c4.com>
 <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com> <CAHmME9rPd8Nu8Q0+R6B4Bz-caKpq5SSvLaiKdwXcyNHY8Ebfqg@mail.gmail.com>
In-Reply-To: <CAHmME9rPd8Nu8Q0+R6B4Bz-caKpq5SSvLaiKdwXcyNHY8Ebfqg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 27 Feb 2022 11:30:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEwsyPcoTvK6PZyA5L3q9u_dd_wXUiyHw7TtPM5LecP7g@mail.gmail.com>
Message-ID: <CAMj1kXEwsyPcoTvK6PZyA5L3q9u_dd_wXUiyHw7TtPM5LecP7g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 at 11:03, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On 2/27/22, Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Sat, 26 Feb 2022 at 23:07, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >>
> >> From: Alexander Graf <graf@amazon.com>
> >>
> >
> > Please don't invent patch authors like that. Alex's patch that started
> > this discussion was completely different.
>
> Considering the investigative side ("why won't the _CID match?") and
> most the commit message were Alex's, and that those things comprise
> 95% of what this patch is, and that the code change itself isn't even
> part of anything Turing complete, I most certainly did not feel
> comfortable stripping Alex's authorship. Instead I added myself as a
> co-author at the bottom. When in doubt, err on the side of crediting
> others. Alex also took a look at this patch, I am under the impression
> of at least, before it went out. Let's minimize the paperwork
> policing, okay? I think it'd make for a much more pleasant space here.

Seriously? You want to go down the road again of poisoning the
atmosphere here, and blaming everyone else for doing it? I had enough
of that with the Zinc debacle, and I thought we had moved beyond that,
after having collaborated constructively with you on various topics
over the past couple of years.

Please stop with the ad hominems in response to criticism on factual
aspects of your code. Putting someone else's authorship on code they
did not write is not cool, and pointing that out is *not* what is
making this space unpleasant.
And 'paperwork policing' is sadly an important aspect of a high
profile open source project such as Linux.

> If Alex objects he can just simply say, "hey feel free to remove me as
> author," and it'll be simple as that, and again doesn't involve your
> policing.
>

When you ask for my review, you get my review. If there are aspects of
your contributions that are a priori exempt from criticism, I think
you're in the wrong place.

> >> We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CLS
> >> entries of the respective devices. However, we squeeze them into struct
> >> acpi_device_id, which only has 9 bytes space to store the identifier. It
> >> originally had 16 bytes, but was changed to only have 9 in 6543becf26ff
> >> ("mod/file2alias: make modalias generation safe for cross compiling"),
> >> presumably on the theory that it would match the ACPI spec so it didn't
> >> matter.
> >>
> >
> > Please clarify that this applies to the module metadata side of
> > things. The ACPI subsystem already captures and exposes _HIDs and
> > _CIDs that are longer than 8 characters, which is why simply
> > increasing the size of this field is sufficient to create modules that
> > can match devices that expose a CID that is longer than 8 bytes.
>
> Good point for strengthening the argument here. Will do.
>
> >
> >> Unfortunately, while most people adhere to the ACPI specs, Microsoft
> >> decided that its VM Generation Counter device [1] should only be
> >> identifiable by _CID with a value of "VM_Gen_Counter", which is longer
> >> than 9 characters.
> >>
> >> To allow device drivers to match identifiers that exceed the 9 byte
> >> limit, this simply ups the length to 16, just like it was before the
> >> aforementioned commit. Empirical testing indicates that this
> >> doesn't actually increase vmlinux size, because the ulong in the same
> >> struct caused there to be 7 bytes of padding anyway.
> >>
> >
> > The padding situation only applies to struct acpi_device_id, whereas
> > ACPI_ID_LEN is used in other places as well. Also, the size of vmlinux
> > only covers statically allocated instances in the core kernel, and
> > most of the ACPI_ID_LEN uses are probably in drivers. So whether
> > vmlinux changes size or not is not that relevant.
>
> I actually looked at every usage in the tree (there aren't that many)
> and couldn't find a single one where behavior changed, performance
> changed, or memory usage changed. I thought we looked together on IRC
> so I'm surprised to see you mention this, but maybe I misunderstood
> you. Anyway, I can't see the size increase impacting anything at all.
> If you see a case, this would be the time to mention that you see
> something. I didn't find anything though.
>

If you did not check the rodata/data/bss sizes of all modules
depending on this macro, or checked their memory usage at runtime, you
cannot definitively say that nothing has changed.

*However*, as I argued below, using ACPI_ID_LEN to allocate a string
that needs to hold a HID or CID provided by the ACPI subsystem might
well result in a buffer overrun, as the ACPI subsystem will happily
return longer strings.

So my conclusion is that the change is ok, which is why I gave my reviewed-by.

> > Patch 6543becf26ff was wrong to change ACPI_ID_LEN, because it failed
> > to take into account any other uses of ACPI_ID_LEN, and did not bother
> > to explain why the change was necessary in the context of what it was
> > trying to achieve.
>
> I'm not sure there really were other usages back then. The commit
> message seems descriptive enough to me too. This was about cross
> compiling, so padding. But it certainly did seem to limit future
> drivers in an unintended way, as you wrote:
>
> > So, given that we need more than 8 characters to match drivers to
> > devices exposed by Hyper-V (or other VMMs adhering to the VMGENID
> > spec), I think this change is necessary and correct.
>
> Right, that's the idea.
>
>
> >
> > So, with the authorship/signoff corrected, and the commit log clarified,
> >
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks.
>
> Hopefully we'll hear from Rafael this week.
>
> Jason
