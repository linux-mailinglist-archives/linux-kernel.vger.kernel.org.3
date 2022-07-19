Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11067579457
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiGSHga convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jul 2022 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiGSHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:36:08 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F889FE9;
        Tue, 19 Jul 2022 00:35:47 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id l15so10511897qvo.11;
        Tue, 19 Jul 2022 00:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ri9Wtdrs9zsrpeBy+vnSCFNuGKAMpG2mmAMCu25LqXs=;
        b=2nsF2Ba6r4kSb0Pjk8ijvX1VRU/cT7xeYRVf5hRX0F6Z+6AGRimvJ+H6xDgr6roNoI
         vXcQE+TWdr2Di0h2U9zXxi3+myYaP1tsXnNOal6RhmeRcIUGh0EDJg44w8tWXNSxaH1C
         2Nof+fQq8i8azVXkeIn66hOOBDJAK4acAvYD7GCKKJphawQxQfcKy7vdT6H6ganH+nRu
         R3dzd2rnvF2sSmUWzPX3LG8rEWPnGN6QTwC3clmKGpMeQdGL8TefJkDAAFfNECsTICYA
         eb7S8c0T2L8rjp7mTol6drggpxPxiDd/2O4Qkn7pj17DC0Adxlez1KiW7DvV9CZVtmoW
         xRAQ==
X-Gm-Message-State: AJIora/dFrkZ8DnV9G3NIWcT7FSD3JZfGXGdEZprVmCEbwCyZRwoqJX6
        879qWDxpmHHCjOlLsr1SoYEYAT/uR4Ng2Q==
X-Google-Smtp-Source: AGRyM1vckIRUfacgjfzK1tibQ97W2ioOOtRWS+cFjlrmybj/cOFm7qagoD2K8A5kftOf92M6QH80Ow==
X-Received: by 2002:a05:6214:260b:b0:473:6ef4:491b with SMTP id gu11-20020a056214260b00b004736ef4491bmr23716899qvb.34.1658216146509;
        Tue, 19 Jul 2022 00:35:46 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id cd14-20020a05622a418e00b0031ef6a420d6sm1961353qtb.35.2022.07.19.00.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:35:46 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31d85f82f0bso131723247b3.7;
        Tue, 19 Jul 2022 00:35:46 -0700 (PDT)
X-Received: by 2002:a81:84c1:0:b0:31e:4e05:e4f4 with SMTP id
 u184-20020a8184c1000000b0031e4e05e4f4mr5036327ywf.384.1658216145796; Tue, 19
 Jul 2022 00:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220711124742.3b151992@canb.auug.org.au> <6e60d396-2a52-d1fa-f125-3c585605b531@amd.com>
 <20220718094453.2f1a1f09@canb.auug.org.au>
In-Reply-To: <20220718094453.2f1a1f09@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 09:35:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzBy0O0kQTZxC52oL7At2EcFpL0C3nY4YAsBPzaEGW=w@mail.gmail.com>
Message-ID: <CAMuHMdWzBy0O0kQTZxC52oL7At2EcFpL0C3nY4YAsBPzaEGW=w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Jul 18, 2022 at 1:49 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Mon, 11 Jul 2022 10:05:45 +0200 Christian König <christian.koenig@amd.com> wrote:
> > Am 11.07.22 um 04:47 schrieb Stephen Rothwell:
> > >
> > > Today's linux-next merge of the drm tree got a conflict in:
> > >
> > >    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > >
> > > between commit:
> > >
> > >    925b6e59138c ("Revert "drm/amdgpu: add drm buddy support to amdgpu"")
> > >
> > > from the drm-misc-fixes tree and commit:
> > >
> > >    5e3f1e7729ec ("drm/amdgpu: fix start calculation in amdgpu_vram_mgr_new")
> > >
> > > from the drm tree.
> > >
> > > This is a mess :-(  I have just reverted the above revert before mergin
> > > the drm tree for today, please fix it up.
> >
> > Sorry for the noise, the patch "5e3f1e7729ec ("drm/amdgpu: fix start
> > calculation in amdgpu_vram_mgr_new")" and another one is going to be
> > reverted from the drm tree as well.
> >
> > It's just that -fixes patches where faster than -next patches.
>
> Here we are a week later, -rc7 has been released and as far as I can
> tell (though I may have missed it), this is still a problem :-(
>
> I am still reverting 925b6e59138c (which is now in Linus' tree).

Thanks for the hint! After reverting that commit, drm-next (sort of[1])
merges cleanly into upstream again.

[1] There's still a small conflict due to the removal of
    force_dpms_off, cfr. the difference between commits
    3283c83eb6fcfbda and cc79950bf0904f58 ("drm/amd/display:
    Ensure valid event timestamp for cursor-only commits") in
    v5.19-rc7 resp. drm-next.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
