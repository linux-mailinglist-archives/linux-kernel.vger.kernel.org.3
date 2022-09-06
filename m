Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594785AE0CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiIFHSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbiIFHSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1774359
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B13612DD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD18DC433B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662448721;
        bh=wOasH0d9vVnsQ6vVQd+RRAYmkKfASMZfn5I/64WuHBk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E4+RHbLsSEhU9eHu6jt9ZcHz9QjmVwSYc6PVN8GL3d4qvw6K/LkGVzwzrpfSxNNLL
         hjKgNiKW0HkCPk9Y1fvwpuh7EyHPzyJ5EVNxcD5YleIm1i+UgkY26G05p5RAywdIQY
         2pmi6PPvDpxUFWvXR6vJjcVEfcTDrjzp5LBYZ1u6ucAig+lsyw0u/FoBxyoOSDw29C
         tDAjJZGYehcpRB9untrnvLxIyiIv+zQFxRA/1qbpZRRSR2rcW1uXkRtK7FavdEi80/
         72bCmVK1Hi79xknulp+be9KduiajX/xbxxRqzpWL33GQmSc8w1qJcMfbCk4V88S56l
         FG4qN0gxK0POA==
Received: by mail-lj1-f170.google.com with SMTP id bn9so11295665ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 00:18:41 -0700 (PDT)
X-Gm-Message-State: ACgBeo2+etNGcyxVS8vfbWv+sSABt8DjeSALcD7oPY+6HsxhN9dfxe0i
        VqkHGrsyNQrSfnMbeh8Hv2RewP2btxViJ8VQ85w=
X-Google-Smtp-Source: AA6agR4Ww//E4nt0F61XUM0Cdm+4eMF6tutfuNx2D0Z3J/JOZ4ZSlSGerGa5kH2jQ1GS5+6ZESm28fB/WRt/9gs5Osg=
X-Received: by 2002:a2e:9115:0:b0:26a:c086:5138 with SMTP id
 m21-20020a2e9115000000b0026ac0865138mr25505ljg.189.1662448719736; Tue, 06 Sep
 2022 00:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104806.128365-1-xry111@xry111.site> <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
 <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name> <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
 <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
 <c53303bf-a5d2-098f-8975-efadbe0b2f2e@loongson.cn> <bc323d8578d2f6ec580066bab181788b305ae3c3.camel@xry111.site>
 <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com>
 <97291c0fe5a660c844475ff019c8db6af77ecf86.camel@xry111.site>
 <CAAhV-H6wzw-MV+h225rM4PfK_HY0tAdSXcUG-2Hx+_gfhzQ4_g@mail.gmail.com>
 <ae2652c5e140d407d523d7f35bee672cebe1b7a2.camel@xry111.site>
 <CAAhV-H56TQeU54JjvNQg2qZ6L1aSbzbaM2a=VQr9ZcAn4uthyg@mail.gmail.com>
 <8d0f96e2977c5c78f17bb410087f2aad986ef5a4.camel@xry111.site> <CAAhV-H7LjkY+XAzGs2K3544+CGOztCd4V8BuSjMJwZCgfBLDow@mail.gmail.com>
In-Reply-To: <CAAhV-H7LjkY+XAzGs2K3544+CGOztCd4V8BuSjMJwZCgfBLDow@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 6 Sep 2022 09:18:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE6YHCVj9DDbxLEZnS-ceZT__xe1XAcUcpXcd6eYb=UEw@mail.gmail.com>
Message-ID: <CAMj1kXE6YHCVj9DDbxLEZnS-ceZT__xe1XAcUcpXcd6eYb=UEw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Xi Ruoyao <xry111@xry111.site>, Jinyang He <hejinyang@loongson.cn>,
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

On Tue, 6 Sept 2022 at 06:43, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ruoyao,
>
> On Tue, Sep 6, 2022 at 12:27 PM Xi Ruoyao <xry111@xry111.site> wrote:
> >
> > On Tue, 2022-09-06 at 09:52 +0800, Huacai Chen wrote:
> > > >   cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > > -                                  -fpic
> > > > +                                  -fpie
> > > >
> > > >   cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > > >
> > > > (Some explanation: -fpic does not only mean "generate position-
> > > > independent code", but "generate position-independent code *suitable for
> > > > use in a shared library*".  On LoongArch -mdirect-extern-access cannot
> > > > work for a shared library so the "-fpic -mdirect-extern-access"
> > > > combination is rejected deliberately.)
> > > >
> > > > Not sure how to submit these changes properly...  Do you prefer me to
> > > > send V8 of this series or a single patch on top of your tree on GitHub?
> >
> > > Don't need V8, I will squash it into the previous patch myself. But
> > > can we keep efistub as is?
> >
> > No, we can't allow -mdirect-extern-access -fpic on LoongArch because
> > without copy relocation such a combination just does not make sense (i.
> > e. we cannot find a sensible way to handle such a combination in GCC).
> > So such a combination will cause GCC refuse to run.
> >
> > Note that -fpic/-fPIC is "position-independent code *suitable for
> > use in a shared library*", while -fpie/-fPIE is more like just
> > "position-independent code".  The names of those options are confusing.
> > (When -fpic was invented first time, people mostly believed "PIC had
> > been only for shared libraries", so it's named -fpic instead of -shlib
> > or something.)  IMO in the EFI stub for other ports, -fpie should be
> > used instead of -fpic as well because the EFI stub is not similar to a
> > shared library in any means.
> You are right, but I guess that Ard doesn't want to squash the efistub
> change into the LoongArch efistub support patch. :)
>

I don't mind changing the stable tag at this point - I don't have
anything queued up on top of it at the moment.

But I don't see the actual patch: please send me the delta patch that
you want to apply, and I will update it. Then, you can rebase your
v6.1 tree on top of it.
