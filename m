Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D78553522
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352139AbiFUPCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352134AbiFUPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:02:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6827FDA;
        Tue, 21 Jun 2022 08:02:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ay16so8747589ejb.6;
        Tue, 21 Jun 2022 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WoX9840c/J6/KgjfO31tkicZj6v+jhfxjr/FKmSKn8I=;
        b=L08S3+YgOTeNh4o+dXImz1JlqFOMbO59nYkXYU12iBPMeyv+fNQV2EXgPG+Pbqnd7W
         VpV5albOuCbIQrG/OF9JD4vfKw4jWZ7IbQva5VlYk94v6MwZiDjZ1SSDsb6HjR+jNsux
         8yxlridj+PpyCnRQ3bdCKI2NDX64n2cZtVQA9BehzZ8rERK6j4ymFCVpMZJbT+Dgj97r
         uu4dYeypPAL76ohWzuLNJ3+/YAK9B5hq2+6ryDusDw0Hg+b1c/D1Q4xhjQUmPzIpIBcd
         Otcn4BJCsHHZ5y3NcB3PSS47tQi+U5wwgCVIthFGl/RqoppEEJaAqbjUK+6NhxFQOv3F
         uA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WoX9840c/J6/KgjfO31tkicZj6v+jhfxjr/FKmSKn8I=;
        b=BIwu+snnSR+S8Eq99hWzL2NqtPyZ761s1tG4XR+fDX0jYPNr11P5xhe2BOgQckZpHn
         cSfu8IahlwcXdwlgQ+U+XVPi2XyZ0Qgm9UOtpSkA+Oas5/dDZSIJifBllalM70xaIriP
         c56fZcC267J2oaUts3jFrvKX2MGJgmMk1mgJ1UEQZSXsF0zP1xKXpHh4mT8dNl9eC59H
         43jbMErZUObnV4pg2pEXu9Yth3oN2fprbkX7FqWmr2bpR15riSYxzywH5VgQ2ypdQplg
         RQlcdbU1dqGtuhxkcdHd/gd0tMZmE9wi+UanYkT82GuNPKoXJEG9wz/JlFl02u8PWg5T
         q8YQ==
X-Gm-Message-State: AJIora+GU5JzC2rTcqzDSdNIWy33WOZmE66vx+haa+dvGRgZ78X4d7+Q
        oubqNLZYHgF3Yx093NOIuckYR2JhdIkjS59V+0U=
X-Google-Smtp-Source: AGRyM1tnpbw7SrZDVUpUILVDpTXh1SUaCjWLTysEACqIxzAcgmzCFEqyrA+yjXPOvw6WCVg4dmKH7T8nHTJtYdPUE28=
X-Received: by 2002:a17:906:c041:b0:718:c984:d9ee with SMTP id
 bm1-20020a170906c04100b00718c984d9eemr27768100ejb.722.1655823763016; Tue, 21
 Jun 2022 08:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220603144315.5adcddbf@canb.auug.org.au> <20220615150013.30c9d7ad@canb.auug.org.au>
 <20220621181551.5eb294f5@canb.auug.org.au>
In-Reply-To: <20220621181551.5eb294f5@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 21 Jun 2022 11:02:30 -0400
Message-ID: <CADnq5_OxNm9EwLDXishu+pMfT2mgOSTvkmgSm+cm98JiCsiJog@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
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

On Tue, Jun 21, 2022 at 4:15 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Wed, 15 Jun 2022 15:00:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Fri, 3 Jun 2022 14:43:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > After merging the amdgpu tree, today's linux-next build (powerpc
> > > allyesconfig) failed like this:
> > >
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3835:1: error: the frame size of 2752 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> > >  3835 | } // ModeSupportAndSystemConfigurationFull
> > >       | ^
> > > cc1: all warnings being treated as errors
> >
> > I am still getting the above failure.
>
> I am still getting the above failure ... it has now been 19 days :-(

Is it still the same error or something else?  I thought this was
fixed in this patch:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/d6aa8424bcac64b2608452589c9a09984251c01c

Alex

>
> --
> Cheers,
> Stephen Rothwell
