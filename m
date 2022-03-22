Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19BB4E3CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiCVKoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiCVKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:43:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6CD81192
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:42:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j13-20020a05600c1c0d00b0038c8f94aac2so1483809wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFfOJE9o2HqAJOSqBaJFQFfutWgZMKV4kI/WYj73AZY=;
        b=WkdbAVUeg++bdea+vhZthWfIKaO5ibIym7B19DfJlss0ygAzE8WtcxGgk3Rq9sfFed
         UwgqLMLZKc6Y5I+J0KyeK+hsrns5AZtsO4FdBKxgXLtHgiGpPPS6eYt4h5NuD+eqzrs8
         RLLj0Gz4hLS8zETFMySV+vWfhFXY5tlf1zSLiPqTs5B62TnVhn+jFjDyu77AyJ6j/UaZ
         5xMfZNuKmut2DhAcvKoRWuqv6jjpfmj9nmbrHqpIc/4/So2tfdOZbdQZNfONwnZPj4hC
         vIyxAzVxXxI1zAMtF4rg90j5QD4xanY1EHUcO/HsV4bsTH4VQTWmnFs6nz4SUmxImV5Q
         nsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFfOJE9o2HqAJOSqBaJFQFfutWgZMKV4kI/WYj73AZY=;
        b=CvdLoBRrw8D9n3eyZKHWy3SfFSPS1qrMTQsseHJlzXvkUwiD26kyDfqQ6FP45TVV5K
         bUuslvjPacR7JueSw2ujnMucYgRyRB7ZFWinVHujPsSK4PyzZZokvk8OOP5js04CfFDd
         aokwgER6+U0zlhRVcSstV5KrOry56Bt02/feY1+hqHV5LCltd097RwTWdoj9ruRsZQdy
         VB4+RZbqqdjKLBsArSXz9tkaha9NNN819ArIbTqYjNRN68U6M9/SeqP2NB91lXZiC4sE
         0bXpE2gOwZDZ1FtrwViYbI9gVU1BvvEEP7TnLRMgmFjVdxf81QWgp0UQj5Yz7VpZoWaC
         zdpA==
X-Gm-Message-State: AOAM531uxpKszMipvMSf/9ZI+d3d0z8gBV+bo+KxbR65gHN6JYvO1GoE
        DVsbtyckl/x7OT+5pGlbH2U=
X-Google-Smtp-Source: ABdhPJx81q0d4bF09rUxEJOf+ippZhBk0x9Q/jaLlDzPBAcA10A2VFYKheCupIeUBtiYMxr654a3Ww==
X-Received: by 2002:adf:db4b:0:b0:203:e76f:fc45 with SMTP id f11-20020adfdb4b000000b00203e76ffc45mr20818549wrj.549.1647945744429;
        Tue, 22 Mar 2022 03:42:24 -0700 (PDT)
Received: from leap.localnet (host-79-37-100-169.retail.telecomitalia.it. [79.37.100.169])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm1903414wmq.35.2022.03.22.03.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:42:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sathish Kumar <skumark1902@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8712: Fix CamelCase warnings
Date:   Tue, 22 Mar 2022 11:42:21 +0100
Message-ID: <1786742.atdPhlSkOF@leap>
In-Reply-To: <3a85ae64-00c1-6483-f1d7-c12abdd3ff3a@gmail.com>
References: <20220318101440.13887-1-skumark1902@gmail.com> <YjRswrHu0JUm9331@kroah.com> <3a85ae64-00c1-6483-f1d7-c12abdd3ff3a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 22 marzo 2022 05:30:29 CET Sathish Kumar wrote:
> On 18/03/22 4:58 pm, Greg KH wrote:
> > On Fri, Mar 18, 2022 at 03:44:40PM +0530, Sathish Kumar wrote:
> >> This patch fixes the checkpatch.pl warnings like:
> >> CHECK: Avoid CamelCase: <blnEnableRxFF0Filter>
> >> +   u8 blnEnableRxFF0Filter;
> >>
> >> Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
> >> ---
> >> Changes in v2:
> >>      - Remove the "bln" prefix
> >> ---
> >>   drivers/staging/rtl8712/drv_types.h   | 2 +-
> >>   drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
> >>   drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
> >>   3 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> [...]
> >>
> >>   	do {
> >>   		msleep(100);
> >> -	} while (adapter->blnEnableRxFF0Filter =3D=3D 1);
> >> +	} while (adapter->enable_rx_ff0_filter =3D=3D 1);
> > Ah, that's funny.  It's amazing it works at all and that the compiler
> > doesn't optimize this away.  This isn't a good pattern to use in kernel
> Do you mean the following code is not a good pattern in kernel?
> do {
> msleep();
> } while(condition);

Exactly, this is not a pattern that works as you expect :)

I was waiting for Greg to detail something more about this subject but,=20
since it looks like he has no time yet to respond, I'll try to interpret=20
his words.

(@Greg, please forgive me if I saying something different from what you
intended to convey :)).

The reason why this pattern does not work as expected is too long to be
explained here. However, I think that Greg is suggesting to you to research
and use what are called "Condition variables".

Take some time to research and understand what the Linuc kernel uses for
waiting for completion or state changes: struct completion,=20
wait_for_completion(), complete(), and others.

Another related mechanism are the Linux kernel "Wait Queues". Do some=20
research and understand how to use wait_event{,_interruptible,timeout}=20
and wake_up{,all,interruptible,interruptible_all}.

If I recall correctly you may find one or more of my own patches to
r8188eu where I use those API (git-log is your friend).

I hope that all the above will be sufficient to start with.

Again, Greg please correct my words if I'm misinterpreting what you
requested to Sathish.

Thanks,

=46abio M. De Francesco

> > I know it's not caused by your change here, but perhaps you might
> > want to fix this up to work properly?
> >
> > thanks,
> >
> > greg k-h
>=20
> Do i need to replace the above code with some other mechanism?
>=20
> If yes, please let me know which mechanism i should use? Or what should=20
> I do here?
>=20
> Note : I am new to Linux kernel development and looking forward to learn=
=20
> and contribute.
>=20
> Thanks,
> Sathish
>=20
>=20




