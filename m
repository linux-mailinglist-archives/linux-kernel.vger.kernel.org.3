Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7219F4FAB3C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiDJAxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiDJAxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:53:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC00105
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 17:51:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bh17so24144460ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 17:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UumSOi3bVb4/q3h+ATEP8uiyPH1qa/l+xbjDc3aGRoY=;
        b=Wpfv8e/QtYVqq+ae3AXvVreoZ7ZF1txzYHecTrr6f56GfjQtarUN44NuJsrNRyb/pn
         yXdgDWBp+gdex/zmzOXSU+AORuclxUPOTszcK7G6DjWiDLLFThwtIzCB13ekoVvA0jTi
         F12b9sY+ZsI6QCdTC+pzifJnBCrldSU7l2fy/Cx2hsspibI6TSkqO0aJBsqW9KuRz40g
         QIc3LcQacL/TRM1to+DMqQl6wL6CCJNdp/f7PsLM+3gkznrfWcd5WsQptG2mtUyUK27a
         mRx7WK5dYQao28oCwkjSvy7fXVbvaeRGgOlW/V/GBKfTWIdtlRbhA1Kjd06Jxrhgr0iR
         ltKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UumSOi3bVb4/q3h+ATEP8uiyPH1qa/l+xbjDc3aGRoY=;
        b=RTNLqis63O4QJs+LrOaUW+xD0Nt2SJZUmAMxmZyXw6tyJ51pl0uk8p1SYga5GJ3JLv
         Ujp8zBlyNQtqIRqlbuxh7adsFwNwYEETJd6kQxjkDkc83RyMWlKWpjjlPzfUgSTGc4zv
         WgmuBN7pfFlOHGA8KAq+JGuUZbUNG9Y61sviCSQwdUq84Q2pHIHrWDleD+mCkv22nsSA
         awg/G0X1GU8IC4xQ7oJ3DocR10PUyqN24XWCLbxozXT8uM1WAyls1OWXYIkKm+ub2EXz
         LPq/6IPn8IaNtSUKMpAvcYtC68CY478eTXKCVvD47dlx1piIdAWxA16haiqvV0+ie7oy
         2MYg==
X-Gm-Message-State: AOAM532JB8+ZwA5TuVSl1A987laintDSfQZtmPP3cHB6v+8Byty2/pd6
        lrMaNjfmQjP7KOZ+kC6ZbGWSCJmq+XeGv8WYv4o=
X-Google-Smtp-Source: ABdhPJxQwID87p/D+o6yfKWz+g3H0+XBvfl8OCx5eFBQpBraG6rnAHk332AH/yFvoDWsBBhKeP5wO3o39UJkUr3VFG0=
X-Received: by 2002:a17:907:daa:b0:6e4:9b0d:3f1 with SMTP id
 go42-20020a1709070daa00b006e49b0d03f1mr23879729ejc.37.1649551900752; Sat, 09
 Apr 2022 17:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220408092803.3188-1-h0tc0d3@gmail.com> <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr>
 <CAP+8YyED70CSqVRaB7JgrAtK-yvBx5EsvrrdR7EpvOG2AVhskQ@mail.gmail.com>
 <QfKpxmkE_cy9wt5VJruw_TSdnl5KceKM8BxJGmZSBs-KiaRwIYfgc8h_-5h7Wmj6G-NtUJ3A88V5pzPvZuLlpkK-oRO5pSjeTxwHcZWlogs=@emersion.fr>
 <CAD5ugGD6QzCUqk7_EVwH9Cc6PQtx_VfjVRWzzP9uKR5tkGh1RQ@mail.gmail.com> <436116c9-6ce4-87cc-b1cd-f44b72fcfb35@amd.com>
In-Reply-To: <436116c9-6ce4-87cc-b1cd-f44b72fcfb35@amd.com>
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
Date:   Sun, 10 Apr 2022 03:51:39 +0300
Message-ID: <CAD5ugGDrDrWWf1xMKTy=56H1AR8cyXMV41f1X8P=HVtYY6idDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL pointer dereference
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Simon Ser <contact@emersion.fr>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Evan Quan <evan.quan@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian K=C3=B6nig, Simon Ser In fact, the code looks strange, we return
the return code, but for some reason we also write false and 0. In my
opinion, the caller should do this.
Of course, you are right, but I look from the position that nothing
should fall in the user system. There may be strange errors that occur
periodically under certain conditions and do not affect developers.
Also, the user will not always be able to correctly write a bug report.

Regards, Grigory.

=D0=BF=D1=82, 8 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 17:30, Christian K=
=C3=B6nig <christian.koenig@amd.com>:
>
> Am 08.04.22 um 15:21 schrieb Grigory Vasilyev:
> > Simon Ser and Bas Nieuwenhuizen, do you understand that you are
> > proposing to make the code less safe in the future? In the future,
> > someone might rewrite the code and we'll get an error.
>
> Which is perfectly fine.
>
> See error handling is to handle userspace or hardware errors and *not*
> coding errors.
>
> Testing all pointers for NULL without any reason is not defensive, but
> rather the exactly opposite since it helps hiding real bugs.
>
> Regards,
> Christian.
>
> >
> > =D0=BF=D1=82, 8 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 14:48, Simon Se=
r <contact@emersion.fr>:
> >> On Friday, April 8th, 2022 at 13:28, Bas Nieuwenhuizen <bas@basnieuwen=
huizen.nl> wrote:
> >>
> >>> On Fri, Apr 8, 2022 at 12:01 PM Simon Ser contact@emersion.fr wrote:
> >>>
> >>>> Is amdgpu_display_get_fb_info ever called with NULL tiling_flags/tmz=
_surface?
> >>>> If not, there's no point in adding NULL checks.
> >>> It isn't called with NULL anywhere, the NULL checks that already exis=
t
> >>> seem redundant.
> >> Grigory, would be be willing to submit a v2 which removes the unnecess=
ary
> >> NULL checks?
>
