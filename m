Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC915B0B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiIGRNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIGRMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:12:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C72BFA8B;
        Wed,  7 Sep 2022 10:12:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c11so17257307wrp.11;
        Wed, 07 Sep 2022 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=eD0xuiNX3wD0z20Pv3fc/gF3yUZHFmC8co6RhSNzbeM=;
        b=Ty1nlULRqbTYBzI09R0J4LKQcvXHU/02T1na/x0/OIdZ4mCSxDvbQw8bszgJ1Nrj8S
         wkfomwVX9GKnQI0I1HtYHmiwbND0BjBJYwRtTzBwOX29jlE3wBO6T4qt4Ndur9Q/r1Uq
         YhJT//FBrJfpbo3yzb4cV/AECiS2b8mr1/WWNK2HlBiRz442F92imzd2MqjAvm16b0EA
         dqqd4x+SJ032c/pDqngfap36L3eDySgXyuirLZ6gL4OuM532yl2VajguRBKBYp9jZTzy
         0SRIKUEE+swjeGipV125CsqX3AO+fAbkWZbDS5BDZLmroWB03aOBsSEJ0NnST3rJ6is+
         eKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eD0xuiNX3wD0z20Pv3fc/gF3yUZHFmC8co6RhSNzbeM=;
        b=qSwN3iPP7nbhLlU0ggJ+JS9hiL+8FAUzkXa8sX7FfB9Dqy0MdH62/f1IMtXEeJiMhU
         2zOnJBU71C/AuZgrZWiXDI2SaDrAu41fu4E3fGskxnJx2r0a0i8vfCaZCZQOtDi9Y8Ns
         gjFPuegpYKbtHdEFNl8G+bTSJgz2OqkmZhBYziKbzzQDPPrS6EvyC0m9xLST61cAIcJ7
         TDX8TUCW++5+JN9MZzEY5lazeWoH7rk+TAjRptVs9LWMMHl5SqFLngvrEeSG3B6KJQES
         Cn6SBkrY7NUb4WthvDzPwX8aNDq35+La4fx1gxvsRpfWmsL0X7zB8dXYTp3I2mTODlKx
         qzNA==
X-Gm-Message-State: ACgBeo0gfGlwaR0unzUaqtaMaVNFY95eQAl04EOcoyJVDXVliK2c3Mqs
        WTa3UU8SFTL/HlUovXsKiF0=
X-Google-Smtp-Source: AA6agR5yxLsnkcrpy3PeMKRCbpBup3SUjSmpp6SprsnF9G8/bK7OpI4Fjn1G7+fCIKMBDSvGQrflbA==
X-Received: by 2002:a5d:5b17:0:b0:226:da70:619e with SMTP id bx23-20020a5d5b17000000b00226da70619emr2793441wrb.434.1662570724639;
        Wed, 07 Sep 2022 10:12:04 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4e41000000b00228bf773b1fsm10548737wrt.7.2022.09.07.10.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:12:03 -0700 (PDT)
Date:   Wed, 7 Sep 2022 19:12:01 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        David Gow <davidgow@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] drm/doc: Custom Kconfig for KUnit is no longer needed
Message-ID: <20220907171201.GA4529@elementary>
References: <20220905184711.391022-1-michal.winiarski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905184711.391022-1-michal.winiarski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michał,

On Mon, Sep 05, 2022 at 08:47:11PM +0200, Michał Winiarski wrote:
> When built for UML, KUnit provides virtio/PCI, which means that the
> DMA/IOMEM UML emulation needed by DRM is already present and does not
> need to be manually added with --kconfig_add.
> 
> References: commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> ---
>  Documentation/gpu/drm-internals.rst | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-internals.rst
> index 5fd20a306718..c264a9587d21 100644
> --- a/Documentation/gpu/drm-internals.rst
> +++ b/Documentation/gpu/drm-internals.rst
> @@ -228,16 +228,11 @@ follows:
>  
>  .. code-block:: bash
>  
> -	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests \
> -		--kconfig_add CONFIG_VIRTIO_UML=y \
> -		--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> +	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests
>  
>  .. note::
>  	The configuration included in ``.kunitconfig`` should be as generic as
>  	possible.
> -	``CONFIG_VIRTIO_UML`` and ``CONFIG_UML_PCI_OVER_VIRTIO`` are not
> -	included in it because they are only required for User Mode Linux.
> -
>  
>  Legacy Support Code
>  ===================
> -- 
> 2.37.3
> 

Thanks for the patch. This was in my ToDo list and I was waiting until
6fc3a8636a7b was merged in the DRM tree, but since you already fixed it
I can mark it as done.

Thanks!
