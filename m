Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B947EFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 16:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353077AbhLXPPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 10:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbhLXPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 10:15:37 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D548C061401;
        Fri, 24 Dec 2021 07:15:37 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id i11so1945485ljm.13;
        Fri, 24 Dec 2021 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kl0YYPYD5040RHk8tdUC5mMa6Ge8dZ75v7xiKZepmfQ=;
        b=TdibYtwGxEk3xJK5BKqfhxRSGn0kwEs7mi3sd9Jwqmtyjdc1pHJFynRD4PJjvY+o2K
         +6uRtu+hvwIv1fxKIUHmqsipqsxFNm2zp/7DK3W03gdkUmjlG8oTh7zBand97wfsAmfo
         bhL282nL7UGVtnxGVhMmTRzzw+xSqXPMeBPBzzbkhxhCdFQJQTMbT3hgXchHZEGvviff
         CX7G0ONo96bzdxQ5bSPdNR5ZADZu25z7X1dIkc7JVb7MhiYmCQOlqAp8ONlRGRgoWcbw
         vrk1c15Krp9maIduMTMEvoVV/y2iKaaN6eUlIZV10p66RMzYQb8nD/5qfcWIktZAk2FD
         aZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kl0YYPYD5040RHk8tdUC5mMa6Ge8dZ75v7xiKZepmfQ=;
        b=YbBj8EnezkMwd1WlYGRDiM/dgBE7mqef0BjK8GOZKmKGat+BTj9dWxVMu/yGXWTBAD
         RVSmMzTx8ZdLQjOu3dv1Kr4pnVDOgM/S6mcdfQEg9GHSVdUNEiZFxDTewpFO6OIFUlId
         7bEfkx8/KwAtdnKkTe0bxpes0rFr1CzBevciA38OTfAl8KopZyoU62tvl6iOUhHDBhni
         KDfe/+A5ZjpzIsAQeRxnWQ2h5hrJ7U9Sk/Ei75HKiziATbeyBnYS7T7E3ZBQ47kZbJbP
         nm8hO7Vkhvg/LOkVL4HnGhzg8vKRjrLuoU/9x34FBRKmS59NzGp4TnBihOjJJdvfG55R
         xLEg==
X-Gm-Message-State: AOAM532+D/Sw63uCEmr0BimqoMwhUr73/Zvz0mIFcUV1lPNJmSB+pc3f
        l3mzm9xRlVtctWJw0mw0oLaqyAlaKyUK/bozick=
X-Google-Smtp-Source: ABdhPJycFT6tNzlLJNgcf4f6fB2GoEbU/rKg+UQBbjMijLF4lW1jPgAVwtQvmTSu8G8DKZfefm2uQkyCSQCjNU8xRwY=
X-Received: by 2002:a2e:9c8a:: with SMTP id x10mr2384131lji.209.1640358935120;
 Fri, 24 Dec 2021 07:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20211221004809.213602-1-colin.i.king@gmail.com>
In-Reply-To: <20211221004809.213602-1-colin.i.king@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 24 Dec 2021 09:15:24 -0600
Message-ID: <CAH2r5ms_VWd6WEh6c6ydfF0it+xdnS9YJL02RwN-baVzdiHmQA@mail.gmail.com>
Subject: Re: [PATCH] cifs: remove redundant assignment to pointer p
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Mon, Dec 20, 2021 at 8:01 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> The pointer p is being assigned with a value that is never read. The
> pointer is being re-assigned a different value inside the do-while
> loop. The assignment is redundant and can be removed.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/cifs/cifsfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index d3f3acf340f1..61091eed8c65 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -775,7 +775,7 @@ cifs_get_root(struct smb3_fs_context *ctx, struct super_block *sb)
>
>         sep = CIFS_DIR_SEP(cifs_sb);
>         dentry = dget(sb->s_root);
> -       p = s = full_path;
> +       s = full_path;
>
>         do {
>                 struct inode *dir = d_inode(dentry);
> --
> 2.32.0
>


-- 
Thanks,

Steve
