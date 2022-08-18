Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151D9598A31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbiHRRR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344942AbiHRRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:17:04 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CA13ECDE;
        Thu, 18 Aug 2022 10:12:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5AB78380;
        Thu, 18 Aug 2022 17:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5AB78380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1660842758; bh=4ybYsjK0e5ul649Sz0YfXQzYl1VJiqfOwsXXBK0Ryqg=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=RCrFUDBQFiCUrVBn3rHGkhM0xPBYhn1gU+AeVUTD8YfehIxtLhCemtCg+ekd2ioQh
         i0HsAV0k7dDSXSz2vAiS8GkRuGHhnECYCyYUBBusfJNdE+T29XJFTKqpCvl28NzTVX
         18KTMNsuLvEw/qh9sWC4/5Q3pWC8gOu7XECHooTOAr37xx92d4vUqj14W4E3gcxuff
         FYG+jioX7OBhUTDrq3/xfNgQ1OU23LdDG9RKKeSI8oXOaaCTRnapWjYHpEPbjDxzXh
         W29YTd6CSFp0H5e0xKDA3wEH6wS5dTNH6eeMCHdgX5GXZLoxQ4I9YXvFvx5XaaPvHV
         JJonFd4z+9Xvg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Eric Lin <dslin1010@gmail.com>, maz@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: irqdomain: Fix typo of "at least once"
In-Reply-To: <20220811091516.2107908-1-dslin1010@gmail.com>
References: <20220811091516.2107908-1-dslin1010@gmail.com>
Date:   Thu, 18 Aug 2022 11:12:37 -0600
Message-ID: <875yipcw6y.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Lin <dslin1010@gmail.com> writes:

> Signed-off-by: Eric Lin <dslin1010@gmail.com>
> ---
>  Documentation/core-api/irq/irq-domain.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
> index d30b4d0a9769..f88a6ee67a35 100644
> --- a/Documentation/core-api/irq/irq-domain.rst
> +++ b/Documentation/core-api/irq/irq-domain.rst
> @@ -71,7 +71,7 @@ variety of methods:
>  Note that irq domain lookups must happen in contexts that are
>  compatible with a RCU read-side critical section.
>  
> -The irq_create_mapping() function must be called *atleast once*
> +The irq_create_mapping() function must be called *at least once*
>  before any call to irq_find_mapping(), lest the descriptor will not
>  be allocated.

Applied, thanks.

jon
