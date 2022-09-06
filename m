Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163E15ADEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiIFEny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 00:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiIFEnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:43:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3659965544
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 21:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8EEEFCE0A0C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC1AC43140
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662439426;
        bh=7TjMi3dv4P+rRVTd8H7v8fPFr0supL/24PBj+1I7I9w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mCbCXwVq8PHAqEhWIP6ZFLri2XK5qsy7UFTua2m6x4OUpu1VLX+GtqJ9BgJ4pSra8
         fc7CgFSbwOrgzgoyKt1vSDc8+HbzTu5TyVDe2Dwly4uNjoHvTRHNNWXh2JzY3uqyN1
         hs930Z7wQ3T/J4z3bUdr2xIsFQQFZjGsverBNNIZ8EQOmKhEWs3TvVeUGs/DxkMEuX
         VB7JROZHpO7Fb02ysbVrVVcMuG1794iCX+V9JYaUCR8rZ5eoPe4K5v3dHtXzsvcnwR
         ElKqKFOUBmebjITRKINIyIX0keocU1I8Fzb9cnOXDwOZ2yx3/aRBwxlJewLZl+Cs3N
         1blTwqbrteT9A==
Received: by mail-vs1-f48.google.com with SMTP id a129so369813vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 21:43:46 -0700 (PDT)
X-Gm-Message-State: ACgBeo2lNYZ7N5G5DqNG31pHWQ5JePINxPHZh926s+r6Q59CYeBCHEzC
        apCKPnGXmhWAm+Q+aKiFPn9DSRdENQHZDtcHSb8=
X-Google-Smtp-Source: AA6agR6Kr7+uYVHAsYYqongz0QSxrPwjX1ypWs90w3dRCTH5JPTvX43l3dGfpFOXcIM1BNcr49ICcCq7yigmUTonaCQ=
X-Received: by 2002:a67:d49e:0:b0:390:dccf:23c8 with SMTP id
 g30-20020a67d49e000000b00390dccf23c8mr13262980vsj.59.1662439425056; Mon, 05
 Sep 2022 21:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104806.128365-1-xry111@xry111.site> <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
 <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name> <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
 <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
 <c53303bf-a5d2-098f-8975-efadbe0b2f2e@loongson.cn> <bc323d8578d2f6ec580066bab181788b305ae3c3.camel@xry111.site>
 <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com>
 <97291c0fe5a660c844475ff019c8db6af77ecf86.camel@xry111.site>
 <CAAhV-H6wzw-MV+h225rM4PfK_HY0tAdSXcUG-2Hx+_gfhzQ4_g@mail.gmail.com>
 <ae2652c5e140d407d523d7f35bee672cebe1b7a2.camel@xry111.site>
 <CAAhV-H56TQeU54JjvNQg2qZ6L1aSbzbaM2a=VQr9ZcAn4uthyg@mail.gmail.com> <8d0f96e2977c5c78f17bb410087f2aad986ef5a4.camel@xry111.site>
In-Reply-To: <8d0f96e2977c5c78f17bb410087f2aad986ef5a4.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 6 Sep 2022 12:43:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7LjkY+XAzGs2K3544+CGOztCd4V8BuSjMJwZCgfBLDow@mail.gmail.com>
Message-ID: <CAAhV-H7LjkY+XAzGs2K3544+CGOztCd4V8BuSjMJwZCgfBLDow@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
To:     Xi Ruoyao <xry111@xry111.site>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Tue, Sep 6, 2022 at 12:27 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Tue, 2022-09-06 at 09:52 +0800, Huacai Chen wrote:
> > >   cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > -                                  -fpic
> > > +                                  -fpie
> > >
> > >   cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > >
> > > (Some explanation: -fpic does not only mean "generate position-
> > > independent code", but "generate position-independent code *suitable for
> > > use in a shared library*".  On LoongArch -mdirect-extern-access cannot
> > > work for a shared library so the "-fpic -mdirect-extern-access"
> > > combination is rejected deliberately.)
> > >
> > > Not sure how to submit these changes properly...  Do you prefer me to
> > > send V8 of this series or a single patch on top of your tree on GitHub?
>
> > Don't need V8, I will squash it into the previous patch myself. But
> > can we keep efistub as is?
>
> No, we can't allow -mdirect-extern-access -fpic on LoongArch because
> without copy relocation such a combination just does not make sense (i.
> e. we cannot find a sensible way to handle such a combination in GCC).
> So such a combination will cause GCC refuse to run.
>
> Note that -fpic/-fPIC is "position-independent code *suitable for
> use in a shared library*", while -fpie/-fPIE is more like just
> "position-independent code".  The names of those options are confusing.
> (When -fpic was invented first time, people mostly believed "PIC had
> been only for shared libraries", so it's named -fpic instead of -shlib
> or something.)  IMO in the EFI stub for other ports, -fpie should be
> used instead of -fpic as well because the EFI stub is not similar to a
> shared library in any means.
You are right, but I guess that Ard doesn't want to squash the efistub
change into the LoongArch efistub support patch. :)

Huacai
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>
