Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30693587F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiHBPiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiHBPiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:38:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3C10FEA;
        Tue,  2 Aug 2022 08:38:20 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31f443e276fso144872517b3.1;
        Tue, 02 Aug 2022 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0b6Z4o9N99dBrxvZIzGAcIl3UdOT7UmGWjcS9K8gvk=;
        b=Qi3am3BQET1o09/pbzliCWfM0TmZ6chfbhojviwnlEK/icgACHA0ax/O0mb/eIcx/u
         To64cTh+brgbDk7NohdgpdLwlPEG1R4i1yobwspAdwWLrfpfmbIDHE3gyUU4ClsVM/Dc
         olqdpQt/04EuOWFVBEWjHbtubRJ2dD6CtjVMzLyHyhzsZykoWXDH2MApMIHjXEJBxcp2
         Xw7E3fkyeTLFI8WyUhH1BVpVox9fUaaa4r8wkSCc3s7x8GQONIMUU9sfuZlLdO4Jpjzn
         DchTnIaJOGYwPqTn/1ZR2Uj9FLl/HQDKMgbJs7nFewlcpv6hhqFI6klWNw4SLqZCCcTu
         kBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0b6Z4o9N99dBrxvZIzGAcIl3UdOT7UmGWjcS9K8gvk=;
        b=Qg7fyfC++hFM0dYBZocpSK1PxoJRBeFppxQOZEmjmgK8ZEIrdmr6xsjkyCd+nB8/H1
         EiELLg33s8rh1xbO/gVosWstheFUGHkMpVcOb5MUgFQkZaTo1ktuoP3BWR2xvOEvn8Go
         vu/erGy/WoH+f9nJ7XMvqrRyK9DgXNb7ucchJJBjGcRldHvW85qxffPk5eREILUtahXi
         lIZEXBNqYaVciPa+GNuuRFb/Vy/CMGt1Zt+jMmcMKWsLQJ40BSUX1rbVRisUQtJ5X64+
         bRIZNyigmj3kMO/EZmE8eVT8DJPT1nUwYb9SBI6eIpjVcqkbbp0jd2eLffd8p2GxRxUn
         yfqw==
X-Gm-Message-State: ACgBeo3CdaBnTCs7Qw5U3OGIryraPB1LUQM4sbZOIoH/V8Els61LT6ce
        N215r4MN52+5MkUbop0TrtlpUC/Ku+brV+S08dw=
X-Google-Smtp-Source: AA6agR4RPpRQhvb7LWsXW4yIc4rxDjRbpzkdw0GMMn/85ECVHC2rpuwUUAQ6N31ADZc8T9TOjyOz2lJF1qgthg3xYNw=
X-Received: by 2002:a0d:ea57:0:b0:31f:4ebd:99f7 with SMTP id
 t84-20020a0dea57000000b0031f4ebd99f7mr18123450ywe.280.1659454699984; Tue, 02
 Aug 2022 08:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <bb1df380b64dd708f480261548fb303046352878.1659296372.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <bb1df380b64dd708f480261548fb303046352878.1659296372.git.christophe.jaillet@wanadoo.fr>
From:   Jason Gerecke <killertofu@gmail.com>
Date:   Tue, 2 Aug 2022 08:38:42 -0700
Message-ID: <CANRwn3RqbhbK-aGa5aAc9gHDU446Qyk_9-HJmN51q=y=HpweNg@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Simplify comments
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Input <linux-input@vger.kernel.org>
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

On Sun, Jul 31, 2022 at 12:51 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Remove a left-over from commit 2874c5fd2842 ("treewide: Replace GPLv2
> boilerplate/reference with SPDX - rule 152").
> An empty comment block can be removed.
>
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

LGTM.
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
