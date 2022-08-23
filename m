Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACCD59EAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiHWS1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiHWS1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:27:10 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D415A4B0D8;
        Tue, 23 Aug 2022 09:47:20 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v125so16737179oie.0;
        Tue, 23 Aug 2022 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=F8aKSZv1NL2MA13LWlrkZ0pyLx1poLLo5+Y2auoHrrU=;
        b=P8Rb6AIUe0BqjayXQEF1C99U0H8YdtTbPpCkW0bERtLUXN9fooVIer4M3R47yIez/U
         5go1SSUpqQGPaOv6AsSeoRoo8SSXNjtCuLMuvgFbBFBYml0t9Zq+e/kHUBIQ0wfa8LYs
         0fCx1wsNmzKkwaquNleJdBdp/70ylcTVBYNrU8zsojU/8KiNhBozHLIiD/2vU3pbT1wu
         StvBfAQHmAvHRbTuuK1wfmyQdce5xlUhPz7Wu2Sg+hL+upMM0Ba5GeaTuFECDP5vlgsZ
         YyBmWB3oQyTquXWCh6CmFcUYquSC+NBylzyFgiUJ+4/FyXltqM8D6PhNC6TwsFN+ykfp
         1FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=F8aKSZv1NL2MA13LWlrkZ0pyLx1poLLo5+Y2auoHrrU=;
        b=imTmjnlgp7XAz6NZ4y7cee8Lm2aEEqNIJbVPgWBQBgN2kgFBdt1LEe2kkuGllDW47y
         8IbxgLMtCtu62EPCpSKeRrLbjI2HsroMke7aZ9bkreKBp7oic8lfHyLAyz1lIbUbT83U
         QgQYLh7y2re9ko0CSxa+TvANlNZvtS98JxyABC4X61BdCKehvfXikAs7D5BXtFCWoSG8
         b+yydJzIWU1+IKfMJ/1kL7FTORWymWh8A4hj6YbbJIny3lTuIUvorVJPO6JqT4lsxuie
         tlr8HzENzVYdRa7sx726Z/ZfrMUDHNemXT2AFbZic+kkASVw4kGFQ6oMSp2fUijDfjZf
         mtuQ==
X-Gm-Message-State: ACgBeo3rgRuj1EU92w5FsKqUJxuWqBjyAYs5Lodx5XpZKwe27WyEJKdU
        X5ygXT9958PSes5e2Y/iQKwJqoeAUV8Hl7I5S1E=
X-Google-Smtp-Source: AA6agR7cQ1HWOR/GP2rtEG15PGZ/r+13Je3nF5uNZRRMMJwUkE+V9G7UTyql1pmHzDQiRGHyVzqd9qmK0bsICHBqrYU=
X-Received: by 2002:a05:6808:238d:b0:344:e5f9:db34 with SMTP id
 bp13-20020a056808238d00b00344e5f9db34mr1650387oib.183.1661273240141; Tue, 23
 Aug 2022 09:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com> <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com> <YvOav/vF2awVWIu0@phenom.ffwll.local>
 <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
 <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com> <CAF6AEGv1cVC9ZNMwpwFOki5CrwD3kSAHM9EUFZGWY-y5zcQsCg@mail.gmail.com>
 <fc019528-7ec7-9e5b-1b6d-c44da14346cf@collabora.com> <CAF6AEGv8zSd0fEYB9hd2QOyTt53gFSQoL8JdZtCvtCdYfMfB2Q@mail.gmail.com>
 <73b51dde-689f-64ce-a1c8-0d7c84a2ed66@collabora.com> <CAF6AEGuR1cRQYaQBYGnMBzy=XJUcN2o2gzabZaGO2Dj62Uq1DA@mail.gmail.com>
 <CAF6AEGvvR1NUd_GKP=Bxp3VTDMBYT+OwTkkgOWxgYFijZaVVEQ@mail.gmail.com>
 <5f118e10-db7a-a128-1e87-c9dddb65b2ac@collabora.com> <2ce5ff0a-9ab2-d146-04db-487a64714fce@gmail.com>
 <cf8cd8da-08d2-5e70-a239-2a67da37c9ea@collabora.com> <e9bde303-6474-aa0b-7880-cf7d8b163983@collabora.com>
 <5988bf07-dd2e-a7ad-1ed9-831a402c3c5d@gmail.com>
In-Reply-To: <5988bf07-dd2e-a7ad-1ed9-831a402c3c5d@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 23 Aug 2022 09:47:53 -0700
Message-ID: <CAF6AEGvnqV4ySs6rNWu0pkeSNJMhgN1rvind8dC-nV1Sv3kk8g@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        kernel@collabora.com, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 3:01 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 22.08.22 um 19:26 schrieb Dmitry Osipenko:
> > On 8/16/22 22:55, Dmitry Osipenko wrote:
> >> On 8/16/22 15:03, Christian K=C3=B6nig wrote:
> >>> Am 16.08.22 um 13:44 schrieb Dmitry Osipenko:
> >>>> [SNIP]
> >>>>> The other complication I noticed is that we don't seem to keep arou=
nd
> >>>>> the fd after importing to a GEM handle.  And I could imagine that
> >>>>> doing so could cause issues with too many fd's.  So I guess the bes=
t
> >>>>> thing is to keep the status quo and let drivers that cannot mmap
> >>>>> imported buffers just fail mmap?
> >>>> That actually should be all the drivers excluding those that use
> >>>> DRM-SHMEM because only DRM-SHMEM uses dma_buf_mmap(), that's why it
> >>>> works for Panfrost. I'm pretty sure mmaping of imported GEMs doesn't
> >>>> work for the MSM driver, isn't it?
> >>>>
> >>>> Intel and AMD drivers don't allow to map the imported dma-bufs. Both
> >>>> refuse to do the mapping.
> >>>>
> >>>> Although, AMDGPU "succeeds" to do the mapping using
> >>>> AMDGPU_GEM_DOMAIN_GTT, but then touching the mapping causes bus faul=
t,
> >>>> hence mapping actually fails. I think it might be the AMDGPU
> >>>> driver/libdrm bug, haven't checked yet.
> >>> That's then certainly broken somehow. Amdgpu should nerve ever have
> >>> allowed to mmap() imported DMA-bufs and the last time I check it didn=
't.
> >> I'll take a closer look. So far I can only tell that it's a kernel
> >> driver issue because once I re-applied this "Don't map imported GEMs"
> >> patch, AMDGPU began to refuse mapping AMDGPU_GEM_DOMAIN_GTT.
> >>
> >>>> So we're back to the point that neither of DRM drivers need to map
> >>>> imported dma-bufs and this was never tested. In this case this patch=
 is
> >>>> valid, IMO.
> >> Actually, I'm now looking at Etnaviv and Nouveau and seems they should
> >> map imported dma-buf properly. I know that people ran Android on
> >> Etnaviv. So maybe devices with a separated GPU/display need to map
> >> imported display BO for Android support. Wish somebody who ran Android
> >> on one of these devices using upstream drivers could give a definitive
> >> answer. I may try to test Nouveau later on.
> >>
> > Nouveau+Intel combo doesn't work because of [1] that says:
> >
> > "Refuse to fault imported pages. This should be handled (if at all) by
> > redirecting mmap to the exporter."
> >
> > [1]
> > https://elixir.bootlin.com/linux/v5.19/source/drivers/gpu/drm/ttm/ttm_b=
o_vm.c#L154
> >
> > Interestingly, I noticed that there are IGT tests which check prime
> > mmaping of Nouveau+Intel [2] (added 9 years ago), but they fail as well=
,
> > as expected. The fact that IGT has such tests is interesting because it
> > suggests that the mapping worked in the past. It's also surprising that
> > nobody cared to fix the failing tests. For the reference, I checked
> > v5.18 and today's linux-next.
> >
> > [2]
> > https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/pr=
ime_nv_test.c#L132
> >
> > Starting subtest: nv_write_i915_cpu_mmap_read
> > Received signal SIGBUS.
> > Stack trace:
> >   #0 [fatal_sig_handler+0x163]
> >   #1 [__sigaction+0x50]
> >   #2 [__igt_unique____real_main354+0x406]
> >   #3 [main+0x23]
> >   #4 [__libc_start_call_main+0x80]
> >   #5 [__libc_start_main+0x89]
> >   #6 [_start+0x25]
> > Subtest nv_write_i915_cpu_mmap_read: CRASH (0,005s)
> >
> > Starting subtest: nv_write_i915_gtt_mmap_read
> > Received signal SIGBUS.
> > Stack trace:
> >   #0 [fatal_sig_handler+0x163]
> >   #1 [__sigaction+0x50]
> >   #2 [__igt_unique____real_main354+0x33d]
> >   #3 [main+0x23]
> >   #4 [__libc_start_call_main+0x80]
> >   #5 [__libc_start_main+0x89]
> >   #6 [_start+0x25]
> > Subtest nv_write_i915_gtt_mmap_read: CRASH (0,004s)
> >
> > I'm curious about the Etnaviv driver because it uses own shmem
> > implementation and maybe it has a working mmaping of imported GEMs sinc=
e
> > it imports the dma-buf pages into Entaviv BO. Although, it should be
> > risking to map pages using a different caching attributes (WC) from the
> > exporter, which is prohibited on ARM ad then one may try to map importe=
d
> > udmabuf.
> >
> > Apparently, the Intel DG TTM driver should be able to map imported
> > dma-buf because it sets TTM_TT_FLAG_EXTERNAL_MAPPABLE.
>
> Even with that flag set it is illegal to map the pages directly by an
> importer.
>
> If that ever worked then the only real solution is to redirect mmap()
> calls on importer BOs to dma_buf_mmap().

Yeah, I think this is the best option.  Forcing userspace to hang on
to the fd just in case someone calls readpix would be pretty harsh.

BR,
-R

> Regards,
> Christian.
>
> >
> > Overall, it still questionable to me whether it's worthwhile to allow
> > the mmaping of imported GEMs since only Panfrost/Lima can do it out of
> > all drivers and h/w that I tested. Feels like drivers that can do the
> > mapping have it just because they can and not because they need.
> >
>
