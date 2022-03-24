Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC134E6A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355327AbiCXWVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242692AbiCXWVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:21:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E808792855
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A459EB826A1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D317C340F5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648160415;
        bh=yckN+MdsKZxNF8aOhJMOgBhFmt6WG9OpxVOqNrPyzqE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ey4FiSSKjRMZ+8SrrZ+VAvpYQeonmWi6DZbMFmyfKzefayuqQ5+Mso6YEsY7VDGz0
         ei94QYctelUOVAgC3uIrSbbMMXMUvowkoTfHflF2m2DX6cKU4qXJubxl1VtpgdLmgT
         qLUI4iCRDMbuVX55ZkjmJ3ulA3JvogfwXxGPfu1XBdV7uqP6cKgdgHYwiSb6LPZH7F
         xUAVm8w39EyRsCiNBnDrUUugemnB6O1xUV2AOziOkTYQjiv8CFT//AT3pn3NBm98qz
         Z5PCXELUCbdNXdpfEDXnR54Y6WJCFV5iVziHY+9B8itCLGn8nH0MPxdB5XKNvaeNEY
         qzz8BadUAXPJA==
Received: by mail-ej1-f41.google.com with SMTP id dr20so11935393ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:20:15 -0700 (PDT)
X-Gm-Message-State: AOAM532Hbji6icpa+tW4T9rFY89mUWLgqRLbK4HHTh/VBdnFRF6CVF2i
        Wxv5tRQcVDbZfv1Ov6p7wU5SVwbw3CmzPa+kpQ==
X-Google-Smtp-Source: ABdhPJxHVFFf7b6MkecoVe5kNuoMPvBab+rmSG9rTkwHitqqDwBRgcvY2X7bD2iP8YTLDR/KQM8MuV+Voe9Yyjz4/2E=
X-Received: by 2002:a17:907:2ce6:b0:6df:a489:d2e1 with SMTP id
 hz6-20020a1709072ce600b006dfa489d2e1mr8366419ejc.264.1648160413423; Thu, 24
 Mar 2022 15:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tytg5jd_i3z3C5Y1dii2-cgO11Gjgvaq8qoWn3CGfCreg@mail.gmail.com>
In-Reply-To: <CAPM=9tytg5jd_i3z3C5Y1dii2-cgO11Gjgvaq8qoWn3CGfCreg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 24 Mar 2022 17:20:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJqb6HYN5cw7GsyFobZxFmhU-ci8w4HKQEdFsx=bC_F3w@mail.gmail.com>
Message-ID: <CAL_JsqJqb6HYN5cw7GsyFobZxFmhU-ci8w4HKQEdFsx=bC_F3w@mail.gmail.com>
Subject: Re: [git pull] drm for 5.18-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 3:32 AM Dave Airlie <airlied@gmail.com> wrote:
>
> Hi Linus,
>
> This is the main drm pull request for 5.18.
>
> The summary changelog is below, lots of work all over,
> Intel improving DG2 support, amdkfd CRIU support, msm
> new hw support, and faster fbdev support.
>
> Conflicts:
> I did a merge into your tree this morning, couple of Kconfig
> clashes, drm_cache.c needs an ioport.h include to avoid a build
> fail due to other header refactoring. I think you should be able
> to handle it.
>
> External interactions:
> - dma-buf-map gets renamed to iosys-map
> - this adds a yes/no helper to the strings helpers, and it's used
>   in some other code.
> - platform driver for chromeos privacy screen
>
> Let me know if there are any issues.
>
> Regards,
> Dave.
>
> drm-next-2022-03-24:
> drm for 5.18-rc1
>
> dma-buf:
> - rename dma-buf-map to iosys-map
>
> core:
> - move buddy allocator to core
> - add pci/platform init macros
> - improve EDID parser deep color handling
> - EDID timing type 7 support
> - add GPD Win Max quirk
> - add yes/no helpers to string_helpers
> - flatten syncobj chains
> - add nomodeset support to lots of drivers
> - improve fb-helper clipping support
> - add default property value interface
>
> fbdev:
> - improve fbdev ops speed
>
> ttm:
> - add a backpointer from ttm bo->ttm resource
>
> dp:
> - move displayport headers
> - add a dp helper module
>
> bridge:
> - anx7625 atomic support, HDCP support
>
> panel:
> - split out panel-lvds and lvds bindings
> - find panels in OF subnodes
>
> privacy:
> - add chromeos privacy screen support
>
> fb:
> - hot unplug fw fb on forced removal
>
> simpledrm:
> - request region instead of marking ioresource busy
> - add panel oreintation property
>
> udmabuf:
> - fix oops with 0 pages
>
> amdgpu:
> - power management code cleanup
> - Enable freesync video mode by default
> - RAS code cleanup
> - Improve VRAM access for debug using SDMA
> - SR-IOV rework special register access and fixes
> - profiling power state request ioctl
> - expose IP discovery via sysfs
> - Cyan skillfish updates
> - GC 10.3.7, SDMA 5.2.7, DCN 3.1.6 updates
> - expose benchmark tests via debugfs
> - add module param to disable XGMI for testing
> - GPU reset debugfs register dumping support
>
> amdkfd:
> - CRIU support
> - SDMA queue fixes
>
> radeon:
> - UVD suspend fix
> - iMac backlight fix
>
> i915:
> - minimal parallel submission for execlists
> - DG2-G12 subplatform added
> - DG2 programming workarounds
> - DG2 accelerated migration support
> - flat CCS and CCS engine support for XeHP
> - initial small BAR support
> - drop fake LMEM support
> - ADL-N PCH support
> - bigjoiner updates
> - introduce VMA resources and async unbinding
> - register definitions cleanups
> - multi-FBC refactoring
> - DG1 OPROM over SPI support
> - ADL-N platform enabling
> - opregion mailbox #5 support
> - DP MST ESI improvements
> - drm device based logging
> - async flip optimisation for DG2
> - CPU arch abstraction fixes
> - improve GuC ADS init to work on aarch64
> - tweak TTM LRU priority hint
> - GuC 69.0.3 support
> - remove short term execbuf pins
>
> nouveau:
> - higher DP/eDP bitrates
> - backlight fixes
>
> msm:
> - dpu + dp support for sc8180x
> - dp support for sm8350
> - dpu + dsi support for qcm2290
> - 10nm dsi phy tuning support
> - bridge support for dp encoder
> - gpu support for additional 7c3 SKUs
>
> ingenic:
> - HDMI support for JZ4780
> - aux channel EDID support
>
> ast:
> - AST2600 support
> - add wide screen support
> - create DP/DVI connectors
>
> omapdrm:
> - fix implicit dma_buf fencing
>
> vc4:
> - add CSC + full range support
> - better display firmware handoff
>
> panfrost:
> - add initial dual-core GPU support
>
> stm:
> - new revision support
> - fb handover support
>
> mediatek:
> - transfer display binding document to yaml format.
> - add mt8195 display device binding.

FYI, this breaks the DT bindings. The relevant patches didn't get
reviewed nor run thru automated testing because their encoding was
'charset=y'[1]. (While email clients seem to just ignore that
encoding, patchwork and b4 do not.) linux-next is still broken and has
been since Mar 2[2]. v2 of the fixes[3] have been posted since Mar 9,
and still aren't in linux-next.

It doesn't have to be fixed in this PR, but it needs to be fixed
before rc1. Otherwise, no one can test their bindings using rc1. In
general, there's no reason fixes need to wait until after rc1 as
Chun-Kuang suggests[4].

Rob

[1] https://lore.kernel.org/all/CAL_JsqLU0m9C1OPdiBPTkofB4sfiAeUPbFHp0w8caWyP4XPOEw@mail.gmail.com/
[2] https://lore.kernel.org/all/CAL_Jsq+6k5EqouAO2Xm=GpBz3Pi-wfB-ixGwfyC+Y+qOrjUFTg@mail.gmail.com/
[3] https://lore.kernel.org/all/Yjzgf10zAhrkpYde@robh.at.kernel.org/
[4] https://lore.kernel.org/all/CAAOTY__kzL8YuGo-oKct4c_bL-Ch5rW8wBpkhOXkK+a10gNXVg@mail.gmail.com/
