Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BBB4EAF52
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbiC2Og3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiC2Og2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:36:28 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D9948E71
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:34:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so12888958otk.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMvmEyLab5Hwgmcc+Z+3zfyYKytRujbovXgUe7Inh00=;
        b=Dqsouoiu2emw/4nz4WC+N8SKQD1v62lPtdRIXrSzWKWL11Dq3ZlsARKok4IjOVScu7
         vG/1Lf21jZrSxALMOwm5n4QThic2lj2rzLZy44UJcDVLMMW/SNXIwq1bEEIfWKmcShT0
         +4N5vyvNN6It6Zp2fns+J0G1Mj21a0QWIoodOJxv5xvjrovD1irmMMjGaNLB5TjJFplP
         MTRYFOroVdmUPesqMGwFPgOobbanD3LuJ8DVmvGro3ZKRovtDmoFiKmyqwMxz8bsOd3u
         W0kbnTSUY8Fhka4+P0qtxstVJbZJd6u9Xwqw46RU6HtdGejRZRDVCwYz0tI8eyR6psah
         Hg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMvmEyLab5Hwgmcc+Z+3zfyYKytRujbovXgUe7Inh00=;
        b=tsByrQc1oHdbxi7jdwKwZbLUs8M8MEdShaTqPNGVObAlvSwtgW4Q+Pt7c5c9PKmS5k
         xQhcbv3opCEL9j2Xmi0lW/3RTZm3y0bNgXQQQQxcJb/8K9Huk6WwZMwWHFKnW5oBuxIy
         YKve6GmkN6pNjmwa8D7FED8vW9N+vQE2mmj+mzPa8SC82MXz89tCWUeFIug7vd1bvXWv
         8niGQl12ESHTbhkrGVEQdtARo/z+T84FcHoBlIvX8Sdd677bOL+kOKSmNR2/4QxylDkZ
         bbzne6nr9ploFJv6ywShFaxOupQz1jGY1MhBMWiC7KErxyer3Czx8BLTsRy/B3UA9Hgk
         DnAA==
X-Gm-Message-State: AOAM5336xIiRyR61vgwVwsyBdQVKR/6wXA4SJFowqKWSPDmdezRHJ92v
        tmYK9e4Lj2zWTzSZeCmmDUcnM+y3TuILNBGUrm8=
X-Google-Smtp-Source: ABdhPJx/1DSFqFqGJ8uQyChN4+4VB8++WxHyhW6Nzzmt36HiCWujISZXRpSyhE345ig1DDmxdda4OMLSlWwW5r5Qw4o=
X-Received: by 2002:a9d:4702:0:b0:5cd:481a:148a with SMTP id
 a2-20020a9d4702000000b005cd481a148amr1239212otf.200.1648564484511; Tue, 29
 Mar 2022 07:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tytg5jd_i3z3C5Y1dii2-cgO11Gjgvaq8qoWn3CGfCreg@mail.gmail.com>
 <CAHk-=wibHWd_E7_YFxc8=RH9b0iL0VunosCkt=L6PcqcDbD+qg@mail.gmail.com>
In-Reply-To: <CAHk-=wibHWd_E7_YFxc8=RH9b0iL0VunosCkt=L6PcqcDbD+qg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Mar 2022 10:34:33 -0400
Message-ID: <CADnq5_Nk5qsqUnA+dmdOBpH_Lu9Jfrv6n_vBRkNSxQJ=qjoh+g@mail.gmail.com>
Subject: Re: amdgpu link problem (was Re: [git pull] drm for 5.18-rc1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>, Wenjing Liu <wenjing.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 9:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I didn't notice this until now, probably because everything still
> _works_, but I get a new big warning splat at bootup on my main
> workstation these days as of the merge window changes.
>
> The full warning is attached, but it's basically the ASSERT(0) at line 938 in
>
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c
>
> and it looks to have been introduced by commit c282d9512cdd
> ("drm/amd/display: factor out dp detection link training and mst top
> detection").
>
> This is the same old setup I've reported before, with some random
> Radeon card with two monitors attached (PCI ID 1002:67df rev e7,
> subsystem ID 1da2:e353).
>
> I think the card went by the name "Sapphire Pulse RX 580 8GB" in case
> any of that matters, but it's been working fine.
>
> It still works fine, it just has a big ugly boot-time splat.
>
> As mentioned, two 4K monitors attached, both over HDMI.

I think it should be fixed with this patch which is already queued up
in my -fixes PR from last week:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/a572f7055067d95455850fd242d8b54ff5786cac

Alex

>
> If there is any particular info you want, just let me know where/how
> to find it, and I can provide.
>
>                       Linus
