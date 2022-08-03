Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BA0589314
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiHCUVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiHCUVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:21:19 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A0140DA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:21:18 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e127so29337968yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LxBvWFWtv3mRccGDvPsHUc9LksL2ke7HhJ0WrGNL6Cs=;
        b=a/3ypc6yT9CJPpSYrIktn7ij+Tk191UCCs7ohCepUbxr93LHERbK7aFXE02239ywjy
         ppggofloFDTugPKqmt9knPyx8B3YS5zejac2E59ygzwp8VyFwUfMWEdlRtwESHbOv/vB
         Qtes4cT4dlRoRW5sE5MeFztz9ZxPQ6SPV3wofXC/491C0NfhYGAUu7qFz/ten/X+7+Au
         gs7BmyZaXQ43RU509zt9QT8fz4Pp/QuRaaM2ga0CiJu+i5bkVKQqNttg98MRJP+C77Gs
         zIu4ptO2GKahteA7AP5CfrrZKaeFwLD0EXl2+TzCcO9PSejhPY32MfqVIm916YDPENSW
         eOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LxBvWFWtv3mRccGDvPsHUc9LksL2ke7HhJ0WrGNL6Cs=;
        b=GbEBjIaMAEY5p42wlcYvusu4cLFlrzzXh/SPQ/lh5d6qD8iytorU7QoyyGA0RGGoCz
         0Pu0Y+0DxTBWnwPYDafAawaNxpCUt4VSN04FGbY0ZKSjgnOgoEVK3e4rDdmHCwLjR0lA
         UmKnwSG3yCilnD2Rnhji3f9htZRhJH/cYOuHUk+l9LG2PX/RuXNzQXZlI1WmP/2NSKrs
         +tiyJIhmQJxKNO24KRF+BU3dxUE25QNuxocVDf0yqsD+hiy6XdiNdxS+XQrOlb97rqFp
         hp73ERkryoMU+KgeHgOas0QfUYldEyiP5j2s9IpLZW6KMBPQIGj+OKrKe/YimapEB2l5
         EVRg==
X-Gm-Message-State: ACgBeo0nU+hN3kfyenkSeyZ6pnQTDV44wqJ9cVgPIRkalb4ZNyicC/Q9
        4cQ58mrZTtBHeMgqXm1dqxwo4ltYXOIUYwFse3Q=
X-Google-Smtp-Source: AA6agR5SkVpjcoOEz/0WRXHKAdZbmHaUJ6zrB1svO9XhaGvxhYOK0YdhcsLsyTp2FruWNDGbOLURhM6hPCfAC12kBcs=
X-Received: by 2002:a05:6902:4d:b0:664:dd89:9709 with SMTP id
 m13-20020a056902004d00b00664dd899709mr20968162ybh.57.1659558077901; Wed, 03
 Aug 2022 13:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
In-Reply-To: <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 3 Aug 2022 23:20:51 +0300
Message-ID: <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 10:04 PM Dave Airlie <airlied@gmail.com> wrote:
>
> On Sun, 31 Jul 2022 at 22:04, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > Hi,
> > Greg and I talked a couple of months ago about preparing a new accel
> > subsystem for compute/acceleration devices that are not GPUs and I
> > think your drivers that you are now trying to upstream fit it as well.
>
> We've had some submissions for not-GPUs to the drm subsystem recently.
>
> Intel GNA, Intel VPU, NVDLA, rpmsg AI processor unit.
>
> why is creating a new subsystem at this time necessary?
>
> Are we just creating a subsystem to avoid the open source userspace
> consumer rules? Or do we have some concrete reasoning behind it?
>
> Dave.

Hi Dave.
The reason it happened now is because I saw two drivers, which are
doing h/w acceleration for AI, trying to be accepted to the misc
subsystem.
Add to that the fact I talked with Greg a couple of months ago about
doing a subsystem for any compute accelerators, which he was positive
about, I thought it is a good opportunity to finally do it.

I also honestly think that I can contribute much to these drivers from
my experience with the habana driver (which is now deployed in mass at
AWS) and contribute code from the habana driver to a common framework
for AI drivers.

Regarding the open source userspace rules in drm - yes, I think your
rules are too limiting for the relatively young AI scene, and I saw at
the 2021 kernel summit that other people from the kernel community
think that as well.
But that's not the main reason, or even a reason at all for doing
this. After all, at least for habana, we open-sourced our compiler and
a runtime library. And Greg also asked those two drivers if they have
matching open-sourced user-space code.

And a final reason is that I thought this can also help in somewhat
reducing the workload on Greg. I saw in the last kernel summit there
was a concern about bringing more people to be kernel maintainers so I
thought this is a step in the right direction.

Oded
