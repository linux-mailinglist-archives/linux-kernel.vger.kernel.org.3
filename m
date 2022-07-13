Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08D573303
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiGMJji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiGMJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:39:36 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC10F54E9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:39:36 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c9b70c382so106695947b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/bZLQ21BnbCxpHA4zoKoOFFh9G3ZriCKWCB4lTGRTU=;
        b=ZO6UB9xl2PomzSnA9P0ERrfsb+F0CnXxcbeTNjkLpFEo+2za3/xXWGbmqKTihGXER4
         mUgRTu0USH+xA3FoCVjWLUFkdgJyDitP/5IlrEykEULV55mtPO57VI6rmC/VX416o04i
         kwQ2YtAApJmvL4GOZ2EoIzNaIBDWwqYuzIng2KRohWNuuIVHdS8JipjKP99t92jluQsC
         SISG6PGesDj5oYOmbT0cXN8DLCLKvFQyDUy4LXMu77z2q11E2r0MZC87PvFMpE1f/3gy
         HcQxarJCB6amUiC0bsTHYF7BFZRv9dnUrP+YMZZZOKyEzJfLzJ57y79Rrry3IR8It8sz
         VUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/bZLQ21BnbCxpHA4zoKoOFFh9G3ZriCKWCB4lTGRTU=;
        b=iZAPOrK1QPZTm0N9NfBeVLdV8dbDG1SflV3EQk66NlLJS0vhWSsffFWjFIgmklPGaC
         KSs4j9xMgmvah15k/aRbv6K9knlAHr5TBOYsnmgafLQtMPgH7OxuM3qwCAlnkW3rjtS9
         mDK8VUlBU2vEuZNs/pcgjwH469Lkmj/gxlgCMnbuErnAaDt6aZbeRedJTp0J3ucUmePj
         petS888Rj/0QKhAobZyggrDUutbs7Q0CyiO5HCkSuuRN609d4TB2fNdc69fXBTzwcpyO
         NlurnBhI+9L0D8F/tYOGZr+I7Dj38Bk3EwvbBsupINSZJGgNaHw8NQowcuvYyzkwmPjf
         56rg==
X-Gm-Message-State: AJIora/aBnrdI1EewK181aS9nBopw6WyI85X0fE6cUGSX94FPuL/ykgf
        TY9CBzU91GcpGqNjp1DZyD8ZMPqWbXJa0zNSlSM=
X-Google-Smtp-Source: AGRyM1uNbxKaJof5c0AAkDGC552d0gWxId5xZzgbfSrWHBy/aP1poMmgkbYdzJkcBPwCKqdNXqAArZSaWfKIFxdFASo=
X-Received: by 2002:a81:4986:0:b0:31d:388b:d08d with SMTP id
 w128-20020a814986000000b0031d388bd08dmr3002440ywa.185.1657705175260; Wed, 13
 Jul 2022 02:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
 <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
 <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com> <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com> <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com> <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
 <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com> <17c91bfb3a864ae1be2ac3226f170f55@AcuMS.aculab.com>
In-Reply-To: <17c91bfb3a864ae1be2ac3226f170f55@AcuMS.aculab.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 11:38:58 +0200
Message-ID: <CAHp75VdOq5-2h_ojRaGKs1sJqM-wsYtv4543FeBW4_eH4+gMVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
To:     David Laight <David.Laight@aculab.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "amadeuszx.slawinski@linux.intel.com" 
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:14 AM David Laight <David.Laight@aculab.com> wrote:
>
> >          if (pint)
> > -               *pint = value;
> > +               memcpy(pint, &value, min(nsize, sizeof(value)));
>
> That is just soooooo broken.

OK.


-- 
With Best Regards,
Andy Shevchenko
