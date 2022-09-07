Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89105B0C89
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIGSfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIGSfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:35:22 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567764D813;
        Wed,  7 Sep 2022 11:35:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 130so17303957ybz.9;
        Wed, 07 Sep 2022 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=STJNUAoDz8/H7GZWo2JC/f9FzlPrG+LEjtWrEMBbtXs=;
        b=RskBKCOfeFOaMxC6KYoO1H6x+3b5BOgf0WTEukFan66nkQS9frqNBSpq46LtZuBCV4
         dK6cNYLtIkbozPkYsjq8blAENOPmRaaWV1SVHk42judEYe6ZQmXQ9be56/fLxl2OmPfu
         Aw6ca/tM3cGUYfGTctoPHZPqSdeUk5A5+Tncgs8cYb4YDrjXgcvOjoUZkJQA4GQ30Vwl
         x9Hw2iBs7sgIuHdBr15dVtqthnyn+QXuLBjumdG04Bj5vHWQrEfvMKGhbU6tuhTdBoE+
         JOkxbtqalDnWAmyT3CvJzX0EonTumQpI5lnWbBKiqhO5s6W5QwxLtTwGyp5LiIaodCCa
         GeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=STJNUAoDz8/H7GZWo2JC/f9FzlPrG+LEjtWrEMBbtXs=;
        b=s8C77o8IaCzMTPtdX3aTg1YyVLRXf5nLcuTSguk9HL7VqJ5qMzmGxGWAxenT6kaSjA
         7dy8HEcMwvyp6+95yO6Q8zQ6paZPJpWvYRS0mofK1QupHuu1A6//GCckQeMf16AmHC41
         Iuh5//EkpZEAigtgAaG0sf1p40GmkTPQkUrvIUd+B3EKO8b7zvW5izsPw5vgYQBXzzXm
         u3RcvM/+UdeMRlWq/vIvgFqpB+/cqQDATHuDMZCJH/32vpCH7GJ3GbvcpZNVdQ0Bt6EU
         sQHYQQb+lWASSIdmv0dQBnw82y5VKnDpy0zhTlSZPZa8SxugySCpPpAWayt1or3RpSHU
         lwug==
X-Gm-Message-State: ACgBeo3oomlBJKxEzqgvZFjj7aKqPNi5Wfvr/WzOk5yCTYr96DLxBbZf
        R7FiA8bRSM2aleR4A+q4w4gy++2Q+CjGTMV65c1aCC/ZXT4=
X-Google-Smtp-Source: AA6agR4z5iyGc/KnbqOKgxH+QqziQC1XLVqpCtNUnd525QBq6NgFTnEt6ShlgjJeBS1/7kliuF78qGIlm6wja/49KCQ=
X-Received: by 2002:a25:dbcb:0:b0:6a8:e19f:9938 with SMTP id
 g194-20020a25dbcb000000b006a8e19f9938mr4130188ybf.158.1662575720543; Wed, 07
 Sep 2022 11:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <YxducgSzR6/zyHD7@debian> <CADVatmNfc1YT02v5-FaMoGN==MOx5ZJ=o8YMQAH19Gvf91betA@mail.gmail.com>
 <20220907170451.efhz62nkxybqxtaa@mail.igalia.com>
In-Reply-To: <20220907170451.efhz62nkxybqxtaa@mail.igalia.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 7 Sep 2022 19:34:44 +0100
Message-ID: <CADVatmNodAV4PB5jjARnowu=VGbgMWgBYDWPuwJe-f1WFaS8ow@mail.gmail.com>
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

Hi Melissa,

On Wed, Sep 7, 2022 at 6:05 PM Melissa Wen <mwen@igalia.com> wrote:
>
> On 09/06, Sudip Mukherjee wrote:
> > On Tue, Sep 6, 2022 at 4:59 PM Sudip Mukherjee (Codethink)
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > Hi All,
> > >
> > > The builds of next-20220906 fails for mips, xtensa and arm allmodconfig.
> > >
> > > The errors in mips and xtensa are:
> > >
> > > ERROR: modpost: "__divdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > ERROR: modpost: "__udivdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > >
> > > The error in arm is:
> > >
> > > ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > >
> > >
> > > Trying to do a git bisect to find out the offending commit.
> >
> > git bisect points to 396369d67549 ("drm: vkms: Add support to the
> > RGB565 format")
>
> Hi Sudip,
>
> Thanks for pointing out this issue.
>
> I think we can replace the macros that are triggering those compilation
> error by functions in drm/drm_fixed.h that do the same calculation.
>
> I checked those errors when building for arm and i386 and the issues are
> fixed after applying the patch below. I appreciate if you can test.

Sorry, could not test as the downloaded mbox is saying patch is
corrupted and could not be applied. Can you please attach the patch or
maybe send using git send-email.


-- 
Regards
Sudip
