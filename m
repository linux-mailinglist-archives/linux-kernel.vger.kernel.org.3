Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE814BDFD5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377497AbiBUORV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:17:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377499AbiBUORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:17:17 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F945E090
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:16:54 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso13346335oon.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pB155swSBk49PDT+eCV95gPkeDDn9OZawdG0rhDIJRE=;
        b=pTEm/Q5ZcaImrNLul2uOOW3JIgCy8oOGT2jyBGg61wUnKrLHJQTr05kDrMDQgV695N
         1te6tuy7pP04E4lnDUN9mOiIFJsZcHM4yPrnagdJJyeWQ3w9iYRLb9QiPeBjGcenXbhr
         lQgeSWXKjMHcGBBdrupKXsEi1ihBo0LY1BTVIWnM/bumbva0Poc/3R8uP8e1KmUPX2aZ
         Ztj6Tr4JjzBiycTk7ncfqLhVq6MM1XdPoQe0PMQ0Z5IoAFBRw2kN8FLLksCzy1OabSdM
         H4f4vw+p3WEOFEjUG3LaZaruVUYe78BU3dIWogDIMp5ISBHKnTXi0lrZuY66Pp7Cxphk
         THMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pB155swSBk49PDT+eCV95gPkeDDn9OZawdG0rhDIJRE=;
        b=Z2hIO4omo6i0O4OJahhJi67C645zcO6Ewe/Kvr0jJVWizI5G1Cw3FLlDNSiiZ2uogZ
         eIuFQM6xisDu+pvJ2hAj3ADBqnI9d96yIEtxzOCbX+5ft0dCchTXsa8xdT+AQ4qWjf3b
         T0HHZ9NSZJthsZVXakF9yXTy9a03dl00ATZ6ynem4Vf+Wl+/AMR82Jsk28Vj7d+fapcQ
         qG/6SqfCI+y2lgnHaSIPXStTX1G7+QD6+03F9CjRDTTV5cRAhWIDtYq9vnIEdsg4L7Yy
         IIjc2CiJ0q2GFqx/R9WuHiuDcl4qUjwNF8V1XB2OKBdTQN61KBkUj/0GYipjmBmVgOwJ
         yc0w==
X-Gm-Message-State: AOAM530LE0wPZXdAwEjrty9W7tBiuhJemgNxcgfVkcjz50bRoJE7Dr+4
        0swak1VgBSZRe5y6Xgox9rH6AiehZP7xsOH+IhM=
X-Google-Smtp-Source: ABdhPJypp4tgFBhtPOEyXtKE+mSjCfOtfvyT3B8a+mk8Lpv2kJcJdY6EchpMEPfdODZ6aUglmLiR483wlIqkrDv6GFw=
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id
 lk13-20020a0568703e0d00b000d3fe6d57c3mr4707614oab.225.1645453013462; Mon, 21
 Feb 2022 06:16:53 -0800 (PST)
MIME-Version: 1.0
References: <Ygf7KuWyc0d4HIFu@eldamar.lan> <CADnq5_MfR99OhjumQESCO7Oq+JVOHOVgyVQHX4FpGFDnPu6CyQ@mail.gmail.com>
 <5164225.DI6hChFYCN@ylum> <c62d4ba9-2214-ca7d-ee78-ee19a9bf51e6@free.fr>
In-Reply-To: <c62d4ba9-2214-ca7d-ee78-ee19a9bf51e6@free.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Feb 2022 09:16:42 -0500
Message-ID: <CADnq5_MWqz7-XhOS4zfuzi3=_nKa72iYaO0BcKNcVDwEvZ+YHw@mail.gmail.com>
Subject: Re: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic
 in suspend (v2)") on suspend?
To:     Eric Valette <eric.valette@free.fr>
Cc:     Dominique Dumont <dod@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Sasha Levin <sashal@kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>, 1005005@bugs.debian.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Feb 21, 2022 at 3:29 AM Eric Valette <eric.valette@free.fr> wrote:
>
> On 20/02/2022 16:48, Dominique Dumont wrote:
> > On Monday, 14 February 2022 22:52:27 CET Alex Deucher wrote:
> >> Does the system actually suspend?
> >
> > Not really. The screens looks like it's going to suspend, but it does come
> > back after 10s or so. The light mounted in the middle of the power button does
> > not switch off.
>
>
> As I have a very similar problem and also commented on the original
> debian bug report
> (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1005005), I will add
> some information here on another amd only laptop (renoir AMD Ryzen 7
> 4800H with Radeon Graphics + Radeon RX 5500/5500M / Pro 5500M).
>
> For me the suspend works once, but after the first resume (I do know
> know if it is in the suspend path or the resume path I see a RIP in the
> dmesg (see aditional info in debian bug))  and later suspend do not
> work: It only go to the kde login screen.
>
> I was unable due to network connectivity to do a full bisect but tested
> with the patch I had on my laptop:
>
> 5.10.101 works, 5.10 from debian works
> 5.11 works
> 5.12 works
> 5.13 suspend works but when resuming the PC is dead I have to reboot
> 5.14 seems to work but looking at dmesg it is full of RIP messages at
> various places.
> 5.15.24 is a described 5.15 from debian is behaving identically
> 5.16 from debian is behaving identically.
>
> >> Is this system S0i3 or regular S3?
>
> For me it is real S3.
>
> The proposed patch is intended for INTEl + intel gpu + amdgpu but I have
> dual amd GPU.

It doesn't really matter what the platform is, it could still
potentially help on your system, it depends on the bios implementation
for your platform and how it handles suspend. You can try the patch,
but I don't think you are hitting the same issue.  I bisect would be
helpful in your case.

Alex
