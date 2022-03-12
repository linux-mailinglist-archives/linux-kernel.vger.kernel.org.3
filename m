Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3364D6FEF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiCLQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 11:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiCLQCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 11:02:51 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C05340A27;
        Sat, 12 Mar 2022 08:01:46 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id h126so22737872ybc.1;
        Sat, 12 Mar 2022 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44lnphS+Jc2ofnB5ToOWXva8vzn4mU0qO5/nu90TMoM=;
        b=hlmMXZqU7JAWCp6pen2phIq+CLrWpquN9uGoFul+Hr83pr/FBc+j+l+EvBPqZltp77
         VYZuNWDFbMdl2VKSmV5WioiflCyv0WgRVS7f+ccO+LeBekDy3SVgZ6nLPImM2wlRWU5L
         gagvRd1Km5rrWZ4UtuaqcEto3sw6I5F8JKZkkzvSCfKYI9Jgj6X7jHgKtomc7Aeqb2U5
         TkgN5QM1IWYe9DV7c4Y0Bon2UgOGvF6mtRVQ2qoRIAEDe8QDPQR7eu1yFLrffG6tySSq
         9fl74w19uz7xjBGLIEqjSui1M7lk1ivGlhf4Ibofd6OGXUqTHbnQwKBjmOn13RhKv/BW
         KOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44lnphS+Jc2ofnB5ToOWXva8vzn4mU0qO5/nu90TMoM=;
        b=cbrRu9f70Bx+q2NICs8+cwPo8+kCFX1O1dbr1jBrJtAq6XAaoiTaOkHjeczujoLZYw
         w22alk0Q6jpPaKabXLiyFrF3l96cCGh1/TbG7vTniy3HpOgbnmAt2Rh2JjpIcGTU1DOK
         oIp5sgvmcsUfncLzNFJkh2z7MzjLO/SL5H8m1tflo6/bTTX6xUVHiDCgHhauQ8r8mFdR
         2VAhZXIOYv72OlR3k/hG4ZEPBApr5cWLgBqXnd723yXIAiygYP0f+65Z7L4pLzWDNY0y
         X9xunNB049zf4vZ8yoF2TBSBDuEC/wy/J6AXjkvLMIw/ZCtF6/XLCW7kCSLn43o4GKxS
         WlOg==
X-Gm-Message-State: AOAM533OdI1R6jlvQ1IfgwOCvBowCcC1XU+ajPza8vr64uSyrfGzQ0WJ
        LtUZsrklvpJ7QYPRrKo/+s79ptw6gYCgUR9aBC0=
X-Google-Smtp-Source: ABdhPJxEFPGviLAZC/0rSd6kbp36qK4avv4V8y9MHYHQgiquiyuubxQexogd2aSONEQKGEV1gVKrV34l4eUCsiepKXI=
X-Received: by 2002:a25:8b:0:b0:628:9774:d6f4 with SMTP id 133-20020a25008b000000b006289774d6f4mr11869806yba.545.1647100905563;
 Sat, 12 Mar 2022 08:01:45 -0800 (PST)
MIME-Version: 1.0
References: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn>
 <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
 <CAKFNMokdB+Zph-1OyC1-Xnyi93r+yKSusgaEaa=CkuUBttwRZA@mail.gmail.com>
 <CAD-N9QU8-Od3G+-=RHM5K7vR2-4Af+4t=XutJJVdmkKhH7OarA@mail.gmail.com>
 <CAKFNMo=E8mMuY7Et0auH02fOzGKx04k2=LOj8mZJ6a-=J+sPzQ@mail.gmail.com>
 <CAD-N9QWt=d2Vj2bevSzOPL4AWF08_zTyq=hHOcOOROCazNY4_A@mail.gmail.com>
 <CAD-N9QWrBLygN24EC6QLRFF6uf7=PiTRdA4suKqEXJ7tk9aocA@mail.gmail.com>
 <dac7104a-21ac-24f4-6132-e51960fa0b7e@gmail.com> <CAKFNMon3=fFWtuUa1_wDyK9agpCXjbzA8b+rj=OYu=7Gs8nMqQ@mail.gmail.com>
 <7da316f4-aa65-896e-9020-2dfff2bbfc09@gmail.com>
In-Reply-To: <7da316f4-aa65-896e-9020-2dfff2bbfc09@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 13 Mar 2022 01:01:33 +0900
Message-ID: <CAKFNMon7cdJ092Ppne_kU6A23pRUb+1tThCkoB2vn0HN-rWUUg@mail.gmail.com>
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
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

Hi Pavel and Dongliang,

On Sun, Mar 13, 2022 at 12:16 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Hi Ryusuke,
>
> On 3/12/22 18:11, Ryusuke Konishi wrote:
> >> In case of nilfs_attach_log_writer() error code jumps to
> >> failed_checkpoint label and calls destroy_nilfs() which should call
> >> nilfs_sysfs_delete_device_group().
> >
> > nilfs_sysfs_delete_device_group() is called in destroy_nilfs()
> > if nilfs->ns_flags has THE_NILFS_INIT flag -- nilfs_init() inline
> > function tests this flag.
> >
> > The flag is set after init_nilfs() succeeded at the beginning of
> > nilfs_fill_super() because the set_nilfs_init() inline in init_nilfs() sets it.
> >
> > So,  nilfs_sysfs_delete_group() seems to be called in case of
> > the above failure.   Am I missing something?
> >
>
> Yeah, that's what I mean :) I can't see how reported issue is possible
> with current code.
>
>
> Sorry for not being clear

Understood, thanks for the reply.

If so,  the case where nilfs_sysfs_create_device_group() itself failed,
is suspicious as mentioned in the previous mail.   A possible scenario
I guess is :

- nilfs_sysfs_create_device_group() on the first mount try fails and leaks
  due to lack of kobject_del() in the error path.
- Then, nilfs_sysfs_create_device_group() on the next mount try hits
  the leak detector at kobject_init_and_add().

So, if the leak bug is reproducible, I'd like to ask Dongliang to
test the effect of the first patch.

Regards,
Ryusuke Konishi

>
>
>
> With regards,
> Pavel Skripkin
