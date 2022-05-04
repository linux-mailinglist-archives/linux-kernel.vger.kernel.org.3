Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02492519AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346942AbiEDJBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346963AbiEDI7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:59:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D83D286EC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:53:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j6so1534223ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=FWeYiYf0DMm7V+g21Cbm+9C9Pn1oqo14ZQ670Fj9soM=;
        b=H3LWFD2SKqhgrKGammVqLPu1+tsxAB77OiaspD7wNyK6giB6LGiCB0egmuFelRz0xd
         Wwr8iW5bq7rM304cdd3tRii/BntL55bHQGs59Jj+dRjdM5XT8vOzIahu7OZtSg/9zgsA
         PYg9GxvGp61ZKK8xDG4sWyfqcA89Y++1uLPP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=FWeYiYf0DMm7V+g21Cbm+9C9Pn1oqo14ZQ670Fj9soM=;
        b=m2p92aV3F6PUs4Nad8isPvs5u2a6e8gtujLuCPP7e5OccqqVFqNstASGJ33D5Hjwvy
         2c0YPWvEMm9WEona05lg4FN7VUZvTX6tF6wdJg2yPdKtx1BPUioO/idT5vb2Ivu3TOi7
         /IZQ2de2S9GBynzkqi56dvTKAiRRwP3DlAfDjLqs8Je+DUKQqGPSulWTp74R1lfN/m4S
         WSDWwDOCOepfKZAH2cVk/inYX2CCURYUEpM/xGOAcCfmubZJ9qdexOowDG6eylB/5wu8
         LxyPHKCQWSRXL3syQfx4XR6uDe2gebZrICt6d3SCxTdR5qhUk75bD9syvNBE8uwxBLJN
         QHRw==
X-Gm-Message-State: AOAM533uJGYMMKf2QTXcG9vqlku5i4xPzEFVFetzghkCsVG8qHcHMTkX
        niWhQiy1TNlDU4asyFt68BdZ1g==
X-Google-Smtp-Source: ABdhPJynePYca4h8hGIO/ma6nS7rL//o7qYPz+d7uodB/VCGwalHggLOksWn/GzUnOuMimdixtbeHg==
X-Received: by 2002:a17:907:50a3:b0:6f3:a302:96aa with SMTP id fv35-20020a17090750a300b006f3a30296aamr18975623ejc.2.1651654395002;
        Wed, 04 May 2022 01:53:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id gz21-20020a170907a05500b006f3ef214e3csm5502964ejc.162.2022.05.04.01.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:53:14 -0700 (PDT)
Date:   Wed, 4 May 2022 10:53:12 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] drm/todo: Add entry for using kunit in the subsystem
Message-ID: <YnI++MYijJFqyStF@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20220504080212.713275-1-javierm@redhat.com>
 <20220504081030.ky57nenipnif5r2e@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504081030.ky57nenipnif5r2e@houat>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 10:10:30AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Wed, May 04, 2022 at 10:02:12AM +0200, Javier Martinez Canillas wrote:
> > The Kernel Unit Testing (KUnit) framework provides a common framework for
> > unit tests within the Linux kernel. Having a test suite would allow to
> > identify regressions earlier.
> > 
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> > 
> >  Documentation/gpu/todo.rst | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> > index 127e76ee0b2d..10bfb50908d1 100644
> > --- a/Documentation/gpu/todo.rst
> > +++ b/Documentation/gpu/todo.rst
> > @@ -603,6 +603,20 @@ Level: Advanced
> >  Better Testing
> >  ==============
> >  
> > +Add unit tests using the Kernel Unit Testing (KUnit) framework
> > +--------------------------------------------------------------
> > +
> > +The `KUnit <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
> > +provides a common framework for unit tests within the Linux kernel. Having a
> > +test suite would allow to identify regressions earlier.
> > +
> > +A good candidate for the first unit tests are the format-conversion helpers in
> > +``drm_format_helper.c``.
> > +
> > +Contact: Javier Martinez Canillas <javierm@redhat.com>
> > +
> > +Level: Intermediate
> 
> Kunit is fairly easy to grasp if you have some knowledge of other unit
> testing frameworks already (pytest, cmocka, etc.)
> 
> Another good candidate would be to convert (some ?) selftests to kunit.
> I'm not sure the others, but at least test-drm_cmdline_parser should be
> fairly easy to convert.

All the drm selftest should be good candidates for conversion to kunit.

Either way patch is Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
