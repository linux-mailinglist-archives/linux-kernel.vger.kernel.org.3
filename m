Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B1A4F5139
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573303AbiDFBzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457453AbiDEQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD25468E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:45:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e16so23913519lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9SdlWzsJedRjMRqCUZiZSLZb2q+ZGrqy7aRPJWfCTI=;
        b=fJXw9eqsOgdBlZZ+bDVO85i8RLMF/x5p8l8STvxnoBvVwuBqjJeGJ66vmj05j392K4
         NXboPqMpJuk99eg222wu+ckKVtFOTR0XQOj3vhGuRDX5qMOhl5E+V7xSCsGP31Dfi0oB
         nv0UX8FPtpN1FwcsHvdkj+z0k5zGg0T833+BOFrxqysdkUYZyJy5N1DVbmYbTsS7jzpS
         CJdpfInmXKJ6qnAbCnejlUNZADWpkLjdfBddsRFSbt+e25TFYoJ31B9l5UfXMTM0DvyV
         baI2StGJgaeYSfhVkc4uol95G4dO4Yv/zG3Pr4nEgzrANIoo6wSDC/mk4zk6SXXoOvPR
         2KzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9SdlWzsJedRjMRqCUZiZSLZb2q+ZGrqy7aRPJWfCTI=;
        b=T/0i/Hxr1hX4PbulVk+DdkOHwjt5haUnKPYZWTAzmSu/Wy87HHjfUihCkeBh0vjqlq
         trIBjyrdYhYqsWmTDlIEqFaWli1IYmaf++LzvjFMYAzy86O4IEoVKI9hjNtj3UjQxucu
         03vM3JIjVtMiKfCRgBwS7ZlJT9EjIhPugCbPPANPMHwyxrmbn80iqnHxVGUztyeRv3If
         p6MlDhn5Qr+cZlH9XznuQ6O+0TC31WCDX+VFe+I6Wdt5DXR1tWbISU5FhjvxHsZUUvER
         wLFviIa/tQC2AMvebdOuvV+bBqEAjkJDTId9es6E0ZGOylY8bPjJ0Y2zrD5xNP2/rE+u
         /BOQ==
X-Gm-Message-State: AOAM5315iLDhIzoRdF+lZgpgy6Og80u1jsXKJ8yWxuc8M40LT4tcdfm2
        EIz4QQyQkAMg8RVVQ+dRtwgKQ5+id7vLRiKJhLY=
X-Google-Smtp-Source: ABdhPJzHwO4rczywv/pgbxm8UYtOW/tXMXJfEqoiCugYVp/7165dKvIw6ECquFAPQBWsdhZjhJRYGSCx9BXdU3dav8A=
X-Received: by 2002:a05:6512:33d6:b0:44a:7966:d688 with SMTP id
 d22-20020a05651233d600b0044a7966d688mr3014884lfg.11.1649173540873; Tue, 05
 Apr 2022 08:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220405150912.GA625670@euclid> <YkxdasBGZ3m2Yu66@kroah.com> <CAMWRUK7c-hqiz+KEFkqBuvu1syCwSnF4UZzbkPFw-VWABm9qOw@mail.gmail.com>
In-Reply-To: <CAMWRUK7c-hqiz+KEFkqBuvu1syCwSnF4UZzbkPFw-VWABm9qOw@mail.gmail.com>
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date:   Tue, 5 Apr 2022 11:45:29 -0400
Message-ID: <CAMWRUK7Jgs3evt3bC0pnRkbRw3CS1XCULPi8NzjgGh7aLTFKCQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: fix indentation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy linux kernel <outreachy@lists.linux.dev>
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

On Tue, Apr 5, 2022 at 11:19 AM Sevinj Aghayeva
<sevinj.aghayeva@gmail.com> wrote:
>
> On Tue, Apr 5, 2022 at 11:17 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Apr 05, 2022 at 11:09:12AM -0400, Sevinj Aghayeva wrote:
> > > Adhere to Linux kernel coding style.
> > >
> > > Reported by checkpatch:
> > >
> > > WARNING: suspect code indent for conditional statements
> >
> > You are also removing unneeded comments, right?  Please explain that as
> > the documentation link the bot pointed you to showed.
>
> I specified that under the --- line:
>
> v1 -> v2: Remove the comments that became irrelevant with proper indentation.

I think I misunderstood the bot's response. It looks like you
triggered it because you wanted me to write a more complete
description of what the commit is doing. I thought I received it
because it was the second version of the patch from a previous
patchset (the last bullet point in the bot response) that didn't
include v2 in the subject and a v1 -> v2 after the --- line.

I can do a fresh patch with a complete description and no v2 stuff;
please let me know.

Thanks

>
> >
> > thanks,
> >
> > greg k-h
>
>
>
> --
>
> Sevinj.Aghayeva



-- 

Sevinj.Aghayeva
