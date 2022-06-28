Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3D355ECF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiF1SsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiF1SsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:48:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211A1AF38
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:48:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id n12so12865661pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2ZFJGLWfARwse3I0qcbyHYAl+J8ZxqGlNp9EqF8Gt/4=;
        b=GcO0xSWTb1ngfjkZ8sUq94xD+QADBUfR+xEyDAxWGq2RsJsen2Y6E7nUoeF90QyEVQ
         JcOklYDKGIn630R8J5w7kVqK1tkQh6/fCb20+xc0qKQZXlWDNMdD+C9qaU8iHreNKkhu
         Qo9hPak8Ky7gG4m367+HnTi9Pq4v2UMtDMUjhJWR8Rucp58BZSZoZe06S1yRZ1p21v7W
         Xa2xPt+7bcY7lXz4nC9ODghyGMtYFTz18MYZMcXPkmawhZMqVnSl+qnDgQrFvwmVfxOz
         dA5pPoNxD0uGWNfYD3DgZ0+vA9QCnrSboz6itLf5sY6gjykq2ukBKo+6daDQq1UT6Faq
         72sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2ZFJGLWfARwse3I0qcbyHYAl+J8ZxqGlNp9EqF8Gt/4=;
        b=qr2kYw90PF0M7l2cJIwIUQ6j6vykUHSujYoB4LTPlwhPI8NXk++FEfSbnnbBheBU23
         ASEOuvGSzli/f+vA9trugmDyPqX/t3OaQgmqhIl9zxxC57Ull/j93cy6HGUGObM7MLK6
         17uoqbErCOg6hHk9KLCZ6WO/QBqV0JZShjVgLKfXF/saEs+ZizfuMzR11adJUR0wEbEX
         3QxNpNf4g7GiBkhZoH7r+fmXtH/k5DIYRu9UvT2qOSO6Wq976tgw0ryO9k/vm1omsP+L
         pX2ksVayysHAPjsREmM4BAGXtw5rWuK+KSkQNW/LM7DTtT5lxGjkLiStSRNhGcIZN4cY
         0ICA==
X-Gm-Message-State: AJIora9MuRQSXq2qd5YoBIxcLSmouJt6rJ7tOqfBLcoVO2GpHKJRqX6a
        sEGJA5Qu+V+5N+P4TOFc3iawBCAUyTkpv3/Ra2g=
X-Google-Smtp-Source: AGRyM1vl8i2+u/2GpoyflXi20qGW2LyjziGmL1IJ6Gl1HeMIS+2byGoaqomAzKOgxHlNrXYjLa3e4gBGdK9VLPJESQw=
X-Received: by 2002:a65:6aa3:0:b0:40c:889d:4f16 with SMTP id
 x3-20020a656aa3000000b0040c889d4f16mr19029190pgu.106.1656442100828; Tue, 28
 Jun 2022 11:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220627161132.33256-1-jose.exposito89@gmail.com>
In-Reply-To: <20220627161132.33256-1-jose.exposito89@gmail.com>
From:   Tales <tales.aparecida@gmail.com>
Date:   Tue, 28 Jun 2022 15:47:44 -0300
Message-ID: <CAGVoLp47kQTuMJWVGtY-KMPf=opv3ted7MkbooEbdb2UWZqevg@mail.gmail.com>
Subject: Re: [PATCH 0/4] KUnit tests for RGB565 conversion
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     javierm@redhat.com, davidgow@google.com, dlatypov@google.com,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        jani.nikula@linux.intel.com,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        isabbasso@riseup.net, magalilemes00@gmail.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

Em seg., 27 de jun. de 2022 =C3=A0s 13:13, Jos=C3=A9 Exp=C3=B3sito
<jose.exposito89@gmail.com> escreveu:
>
> Hello everyone,
>
> This series is a follow up of the XRGB8888 to RGB332 conversion KUnit tes=
ts.
>
> The first 3 patches refactor the existing test to make them agnostic of t=
he target format and add support for "swab".
>
> The last patch adds the RGB565 conversion values, and shows how more form=
ats will be easily added in the future.
>
> Thank you very much in advance for your feedback,
> Jos=C3=A9 Exp=C3=B3sito
>
> Jos=C3=A9 Exp=C3=B3sito (4):
>   drm/format-helper: Rename test cases to make them more generic
>   drm/format-helper: Transform tests to be agnostic of target format
>   drm/format-helper: Add support for conversion functions with swab
>   drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb565()
>
>  .../gpu/drm/tests/drm_format_helper_test.c    | 231 +++++++++++++++---
>  1 file changed, 196 insertions(+), 35 deletions(-)
>
>
> base-commit: 6fde8eec71796f3534f0c274066862829813b21f
> prerequisite-patch-id: 8a16f4c8004d6161035eaea275c8eafaa0ac927e
> prerequisite-patch-id: 53fded2a49e6212b546db76ec52563a683752e65
> prerequisite-patch-id: 294b0ca27a6ee57096c8f097c0572336b8a2d583
> prerequisite-patch-id: 5e05bfc5287d16c207bfc616b2776ad72eb4ab29
> prerequisite-patch-id: e94560be85dffb62a5b3cf58d1f0fc3d278ad806
> prerequisite-patch-id: a471df39c7b32c69dd2b138a7d0af015ea42e00a
> --
> 2.25.1


Tested with "./tools/testing/kunit/kunit.py run
--kunitconfig=3Ddrivers/gpu/drm/tests --arch=3Dx86_64", "... --arch=3Di386"
and baremetal on x86_64 to be sure; everything looks fine, but I feel
like some patches could be squashed, though.

Tested-by: Tales L. Aparecida <tales.aparecida@gmail.com>

Inspiring work, Jos=C3=A9, keep it up!
Best regards, Tales
