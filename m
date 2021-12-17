Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50774794E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhLQTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhLQTiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:38:13 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B8C061574;
        Fri, 17 Dec 2021 11:38:12 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id p8so4977840ljo.5;
        Fri, 17 Dec 2021 11:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GW23enkVkLelgnifB0VDqCJ+lagCiFCUWHfynyjBCOc=;
        b=j4ev1owoREKlmXuli8yHkc54BJjYwfiEdH/03ThwFx+ksgmmulzIawFoLt0t1EhN8+
         0A6HbxysmmONZGq+pwkYvkpYUbs4dzwtD+g9osqT6IqUIQXWSZE5rZ37OYUJ1Xo9zvST
         4FcTufN1YY2mprVvUAkQsOSJbKSkpTFHoL/h8pPmnBnsV2oFYAKA6zlVv+DO9g0kGt62
         Fj3fNdLToKZyKBrSrpX2ie5N2ZXeb4OhyeiPSTVucNx8OiOMS58oa8q9Eqe8Vll3vBgs
         r25f3WDCJjJ6MP4SjeZeTxcCxd2ASzV2xPDxY3cyNxTMqlCwrAhMhb6nKdIScnb0r3Se
         1IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GW23enkVkLelgnifB0VDqCJ+lagCiFCUWHfynyjBCOc=;
        b=3HofODWhjQdF8D3WPLv2lpgTZxkDslDXC6WO4D4KGYWfVOUwbXr3X4rnj8gxBPPnFa
         +qy+e7pF7Xgs+UApnmLAqO6F+KwvDn2Ehqr4vXKOf7OLl9W3UgtQeJFC7zMKtuGDy1X5
         eMcL35WJ3B4aaHESscq846B9Ia2Loaye5F+C8ET2SsxOMdwAvUend69YSfch6spohYTw
         O98ntMBN+GlbchfXoq0mniQEjmA3r8v78Wr7HgQImp4wZs24MchXB7+zapP1r/UQbx0X
         kJz4PmxP5mKpTVHL0DBdMulVcgYMpjbmteDbsd+Es2KLZY5vwXgQJ9r9WdxwP3aTA9/F
         XEDw==
X-Gm-Message-State: AOAM532LBq6iFWaH/vcE43+E6JWSNNu6J1kLAdfP9wa6pclNSBXedbtx
        UgMQlmgMhvwGeKG36QXIy+0KVEZXBsrZpC/O1lVWQh3i
X-Google-Smtp-Source: ABdhPJxnzbFle2KJ/winhKxA0sMz+f6aJ9pCL0hM9136+/dhFni1htCAHQ1xxnjhgmXXkSlutMKdzI2rMc77Ogk3Uus=
X-Received: by 2002:a05:651c:154a:: with SMTP id y10mr3932487ljp.314.1639769890970;
 Fri, 17 Dec 2021 11:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20211216124317.4143405-1-broonie@kernel.org>
In-Reply-To: <20211216124317.4143405-1-broonie@kernel.org>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 17 Dec 2021 13:38:00 -0600
Message-ID: <CAH2r5muO9aTksvqD9v+sOQ2z-Xp3Rzbi9mPtfc0ad57jZG5aFw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the cifs tree with the fscache tree
To:     broonie@kernel.org
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,
This cifs fscache fix should be upstream soon, so you should be able
to update the fscache series ontop of updated kernel soon

On Thu, Dec 16, 2021 at 6:43 AM <broonie@kernel.org> wrote:
>
> Hi all,
>
> Today's linux-next merge of the cifs tree got a conflict in:
>
>   fs/cifs/inode.c
>
> between commit:
>
>   830c476f5eb82 ("cifs: Support fscache indexing rewrite (untested)")
>
> from the fscache tree and commit:
>
>   68f87ec9c1ce3 ("cifs: ignore resource_id while getting fscache super cookie")
>
> from the cifs tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --cc fs/cifs/inode.c
> index dc2fe76450b96,279622e4eb1c2..0000000000000
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@@ -1372,20 -1370,6 +1367,7 @@@ iget_no_retry
>                 iget_failed(inode);
>                 inode = ERR_PTR(rc);
>         }
>  +
> -       if (!rc) {
> -               /*
> -                * The cookie is initialized from volume info returned above.
> -                * Inside cifs_fscache_get_super_cookie it checks
> -                * that we do not get super cookie twice.
> -                */
> -               rc = cifs_fscache_get_super_cookie(tcon);
> -               if (rc < 0) {
> -                       iget_failed(inode);
> -                       inode = ERR_PTR(rc);
> -               }
> -       }
> -
>   out:
>         kfree(path);
>         free_xid(xid);



-- 
Thanks,

Steve
