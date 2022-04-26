Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B3D50FD36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350021AbiDZMly convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Apr 2022 08:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242981AbiDZMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:41:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031451102AA;
        Tue, 26 Apr 2022 05:38:40 -0700 (PDT)
Received: from mail-yw1-f175.google.com ([209.85.128.175]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MJW5G-1nTryY2h2m-00Jrvo; Tue, 26 Apr 2022 14:38:38 +0200
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2f7c57ee6feso85740527b3.2;
        Tue, 26 Apr 2022 05:38:38 -0700 (PDT)
X-Gm-Message-State: AOAM530YjwyCpDqfAt2pn6PlmtS5bZRN+vOZXSa2rzTrwD/986WJij/K
        AcDGcBnk4DrN4y9S6MJ3KhjWp6a5Y7M8sv7uahc=
X-Google-Smtp-Source: ABdhPJwgCuCUa4o+AgAH4pI2w9geQ9zGuYooiQu61gb9/bVoeW8aj/5quj9UKhljTouqCt64isUtADXX7teUyfMtQT0=
X-Received: by 2002:a0d:d804:0:b0:2f4:e47d:1c2c with SMTP id
 a4-20020a0dd804000000b002f4e47d1c2cmr21230444ywe.320.1650976717282; Tue, 26
 Apr 2022 05:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220426060808.78225-1-cai.huoqing@linux.dev> <20220426060808.78225-5-cai.huoqing@linux.dev>
 <618a4f53-0998-1e6b-e32b-8bf2d3057cec@amd.com> <CAK8P3a2w1t7Sk897u0ndD66Lwp5a4DuOqqQLN4yHSg=JmrpOHQ@mail.gmail.com>
 <20220426122404.GA6788@chq-T47>
In-Reply-To: <20220426122404.GA6788@chq-T47>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Apr 2022 14:38:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2M=zw509HGRALmgbr+E6GjKoZqqkh9kCbyGB9hD_+3LA@mail.gmail.com>
Message-ID: <CAK8P3a2M=zw509HGRALmgbr+E6GjKoZqqkh9kCbyGB9hD_+3LA@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH v2 4/4] drm/nvdla/uapi: Add UAPI of
 NVDLA driver
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:gRCY+7tVVaGzz1Zw57leScxM6hNk72VKotb2SlPYG45OTaXHnwG
 rDNn6xC1YeJQyz2gyIIskORJ4IXiXVnoTEIT097opARXBWiOmJNqlcpyFFpl4Jg381hBWJ5
 EnPeMN+HS5mYcEVvIcDBFNtnfaQzAgc14308TOY97po68RDYZtZVApIgoseWQX749zybhgE
 IUm5YLj8PYhcv+UqgcEzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UULVwVQ3fpg=:Ei5XKR3vSIUTf8MkByuDKg
 hmrMvU9eGFy9c08+AofAibT6vUfcobwdvbci8NvDenrmSE1tGzMv9/MtevEKJ0KLsXWp7Lx91
 6N1kiZHFsRGiHnp9coTbPbTZnRsROhoOb82fpgJpwQmNj/VtepbbPah2/7hHSPIa5bRfZaM9K
 mcObCLmBhlTgb4hexPjPn4lQR6e7qeDXDcXtzRpOHeG9aLdZIt6mgLdRN1ns+2mHQOLyr0hMb
 vKTYrf5SQ0K7P87/rcGJ6Hut3Raw3PTd2+eRN3eyln1ptsAanO09XqfJwX4+uPfvtjYZPUGvY
 1rvy7LsNIgvk3nnVXW3AhVkSxWKo3LfLaNJSLKZErdFc2cob2YuWzMELg5hkC+ujX4O6U3G+T
 Kw0lcsTUxvq4V8NCpJkdxJ46MzU1D76Zx8KCjjec6so8qMKIlS7gY5NuGktixsrJ7/VMszGOo
 87TI/bY6x3mPPkvBs8Rjw6UbhE7hSZmGfcv3vX0rY5m7pNvIgnlZzCnHPEK313WkrYZvrAHpB
 aKIksIPMMIY3xW/41o81l45+DZWXOqADhD8r2jtF9qQC5mGvx9X/f0DO2qobKKBiXdiIC8EjU
 a2XZNqpE1dY/h6Xh5fo1ZEoKlrjHPYPLjCSb8ckEHj+VEPwL7+xBDu8v4cvC5kHzjiBnpacHb
 RE5LgaNRhsP26WlgKQgiKqrIpDLQSF6/v2s/p5aDp20o7RKLw47VTCqExfeq5918Bf3uEUqeO
 DT0knqbOIcBpConDk9YKus/k25DQ3eJoU+rakdRVzJa1mdrQYV9s+JrOR4rFK8RWR61LrF3up
 2Ikvg8Jlg5RNepfVrek8CpQJDpZFvU1urldcKdpWpnH62PBa78=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 2:24 PM Cai Huoqing <cai.huoqing@linux.dev> wrote:
> On 26 4月 22 12:50:50, Arnd Bergmann wrote:

> > > > +#define DRM_NVDLA_SUBMIT             0x00
> > > > +#define DRM_NVDLA_GEM_CREATE 0x01
> > > > +#define DRM_NVDLA_GEM_MMAP           0x02
> >
> > Is this an actual mmap() call, or something that needs to be done before the
> > mmap()? Is the 'handle' a file descriptor or some internal number?
> It's an gem object mmap which calls drm_gem_dumb_map_offset() inside and
> the handle is gem object handle.

Ok, thanks for the clarification. I see that other drivers have the
exact same thing,
so I assume it's fine for drivers/gpu/ then, even if it would be a bit odd for
other subsystems.

       Arnd
