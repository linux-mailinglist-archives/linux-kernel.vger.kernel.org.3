Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F8350839B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376842AbiDTImt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376822AbiDTImq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:42:46 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3469F646C;
        Wed, 20 Apr 2022 01:40:01 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2A1DA536;
        Wed, 20 Apr 2022 08:39:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2A1DA536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650444000; bh=OnN39R9Apu7YvIQoa0s8yg2B9NbuSBGKFjgbCsdXhHw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V1zs1SBe2oZKWhPzw8DJaL9G0DdbtcHxoGotyLOq9dwIrMnp42pyhAxlnsA3Galms
         WLeUfL8EcM5XHUb1dq+Txxv/HU5FJbTy9YH0Bi7MRXtFelks0ET1t1U0KPUu+OS5Y1
         6G1s1YZ+Vc6HZl0mIxeMIkYNQgDieuZl/kJyaCSnDq6bxXVUkfvHBfKOIkSs+fc02+
         OPj1z2PgAgo8U8Scboy3ARWnQKXoTYzmYzY6VvcRoB81drDC20+5sPAjz0TBcf7aax
         LnvcIMELiYtaCrrEqM87bSkZ5J5dOaCwXq0o//tXkOcCOYxA2No6i9VQQ30ns81454
         IxtkNa4rMmayg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH] rtla: Documentation: fix email addresses
In-Reply-To: <20220418011450.11821-1-rdunlap@infradead.org>
References: <20220418011450.11821-1-rdunlap@infradead.org>
Date:   Wed, 20 Apr 2022 02:39:57 -0600
Message-ID: <87fsm84082.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Correct lkml@vger to linux-kernel@vger.
> Add linux-trace-devel since that is what is in the MAINTAINERS file.
>
> Fixes: d40d48e1f1f2 ("rtla: Add Documentation")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> ---
>  Documentation/tools/rtla/common_appendix.rst |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- a/Documentation/tools/rtla/common_appendix.rst
> +++ b/Documentation/tools/rtla/common_appendix.rst
> @@ -1,6 +1,7 @@
>  REPORTING BUGS
>  ==============
> -Report bugs to <lkml@vger.kernel.org>
> +Report bugs to <linux-kernel@vger.kernel.org>
> +and <linux-trace-devel@vger.kernel.org>

Applied, thanks.

jon
