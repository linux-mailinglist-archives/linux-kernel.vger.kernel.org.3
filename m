Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10BB480C24
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhL1RiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbhL1RiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:38:07 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA7C061574;
        Tue, 28 Dec 2021 09:38:06 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u13so42712898lff.12;
        Tue, 28 Dec 2021 09:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0iA2h+wer53P6FVdsWUB/3fyhSEZS9hzOIF1Qivilbk=;
        b=hw9yKAdgPw32JhUrnTtpeh7k8wj0alJVyY9un/DAdKvfPsIIQPUO1M/ZJtTHHKAGTL
         1udXmC1zDfiep2LU6yggAHy5QxESq3X63XJYIhqTbz8gjwEmJzevAETt42+WDqwG4/nQ
         qPTFKc/yhFKtd59prJsQZgOUAEAHvUMMTrxeaKQUjZx6Nkzxq7J3UhtiprV/NXTQ6dv7
         rvpjwDcToOfS29ZWdizzZifFuyiiRspP6TNvyKCDAQm8cofQ5qljoPbXbHbV9Pvogm9u
         roXY0cE90yagFRy45cKKAYOd72E60U/Xrm40aSJS/FM9NW3ZncVMkoFyHsG/RVyzrYkd
         Tz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0iA2h+wer53P6FVdsWUB/3fyhSEZS9hzOIF1Qivilbk=;
        b=N6bw9Sol4ZlDUO2ZjxhssraLssw073KGqk8WbkFaDG3eVBWPrBjo4pYDM4E8nMSix1
         yMIxFedO2+owdRz5S89SrcU9NZbAk+ZTfEkWzqegNW7/lRFl9WTPKfdXREz7kukHXbrK
         WvYfrhNWQGUqouT2Nf1qD2U4sJGTQSe+vuS74yYhjeG93pm3KRxni/8u0VNwV1aggkXZ
         B9yGv0xaXUlSvfCvWvywyNPBlv2gY0g+b8PPbrVJJDK4VGtGRjtAvDcQaYENEBPLTFK6
         UQaYiTCyHXlmZN65BNAWFGC55S02nVJnOocami8/R+EggcoM69P7SqpR9neCvZPoMA//
         lJxg==
X-Gm-Message-State: AOAM530/BwmJha+2tewrbH0VtBGVeR0bKOQ+7ZAYUPJwJuvRGnx/3u97
        fNCkwjiM8DnQUcl80TQnNBWfB/6vZ7kq0Xe5mGyW8a9RYAM=
X-Google-Smtp-Source: ABdhPJy/ZgDqYsWOcF41BMUBLRJVKq/SwcedpIZfOmUChdw9tq1lHDRfkXQSrHJEEBMl02hggQ4s91fJJF+UxH+MRBc=
X-Received: by 2002:a05:6512:3e28:: with SMTP id i40mr19361746lfv.436.1640713085111;
 Tue, 28 Dec 2021 09:38:05 -0800 (PST)
MIME-Version: 1.0
References: <1640712476-15136-1-git-send-email-konishi.ryusuke@gmail.com>
In-Reply-To: <1640712476-15136-1-git-send-email-konishi.ryusuke@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 29 Dec 2021 02:37:53 +0900
Message-ID: <CAKFNMo=7eaneb6oeCECZ-p-N=ZuANtpZEsseBtx_pBumo2GW4g@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: remove redundant pointer sbufs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please queue this for the next merge window.

Thank you,
Ryusuke Konishi

On Wed, Dec 29, 2021 at 2:27 AM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> From: Colin Ian King <colin.i.king@gmail.com>
>
> Pointer sbufs is being assigned a value but it's not being used
> later on. The pointer is redundant and can be removed. Cleans up
> scan-build static analysis warning:
>
> fs/nilfs2/page.c:203:8: warning: Although the value stored to 'sbufs'
> is used in the enclosing expression, the value is never actually read
> from 'sbufs' [deadcode.DeadStores]
>         sbh = sbufs = page_buffers(src);
>
> Link: https://lkml.kernel.org/r/20211211180955.550380-1-colin.i.king@gmail.com
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> ---
>  fs/nilfs2/page.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> index bc3e2cd4117f..063dd16d75b5 100644
> --- a/fs/nilfs2/page.c
> +++ b/fs/nilfs2/page.c
> @@ -195,12 +195,12 @@ void nilfs_page_bug(struct page *page)
>   */
>  static void nilfs_copy_page(struct page *dst, struct page *src, int copy_dirty)
>  {
> -       struct buffer_head *dbh, *dbufs, *sbh, *sbufs;
> +       struct buffer_head *dbh, *dbufs, *sbh;
>         unsigned long mask = NILFS_BUFFER_INHERENT_BITS;
>
>         BUG_ON(PageWriteback(dst));
>
> -       sbh = sbufs = page_buffers(src);
> +       sbh = page_buffers(src);
>         if (!page_has_buffers(dst))
>                 create_empty_buffers(dst, sbh->b_size, 0);
>
> --
> 1.8.3.1
>
