Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3EC4910B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 20:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242996AbiAQTer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 14:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiAQTeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 14:34:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1D1C061574;
        Mon, 17 Jan 2022 11:34:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p27so49870225lfa.1;
        Mon, 17 Jan 2022 11:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emOtZhdt5N3mHj5D3ASETnqYXUFr2pjYPEAN6eeF9Ts=;
        b=J+VSDCpYVNAwVW2eHpYj14WGtUwxHXL2Lp5GacTZmY1VwmgLJKQcztLT33T1ef6hUG
         dvd44EeSpPC8kZlVT7zY8JRvshTczdhzMwSM9a+tEZCzHV3/b/lm/JWOEJb8liOlcUFs
         RPqOCHEai9nT/Gbkz8KzZ02BgxWr4r8mxD/WRQ7ITaP1Im4qqpZZ0x761LJfxiRcJ5fD
         OcdrB3SKTNWQpv+2cPRu/b6MDm9naaC9xIfY0TyUFoRkGxqvrvharc0HfvEIjTpnSHoT
         nDQi5IXW4D2rx852y0pA1y/+dT5toftzVJr+ZIkRvGDp5ncdvbQA5cC9S2CAM6JlpXc5
         m0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emOtZhdt5N3mHj5D3ASETnqYXUFr2pjYPEAN6eeF9Ts=;
        b=rS6gec+oFMX4eU+951aN74HM3n49Q4QhBOkq29oFAOMb3U6yxjPa3LRgnMxSIAeIvv
         6aQAQ8kwbZ1QI9ZzWAnBnl9cTZEPHzpuv0R/HPELlb9fBuPQV8Q3a0wFFBNiUvjxYDLc
         eVhOLEwTJUx7RrQ0iLi2V/qijz8/njWikdJtsE06qJYfTzRrsJIWoOtacV7LT3BapxCW
         ASkAim4r9R9+19BeSv5lMbJHPXYowsUjxNQhGuGJpcmO2fu5CENf2Gt2AiX9MtCwkSv+
         uehWf5Zord8iH3+jgM/XpThXdNm5M/EE+zgGwaynPTucTEWT+fKW+MQrfcRok5FiP9ra
         dF4A==
X-Gm-Message-State: AOAM533ZpQ4fL8F/o0vIYw41gQ6dzf/GZo4Rqb4WRfZ+HBPV4S1VNzt6
        HsCRL+cTqqxYZh4eKPNW5kSJAKgE5K3glp4eakvqmBo4
X-Google-Smtp-Source: ABdhPJxjxhkWx1IfG3E843M4a7EOnVlBZ1imHsFc/tH6VpSxTXzEfkxeNwnrwY++66zOk9uI6yitf+1snApKwGz5HMY=
X-Received: by 2002:ac2:4c41:: with SMTP id o1mr17939096lfk.545.1642448084498;
 Mon, 17 Jan 2022 11:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20220117011130.84223-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220117011130.84223-1-yang.lee@linux.alibaba.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 17 Jan 2022 13:34:32 -0600
Message-ID: <CAH2r5muO5=-8A-SiPaU+0MWgGvKrZZbRpEv=3zttNHARLGTNyg@mail.gmail.com>
Subject: Re: [PATCH -next] cifs: clean up an inconsistent indenting
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Mon, Jan 17, 2022 at 5:07 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warning:
> fs/cifs/sess.c:1581 sess_auth_rawntlmssp_authenticate() warn:
> inconsistent indenting
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/cifs/sess.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
> index d12490e12be5..96434cad0bfe 100644
> --- a/fs/cifs/sess.c
> +++ b/fs/cifs/sess.c
> @@ -1574,7 +1574,7 @@ sess_auth_rawntlmssp_authenticate(struct sess_data *sess_data)
>  out:
>         sess_free_buffer(sess_data);
>
> -        if (!rc)
> +       if (!rc)
>                 rc = sess_establish_session(sess_data);
>
>         /* Cleanup */
> --
> 2.20.1.7.g153144c
>


-- 
Thanks,

Steve
