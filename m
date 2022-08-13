Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F170D5919DE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiHMKgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbiHMKgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:36:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693EE248E5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 03:36:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n4so3592675wrp.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=HPuvTq5hFjRHTYbOkDpZrmTC++rMWhoNof888/AkPnc=;
        b=AAkADSOegOTUqUha0RqJU/WOWtpIjaLnBBG1CrsD/pTFaDC5BIaxwKdWiZikvRIgYh
         s7eFvvYg9gMQc//tTE42QQddOXmeHvZ4MS83ppg6epa96YRuh8OGTlQj9DxjZXu/fBD9
         lAt9813Qn6Tm+qfP1mf5fJ9GTvDqa1/F0Cap73LnLNSTgD27ynLXw0YdUluth7N/YL76
         9Pu53gAg2dKbdHa5mt5t5Cn1Z1XBr60o3e6L3TIV0XDCtLZtZyZC2Fp4+j1aGOs1nJ27
         T2Oz20n/JhJzsOvlKoSHajPdJd2qA8QxRU6OXiK4IM1gFI1VZ/XvSuuLGn8GvMujOQ26
         G4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=HPuvTq5hFjRHTYbOkDpZrmTC++rMWhoNof888/AkPnc=;
        b=xDYizJqtBSSnq3cg5UeQIfaRhtG9cq520r0Hngkj9mhJvRh3K3uFjmvq2nA3wAm7Mi
         Scg/1E5ECJfx0qCb+HXOLyiVnPTOBu/qN3+8JZCwD0amK43WYpCxITLJ6mF68XLv88vB
         kI8Ta1Kaefcid9+z1L1ZEjwDiAra4kdR8oZSCEsmliLplbwVAy9gP+j9U4NwC1LGbe2u
         0eGD4f7Z95nWpPXp+9tYQypOdBP8cTZ5O6KVT5RkftvdcNMdXG2DVHfCf+f/43cp3V0/
         TC7+Q6FpXVGaE9gVSg4YyjxOLKaZ8pEmKVX4DgvM48GT/9MzlQKVgoFreyeD/S5Yyd6E
         MwEQ==
X-Gm-Message-State: ACgBeo0nITKsSbRHM4BtxVdmcKXdXXieQ9Ngjy4o73N5fvNtoagX5um5
        a7mYiynHSd/yJfVrXGy4aks=
X-Google-Smtp-Source: AA6agR6O4owm7ZLvvr10Jg+0Qa1Cn4ZvQcTZ/9lEDTu9z3VlZouQN1mdGcpPmr1rOUR/OOXs6sNb3g==
X-Received: by 2002:a05:6000:2c6:b0:222:411:a934 with SMTP id o6-20020a05600002c600b002220411a934mr4067190wry.155.1660386990870;
        Sat, 13 Aug 2022 03:36:30 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb43000000b00222d512d96asm1725763wrs.75.2022.08.13.03.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 03:36:30 -0700 (PDT)
Date:   Sat, 13 Aug 2022 12:36:19 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb565()
Message-ID: <20220813103619.GA12453@elementary>
References: <20220709115837.560877-1-jose.exposito89@gmail.com>
 <20220709115837.560877-5-jose.exposito89@gmail.com>
 <CABVgOSmhOBdXPH_=B_WRcUjMGC-wVPTLBwCdbgZLb0o3-O8pKw@mail.gmail.com>
 <20220717170054.GA1028249@elementary>
 <CAGS_qxqqsLQ-aCfZHTJbYqb3e21hNSzobAmsZNN_QETXExwQ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGS_qxqqsLQ-aCfZHTJbYqb3e21hNSzobAmsZNN_QETXExwQ+A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:41:18AM -0700, Daniel Latypov wrote:
> On Sun, Jul 17, 2022 at 10:01 AM José Expósito
> <jose.exposito89@gmail.com> wrote:
> >
> > José Expósito <jose.exposito89@gmail.com> wrote:
> > > I already fixed the warning and added the reviewed by tags, however, I
> > > noticed that rebasing the series on the latest drm-misc-next show this
> > > error:
> > > [...]
> >
> > Sorry for the extra email. I forgot to mention that the error is only
> > present in UML. Running in other architectures works as expected.
> > Tested on x86_64 and PowerPC.
> 
> Can you take a look at the raw output?
> 
> It would be .kunit/test.log (or replace .kunit with w/e --build_dir
> you're using).
> You could also run the test with --raw_output to have kunit.py print
> that out instead.
> We might want to compare the output on UML vs x86 and see what looks suspicious.
> 
> These errors
>   [ERROR] Test: xrgb8888_to_rgb332_test: missing subtest result line!
> means that kunit.py can't parse the KTAP output.
> 
> It could be that the output is mangled for some reason.
> I recall running into a UML-specific issue with output mangling on an
> old kernel fork. I doubt it's related to this one, but it shows that
> it's possible there could be something going on.
> 
> -Daniel

Hi!

Sorry for not clarifying the error in this thread.
I fixed it in v3 (already merged).

The issue was in my implementation. I was overwriting a few bytes of
memory due to an out of bounds bug. Thanks to the crash I mentioned,
I detected it before the code got merged.

Thanks a lot for the pointers Daniel, the next time I'll check
.kunit/test.log for usefull information.

Jose
