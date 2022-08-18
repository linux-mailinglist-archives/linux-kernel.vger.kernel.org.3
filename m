Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C0E59872E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbiHRPP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245120AbiHRPPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:15:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0672EC0;
        Thu, 18 Aug 2022 08:15:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c39so2323195edf.0;
        Thu, 18 Aug 2022 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5jf2La2WzmcjgUchLTXC01GUtAH46tT26LIoZiQDfzE=;
        b=iFz46T5OYv3VU1MVMvIauk7AlBXUmu/ghWRT/9G9Rj3OSDgptbP3NrW5ckC4ZGgzNf
         BpOfmNLi0Dh40chjXk6ZyaElF6oyXIjzU4q+TKl900WkNXiV+D3oZ1/K9knGZ4XxiFyu
         vPSEApn9CQqttbOc3K+ZahH+nV0DiWIAM8OX8xyyki5Dxi6f1GryLw30OrzIPQsook3p
         cnCWuNPc/XKFXmgNJk2N+eH1Ojxsb+7q0SvsR9ESF4qxwIOZKCmT6FmxL/LTKiik1VRS
         FifkNRCqbK5GG/LhZ2rHYRabaSuk1Iaikn3e1ti431pcEKzdnLjHA+3hvhNiFUDlRvfI
         NdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5jf2La2WzmcjgUchLTXC01GUtAH46tT26LIoZiQDfzE=;
        b=r0D9cX6HOnAK58CXWXSbfi4tUKync7mLjV80GChrzMINNkBb6W/uUplJoQ4GlMlXbX
         bm9as2kjHHqXZXilnBP12dMjvigVBAZyO6W8WLjszaq0asqJdZ1wwdJFPR1s+3KXwz4y
         27doK63ct3e9lmoamV84UmYWhujXolfeOpyjFDhZZJuOkCfVU8wwCljorDPDK5b3Yt/a
         ac4fni0Q6ks2J3EDW16iYkPIvNDO60WlmMjqmVtgpQKT9BXJjuR/UlqO8+WJlZbL2Xg+
         6d6AZcZG1YorSLzluqt10qeOr8xzuTilNSIoVcmOK4CM7yylLSUMBAAM44nrU6THAm2j
         +oWg==
X-Gm-Message-State: ACgBeo3XTGej6CChnPPyoBDk5QQISIQA8lZdB1u6SzVwfXfPA0yMfeZI
        TLVp9CNuBAUmLGBvbuoEMhPt6FRb6yNaKirQiSU=
X-Google-Smtp-Source: AA6agR4jybmfsZrjc6F3THjZOpgW5ci+P6K1RHkNI3S5ywMtdEWBG/BAQvLDX5aMHXebOnV1wgkdkcy58LKUe4dW6ss=
X-Received: by 2002:a05:6402:28c8:b0:43e:8622:1c21 with SMTP id
 ef8-20020a05640228c800b0043e86221c21mr2649869edb.135.1660835751169; Thu, 18
 Aug 2022 08:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220812061805.88627-1-dzm91@hust.edu.cn> <20220812061805.88627-2-dzm91@hust.edu.cn>
 <Yv5VkNvk6CDBFgNK@kroah.com>
In-Reply-To: <Yv5VkNvk6CDBFgNK@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 18 Aug 2022 23:15:22 +0800
Message-ID: <CAD-N9QUO9i0rkUGu_buBLSkFaTvvHp69ynkP30kEcmCRDDQg8A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] USB: trancevibrator: simplify tv_probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, USB <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Aug 18, 2022 at 11:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 12, 2022 at 02:18:02PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > The function tv_probe does not need to invoke kfree when the
> > allocation fails. So let's simplify the code of tv_probe.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> > v2->v3: fix the truncated subject of PATCH 2/2.
> > v1->v2: no change
> >
> >  drivers/usb/misc/trancevibrator.c | 11 ++---------
> >  1 file changed, 2 insertions(+), 9 deletions(-)
>
> Note, I would recommend you work on basic "clean up" patches in the
> drivers/staging/ directory so as to get experience on how to submit
> patches properly before working in other parts of the kernel tree.  That
> way subsystems that don't normally take "cleanup" patches don't get
> bogged down in basic patch-process issues like this one did.

I see. Thanks for your suggestion.

>
> thanks,
>
> greg k-h
