Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DB247A9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhLTMpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhLTMpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:45:01 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C7C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:45:01 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so28270524ybg.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bymUVH7dKBh7uCkZZEUVVQY6d2Jlj4KY+YLiw5M1EeQ=;
        b=AKpLCtabjvqSUU+xr4cjPZd3vtcZlzKWOfawBgGQHza73eWLnwyguyGj8VkBKkU/gt
         hKdavF3uNDsLXZbwLX1B68pl3/97PbSZDRoQ5DzaIeYDr9f8yQB5uPyABLHkWcglQVWX
         Bk0V6ac0gnE02Dvg8itMiL1MTG3tS0GGoYUF9NNeMHlkgZOBWkxSGqFGYPQy+HQ8EjwI
         m4efEYEUYvSsxNY60UMwKFZGxkWqEvwa5m89uLjOyubbD6IGTv0t/rOTsVQOUNvPg4QX
         AuYQID+9B0tGYDKEwShzTNVfV05Ua5u1Fb49ttRlurEohmNzeJJOlI/AfZ/i5MngaiUa
         GlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bymUVH7dKBh7uCkZZEUVVQY6d2Jlj4KY+YLiw5M1EeQ=;
        b=zH0rCse1O6akFiOpWOp1nrC2LKDkPTc1q4zmtM/HJuqWj9/UEyDOQVN3mDlh18uF8n
         gAV/1VINWkyjY7NiUHn3foiGrL66AyfTYPVX9AlzyTNXmD3xGJZVmP4T23GnV0pBZjI2
         UbEbec73p0yuy6Tu6glOI0Zv6DWQjS6iakkSehb/4fgSo5NXYyDdBp3SFUv/lgO1yggf
         FLQu9KOkrGAFCfwUOp9U8+Pvpo5dUY40uMvBGhy2EQE/ENFtf3+mLjQBp8p7hZrutXWN
         IbpLqZmRWnGRei8ffa126D6gUwFmUQpXU+gbJVLkpDJsnP7iYZkSdcx51z90FKm2plKK
         lG8w==
X-Gm-Message-State: AOAM531ZHK6nKpUHYlWgEVFbM2KXJGsPa6kI+5k+j8viI/+rIKlSfdpF
        c0K2c/ofGxhkDXLTMr3iWZdAZ/Va1Av+HPheeAf6Eogb7YP12A==
X-Google-Smtp-Source: ABdhPJz/+WopWTog4ZtWYhnbiRxpAv7NDiRobRdqX/jKXBOCt6J4IbzAgSM6hlVmNaZGYuqY3Dy6DTneH0URBfk2qu0=
X-Received: by 2002:a25:d685:: with SMTP id n127mr21284381ybg.523.1640004300820;
 Mon, 20 Dec 2021 04:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20211220220843.735da08f@canb.auug.org.au>
In-Reply-To: <20211220220843.735da08f@canb.auug.org.au>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 20 Dec 2021 20:44:22 +0800
Message-ID: <CAMZfGtV=9_2N7HJNKMikj9WAhzWp1cxOtp6bSRxY7gEOCBLNhQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Armin Wolf <W_Armin@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 7:08 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/hwmon/dell-smm-hwmon.c: In function 'i8k_ioctl':
> drivers/hwmon/dell-smm-hwmon.c:454:31: error: implicit declaration of function 'PDE_DATA'; did you mean 'NODE_DATA'? [-Werror=implicit-function-declaration]
>   454 |  struct dell_smm_data *data = PDE_DATA(file_inode(fp));
>       |                               ^~~~~~~~
>       |                               NODE_DATA
> drivers/hwmon/dell-smm-hwmon.c:454:31: error: initialization of 'struct dell_smm_data *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   2dd082773083 ("proc: remove PDE_DATA() completely")
>
> interacting with commit
>
>   073bd07205af ("hwmon: (dell-smm) Unify i8k_ioctl() and i8k_ioctl_unlocked()")
>
> from the hwmon-staging tree.
>
> I applied the following fixup patch.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 20 Dec 2021 22:04:57 +1100
> Subject: [PATCH] fixup for "proc: remove PDE_DATA() completely"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks Stephen.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
