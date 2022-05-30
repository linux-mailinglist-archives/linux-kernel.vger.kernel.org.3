Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C558538620
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbiE3Q3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiE3Q3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:29:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D016D99698
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 09:29:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h5so7279617wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d2wgBSa8Lbmv0viBPypHgxSRAxsqN3YuIRD/sWT3Efw=;
        b=VTG5Rtx1pu5/K8zxudbVTVPr871gAZKM1HMw85OTdN4fDw4NksG+BEPCaWKZbYLJj8
         cJEzOGReRoVZiLWzk5EaM2QMtmyF2RNAwJl9ux8ffhP9/5+Jzdtv1Fcg+lhmYlWtqBnB
         0Pq0lMwOa5Re02sYaxw5b6w9pDd1F7EYSZ08ibLI/BdhOSeVk3BY1HMmhMtZ6C3AoKs9
         0QCtMSA2sCB8eJ14Fiekya+uCkkZew+iTrGUMc+ETbjhNLgLB9ZsuV9cvfHhtTr+TBW0
         pSWaEXvCmR/KOneM79k0zMrgT6aO/GC4nNyFwxN7Igi3gfM3tPfeN3Q5BPdFCuurUDO5
         PhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d2wgBSa8Lbmv0viBPypHgxSRAxsqN3YuIRD/sWT3Efw=;
        b=Yz7y22mZv+Zkx3qv5hsgxVqTVUzOwWz3LUgNpgV0N0nUO2Qw2EgSbTlIgJuOyhaWD5
         o6wwuZkZ3gzc4gj4HvcG4Igam/Tllx0J3eKjI9xbEVBE06m7yv9umg1zSvk7tTomNMFX
         BQptKUXcXPNEpu+bMTU81FDDnrKCoY40NRUbAxMRi/VKduNm0ovycbV5iiuPgJtvBSYO
         6HFjGP5jwzmgZi6jsGSVWnVp1ZdOabo5UREoZsVLof2sG7q4156Wzk1nIjrZ1YFYjxUk
         ZaGmpYlGOQE8jeknonofb8CudYZwwqslA40X+mHGr0zjMhvJ/JPLs8Qr+f7dm79/uNrk
         N3zQ==
X-Gm-Message-State: AOAM532KcCHSOFvoNFAIjZGFe7kvqbHTUAN6RlJlkfqpoPii3Nci+oBb
        ByRoF9jJU7nfJxoA4jRfIMg=
X-Google-Smtp-Source: ABdhPJxXr6D1y9WcvLOIG5HzbCi0laSctJfbyP+mtsivl2dIFGdIgZEFI9LJ+xdYYS/dPJZ8+FpsOA==
X-Received: by 2002:a05:6000:1acd:b0:20f:dae8:569d with SMTP id i13-20020a0560001acd00b0020fdae8569dmr32575590wry.491.1653928152314;
        Mon, 30 May 2022 09:29:12 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id y4-20020a056000168400b0020d10a249eesm9376195wrd.13.2022.05.30.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 09:29:11 -0700 (PDT)
Date:   Mon, 30 May 2022 18:29:03 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>, kunit-dev@googlegroups.com
Cc:     javierm@redhat.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Message-ID: <20220530162903.GA6546@elementary>
References: <20220530102017.471865-1-jose.exposito89@gmail.com>
 <20220530102017.471865-2-jose.exposito89@gmail.com>
 <20220530131158.kqq2mohxoh52xpeg@penduick>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530131158.kqq2mohxoh52xpeg@penduick>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, May 30, 2022 at 03:11:58PM +0200, Maxime Ripard wrote:
> 
> Hi,
> 
> On Mon, May 30, 2022 at 12:20:17PM +0200, José Expósito wrote:
> > Test the conversion from XRGB8888 to RGB332.
> > 
> > What is tested?
> > 
> >  - Different values for the X in XRGB8888 to make sure it is ignored
> >  - Different clip values: Single pixel and full and partial buffer
> >  - Well know colors: White, black, red, green, blue, magenta, yellow
> >    and cyan
> >  - Other colors: Randomly picked
> >  - Destination pitch
> > 
> > Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> It looks mostly good to me, but I think we should Cc
> kunit-dev@googlegroups.com to have their feedback.

Thanks a lot for the quick feedback.

I just cc'ed kunit-dev@googlegroups.com. For anyone joining the
conversation, here is the link to the patch and the cover letter with
some questions:

https://lore.kernel.org/dri-devel/20220530102017.471865-1-jose.exposito89@gmail.com/T/

> 
> > ---
> >  drivers/gpu/drm/Kconfig                  |  12 ++
> >  drivers/gpu/drm/Makefile                 |   3 +
> >  drivers/gpu/drm/drm_format_helper_test.c | 166 +++++++++++++++++++++++
> >  3 files changed, 181 insertions(+)
> >  create mode 100644 drivers/gpu/drm/drm_format_helper_test.c
> > 
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index e88c497fa010..d92be6faef15 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -76,6 +76,18 @@ config DRM_KMS_HELPER
> >  	help
> >  	  CRTC helpers for KMS drivers. 
> >  
> > +config DRM_FORMAR_HELPER_TEST
> > +	bool "drm_format_helper tests" if !KUNIT_ALL_TESTS
> > +	depends on DRM && KUNIT=y
> > +	select DRM_KMS_HELPER
> > +	default KUNIT_ALL_TESTS
> > +	help
> > +	  KUnit tests for the drm_format_helper APIs. This option is not
> > +	  useful for distributions or general kernels, but only for kernel
> > +	  developers working on DRM and associated drivers.
> > +
> > +	  If in doubt, say "N".
> > +
> 
> AFAIK, kunit test cases are supposed to have a .kunitconfig too to
> enable the kunit tests easily.
> 
> Maxime

A .kuniconfig example is present in the cover letter. My understanding
from the docs:

https://docs.kernel.org/dev-tools/kunit/run_wrapper.html#create-a-kunitconfig-file

Is that, like the .config file, the .kunitconfig file is not meant to
be included in git, but I'm sure someone else will clarify this point.

Thanks again,
José Expósito

