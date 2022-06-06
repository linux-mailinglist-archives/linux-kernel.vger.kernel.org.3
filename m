Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B702353EA12
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbiFFQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241932AbiFFQaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:30:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917132525B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:30:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x17so20573917wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xJwQl/PiEUwiwk52JeaaRavLlxhGbowpTp1ZVoSGKqg=;
        b=XAmkm6HeHfdJZ2x9c75GpfnvFb80dmOF3hQbzJZ3pnpuH2s+eKJ4MTulLbTixbbrzP
         hX2iLDaET9JJC2ywRNuep0vyoObiTJaQs7e+HJ6ziWBvK7JVOeRqqm5d0vyqLc52lXkK
         nI7+hM0umb7pILpvQMJfFEEkHGCQUnUoXFlq1GLd+Uxblg/aOOI1zhLlXS/woiwYyIMS
         yaqJU86mR5V0RVnYUGCBxJgpC9ctLyl2NrokbvLVdQbzS7RfIytd6/O+NMJcggDoF5NZ
         2mZ8CV9V5abU1aAX7nuF0Fox0C+tozWfeL4ya7kE+8W6fRmm3mT1YSEmZEPq76hB6wzW
         rOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xJwQl/PiEUwiwk52JeaaRavLlxhGbowpTp1ZVoSGKqg=;
        b=eH9HT+ufj14M5/aEJiU23sKLLzkE+QzRiA1NBms+eXp+hQOf23Bin5zg51BLfmGvbF
         Vaw/qhmGv8biLRBpKCu4Eu2tIMaV5Kkv5kfe9SMdPMmQrcJp6O6ijDrHpCetkfzG6Sqe
         vXnC2tMFTYId1OMGXHVxu8W7ggkYQQ3NOWWHrdDOtwyOXIplVtOVYPnMPT8oZbhyI779
         GpLTNndB9ZJVWSlzXfxteAjE/ZuoHefijUiFUxrhkV3LkV4k+gll5RKcsmKAmbBRIZTV
         HUALQ3kJ1jtqJpNcdcwg3taKKrrF7wYamcmoGLm9QeK05BeyufEkeAkppRsxJd3NDKo2
         Ov1g==
X-Gm-Message-State: AOAM5311lTbnfkz1okJUF5d6TWoPWQ3iJbcQrYIp+9UKWz1g7KQ4pKPJ
        o2y6TlqsS5WuVudYcDBdzPM=
X-Google-Smtp-Source: ABdhPJxQ3J9vZ+ZM5ZF6/sQz314KJ/6atguYE7HzUvHP+PXE9tWeHbp0/vF63dUCKiZApdTziRo6tw==
X-Received: by 2002:a05:6000:716:b0:213:b7d1:adeb with SMTP id bs22-20020a056000071600b00213b7d1adebmr18475559wrb.337.1654533009215;
        Mon, 06 Jun 2022 09:30:09 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id d11-20020adffbcb000000b002183ee5c0c5sm3143096wrs.50.2022.06.06.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 09:30:08 -0700 (PDT)
Date:   Mon, 6 Jun 2022 18:30:05 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Message-ID: <20220606163005.GA5274@elementary>
References: <20220606095516.938934-1-jose.exposito89@gmail.com>
 <20220606095516.938934-2-jose.exposito89@gmail.com>
 <cbef78d3-c392-37e6-afdd-177806dfb033@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbef78d3-c392-37e6-afdd-177806dfb033@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Javier Martinez Canillas wrote:
> Hello José,
> 
> On 6/6/22 11:55, José Expósito wrote:
> > Test the conversion from XRGB8888 to RGB332.
> > 
> > What is tested?
> > 
> >  - Different values for the X in XRGB8888 to make sure it is ignored
> >  - Different clip values: Single pixel and full and partial buffer
> >  - Well known colors: White, black, red, green, blue, magenta, yellow
> >    and cyan
> >  - Other colors: Randomly picked
> >  - Destination pitch
> > 
> > How to run the tests?
> > 
> >  $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm \
> >          --kconfig_add CONFIG_VIRTIO_UML=y \
> >          --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> > 
> > Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > 
> > ---
> 
> Thanks for addressing the issues pointed out. Patch looks good to me now.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for the quick review Javier :)

Javier Martinez Canillas wrote:
> By the way, I think you should request an account [0], so that you can push
> patches to drm-misc directly. Specially since AFAIU the plan is to add more
> KUnit tests in future patch series.
> 
> [0]: https://www.freedesktop.org/wiki/AccountRequests/

I'll request one, thanks for the tip.

-------

Maxime Ripard wrote:
> > > The following works correctly but it won't use User Mode Linux:
> > >
> > > ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/.kunitconfig --arch=x86_64
> > >
> > > But then, can't we add them to .kunitconfig?
> > >
> >
> > That's what I asked in the previous RFC too. Daniel mentioned that it shouldn't
> > go there because is platform specific (AFAIU, one might want to test it on x86,
> > aarch64, etc) but then I asked why we couldn't have a arch/um/.kunitconfig.
> >
> > The answer was that's not that simple and some agreement on how to do it is needed:
> >
> > https://lists.freedesktop.org/archives/dri-devel/2022-June/357617.html
>
> We should probably just document it somewhere in KMS then? It doesn't
> have to be in this patch series, but I have the feeling that we will end
> up with that discussion a lot from people frustrated to have spent too
> much time figuring it out :)

My understanding from Daniel's comment [1] is also that at the moment
it is not easy to support this use case, so yes, at least copy and
pasting the command in the docs should help everyone figure out how to
run the tests.

Documentation/gpu/drm-internals.rst seems like a good place to add some
information about how to run and add tests.
I'll send a patch with the docs ASAP.

Jose

[1] https://lore.kernel.org/dri-devel/CAGS_qxqpiCim_sy1LDK7PLwVgWf-LKW+uNFTGM=T7ydk-dYcEw@mail.gmail.com/
