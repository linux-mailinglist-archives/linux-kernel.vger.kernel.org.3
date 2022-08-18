Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D960C598190
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244111AbiHRKoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiHRKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:44:11 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A035D7FE5B;
        Thu, 18 Aug 2022 03:44:10 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-32a17d3bba2so29821987b3.9;
        Thu, 18 Aug 2022 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/Vg0MiE5047HvBd7kU3Dl8WG5Dtp7QWU7yaZmVgWvE0=;
        b=XBdxOIbpmad8maPo4XhdSMrnSkrWvg5nakK+efBLeJ5Dhda5817DMJDouZlliduGpJ
         cMI0PnJAxqFOOFm7rAFqrsLpEcmH508OQg92oOL0rAFnK/+n2gjeWpXrOogkawkZVQG5
         VP0N7xNN08DQPQ9SY53iFIHOhZ9JvL+U+KSRV4vFswq4WP11k7Zv9KelLOBoU8if2XHk
         kPiHeI2X96L2Hru8Eyz00HNQHoJG8ymiUmOE1Fe7MKZK3YDF79kwsWd7IhOxIKkwOS8/
         Jsv2X3wJnmvW8b+JIM6eTV/3XUOoVpybgNG3k4M2OVFKpCCOmcyDe03UYYN7UTmqNTHB
         pWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/Vg0MiE5047HvBd7kU3Dl8WG5Dtp7QWU7yaZmVgWvE0=;
        b=KGGqybTPs2xmjlYT/tSgiyR7MUQtVjRsaUeXwJmyEjofkHbhw5E6cIihptVTm6/uBZ
         GfLUOSiIonPOpONc6Fac8FwYh48/bjcD0aZY2pxtWtL9DPTzu0B2TI1sF07MB4TX5Qn+
         1V0TiqY5c02NH0R23BrbVRjIE0h2GS9fnZK9dAcbG9R2w5Lh8CmlXIUDOZa20PI6FpJq
         D3c6FRQXSqTnlEXdGcpf8tch0DdcrLqZRG1ZKY5Z1pZpLORzH/nqEfPNt0AL94J9qJrL
         e9MAhRbmohmdYAJUUk16pkspmtLF+7SwA17QYM7dm86EYyMZDe2zElE3df88A+SITC6p
         9kzA==
X-Gm-Message-State: ACgBeo0e3ilBMXvjxXkJet1Xpkx2BHotVnF6w/JCo1RRLH65EY0Q++5m
        fjIvvDVNJzuotCimnV+5h2QzUJ2YfpJAEWVBrBH9as5W8p0=
X-Google-Smtp-Source: AA6agR6bpMkfOdg/XRd/QTB2hcWngbdEhqg0DhxaakFttwjPtxVRnCyU9KJocZLjpI5nP8q5uNUBHgiRbNIJ29vaWxM=
X-Received: by 2002:a5b:845:0:b0:683:6ed7:b3b6 with SMTP id
 v5-20020a5b0845000000b006836ed7b3b6mr2221253ybq.183.1660819449894; Thu, 18
 Aug 2022 03:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <Yv1lepjhg/6QKyQl@debian> <CADnq5_Od9W1iuzYpsmODOB=Xem97ogeH_t0JrjWC-S8h0XM9fA@mail.gmail.com>
 <5638aaf1-b808-bdc6-d84a-820f24facea6@infradead.org>
In-Reply-To: <5638aaf1-b808-bdc6-d84a-820f24facea6@infradead.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 18 Aug 2022 11:43:34 +0100
Message-ID: <CADVatmNA6-qCJEHNn-gRO6Nx88SsTrPsJn_F5J0NiFhyvijNxA@mail.gmail.com>
Subject: Re: build failure of next-20220817 for amdgpu
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-next <linux-next@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Aug 18, 2022 at 3:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 8/17/22 19:01, Alex Deucher wrote:
> > On Wed, Aug 17, 2022 at 6:03 PM Sudip Mukherjee (Codethink)
> > <sudipm.mukherjee@gmail.com> wrote:
> >>
> >> Hi All,
> >>
> >> Not sure if it has been reported, build of next-20220817 fails with the
> >> error:
> >>
> >> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> >>
> >> Trying to do a git bisect to find out the offending commit.
> >>
> >
> > Thanks.  I don't see that symbol in the driver at all.  Not sure where
> > it is coming from.
> >
>
> It's powerpc only.
>
> Sudip, is it non-CONFIG_SMP by any chance?

Ohhh.. really sorry for the incomplete report. I should not try to
mail while travelling.

The error is seen with powerpc allmodconfig and it has CONFIG_SMP=y.

-- 
Regards
Sudip
