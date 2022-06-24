Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19BE55A17C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiFXTTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:19:30 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D2E4A3C4;
        Fri, 24 Jun 2022 12:19:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 103332A0;
        Fri, 24 Jun 2022 19:19:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 103332A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656098369; bh=9Ji5uLZz14A869gxBwYDwBrsjygfs3ud5yvyYK8Xbmg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mDWmnAjzvDkjRjnlf4DD4PyNEdlYn04kg1Icj0fKVAssVGs131dRlEfCA5MyMCcyT
         gknETvSyErbSXsekzBaN5RZ2QOwPMJQyipg1KXPedZUk0GbRV9T1YzDixPttDM8Oud
         0ZujCFSX/jSlrsmMJzXcAf+vWcB4fxko4RBZvKVAlDTiNjqMcw9gSaRl40wV/KoRUZ
         matOay0OZrHxaIZd6pNuU9/7qBTlsKyzMmMoTFmA9F992Cd2+biDPg1cUGY0W9sSBp
         siDWxMF+O3rNYHzum6V+BA7/DL12zZSJFLK3ZpJG6uOreZJmyeJHyNRt/y7elWBxGb
         XZ80ZIYo1f2/A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Lung <1030steven@gmail.com>
Cc:     johannes@sipsolutions.net, linux-um@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Lung <1030steven@gmail.com>
Subject: Re: [PATCH] docs: UML: fix typo
In-Reply-To: <20220621072910.4704-1-1030steven@gmail.com>
References: <20220621072910.4704-1-1030steven@gmail.com>
Date:   Fri, 24 Jun 2022 13:19:28 -0600
Message-ID: <87k09550ov.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Lung <1030steven@gmail.com> writes:

> Replace 'absense' with 'absence'.
>
> Signed-off-by: Steven Lung <1030steven@gmail.com>
> ---
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 863f67b72..af2a97429 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -322,7 +322,7 @@ Shared Options
>  * ``v6=[0,1]`` to specify if a v6 connection is desired for all
>    transports which operate over IP. Additionally, for transports that
>    have some differences in the way they operate over v4 and v6 (for example
> -  EoL2TPv3), sets the correct mode of operation. In the absense of this
> +  EoL2TPv3), sets the correct mode of operation. In the absence of this
>    option, the socket type is determined based on what do the src and dst

Applied, thanks.  Congratulations on (I think) your first kernel patch.

jon
