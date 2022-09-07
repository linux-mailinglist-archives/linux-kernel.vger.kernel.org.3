Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAC95B0DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIGUIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIGUIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:08:07 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F4C7C198;
        Wed,  7 Sep 2022 13:08:05 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id t184so23238763yba.4;
        Wed, 07 Sep 2022 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=76Ee32nm+xTMs5kfzOUpRMin+LosPvvaUUyBZQVbfSI=;
        b=LVnDj6WocuThO0kgaYyOzA45PKsY6OTWEl6n0gZBNQdgMRJt9CrelX7gVqXLWMB1Zu
         4aeGdqeiNeV499Ja5nTWEKls8edO/cXhuisCzNXaMGNaLLiQ7A5s7A+h59bQqyxHALPo
         3cKkijg/UawHMRKRHsso7ergQwKkPnj1O/T5xn894n2CqfKAAxL1V/eYk6nOKe+wcawM
         esN+VJICP4LxoVGd1pccpIUnB9smEpXDDbO2VpRAu6WqsC6E49Iya9Hle5yaV8G2uF94
         5peLBwlhkRXDy+pRh6qMCvw73W9dNX5OU704kWu32CXGKuUZQLrLr0qIqIjGLV+a4d0J
         KRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=76Ee32nm+xTMs5kfzOUpRMin+LosPvvaUUyBZQVbfSI=;
        b=Z1PCH/lbeYOnLeLegm8qkBEOLR3GvdK+VaQSN554V4sQf2X0jBa6MdjxhkPGSUiaCr
         XI5rLpt6K987WQFdsRO1Ko+YQHx+bVlAUvjzALd8QTiCXHCgZaWohHrbBX2u/J3+Wi9X
         /npdaarMmbDesH6/l3i2sgMZKQchcbLxn04zh15/YmxiqLzS1IhZ1QEa+qRUIL7msjXl
         zMwrvSxwXl5dFVLzV16DoBOksMC6IYRK10XcfTXk71qdPagUJgR6305iblAthTrmKUTG
         +BltEb3b6r0/2mSj5IeVPCQjaOK8u5mPIiWnVgZ6rg9Sk/XmfJgsOFDnAUT1bBeMR7yB
         s/ag==
X-Gm-Message-State: ACgBeo1FizXybzgG7GwqVmODYHdnLRoob2q8D6w1qpu6k97iAz3V1pqx
        2pfnW5o3g/TpdNhfXW3zeIJrf8jBlOFQLGZabS4=
X-Google-Smtp-Source: AA6agR6eJ2EnWBxsJPHnPXzCDJVQr335pc3iUxnXF3GY7dsWOsxaB0TzMgpZOWbjWc7t58kVq8o/XEKfD/KtEzbGroE=
X-Received: by 2002:a05:6902:38a:b0:670:aa12:8908 with SMTP id
 f10-20020a056902038a00b00670aa128908mr4255200ybs.446.1662581284544; Wed, 07
 Sep 2022 13:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <YxducgSzR6/zyHD7@debian> <CADVatmNfc1YT02v5-FaMoGN==MOx5ZJ=o8YMQAH19Gvf91betA@mail.gmail.com>
 <20220907170451.efhz62nkxybqxtaa@mail.igalia.com> <CADVatmNodAV4PB5jjARnowu=VGbgMWgBYDWPuwJe-f1WFaS8ow@mail.gmail.com>
 <20220907192250.jfkpwaq54f2h7stf@mail.igalia.com>
In-Reply-To: <20220907192250.jfkpwaq54f2h7stf@mail.igalia.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 7 Sep 2022 21:07:28 +0100
Message-ID: <CADVatmN2u4RB2tamaJ8qc+Vj3A4Lk9py-4fVVMNOBxz07Zjv-g@mail.gmail.com>
Subject: Re: build failure of next-20220906 due to 396369d67549 ("drm: vkms:
 Add support to the RGB565 format")
To:     Melissa Wen <mwen@igalia.com>
Cc:     Igor Torrente <igormtorrente@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-next <linux-next@vger.kernel.org>
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

On Wed, Sep 7, 2022 at 8:23 PM Melissa Wen <mwen@igalia.com> wrote:
>
> On 09/07, Sudip Mukherjee wrote:
> > Hi Melissa,
> >
> > On Wed, Sep 7, 2022 at 6:05 PM Melissa Wen <mwen@igalia.com> wrote:
> > >
> > > On 09/06, Sudip Mukherjee wrote:
> > > > On Tue, Sep 6, 2022 at 4:59 PM Sudip Mukherjee (Codethink)
> > > > <sudipm.mukherjee@gmail.com> wrote:
> > > > >
> > > > > Hi All,
> > > > >
> > > > > The builds of next-20220906 fails for mips, xtensa and arm allmodconfig.
> > > > >
> > > > > The errors in mips and xtensa are:
> > > > >
> > > > > ERROR: modpost: "__divdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > > > ERROR: modpost: "__udivdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > > >
> > > > > The error in arm is:
> > > > >
> > > > > ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > > > ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > > >
> > > > >
> > > > > Trying to do a git bisect to find out the offending commit.
> > > >
> > > > git bisect points to 396369d67549 ("drm: vkms: Add support to the
> > > > RGB565 format")
> > >
> > > Hi Sudip,
> > >
> > > Thanks for pointing out this issue.
> > >
> > > I think we can replace the macros that are triggering those compilation
> > > error by functions in drm/drm_fixed.h that do the same calculation.
> > >
> > > I checked those errors when building for arm and i386 and the issues are
> > > fixed after applying the patch below. I appreciate if you can test.
> >
> > Sorry, could not test as the downloaded mbox is saying patch is
> > corrupted and could not be applied. Can you please attach the patch or
> > maybe send using git send-email.
>
> Sorry, my bad. It's attached. Let me know if goes smoothly.

Thanks. That was perfect.
And with that I can confirm I don't see the failure on mips and arm.
Not tested on xtensa but should be fixed there also.

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip
