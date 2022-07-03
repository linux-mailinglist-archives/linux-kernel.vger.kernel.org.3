Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03145644BD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiGCE2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiGCE2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:28:30 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42C65A0;
        Sat,  2 Jul 2022 21:28:29 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id t127so6020303vsb.8;
        Sat, 02 Jul 2022 21:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPp1iqE9WbnI1BB7CGfKQapKem5vMNrsn0GT1sug9GI=;
        b=RXNkE9JF6DjC19sZwzs3/ijuoY4C1yRyI7c4OQwd2w3npPywV4ggvjUuGMIB3dxbEU
         FlEXg0Wvf5yXXLFMnk9WJ5yAQIp/p1QEWHj6wfgtRhNHzKCJxzm0gAcvqJ+LaVg1TGQc
         9sU1d4jC372iPJllloxMm83ytNqmDg2qBlMzI2awz0diZqu9hPSP+hjOE5Hkn29hVk2o
         xFQg8WWk6Ygott4BaP8PlN9Wo8ScKAZpNnraCOKmNptF2/DDrk7A/fGpYnxfQ0XVHf6n
         GxC8YbrB68/VTxo29zdkb+W2/Nx9rmI17dP2LzKXLR+lFSIHtnt4Z+zt6tt8vNR468d7
         XHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPp1iqE9WbnI1BB7CGfKQapKem5vMNrsn0GT1sug9GI=;
        b=s++ibSsqkp90c3aTQ1tLKyeH3+VKVf0ELEVMc21zsLhCN2VA5lnHsoQNwXmK5hqU3b
         dxBDTFgr/ahdngyU8EhuLXpnqlkJggGFCUtxKa8yfzHiP37aExfV9BwTVKqEFcsZ2yFH
         ls0d7Vtsdpq6zIAD3ct0y2HSi+gv5/nqzjHCI3BrEoCE2Ft0eL+xdhXrOfijHS5Jab3k
         zlxkSHi6CIPwxb26vVkbNgCtyCYMwOCWFd6uk90cdGS2aMBJa8Pnt9G94J+csX1mNfSM
         o5oh+kZ2uCewlQ8lzMXG8fXeATrFYeKyWW7fwZPA1BZl+7ZWQUWZ2mCGwa2XfX3dlOWa
         5BLQ==
X-Gm-Message-State: AJIora+1KjRhTnjqFnsE0MuTztGq6+T44PD1Vk3rDn5LZNI1CEeqh5Gf
        CdJnE9W2NE69s6J+tXA2fWst0FZfaD6rry32lF/4trsB+OE=
X-Google-Smtp-Source: AGRyM1uWamAWth4kZc4SzjqduqRteA3dvdPek5fMaJyOpogJGLVS3NqZezhwbI0Em/Z7D0JYB63jsHyi/RV6ymwF+0I=
X-Received: by 2002:a67:fe50:0:b0:356:a09d:afe4 with SMTP id
 m16-20020a67fe50000000b00356a09dafe4mr4322566vsr.6.1656822508482; Sat, 02 Jul
 2022 21:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220628213229.354032-1-colin.i.king@gmail.com>
In-Reply-To: <20220628213229.354032-1-colin.i.king@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 2 Jul 2022 23:28:17 -0500
Message-ID: <CAH2r5mucQ9LRBO9Kw6dEeSG=fWsbUnOv=C9b5Bp+fZg_Ox-7-w@mail.gmail.com>
Subject: Re: [PATCH] cifs: remove redundant initialization to variable mnt_sign_enabled
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

merged into cifs-2.6.git for-next

On Tue, Jun 28, 2022 at 4:40 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Variable mnt_sign_enabled is being initialized with a value that
> is never read, it is being reassigned later on with a different
> value. The initialization is redundant and can be removed.
>
> Cleans up clang scan-build warning:
> fs/cifs/cifssmb.c:465:7: warning: Value stored to 'mnt_sign_enabled
>  during its initialization is never read
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/cifs/cifssmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 6371b9eebdad..9ed21752f2df 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -462,7 +462,7 @@ cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required)
>  {
>         bool srv_sign_required = server->sec_mode & server->vals->signing_required;
>         bool srv_sign_enabled = server->sec_mode & server->vals->signing_enabled;
> -       bool mnt_sign_enabled = global_secflags & CIFSSEC_MAY_SIGN;
> +       bool mnt_sign_enabled;
>
>         /*
>          * Is signing required by mnt options? If not then check
> --
> 2.35.3
>


-- 
Thanks,

Steve
