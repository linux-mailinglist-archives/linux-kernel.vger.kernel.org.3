Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BABF4DB9D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350584AbiCPVBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiCPVBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:01:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADB5A5B1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A635EB81B9C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723EBC340EC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647464396;
        bh=JpfLakr1z8Vt7o6wmqB1JGT5eV2Ar+cCLzJvfd/g/PQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nndkUGsbCK3cJYxyqrSHutL4DwjGr63DpJvIaCAzDVk+GrVyYTALkFHt2Uv+zJI+7
         WnA+3SvRQrf4TbcPsCSLh2nwcpUHPo5YYtDsFjqe7CQfXJQfUez/MUQ8uOUdC+Rp8G
         hD2PLmsfF1tmfCRsVXH1cCUvXvEUdIwboL4r7BM6uf48QMxV7StACRykbvt60pRzrW
         gH6SqVk7BOFwCi3MyOYhtFYr250/Fx26+/sM7uwJkwzYeMHvzS0vzkwKM5+2+xuW6a
         6UQJdPfwM6ofyrCio2UlcWnT7Dx9+toUDnPHQ8yE4ttFMbw75ntm41hbbs6G748fzQ
         l0N5FSWj4p/2w==
Received: by mail-wr1-f46.google.com with SMTP id a1so3287979wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:59:56 -0700 (PDT)
X-Gm-Message-State: AOAM533zqvTti1OkLEjaOfEN7Bk3VRsJ3rtgxTP7ZoA0okU3E7n675SQ
        caOu1i1IUA/mOhPMGVl6rPiMqBSxMOxR7db87ZU=
X-Google-Smtp-Source: ABdhPJw3zEl4mldDqPFN++8SGgehHvZfPJqVmJRw/310rMeQtEL61PG4qGCc240hwWfuYczOaC0H6pBT6jxChmgF0+k=
X-Received: by 2002:adf:f606:0:b0:203:8dff:f4ac with SMTP id
 t6-20020adff606000000b002038dfff4acmr1376275wrp.12.1647464394497; Wed, 16 Mar
 2022 13:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220316183708.1505846-1-arnd@kernel.org> <aaf204b2-e876-d271-3d4e-51cbcc70d690@suse.de>
 <1f6c4559-ee48-ca67-8ff1-f7f9d330bc12@suse.de>
In-Reply-To: <1f6c4559-ee48-ca67-8ff1-f7f9d330bc12@suse.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 16 Mar 2022 21:59:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3ogV8sJshQJrzHe7hc2k1Opq-2hvXf6DU+HfhREk-DhQ@mail.gmail.com>
Message-ID: <CAK8P3a3ogV8sJshQJrzHe7hc2k1Opq-2hvXf6DU+HfhREk-DhQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: add CONFIG_DRM_KMS_HELPER dependencies
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 8:31 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 16.03.22 um 20:12 schrieb Thomas Zimmermann:
> >>
> >> Adding a dependency in all drivers that select DRM_MIPI_DBI avoids
> >> the problem for now, adding the dependency in DRM_MIPI_DBI as well
> >> should help make it easier to figure out why it breaks if someone
> >> forgets the dependency the next time.
> >>
> >>       tristate
> >> -    depends on DRM
> >> +    depends on DRM_KMS_HELPER
> >
> > This symbol cannot be selected by users, so it's maybe not a good idea
> > to depend on it. In fact, I've had to remove such a statement because it
> > created a cyclic dependency. [1]

I tried to explain above what I was thinking here: the added dependency
is both a correct statement (DRM_MIPI_DBI depends on DRM_KMS_HELPER
because it cannot be built without DRM_KMS_HELPER) and helpful as
an indication what went wrong if we run into the same problem with a new
driver, instead of the cryptic link failure you get something like

WARNING: unmet direct dependencies detected for DRM_MIPI_DBI
  Depends on [m]: HAS_IOMEM [=y] && DRM_KMS_HELPER [=m]
  Selected by [y]:
  - DRM_PANEL_WIDECHIPS_WS2401 [=y] && HAS_IOMEM [=y] && DRM [=y] &&
DRM_PANEL [=y] && SPI [=y] && GPIOLIB [=y] && BACKLIGHT_CLASS_DEVICE
[=y]
  Selected by [m]:
  - TINYDRM_ILI9225 [=m] && HAS_IOMEM [=y] && DRM [=y] && SPI [=y]

> [1]
> https://lore.kernel.org/dri-devel/20220315084559.23510-1-tzimmermann@suse.de/

I was going for 'depends on' in the panel drivers because I saw the same being
done for other panel drivers, and mixing the two methods causes dependency
loops. I looked again now, and find that 'select DRM_KMS_HELPER' is more
common for other drivers, and makes sense here because it is generally
not user-selectable.

The easiest replacement for my patch would then be to just use 'select
DRM_KMS_HELPER' from CONFIG_DRM_MIPI_DBI, which makes it
safer and more consistent with your change. If you like, I'll send an updated
version.

One thing I'm not sure about is whether there is still use for ever having
CONFIG_DRM without CONFIG_DRM_KMS_HELPER if it gets selected
by almost every driver anyway. Is this actually a configuration that
users rely on, or should we just remove the symbol completely and
build the KMS helpers unconditionally?

       Arnd
