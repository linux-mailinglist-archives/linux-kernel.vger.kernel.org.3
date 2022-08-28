Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5845A3CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 11:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiH1I7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 04:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1I7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:59:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF5432EE1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:59:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j26so2888341wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=6n2CtwjylJHGKeOQHVvrMhmnklOgYwrq0j6ivmjhucc=;
        b=EVbhcIus7jocM22F8kdsrRXc44SPslZj25giSfVCCzcp9vqQYmTkIYb7OmN4j936R6
         64l3Sjx0sQDkQf4lbcHYSAtBPxTcXIfHhvlfc5zni2AZPoroj7Pxr+BQwq33Bu1z8CoH
         HELfycweKKOle19vporRG4U5hHr/Ujv6ig44dyucmZWGoPXBky7wDv0t1AEU3UgeOwoh
         4hAI58CHrn7LyIjYSnePTE2hgtwaBiuP5eoI0rS4i1ZK3vx9iOzJLzybPwCT3PVn0/CQ
         ahGR1oScXrAb6dofYIcymlUkWf2vdBLXuq4CFubVHoxBH1cxmbHU5yRFa1wRe1WScOac
         BwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=6n2CtwjylJHGKeOQHVvrMhmnklOgYwrq0j6ivmjhucc=;
        b=jgt9CYy4dtyPLaJTswVv8T76B1L6IhnPV52t69lcnawTQlpGqqCNaYBdXehX7gIH+d
         UqmKdldDmgfpd9p4t1bCzOWrOssWN31cvyEXUgb6HRfP6CyudnKhhMQOrWjgsLdJ0kdy
         tz7wiqplKWxhYFalAr88GU383ShrNS090K+/WV4ZEaZxl6vBbDYZSw39ka3bldR9VKA4
         SD5zfVgUoyGLn9JFMRInnEsfRNzScSDs0KJiRrRNLDZyXI8Wa6TMsyur6Uw6tyxSkzRT
         6uD0X+hp45hgBbnhXG1c4cLgQUxoO9ggZfnrsCmYfQbd+ZdqVCu8irgHhoC0Xeznt9dI
         XMlw==
X-Gm-Message-State: ACgBeo2Ci90cSdCKyVgUInjmp9MumcS/EG2YqquxPYkRDOtL09UAy6Ah
        ZmrTVkMV3mbUS4XhqRij+ho=
X-Google-Smtp-Source: AA6agR4QKmmDPIdSig2lUuLgA12j+7i/ihGNcz4Vx0b5Yitwxw3Ia77N454CBJhVbPCSgtfPSOtPeQ==
X-Received: by 2002:a05:600c:22c7:b0:3a6:68e4:1e5f with SMTP id 7-20020a05600c22c700b003a668e41e5fmr4036845wmg.46.1661677159051;
        Sun, 28 Aug 2022 01:59:19 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a6091b3a96sm6035822wms.23.2022.08.28.01.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 01:59:18 -0700 (PDT)
Date:   Sun, 28 Aug 2022 10:59:16 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc:     javierm@redhat.com, davidgow@google.com, dlatypov@google.com,
        tzimmermann@suse.de, mripard@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        jani.nikula@linux.intel.com, isabbasso@riseup.net,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        geert@linux-m68k.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] KUnit tests for RGB888, XRGB2101010 and grayscale
Message-ID: <20220828085916.GA12952@elementary>
References: <20220816102903.276879-1-jose.exposito89@gmail.com>
 <6761eeb7-eedf-c9bb-4f7f-d42e3c6e8ae4@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6761eeb7-eedf-c9bb-4f7f-d42e3c6e8ae4@riseup.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:37:49AM -0300, Maíra Canal wrote:
> Hi José,
> 
> Tested the whole series on UML, x86, i386 and PPC. All looks fine!
> 
> Tested-by: Maíra Canal <mairacanal@riseup.net>
> 
> Best Regards,
> - Maíra Canal
> 
> On 8/16/22 07:29, José Expósito wrote:
> > Hello everyone,
> > 
> > This series is a follow up on my work adding KUnit test to the XRGB8888
> > conversion functions. This time RGB888, XRGB2101010 and gray8 are added.
> > 
> > Best wishes,
> > Jose
> > 
> > José Expósito (3):
> >    drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb888()
> >    drm/format-helper: Add KUnit tests for
> >      drm_fb_xrgb8888_to_xrgb2101010()
> >    drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_gray8()
> > 
> >   .../gpu/drm/tests/drm_format_helper_test.c    | 190 ++++++++++++++++++
> >   1 file changed, 190 insertions(+)
> > 

Thanks a lot for testing the series Maíra and for the code review
David.

I added a note to my ToDo list to use KUNIT_EXPECT_MEMEQ once it gets
merged.

For the moment, I'll send v2 :)

Best wishes,
Jose
