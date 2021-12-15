Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3198A47580A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhLOLln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLOLlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:41:42 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D252C061574;
        Wed, 15 Dec 2021 03:41:41 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf39so30474853lfb.8;
        Wed, 15 Dec 2021 03:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVoe7yAKZFMYlKyfdTJ++5MCDFft8o/YXQn2x8pFVvM=;
        b=dakCHQ74Gvvs1ALAu2j5VLqque38l0RQ/M/uOYRdnXlnFwS4BIo0aYMrLPiq2QDdLy
         zBaNWLxYfygqcLhYvWTsK3fu2iR2xA39S0tDYr1V3sz6gADFAwdkIEyEQ0phK59PIAiU
         qW1/Oj1vYsVZYj02bLRm4yHGsfBmz8N0uwowkbGy4LerHa8eSWmVdY/wmONCfokjetd4
         Bql6QcfvhNCJsocP9MSnA1VU78NoRpoEV4IrZIt34S7zLVAUbEXomFCHeFRnw1Hb4UCu
         5TZEpE/1japTifDqrMIhuivqwdUDtlvHtNUaFYYg2EfQwYGkVs15hRZTbR6Ur+Qqc1tB
         zMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVoe7yAKZFMYlKyfdTJ++5MCDFft8o/YXQn2x8pFVvM=;
        b=Nt610pw6FZMUX2c+Y/5vHfnoSSxZb6eghDbtIDpcGyttClvMbMddkefRnQAfyiXlsU
         jBsdKZmaJ3j2N/6rpCD8hl+IQuF2ibNi4DLl/xCpSGaW6JW9GrGbS+Pwp5H0FiTCo0l9
         sOhNCUikCrpNGdXkWKurHDKMddf8jVd/o6qpbQb2iwhPBkZW1m7b/Ka4lfBTeGirn/vr
         +BLxH27Z67yvxp+u8ZFjq8lPmTUnL3rUbGzpeGZ8vaalMq3C6nhvQiXPKuWo8MlSs8Dm
         BDvJ5ujJQN6QpfVmRVScmNH3q/0+Oz4TBPR0qhLP7A2RII0ZfAO21Qudi0GeEp1xycXH
         fp7w==
X-Gm-Message-State: AOAM5309cMHUNyJe7YnDjIlbOy0uVBL9LURra1oHabax9+ULIAsPBZRu
        9vnYQD+wUpeeglpksrtVJ5v2vC2Zs8uJN5z+zOHd2PC+
X-Google-Smtp-Source: ABdhPJyBZLApEGmOqB7EAmnRubSJb1zz93HrptYM8K8908gJcGN7dTO9mFPJB5AjfhATifQmBj9o5ASzmYy04mvDKMU=
X-Received: by 2002:a05:6512:1109:: with SMTP id l9mr9219864lfg.181.1639568499742;
 Wed, 15 Dec 2021 03:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20211212115506.180629-1-gnurou@gmail.com> <9b20ae5d-be8f-59dd-3136-2a9f7ce216e9@suse.com>
In-Reply-To: <9b20ae5d-be8f-59dd-3136-2a9f7ce216e9@suse.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Wed, 15 Dec 2021 20:41:25 +0900
Message-ID: <CAAVeFu+sLzNUztnW4Vyr6ukCyjxTwCT-L4Y2xEWsRx=CPuarPw@mail.gmail.com>
Subject: Re: [PATCH] usb: storage: do not use UAS with Logitec LGB-4BNHUC
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Tue, Dec 14, 2021 at 4:34 AM Oliver Neukum <oneukum@suse.com> wrote:
>
>
> On 12.12.21 12:55, Alexandre Courbot wrote:
> > This 4-drives USB 3.1 bay gets unhappy when used with UAS:
> >
> >       sd 10:0:0:0: [sdb] tag#18 uas_eh_abort_handler 0 uas-tag 5 inflight: CMD IN
> >       sd 10:0:0:0: [sdb] tag#18 CDB: Read(16) 88 00 00 00 00 00 00 9d 42 30 00 00 04 00 00 00
> >
> > It works perfectly fine as a regular mass-storage device, so prevent UAS
> > from being used with it.
> >
> Hi,
>
> this is a big drastic a fix. s it always that command?
> Have you tried less drastic quirks?

Unfortunately I am not familiar with the storage subsystem so I'm not
sure which quirks would be good candidates to try, would you have
suggestions? As for the command, reproduction is rather random and I
did not keep traces of all instances.

I just noticed that users with similar issues reported that disabling
UAS fixed the problem and sure enough it did in my case as well. The
bay is used with a NAS so I'd rather not mess too much with it, but I
am willing to experiment a bit (after double-checking my backups) if
you have good leads to suggest.

Cheers,
Alex.
