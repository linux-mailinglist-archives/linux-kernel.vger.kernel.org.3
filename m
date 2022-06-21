Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF5D552FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiFUKW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFUKWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:22:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38242899F;
        Tue, 21 Jun 2022 03:22:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g4so18206620wrh.11;
        Tue, 21 Jun 2022 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFKOWnxfMAvpfuR5nZvfo/PJZQyBNJd8pSCg3peeMzU=;
        b=PS1CvUmfj+YgU/b5s3RHKMSGeq25FnBJ908QsNFw9En7udzmO5KWpI87Fxrz7cBCP2
         M2b9eOiapgceBX3JBUOGXwsuO368zVhC/SL8YP/Op3i6NFfG1zDNg/KwAHfdkbJmI2lb
         O+ogXD9IU1W5rytIxgWHMlX/2SofhA841OyaEHNBnT2edKBa9lD5y45EXkzgmoOu7YYQ
         PvBlHX+7wd63wZAmEW021ZnD8kGY2023HmEU9Yr4wF58bJsOGCCw+v7sV8JCZWq1y6WD
         5VT3LCPDRZ1Np+Dy8RyNwiTdDogQ+c7VvDkGUrqtUuJEwv1zdV3FmofzDfOUD9BUnNNX
         7K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFKOWnxfMAvpfuR5nZvfo/PJZQyBNJd8pSCg3peeMzU=;
        b=NFuh6s89PwucEuKCVjuhWx06tW8JJ+On9dQxo0l433T1jQsZgC4uWWKYwITxf1ZXzl
         ETX85mualIgunL6Udk+DOE4I279YbpiCeI8H6AeefWo48WNmwgacFZbY4erp1gy1XkzK
         t81XfoHzTQ5+qJPwuXhMrr8y5uytXJmH1J3kj6GTAZlS/9LpdXhk/Y8rMur+yQJVj5Fh
         P3c7e816JBRC9JgGa3AcCq3I08fyytOl5rJVfs0jIoUfr5UQfHTSEmKqWycryqRSvFIm
         YPLbe2CkFjoV7L3F9LveS6vsIPY7BYZpqLPNC5si7+acaqj8VELwApkTt9D6oh7OWgqF
         CTJA==
X-Gm-Message-State: AJIora8cVlaD80yc6Dmgf7vtLeHqMe8hVbT4k7NoKK4tXnjbR4TG4tel
        Q07Mm2ueGAo7Frifqgho1DDa2SOZnNX9phZJSZFasHaLgig=
X-Google-Smtp-Source: AGRyM1uvf4LHU1HU49uZEE55Xvve6Ulm83LVZnbey7RZpGVfRK8TyarjNw9QuE1f9s0fM3kEJoVkyDixZGpKfisVAJQ=
X-Received: by 2002:adf:e0c3:0:b0:21a:39f3:e6f6 with SMTP id
 m3-20020adfe0c3000000b0021a39f3e6f6mr23433295wri.98.1655806941204; Tue, 21
 Jun 2022 03:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZm_C=o-rc4a+u_8-pFJtmL_2drwczASMRTqszamrks5Zm_OA@mail.gmail.com>
 <CAG48ez2PVMs-CeLoZtvPq2EeQqOg05mm3AuvEE_pr9Sog0O5og@mail.gmail.com>
 <CAMZm_CmW7pHwfEfCQfXRJPiHOjeGviQunfwxY_1ejrihKab5rA@mail.gmail.com> <CAG48ez2OcfTQ4SRbY89uHDJG6QujSfChaO4B3=zgGpj=9J8bdA@mail.gmail.com>
In-Reply-To: <CAG48ez2OcfTQ4SRbY89uHDJG6QujSfChaO4B3=zgGpj=9J8bdA@mail.gmail.com>
From:   Federico Di Pierro <nierro92@gmail.com>
Date:   Tue, 21 Jun 2022 12:22:10 +0200
Message-ID: <CAMZm_C=5sNVxB6vE83zcrhv+b0JhYT9hL8i4o_6rwRuwm_ggVg@mail.gmail.com>
Subject: Re: pgprot_encrypted macro is broken
To:     Jann Horn <jannh@google.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Thank you very much for your hints and for your time!
I solved the issue and I agree that we should not have used that macro
in the first place.

Again, thank you very much for your help,
Regards
Federico

Il giorno lun 20 giu 2022 alle ore 13:32 Jann Horn <jannh@google.com>
ha scritto:
>
> On Mon, Jun 20, 2022 at 9:39 AM Federico Di Pierro <nierro92@gmail.com> wrote:
> > > Why does your driver need to use that macro? pgprot_encrypted() is
> > > mostly only directly used by core kernel code, not by drivers... and
> > > if memory encryption is enabled, almost all memory mappings created by
> > > the kernel should be marked as encrypted automatically.
> >
> > This is interesting; i don't really know the history behind our piece
> > of code; as far as i understand,
> > we have a shared ring buffer with userspace, onto which we push tracing events,
> > and we must mark it as encrypted when
> > the kmod runs on an AMD SME enabled kernel to allow userspace to grab sane data.
> >
> > This is the commit that introduced the change (if you wish to give it a look):
> > https://github.com/falcosecurity/libs/commit/0333501cf429c045c61aaf5909812156f090786e
> >
> > Do you see any workaround not involving `pgprot_encrypted` ?
>
> If you do have to use remap_pfn_range() to map normal kernel memory,
> then you might want to use vma->vm_page_prot instead, like a few other
> places in the kernel do.
>
> (Alternatively you might want to use remap_vmalloc_range() to map
> vmalloc pages into userspace, but note that that has very different
> semantics - I believe that installs a normal page reference rather
> than a raw PFN reference, so that would permit get_user_pages() calls
> on the range.)
