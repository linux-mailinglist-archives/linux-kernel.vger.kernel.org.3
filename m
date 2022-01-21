Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987F2495852
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 03:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378540AbiAUCdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 21:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378522AbiAUCd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:33:27 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F3EC061401;
        Thu, 20 Jan 2022 18:33:27 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so2840759pjb.1;
        Thu, 20 Jan 2022 18:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBy/CC6BIEsV98v55hmxC9LzMoHsxKrj8y/GPrRxmV0=;
        b=WI8ngvcqJEubuvFeWMLrQoXwb+m/EBu/K6HYWSWnLHgUJOrItFTo3Jg/+w2vpKndlL
         NPwn4dKFwoYu/pSj4y0jJyuPTC/86KPv2TIaoV1CivCQDjroOgoPo8HBIuUhHWBVUEHW
         MmYBK58pZuRckLnIlmo8cWBd3mj+kGeVp3B0D/HF/UcC70Cs3QXH+6WGKEuLuaq0LqCA
         1SOC2KuJZTSpaydepv2nkvItj4MFGl9qmRflHygB4/jC9QmzmAskX37/Dh8AXKavjX+4
         bqdtPVEfyeEGGwwejIylY4XN5HYgX28q27ux3ETWcDTp9mqQfon2m2X4cejwaQoknEf6
         Dowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBy/CC6BIEsV98v55hmxC9LzMoHsxKrj8y/GPrRxmV0=;
        b=0tq0yokkM/T8lznFJPduzunKy3YT1e1RKuZBjFleVhyJSM2NSiqQ7RKTX85WXn0ulr
         LozxE2/PXMo4t8v9NhxOguasn+HxTcI7PlmkXxz9bmPsdPJ/9lPVjbpsQRRuabRmGDsp
         GxPYYb1gHTJuPJPOQthbwipXgaycs++cXB3p90fcYnxkNRx9q+9fcdIWIZEQ4gnH/DXA
         CTiPKF5DiqOI16DwTT0doV/bi/oIf5iTjmi5gvFbIL+oIesFg8fUbmTvzUA4ErZCns9d
         KjNRpyofQ4LaugghT91KZLiMl2g6mibIKTgBfVCHVPuNbK7zYbBO3OEDMiI/XtJi5BMr
         p6uA==
X-Gm-Message-State: AOAM532ETFKiVMR176o9H3yXxLCJAO/qmKi4Sg12lYgVodP7nsH+efBQ
        CB/UQlVSRAzWdCmFT7Vh4Xgh+tPXZ8hM2tAPdKY=
X-Google-Smtp-Source: ABdhPJyTOkMz59zmne+7NWahAjQgcmUkxfdh+P7oX/SlrGbVAUICPavw6r1lY8EFqyqlgELrU+DSwFZyhPVad5pysN0=
X-Received: by 2002:a17:90b:1d83:: with SMTP id pf3mr14348213pjb.228.1642732406871;
 Thu, 20 Jan 2022 18:33:26 -0800 (PST)
MIME-Version: 1.0
References: <CAAH8bW_3mVqCxebkYeY0XKBfTAjPi1dtygCBEy4GpqvyeKAPqA@mail.gmail.com>
 <CAHk-=whc9DAJN-TWPTnw=bSjHwXk1zDGeJ9A8eniaK7Jfax5aQ@mail.gmail.com>
In-Reply-To: <CAHk-=whc9DAJN-TWPTnw=bSjHwXk1zDGeJ9A8eniaK7Jfax5aQ@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 20 Jan 2022 18:33:07 -0800
Message-ID: <CAAH8bW-uVyzqQ-nk6f_RGoL3-kOF99_r2uoJvPWLx4Q9AZGOEw@mail.gmail.com>
Subject: Re: [GIT PULL] Bitmap patches for 5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dennis Zhou <dennis@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-mm <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 7:53 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jan 15, 2022 at 7:10 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > bitmap patches for 5.17-rc1
> >
> > Hi Linus, please pull these patches for bitmap. They were supposed to
> > be pulled in 5.16 cycle, but due to merge glitch we decided to merge them
> > in 5.17.
>
> So I'm looking at this pull request that changes quite a bit of random
> files, and some rather core headers, and I see *no* actual explanation
> for what this pull request does and why I should pull it.
>
> Only a "we didn't do it last cycle, so we should do it now". That's
> not much of an argument.  If anything, it makes me go "there was
> something wrong with it last time".
>
> I can look at the commits (and I did), but that's really not how this
> is all supposed to work.
>
> When I _do_ look at the commits, one thing that stands out is how this
> was all appears to be rebased after the merge window opened (just
> minutes before you sent the pull request, I suspect).
>
> Which is *also* not how things are supposed to work.
>
> I also don't have your pgp key (not your fault - pgp key distribution
> is broken because keyservers are broken) and I haven't pulled from you
> before. That all just makes this pull request something where I think
> it's all likely good, but there are enough problems that I haven't
> actually pulled it.
>
> Put another way: the contents do not appear _wrong_ per se, but there
> are many things in this pull request that keep me from actually doing
> the pull..
>
>                    Linus

My apologies - this is my first pull request ever.

This series has been sent to you by Andrew in September 8, but it was
broken and you dropped it:

https://www.spinics.net/lists/linux-mm/msg269772.html

This pull request includes 3 series' and has been sent to Andrew in this
form at Aug 14:
http://lkml.iu.edu/hypermail/linux/kernel/2108.1/07328.html

One patch from Andy Shevchenko is already upstreamed. The others
are:

bitmap: introduce for_each_set_bitrange()
https://lore.kernel.org/lkml/YPG8SdsbQ+sxjk0w@yury-ThinkPad/T/

all: use find_next_*_bit() instead of find_first_*_bit() where possible
(should read: use 'first' instead of 'next')
https://lore.kernel.org/lkml/YMVSHCY9yEocmfVD@yury-ThinkPad/T/

bitmap: unify for_each_bit() macros
https://lore.kernel.org/lkml/20210719021755.883182-1-yury.norov@gmail.com/

It spent almost 6 month in the linux-next. Would be great to finally merge it.
My PGP public key is attached.

Thanks,
Yury

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQGNBGHWbSUBDADO5P610/ZZq/kHTTxtHgWAZtHqzN8QDd7TYT9W8HTIi8U04EUD
wDhtTXSvSXG8yQgY4svwY6q4ORn96G91kdT1cA8skCPvNZYx9LVUzrzsYxMc9U98
7YYu00/dFA7rEBZmMg8rWP0YON0093WFOx94z3/GTkhEN39wZDNdVxuJTtMu6Ykw
AIDhoOMD92Q6XguChfgCcHjrjlOOn1AuRE5akAmK3UuEjxosWpr1jFmSVQ0gHhrD
kIbcN9IFIVYkLkwdqwxobmW8pRlpgs7bRBRLLD0LeT3vZ/yyRzDvq0PcOeQ3B78M
ZlCgeqfhJzPGZFO02WqMV9u090NdxwJ0f5+N8ZmddW4wGFa9FMyNGKO7gsITVwvx
7MBubAvrpoPwB1eVzITDb0kjJf3eWSh5WQuGtGpv8i6ATHDTGYl8gCdvb7EkgDmg
YWeHWEy29cNEXvmuu+hV2QvB7snQL3vNo/J3V8+tgP0QraK/szsGMgPneS40+YfK
xZLqD7jFBAu5AeMAEQEAAbQhWXVyeSBOb3JvdiA8eXVyeS5ub3JvdkBnbWFpbC5j
b20+iQHOBBMBCgA4FiEEi8GdvG6xMhdgpu/4sUSA/TofvsgFAmHWbSUCGwMFCwkI
BwIGFQoJCAsCBBYCAwECHgECF4AACgkQsUSA/Tofvsgz3Qv/cVkMC+efwo6cD6Wp
YlZfqDc9ygHJ6CrRKKSEO4vQOLgPTmbNjIcaAQcyDF34x839Dwi+UTJOyXB5wYzW
0D4T+J4zs+fLPc6izPgpEmjPaflh9zwgPuKQtfeI6/xVmV9vOwwV37E9ZiUjEdd+
BegK70eoif7dJgNqj7pWNn8H2eOVmyL4rK7eWTYJz3AWBjA5q2Xva4IJS7+gLOSM
RmtxfwZdla50AcaxHWUaxfE3Q8Q/LFaIBFKEjVO5XWWsOmuj64ceSikNdHGiGpGU
UJpizR5IRRnEpvtWe54mj4dh2L55sU5fyzaQ4D+6dxEC5lOvFyV4SlHJwScTO2mJ
mvKEGxto7L2/bvcRyzkOxaEzEOVj/z9XjyNVX6MnuWEv2SwlxJmZMwQPt1Rz2lQi
i7sDHToDxdS7wplYStHWSDT736fZjXC5vwAwNzx+eeHF2YERBhzWVR5SruLycsFp
qeIg7V65NXurATdMVnO39Wtrl5V4CUZmzVhzLMyc12z662VyuQGNBGHWbSUBDADS
rXm60ZthpvuOG2Mnv82Hrofroh/lzDgvhx1vht+5tg65Y9ZxdWGg33X20RVcbyCs
CLXsDx1bUuf+upvlc2BNcPC9igq5An1vTQjiSs/cvu00b5K1YuGh0cqC5so9C39s
Ir7Fwba8Qh02NdDVfmgBo9pYd4GhjqWLAM/cYTAGmAaKMYMzN8BtP5mAOwQU55gN
O3Na46OGXm7r10fCWJwYNsMEUmKzNJQroww8t04vCBWBEe8kpYS42K4hm2gBc/2+
EUmxFKjy8RrHyLicIOuNiiz1/GK4oMeZK8nhBebm/Kggok5G8iQlUArcKcT6dGh6
kJh+uTThaamhA8SI1hBlYe4evs0v9VCbrihCLwhnhzvoH9PHF1EpHezqLVcfrf/G
oqvpTeIcW+2P8M4SF6QjHrEM4z/DPggp3hXNkaqX1Gz/zBjc+ZfoBqEE23Tt2hSh
YbQ83gquUNiCkNhOH6JJOIWvButfenyzXNbDqu/RnAZDlcocLd3ivNJmlCVrnAsA
EQEAAYkBtgQYAQoAIBYhBIvBnbxusTIXYKbv+LFEgP06H77IBQJh1m0lAhsMAAoJ
ELFEgP06H77IFIwL/0E0HumprcozXuIUTKXeZwSBV/GNinr308FixnGFJlh/JILd
6cNS3703+Us2ITp3LEyCMB1QlSfgLL6+GYWnpZAess3bm2g2DCeA5UxuCDVuT6wY
YJWTVdY5a8mGgNpxm8WPZdW6sJoipjZyBxAtBw3rODz8QWsCEXCgB9kAcoHiRnxn
8DvOwuGWCiKDOqdeyRz7x8aHbOjYK5ZJXBhon7AvE2HcUb96A0TQySfcoSY+MNHy
AkAccWN0+xarzWs5Wmq8u4l+ofCMCVu0jZqwBRlWELBUclj5FGbxcM+QFLgwMrc6
FODbFXMgej3AD5ZEPB+1oxUDsQtDGvylKh1gslJd0wntpXTQKBnuxKgStAEPUSWr
h6ZRebhQ727NtFot17ECb3NpAxIM9lZONNaG8wYFV431gs4IZ1gQrxtzST4H97Ze
Jb0REaila/2bFtMmpvrPeE64/F9k4eGNrJfGBUj8OYGERLJ43nho4kGPMK5OfEl7
08ht3nV3xa60SBfdBQ==
=BCNg
-----END PGP PUBLIC KEY BLOCK-----
