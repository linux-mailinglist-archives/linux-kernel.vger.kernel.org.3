Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9395D546FCF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346371AbiFJXEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiFJXEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9831038DB2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654902276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGzVE/SF8AaGh1ZlzjGdxVR1MK6N6sM70Y5WFzFs5GM=;
        b=fCxA9ASXOQFjTpuP9Lzr3bvI3iKX59mNggpdcJs38a28raJGQL7lI9/EMdnOVaHwcz3Rk9
        H33dzcK15j3N1ZoffmocGscG2/Pvm5+wr0vje5Yrn+3iBGsB7/+8JIewlXabMdSBQZlhMO
        2nlWrdDxGk/JZ/TrphqG5qD+NKOVA+E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-TB3s6MTPOq2ZBEYgNBXoDQ-1; Fri, 10 Jun 2022 19:04:33 -0400
X-MC-Unique: TB3s6MTPOq2ZBEYgNBXoDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABFE0811E75;
        Fri, 10 Jun 2022 23:04:32 +0000 (UTC)
Received: from [10.22.34.253] (unknown [10.22.34.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 652EF2166B26;
        Fri, 10 Jun 2022 23:04:32 +0000 (UTC)
Message-ID: <f8f612f1-0d32-4275-88e7-d1beb9b03b93@redhat.com>
Date:   Fri, 10 Jun 2022 19:04:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [REPOST PATCH] locking/lockdep: Remove
 lockdep_init_map_crosslock.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <YqITgY+2aPITu96z@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YqITgY+2aPITu96z@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 11:36, Sebastian Andrzej Siewior wrote:
> The cross-release bits have been removed, lockdep_init_map_crosslock() is
> a leftover.
>
> Remove lockdep_init_map_crosslock.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Link: https://lore.kernel.org/r/20220311164457.46461-1-bigeasy@linutronix.de
> ---
>   include/linux/lockdep.h |    1 -
>   1 file changed, 1 deletion(-)
>
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -431,7 +431,6 @@ enum xhlock_context_t {
>   	XHLOCK_CTX_NR,
>   };
>   
> -#define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
>   /*
>    * To initialize a lockdep_map statically use this macro.
>    * Note that _name must not be NULL.
>
Acked-by: Waiman Long <longman@redhat.com>


