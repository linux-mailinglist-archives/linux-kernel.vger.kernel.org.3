Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF8F58F0A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiHJQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiHJQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:45:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6527817598
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:45:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i14so28750399ejg.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=5NvoZJM3Gs+fBasdyNd4Z2rFfR4Itw8USwXW1cmyyE8=;
        b=GIYzVXcdJxpQ4lZ25KP2SH5ofk/LXeWONvwkMDgjc3EOG8fVZz3Z4r/EA/diDglMCc
         QuLhWkGhHKZ/9I4K+K7mAQyI5xkaQ8xRZoChF3UTRRIq6r+28RxIFlUaR0BnyHpfcWmx
         sCUKW9nB1Yz6TUj4D74JeVPtpmPtcsuTWLqrLvjyg/VYqtL5L08h3Ehh7xKs9BQtYqtf
         EKB3oBidDMpfIJ3QqH1vE97g9j1fkh8osmE/carv0fYVdpia1jHzrVKvYeMhP7bxTsbr
         DygSJskZfMY+XcDeN6Na0hgG1ZYqqN+tfov5+S87PHEe2uK4eYXCzPNImtV+vVbb3BPj
         pDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=5NvoZJM3Gs+fBasdyNd4Z2rFfR4Itw8USwXW1cmyyE8=;
        b=O6IZqcCpZVqpij2kRubLcyayDP9V1sosMwnadLXqQ/B1E9B0e1M667KUNDoK+zNPFT
         TSQXIt4rYYe+HJMMBvqESEWsl5zopWny2pgBa6k3CSKNgn4RyZT3Ni3SZAOAgL8TcOG/
         11AWwPBrcryeBXSnpvAPeqqLZbziDd0vG4hxsb817ESKg0iLztqjTou14AXp8Gt2fhxO
         cIgDXjhAWG8hC9C0E5YNnP1A0xqwmDrYtAFJrIjLM/iHms9omDZ66Y9Drq/RTJIjX4s2
         qf7SiNYIVq3rgYwgryOvwmuBo5Sj1lhHJdxobHLabYowquFfGbTaK/OztMxlAWK7GAbx
         XABg==
X-Gm-Message-State: ACgBeo2FvXn7YjCa7S502fqsA8T42u00bgdPQDnPf0lKVN+O4Mq59G2F
        hWEU71abOc6WbYnQnTMEj/h0p53G7NcrzH/mCiWx9w==
X-Google-Smtp-Source: AA6agR59uDEneVfQSSQ5O0JbL9fvFhN61r08zRzhXcVxubzSSg2ygxBcsm4TZKp55NK2SPAS2Mt4RJQd3vAi7VMUtwQ=
X-Received: by 2002:a17:907:7da0:b0:730:fe97:f899 with SMTP id
 oz32-20020a1709077da000b00730fe97f899mr17172028ejc.369.1660149930625; Wed, 10
 Aug 2022 09:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220709115837.560877-1-jose.exposito89@gmail.com>
 <20220709115837.560877-5-jose.exposito89@gmail.com> <CABVgOSmhOBdXPH_=B_WRcUjMGC-wVPTLBwCdbgZLb0o3-O8pKw@mail.gmail.com>
 <20220717170054.GA1028249@elementary> <YvPddQEptMj23HSj@phenom.ffwll.local>
In-Reply-To: <YvPddQEptMj23HSj@phenom.ffwll.local>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 10 Aug 2022 09:45:19 -0700
Message-ID: <CAGS_qxoM61S6vBBBKMQ8JMCSOuJWXXbGjQPhA_zjURy7Kwm0cA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb565()
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 9:31 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sun, Jul 17, 2022 at 07:00:54PM +0200, Jos=C3=A9 Exp=C3=B3sito wrote:
> > Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com> wrote:
> > > I already fixed the warning and added the reviewed by tags, however, =
I
> > > noticed that rebasing the series on the latest drm-misc-next show thi=
s
> > > error:
> > > [...]
> >
> > Sorry for the extra email. I forgot to mention that the error is only
> > present in UML. Running in other architectures works as expected.
> > Tested on x86_64 and PowerPC.
>
> Maybe a regression in the kunit infrastructure? Just guessing here ...
> -Daniel

As noted elsewhere on the thread, these errors means that kunit.py
can't parse the KTAP output coming from the kernel.
There shouldn't be any recent changes in either the python-side parser
or the kernel-side output logic.

So I can't think of a kunit-specific change that would trigger this.
There could be some other issue causing output mangling.

We'd want to look at what output the UML kernel produces (stored in
.kunit/test.log, or visible via kunit.py run --raw_output).

-A different Daniel
