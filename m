Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59955A17B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiFXTLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiFXTLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:11:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB70E82396;
        Fri, 24 Jun 2022 12:11:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3B27A31A;
        Fri, 24 Jun 2022 19:11:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3B27A31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656097896; bh=/hcWFSxgiaiNcPhaw2iwtRiQyURtEUizPdBnFLZxYPw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=G/U+ZVLp6azbvZkvALXTUCqCtphtC5wJVs/vvq7aN/jIuetNE/bTvWw8LGMdDxnvF
         AkQi1BerBWi0MZxZy0xDGs4qoDsUPnh3a+qrC9utEw3dy2hlP5shimQnO1+OHfJSWG
         qH+2FwUo5jp86gWWP2R2GKx4iGn5mNRT+SKNv/j0za9cEzxrEh6T6zcaO/Vj0u64Ne
         zA3FFwt1POOanp4EVM4PmRgF4zMRnSIpUSyxgLRWia5HT/xWendEuuOZuZEti4fCsS
         cYC+uDR9r/+zZa2WFjnnYDLCvRzKIaXmrpK/Gf335Fk2N42wIPL1tXnONVEs+ZTROe
         UAlX1pQMLjKmA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Deming Wang <wangdeming@inspur.com>, miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] media: docs: Modify the section of User xattr
In-Reply-To: <20220624014605.2007-1-wangdeming@inspur.com>
References: <20220624014605.2007-1-wangdeming@inspur.com>
Date:   Fri, 24 Jun 2022 13:11:35 -0600
Message-ID: <87wnd55120.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deming Wang <wangdeming@inspur.com> writes:

> Delete duplicate words of "the".
>
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  Documentation/filesystems/overlayfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> index 7da6c30ed596..4c76fda07645 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -607,7 +607,7 @@ can be removed.
>  User xattr
>  ----------
>  
> -The the "-o userxattr" mount option forces overlayfs to use the
> +The "-o userxattr" mount option forces overlayfs to use the
>  "user.overlay." xattr namespace instead of "trusted.overlay.".  This is
>  useful for unprivileged mounting of overlayfs.

I've applied this but changed the patch title.  This is not a media
patch, and "modify" tells the reader nothing; it's now "docs: Remove
duplicate word".

Thanks,

jon
