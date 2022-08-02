Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14F35881F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiHBSlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiHBSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:41:26 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9D13F97;
        Tue,  2 Aug 2022 11:41:25 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id w16so7458270ilh.0;
        Tue, 02 Aug 2022 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzeyAGDUN/5A+HWtk+TkUOMLjgyiHaE5JWRfu9ZYqzc=;
        b=i8kv/sB2pUO8kWbomr6irJGT80XTy+ZIKQIM0es3wsFaScbFJEfht0LwuJSI76ZDBI
         otcs31AWbY5bIQQMtsSaTm1NMglVigUzPLlvOX+1CJvyJ6cjF8XlcUQyzkbszMPyyACF
         yqJ3hWWlInEXFtMdEfa0eEcV/s+jrsGbqQuRs2+KwUv3Y4Pwl7VAx+5dnLqRg7xgR041
         er6oD9vUYQM3h43RX8drjXslySbk6rJXLCktQ8dqY7KKcWRObNO2pPauKarVbRL2sgrx
         PGI1spIjdERjT7+aAC4SN8dByFxNb8bhSJPFW5pjuVB1+w72lDnB7ISSxfpP+viuxb5P
         8AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzeyAGDUN/5A+HWtk+TkUOMLjgyiHaE5JWRfu9ZYqzc=;
        b=06HCQGJD1rWbLaZXMIeowdueJgxv92GiiDYowI/Zn+HOZPQqzAMpR4xSc/o6wOFb7R
         XgtveP9JcygoOpDlXFHjN5zLoMp8Y7UNSIKEPoWLGotq/rnlEseZDskHwcNxXk9znU2F
         rOpJJnMZNbWTqEXDTORcZoLbdmmgObNZVM/phtamBsvS6981cPOh+hSVp5D9AVOog9Bi
         nMdCKHRjMH71Bw+YSnOPLVev7K5hIWn1NRZLDSlqHZEV6j3L57n9xOVUtNrNBjRZ1Qhj
         Xk0UiohJ3vUrg169qSAZmd9RLv6aSB1cCi4EA54C7lNXFhzMzY/wRtkQ4/SL3M97YgNA
         nTgg==
X-Gm-Message-State: AJIora99SNyhoUhLbEjRfPcDIUZZFAVVUpMQx9q6jN6YD9DIEk92mWl5
        mVJPkjBkMVsXMBWl+zSIxW+igkTFjCuIOlQbN+E=
X-Google-Smtp-Source: AGRyM1tXNM1HsM8dHkl1eQ4yCXGzTuCCrhzZadT08BpYNirft2Y/dlPEMbRSek/G58DWQ7LJ/W7rCQFykuLRGEdHmd4=
X-Received: by 2002:a05:6e02:152c:b0:2dc:9b02:b590 with SMTP id
 i12-20020a056e02152c00b002dc9b02b590mr8645294ilu.320.1659465685089; Tue, 02
 Aug 2022 11:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <bb1df380b64dd708f480261548fb303046352878.1659296372.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <bb1df380b64dd708f480261548fb303046352878.1659296372.git.christophe.jaillet@wanadoo.fr>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Tue, 2 Aug 2022 11:41:14 -0700
Message-ID: <CAF8JNhJBwaxUqWXLEejirRRoFo7mM2y99cPTByCpgba0cDjOFg@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Simplify comments
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
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

Hi Christophe,

Thank you for cleaning up the driver code.

On Sun, Jul 31, 2022 at 12:51 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Remove a left-over from commit 2874c5fd2842 ("treewide: Replace GPLv2
> boilerplate/reference with SPDX - rule 152").
> An empty comment block can be removed.

While you are here, can you update your patch to include the removal
of the empty comment blocks and paths in the other three files:
wacom.h, wacom_wac.h, and wacom_wac.c?

Thanks,
Ping

> While at it remove, also remove what is supposed to be the path/filename of
> the file.
> This is really low value... and wrong since commit 471d17148c8b
> ("Input: wacom - move the USB (now hid) Wacom driver in drivers/hid")
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/hid/wacom_sys.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 194a2e327591..21612fdae9c3 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1,13 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * drivers/input/tablet/wacom_sys.c
> - *
>   *  USB Wacom tablet support - system specific code
>   */
>
> -/*
> - */
> -
>  #include "wacom_wac.h"
>  #include "wacom.h"
>  #include <linux/input/mt.h>
> --
> 2.34.1
>
