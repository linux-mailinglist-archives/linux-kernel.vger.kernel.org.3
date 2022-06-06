Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C3453EC80
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbiFFP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbiFFP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:57:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D7C1D0DF;
        Mon,  6 Jun 2022 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hU4R6/iBUp/dtfX8tAmKB9EUg/WAL2XOAVfbzaq0EuI=; b=g/yFzWijqEL9LMtS5EQv5ECnHg
        hUKbaD3IP81alwyiJ4M+Iouw1RTHClicmOLvYX/p/+fpvEBOGbNYYg80TOcmDW6u7OPFb+8LvLD16
        b7a3HQFKdn+rNC8Z+wUibs6Gi3cTnSla/iHwicYSBCyAub4EPJOxSaPdQ0mUXU6ZcgHB4T+RRAtZp
        o/uuWLb3AxKdtSCVKkMDKqVPbj9Og7YVWBcqsKZqsF7WdRd4w0cNSUg63PKYO8UQJjeUiWBdXdCay
        22mAamJMNE8fsPbp2wFLsmSw6Pwjzwl4Uc4OvoiPYt1flrO/fgC6MHYu4SZJNigTZcBq9HGzpOoB1
        w8Ckvcbg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyF61-005URP-SA; Mon, 06 Jun 2022 15:56:51 +0000
Message-ID: <d01a18b0-f582-f1de-eab5-78e34f014e7b@infradead.org>
Date:   Mon, 6 Jun 2022 08:56:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 09/23] Documentation: update watch_queue.rst references
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1654529011.git.mchehab@kernel.org>
 <6fc832114fac77b56b9e47aa300654bf30cc0fad.1654529011.git.mchehab@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6fc832114fac77b56b9e47aa300654bf30cc0fad.1654529011.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 6/6/22 08:25, Mauro Carvalho Chehab wrote:
> Changeset f5461124d59b ("Documentation: move watch_queue to core-api")
> renamed: Documentation/watch_queue.rst
> to: Documentation/core-api/watch_queue.rst.
> 
> Update the cross-references accordingly.
> 
> Fixes: f5461124d59b ("Documentation: move watch_queue to core-api")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---

Oops. Thanks for the update.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/
> 
>  Documentation/security/keys/core.rst | 2 +-
>  include/linux/watch_queue.h          | 2 +-
>  init/Kconfig                         | 2 +-
>  kernel/watch_queue.c                 | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
> index b3ed5c581034..811b905b56bf 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -1046,7 +1046,7 @@ The keyctl syscall functions are:
>       "filter" is either NULL to remove a watch or a filter specification to
>       indicate what events are required from the key.
>  
> -     See Documentation/watch_queue.rst for more information.
> +     See Documentation/core-api/watch_queue.rst for more information.
>  
>       Note that only one watch may be emplaced for any particular { key,
>       queue_fd } combination.
> diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
> index 3b9a40ae8bdb..fc6bba20273b 100644
> --- a/include/linux/watch_queue.h
> +++ b/include/linux/watch_queue.h
> @@ -4,7 +4,7 @@
>   * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
>   * Written by David Howells (dhowells@redhat.com)
>   *
> - * See Documentation/watch_queue.rst
> + * See Documentation/core-api/watch_queue.rst
>   */
>  
>  #ifndef _LINUX_WATCH_QUEUE_H
> diff --git a/init/Kconfig b/init/Kconfig
> index c984afc489de..c84ceb2b2b9f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -414,7 +414,7 @@ config WATCH_QUEUE
>  	  with watches for key/keyring change notifications and device
>  	  notifications.
>  
> -	  See Documentation/watch_queue.rst
> +	  See Documentation/core-api/watch_queue.rst
>  
>  config CROSS_MEMORY_ATTACH
>  	bool "Enable process_vm_readv/writev syscalls"
> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> index 230038d4f908..869fea4fe26b 100644
> --- a/kernel/watch_queue.c
> +++ b/kernel/watch_queue.c
> @@ -4,7 +4,7 @@
>   * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
>   * Written by David Howells (dhowells@redhat.com)
>   *
> - * See Documentation/watch_queue.rst
> + * See Documentation/core-api/watch_queue.rst
>   */
>  
>  #define pr_fmt(fmt) "watchq: " fmt

-- 
~Randy
