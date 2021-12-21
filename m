Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FC847BF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbhLULkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:40:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53772 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbhLULj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:39:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38C4F6153C;
        Tue, 21 Dec 2021 11:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FABC36AF4;
        Tue, 21 Dec 2021 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640086798;
        bh=FZveIUfSLfCEZ1y0HfpyCoozxsgZmMxrhPNBuggw9dc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YyaC04+iHm3HCJGC9E2C40+3bVu/qLLlAVy5b7+loiUEADd9jUwQU0LmJ48GBdpAG
         gBNdD4v0wlsMufOeHD+LPNdN4Sau/5okchAnLgZuSADk0SXd8W9zV+fElH0yhJymz7
         6vW6Q/MXj1r1FGIhctGFQv/gYpa26friD4MAkdwmBJgKMGO5kkjjyJBuTBGfU2p/+O
         S8nhXBEVe7FZtbQVQZlNtebh4Xm5u6nSlaL10UUpYi3y13hsCqd2sTDPbIM7pAfspq
         1JHl94PgI/IUGlTlca8QCAv7RstUxHcuwRsVqBbvH4mwUfUQcpYQuPieaJUYA8pjAD
         dVsh0ULUW7s4A==
Received: by mail-ot1-f53.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso16353021otf.0;
        Tue, 21 Dec 2021 03:39:58 -0800 (PST)
X-Gm-Message-State: AOAM533lRAWy3ATzxzyyKu0/4V/jcrFynG6QqRE4dh4T5A8HbMuIAivl
        YbeAv5jDEHJeuzUbG/mP8PzYJD3kYVNAWnvohp4=
X-Google-Smtp-Source: ABdhPJwcUhvpKWIr2DIfWcBlHa2apSuyJ0A17Xaah/Z1k9S/dtSf0z1WUHPmahfEPQDvYBZmR7Ln+0ZhtSPwCQXL3tE=
X-Received: by 2002:a9d:43:: with SMTP id 61mr1855862ota.18.1640086797831;
 Tue, 21 Dec 2021 03:39:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:428a:0:0:0:0:0 with HTTP; Tue, 21 Dec 2021 03:39:57
 -0800 (PST)
In-Reply-To: <20211221090714.122543-2-yang.lee@linux.alibaba.com>
References: <20211221090714.122543-1-yang.lee@linux.alibaba.com> <20211221090714.122543-2-yang.lee@linux.alibaba.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 21 Dec 2021 20:39:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_5M6Wajx2Zqv9vaAs1oRLO7YCv4iKxzoqpZ4UqVc+oPA@mail.gmail.com>
Message-ID: <CAKYAXd_5M6Wajx2Zqv9vaAs1oRLO7YCv4iKxzoqpZ4UqVc+oPA@mail.gmail.com>
Subject: Re: [PATCH -next 2/4] ksmbd: Fix smb2_set_info_file() kernel-doc comment
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     senozhatsky@chromium.org, sfrench@samba.org, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021-12-21 18:07 GMT+09:00, Yang Li <yang.lee@linux.alibaba.com>:
> Fix argument list that the kdoc format and script verified in
> smb2_set_info_file().
>
> The warnings were found by running scripts/kernel-doc, which is
> caused by using 'make W=1'.
> fs/ksmbd/smb2pdu.c:5862: warning: Function parameter or member 'req' not
> described in 'smb2_set_info_file'
> fs/ksmbd/smb2pdu.c:5862: warning: Excess function parameter 'info_class'
> description in 'smb2_set_info_file'
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 9496e268e3af ("ksmbd: add request buffer validation in
> smb2_set_info")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/ksmbd/smb2pdu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index ee2bcd02d0d7..2d55a186b825 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -5850,7 +5850,7 @@ static int set_file_mode_info(struct ksmbd_file *fp,
>   * smb2_set_info_file() - handler for smb2 set info command
>   * @work:	smb work containing set info command buffer
>   * @fp:		ksmbd_file pointer
> - * @info_class:	smb2 set info class
> + * @req:        request buffer validation
I will directly update it to "request buffer pointer".

About your 4 patches, Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
>   * @share:	ksmbd_share_config pointer
>   *
>   * Return:	0 on success, otherwise error
> --
> 2.20.1.7.g153144c
>
>
