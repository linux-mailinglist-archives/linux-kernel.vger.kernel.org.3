Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F75A9986
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiIAN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiIAN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:56:47 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F4A54CA2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:56:46 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11f11d932a8so23325944fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=I6b2BpVPciHMhVZH7YUBZEI4uoChzNOCc33KlKxQssU=;
        b=UfYagmTCEAKlJiF5vi9Lr4zhbHBYRckggijCHnrDqm9tdNhJroir28h2rwqGdpX+sk
         bM9G4RF1NQXxJkb+WSLhb+DNdA4zYtWHOeKkoUJU/gn4R7xXldKgldHrvGWKm0MgsszT
         JNLT7Fipig6CmtfO5qF57rUTh1wjU8SW2aleHywPOZBU4t9AxJy3qSN12N44DvWvqnQI
         qq6IKO+Fz/J1QlCe4s+BhLxonUQdOgBEJQYs4Haq/9MkDWXxBCHkJDIO3z2qDjGcvPQN
         MZ0z0P6jfZILZbGYcWu7kfSNnvvXZB5FPoKcZvG7LNetYcf96Dl398fGyrxEPN5HT1tW
         wHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=I6b2BpVPciHMhVZH7YUBZEI4uoChzNOCc33KlKxQssU=;
        b=LI67KRUyNablrFOI0AcMG+FvIvqYDqHZSZnlaLdMPzmVYNIjEkpCUASvqF7r1wLM7W
         7VBZbF/hiYCePXWzID4nHrVicaO3JZ8OltJQg01Z+uOIFwra4Z+mZppg2VKIbSYYJCzL
         VjBurojOg/t2HSJPVd3aHdshStQsbWsJE/1av2JhgeBJLq1yWW54U9IGmHlINbJYRVez
         UJ9kfPDYfb3SykPzFVF+0ImCyZBw4zhWuqD7TWCUIIgOdJFrUrzDN/6OiMTFTYMetuyC
         DFK4lHi6tAy6DRf8M9dkgS2/cJ7e4h3bUiTWb2f7LIDiDXKvGebBP5pWqkCcFiML/jug
         IWSw==
X-Gm-Message-State: ACgBeo3SYckA1S+8km+X5gcrJGB+nLfylfFcHyfXHCi2jtEiWhLGv82+
        kQPRu4f8dAowGuhn9rGAEqtkcwM7ZWNBhnZn3gm9B1ZDWQ==
X-Google-Smtp-Source: AA6agR6sJmqeUCe9RB5vYfnF5hulI5nC7gPvNmZKeMuLtjUoo0UVYScgBw5MsE89TbGdAZbxgapbu7NuE7Gc4/ZtmGk=
X-Received: by 2002:a05:6808:bd1:b0:345:da59:d3ae with SMTP id
 o17-20020a0568080bd100b00345da59d3aemr3525523oik.136.1662040605439; Thu, 01
 Sep 2022 06:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220901122739.6d1a54ef@canb.auug.org.au>
In-Reply-To: <20220901122739.6d1a54ef@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Sep 2022 09:56:34 -0400
Message-ID: <CAHC9VhQV2qW3o_bPnabhfdN_YoY7n7ncU1-8cUpVHhPZ1iLWQw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the security tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Frederick Lawler <fred@cloudflare.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:27 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the security tree got a conflict in:
>
>   security/selinux/include/classmap.h
>
> between commit:
>
>   f4d653dcaa4e ("selinux: implement the security_uring_cmd() LSM hook")
>
> from Linus' tree and commit:
>
>   ed5d44d42c95 ("selinux: Implement userns_create hook")
>
> from the security tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc security/selinux/include/classmap.h
> index 1c2f41ff4e55,0bff55bb9cde..000000000000
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@@ -253,7 -253,9 +253,9 @@@ const struct security_class_mapping sec
>         { "anon_inode",
>           { COMMON_FILE_PERMS, NULL } },
>         { "io_uring",
>  -        { "override_creds", "sqpoll", NULL } },
>  +        { "override_creds", "sqpoll", "cmd", NULL } },
> +       { "user_namespace",
> +         { "create", NULL } },
>         { NULL }
>     };

Thanks Stephen, that looks correct.

-- 
paul-moore.com
