Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1B54D19A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346606AbiFOT3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346151AbiFOT3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:29:05 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A415353C67;
        Wed, 15 Jun 2022 12:29:04 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1016409cf0bso6672996fac.12;
        Wed, 15 Jun 2022 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y4NhrC9ap1cWsoDMhoc9arNxoObzeSf6cpbEcoKtqOY=;
        b=B/P70sGpq6xUOe94W78uBcFHRfunszNgH2mj+2oSKF0RN2ETvCjk9qWg0+MBR1dD7z
         HDlN0nI0BAlnrbqt0yrF6OD5MP0cjwu0t5C17naQiodA9+aVXlZLXBm9LmD4XvgFme06
         NKi+mNb1yZ0AKl7PmFo989PYS4uLU1dSDTr5a9CxvcpoOKqWNbmqWw0NwhK9oH3MTTJs
         sbj/6Lv652bL7DVtJjlPZBRnvk3aRLF/DFUIodXdRdEdTC6Qr7UnZYCReGbJP6ka7nvi
         vmPC1NEw/S/tMwl+uincKChUGO6fRGdDzFvdk5Rmwq4P/62MmPWMB/0sZBDO+GtUHqBe
         yYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y4NhrC9ap1cWsoDMhoc9arNxoObzeSf6cpbEcoKtqOY=;
        b=K2FWr/HkvND7zTJpFtMe1LZevI58TSRo0eZ2HLh01sSJe+0k6jA0OGwXXCxX6/QPq/
         VLFDK7En3S94eEY76TRj1PnLrarSbGxKufZNyEiEPS/eTjB/ar/cRpUD4DmA3Q0yqD+D
         Unkkrd1TNgoj/vjVAsUn9PwdaxbQLXM0hOnosS+pHxVv4iKRkhbobXwdsEpki8s2DEsL
         UT94KxLyNLqROYtfgv3KO8RQABkyUtY+0zJgYLBXC7gw3eiCVdy/ShyRA/avkqs4cwMo
         nkahbYV34QsxGS8CpF9cILaghtLcdK9fl4VHihXCE0FgaEM5qMYuVvxjyBayHnK+5Diy
         j4RA==
X-Gm-Message-State: AJIora8yEtiEHg0AXPfXATpddxf2rvLIdayrFGjxgIOxZVP/Yy+gQi4i
        SxGHYELQCR7SGYqQMlYuMI5qYlbQMcLGk9UW4oTct/tLz4c=
X-Google-Smtp-Source: AGRyM1sh5C6I86k34hmYg98ITPYaf2PCUY3hNVmQHMGJbMzCs6kHfAYa838vIEBejr/TrpvyKV6eZFFbyFvDSQFyMUs=
X-Received: by 2002:a05:6870:538b:b0:101:17f2:d6e with SMTP id
 h11-20020a056870538b00b0010117f20d6emr6296051oan.200.1655321343622; Wed, 15
 Jun 2022 12:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220615160116.528c324b@canb.auug.org.au> <d1a48a84-6d07-e8f7-5fd8-d24a7a1cf187@infradead.org>
In-Reply-To: <d1a48a84-6d07-e8f7-5fd8-d24a7a1cf187@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 15 Jun 2022 15:28:52 -0400
Message-ID: <CADnq5_N6gfaPfZJAX4+poWFFruxNdFKZqzXZXosj1A55e-O1mA@mail.gmail.com>
Subject: Re: linux-next: Tree for Jun 15 (drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 3:01 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 6/14/22 23:01, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20220614:
> >
>
> on i386:
> # CONFIG_DEBUG_FS is not set
>
>
> ../drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In functi=
on =E2=80=98amdgpu_dm_crtc_late_register=E2=80=99:
> ../drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6599:2: er=
ror: implicit declaration of function =E2=80=98crtc_debugfs_init=E2=80=99; =
did you mean =E2=80=98amdgpu_debugfs_init=E2=80=99? [-Werror=3Dimplicit-fun=
ction-declaration]
>   crtc_debugfs_init(crtc);
>   ^~~~~~~~~~~~~~~~~
>   amdgpu_debugfs_init
>
>
> Full randconfig file is attached.

I tried building with your config and I can't repro this.  As Harry
noted, that function and the whole secure display feature depend on
debugfs.  It should never be built without CONFIG_DEBUG_FS.  See
drivers/gpu/drm/amd/display/Kconfig:

> config DRM_AMD_SECURE_DISPLAY
>         bool "Enable secure display support"
>         default n
>         depends on DEBUG_FS
>         depends on DRM_AMD_DC_DCN
>         help
>             Choose this option if you want to
>             support secure display
>
>             This option enables the calculation
>             of crc of specific region via debugfs.
>             Cooperate with specific DMCU FW.

amdgpu_dm_crtc_late_register is guarded by
CONIG_DRM_AMD_SECURE_DISPLAY.  It's not clear to me how we could hit
this.

Alex


>
> --
> ~Randy
