Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4396F4E4638
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbiCVSo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbiCVSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:44:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058DD25586
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:43:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p9so24669268wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PTw1Ngb/5IGZJfySo52s6yL6EQYSBf4xK9vWZzdHvqA=;
        b=OpP1yr+zy1OjfHROi7aD3NDxRfVNU5xYU5sKI6GfLagMM2/XUgbjQyj+ubE8Ph92IB
         7qarV5iq5TMCXv9UJsTaZavEFNsCReJsVV7g8oEUUYvLaLpIcY1PNEN/N3Kv6lSnUjur
         aVungH7taEPjAY6OZNBJQCkyc3DQai5kSEK8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PTw1Ngb/5IGZJfySo52s6yL6EQYSBf4xK9vWZzdHvqA=;
        b=b6mIwVDJT3idnUG1/f2tIHthKWAA3C1jrZrJJqXHsc/DwbBJ9C3k5hkBIzOZL6h4gn
         dt4hoFsLJZ1hDMN/M7X0ZBobCDgY1csuTjtHYyQa9isEjU8wHJCwmLNVPQAWpjNU7tne
         Xt1kAd4TDHnnb8w1vlm0R5whgSba41A7lwpQniv5etL/6Oq6KHsPCXGg+z1hRHSl4jbI
         ThENxkGUuv2bO+5lk6gZuzZNHA7RP1Wj3BxFTLyHBilA3hrypUHdbzwMjoWI7BDxqIIo
         4jvJtfupW1qkhPI9/lp5bne+rxnpntb+vOEeHtnDY+qrFhG8SVO3Zfd/G06OZ5eNKk18
         igyw==
X-Gm-Message-State: AOAM531EURgxFtz/ZZ2AYJL3sx+QopHWuxz+vGV4xuf4GNv1tX21Xnmz
        qgRtrcwZ3ndzRvAjMrd+YT7n3g==
X-Google-Smtp-Source: ABdhPJxWJhc/mrUfLmxDPc/wDdSNZS4bI61hMpAh3233GY9QkpMhRpVU8f/XIxdk6ptlwsw1crMHLA==
X-Received: by 2002:adf:fccc:0:b0:203:fe14:e316 with SMTP id f12-20020adffccc000000b00203fe14e316mr15173047wrs.42.1647974601600;
        Tue, 22 Mar 2022 11:43:21 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-56-61.cust.vodafonedsl.it. [188.217.56.61])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d64c7000000b0020415e54576sm5136826wri.69.2022.03.22.11.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:43:21 -0700 (PDT)
Date:   Tue, 22 Mar 2022 19:43:19 +0100
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/nouveau/bios: Rename prom_init() and friends
 functions
Message-ID: <20220322184319.GA2353627@tom-ThinkPad-T14s-Gen-2i>
References: <7e0612b61511ec8030e3b2dcbfaa7751781c8b91.1647684507.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e0612b61511ec8030e3b2dcbfaa7751781c8b91.1647684507.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 11:27:51AM +0100, Christophe Leroy wrote:
> While working at fixing powerpc headers, I ended up with the
> following error.
> 
> 	drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c:48:1: error: conflicting types for 'prom_init'; have 'void *(struct nvkm_bios *, const char *)'
> 	make[5]: *** [scripts/Makefile.build:288: drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.o] Error 1
> 
> powerpc and a few other architectures have a prom_init() global function.
> One day or another it will conflict with the one in shadowrom.c
> 
> Those being static, they can easily be renamed. Do it.
> 
> While at it, also rename the ops structure as 'nvbios_prom' instead of
> 'nvbios_rom' in order to make it clear that it refers to the
> NV_PROM device.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: using nvbios_prom prefix instead of nvbios_rom. Changed structure name to keep things consistant.
> 
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h    |  2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c  |  2 +-
>  .../gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c   | 14 +++++++-------
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> index fac1bff1311b..cfa8a0c356dd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
> @@ -19,7 +19,7 @@ struct nvbios_source {
>  int nvbios_extend(struct nvkm_bios *, u32 length);
>  int nvbios_shadow(struct nvkm_bios *);
>  
> -extern const struct nvbios_source nvbios_rom;
> +extern const struct nvbios_source nvbios_prom;
>  extern const struct nvbios_source nvbios_ramin;
>  extern const struct nvbios_source nvbios_acpi_fast;
>  extern const struct nvbios_source nvbios_acpi_slow;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> index 4b571cc6bc70..19188683c8fc 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> @@ -171,7 +171,7 @@ nvbios_shadow(struct nvkm_bios *bios)
>  	struct shadow mthds[] = {
>  		{ 0, &nvbios_of },
>  		{ 0, &nvbios_ramin },
> -		{ 0, &nvbios_rom },
> +		{ 0, &nvbios_prom },
>  		{ 0, &nvbios_acpi_fast },
>  		{ 4, &nvbios_acpi_slow },
>  		{ 1, &nvbios_pcirom },
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> index ffa4b395220a..39144ceb117b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> @@ -25,7 +25,7 @@
>  #include <subdev/pci.h>
>  
>  static u32
> -prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
> +nvbios_prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
>  {
>  	struct nvkm_device *device = data;
>  	u32 i;
> @@ -38,14 +38,14 @@ prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *bios)
>  }
>  
>  static void
> -prom_fini(void *data)
> +nvbios_prom_fini(void *data)
>  {
>  	struct nvkm_device *device = data;
>  	nvkm_pci_rom_shadow(device->pci, true);
>  }
>  
>  static void *
> -prom_init(struct nvkm_bios *bios, const char *name)
> +nvbios_prom_init(struct nvkm_bios *bios, const char *name)
>  {
>  	struct nvkm_device *device = bios->subdev.device;
>  	if (device->card_type == NV_40 && device->chipset >= 0x4c)
> @@ -55,10 +55,10 @@ prom_init(struct nvkm_bios *bios, const char *name)
>  }
>  
>  const struct nvbios_source
> -nvbios_rom = {
> +nvbios_prom = {
>  	.name = "PROM",
> -	.init = prom_init,
> -	.fini = prom_fini,
> -	.read = prom_read,
> +	.init = nvbios_prom_init,
> +	.fini = nvbios_prom_fini,
> +	.read = nvbios_prom_read,
>  	.rw = false,
>  };
> -- 
> 2.35.1
> 

Look's good.

Tommaso
-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
