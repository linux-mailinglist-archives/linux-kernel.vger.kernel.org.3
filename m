Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F8573D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiGMT7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiGMT7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:59:35 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5DE2C66D;
        Wed, 13 Jul 2022 12:59:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C9F242B2;
        Wed, 13 Jul 2022 19:59:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C9F242B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657742373; bh=Do9uHLHyAyHu2lpSZWRJT0iOh1Ss7Aj4K6hs6hKuVOE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UpPOC2dbrvMdzoMrJVSBxpR4RBctDg0foauekyxOBZZcASr66WgLnvgRW2q4QxJR/
         1PP/HHxkA1P4E9QchroGOjZb2maKJrh7OwCuhDqD4ZeLGvescJrRubi8Y+SUKBiPC3
         BMHR11bpf9j9gL+SO6eL0agpCqQJ+KgXAfEDGOPj8ungJJ6beVfIoAnPmWx/0LlbHk
         nE/hCT2lQYuzXhRsNfmhWv6ETmWmG5aY/vMowPJuZ4eBju9zam7gfP+R/8Y85tNbOQ
         5xhk6e0uDMgEdAV2YLyva9peZQ3C+zQFjlbKWkssJLAXvqBfX5Gzju32gRabHgQsve
         p3eElikcK1qdQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Hu Haowen <src.res@email.cn>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mark linux-doc-tw-discuss mailing list
 moderated
In-Reply-To: <20220713043516.19290-1-lukas.bulwahn@gmail.com>
References: <20220713043516.19290-1-lukas.bulwahn@gmail.com>
Date:   Wed, 13 Jul 2022 13:59:33 -0600
Message-ID: <87k08g4wd6.fsf@meer.lwn.net>
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

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> After sending a patch to linux-doc-tw-discuss@lists.sourceforge.net, I got
> the typical response for a moderated list:
>
>   Your mail to 'linux-doc-tw-discuss' with the subject
>   ....
>   Is being held until the list moderator can review it for approval.
>
>   The reason it is being held:
>
>       Post by non-member to a members-only list
>
> Mark this mailing list moderated in MAINTAINERS.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5aeaddc9539..1320d3eaf198 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20579,7 +20579,7 @@ F:	tools/tracing/rtla/
>  
>  TRADITIONAL CHINESE DOCUMENTATION
>  M:	Hu Haowen <src.res@email.cn>
> -L:	linux-doc-tw-discuss@lists.sourceforge.net
> +L:	linux-doc-tw-discuss@lists.sourceforge.net (moderated for non-subscribers)
>  S:	Maintained
>  W:	https://github.com/srcres258/linux-doc
>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw

Applied, thanks.

jon
