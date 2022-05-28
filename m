Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023155369B7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 03:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352136AbiE1BdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 21:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiE1BdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 21:33:02 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B504131F3D;
        Fri, 27 May 2022 18:33:01 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id e144so2729109vke.9;
        Fri, 27 May 2022 18:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4DAZBdaLL/g6XFS6QgCms1Gzfa6QkrtgLsny1wbvW4=;
        b=BtqFQ7cmMvO0yOXNuk12Hw1NTanwTkbaQejWyG3Nsv5ZHHVeStXXa3bUpNFRX7PGVx
         Ai3eRhdX6w+xOBf+9jS/KhQYnILdIEY4ETFV11JedpGg+IZdDuzs4aLmkj+eEHn2cuct
         q0aOETPZlYrySEnnGstvUKV5sWGwUIXZILYarVWzFopCks63LWM8Iyi/cXhAYeQgJRNH
         REj9K9xqh4UntdObju9EavOcTNPgQzsuuWVwlNe1carn2yUfyHO0QuWRM60DOZAqeKvD
         I4dH4NJAJZT6aRQAXjbuxvX5/bqcDctu/ZBRfVpSbzNn6P5+lOXutcMj3G9j2wvyT1Om
         Sd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4DAZBdaLL/g6XFS6QgCms1Gzfa6QkrtgLsny1wbvW4=;
        b=mo06tJ/6K/W/+NWeglULAL1z8cZkrAefvKSfiGeqPMuI7JcSqz8CA4B0z4YqH40kHq
         j43PNJWArBqt0dx3O44qcEnz5+VWLZrC0y6a1lUZCye9zZrRix3nb8THDBs/eXTGOq86
         aDinoyvT9hLUNGkB4P/MpdCMDoZjIoqmMqAJX2UlbAvpWEGOhnT0XMyf7eV0NVj0JNEQ
         vfqnw5LMRfECoH/8Y37oXMbSrTPEaeJT6ZHwPHxywRhgW/14CAGRzyqlNbPQ1RP3evfb
         zUyGOoSpZH+gkltie/CaU3aek2qY3JljjaE50W7ZcCgD8883D5oROC4/DQZ69LQU3y7k
         mi6A==
X-Gm-Message-State: AOAM530aBTyMp1VlA8bMzmzqaoHxUE8+vTketk0cpaxMzZw8EFzyiM0r
        kf2Z/auxItwQvG0UPr2Gx/y3iZwHiLbs4hg9L0oaKy9FO3o=
X-Google-Smtp-Source: ABdhPJzAtDsFq2sRy+UlcoUFE+V6lAuAcSUAFj7SFgcdrYcD1arLZQoX3iEUIQGdcKoOz9vr2/8xG9K2S7A4FMvLJ9U=
X-Received: by 2002:a05:6122:2027:b0:35a:19c8:3ec7 with SMTP id
 l39-20020a056122202700b0035a19c83ec7mr3903786vkd.4.1653701580256; Fri, 27 May
 2022 18:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220526232606.64174-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220526232606.64174-1-yang.lee@linux.alibaba.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 27 May 2022 20:32:49 -0500
Message-ID: <CAH2r5muhKEaxgwJQG7s46h1v+1CHVEP441+x+W4dBk77QbYK2Q@mail.gmail.com>
Subject: Re: [PATCH -next] cifs: Remove duplicated include in cifssmb.c
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
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

I don't see this line (ie the include cifsfs.h) in fs/cifs/cifssmb.c
anymore could you do a "git blame" and find where that line was added
in for-next?

On Thu, May 26, 2022 at 11:27 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix following includecheck warning:
> ./fs/cifs/cifssmb.c: cifsfs.h is included more than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/cifs/cifssmb.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index e3457356ec11..193009f1421b 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -28,7 +28,6 @@
>  #include "cifsglob.h"
>  #include "cifsacl.h"
>  #include "cifsproto.h"
> -#include "cifsfs.h"
>  #include "cifs_unicode.h"
>  #include "cifs_debug.h"
>  #include "smb2proto.h"
> --
> 2.20.1.7.g153144c
>


-- 
Thanks,

Steve
