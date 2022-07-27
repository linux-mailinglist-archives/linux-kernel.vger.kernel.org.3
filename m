Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C65822E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiG0JOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiG0JOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:14:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAD4FC2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:13:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v5so10144125wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yGOC0yzOwk2ivyOmjUhHiy+4brmp+dp+tJmS/rscJ4A=;
        b=NOjV7VNiYCi1rRKx6ZgsktE8t50WNfR5DF/rY/r0hHfl9xwf/fVyO7N2/i0fCGv1Co
         Z5b4SASyQsTgQNpoP0+PouhRN7AUA+beX7KgfvelkwOY88afmOGn1XEwt3LRkJpdShLC
         44gMQYPRTScnXD9p1YP1eS71+vCvcEELoShlAqMaWfG6025BlAX4VN4hSxoeRJ+VHK5G
         SK+dpR0rGsCSIjg56z5f9U1pt2kgpMA0EcrllmVNjoXyFriPpYUUDQzGg25ESVnw2NvL
         LiJEMiYD++9X9a8LxUXz/VH/Xhoty1tq1jWDp1xoibS81TxCmM9WD/LY7vxRVZ3jv+9/
         vlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yGOC0yzOwk2ivyOmjUhHiy+4brmp+dp+tJmS/rscJ4A=;
        b=ThDhfQcAsxR9ZGYm4MickAdK+nWb4vpyL9ynG5zSPKoBD/8ZxRP8b/nWjdKrSX4izk
         LxAaMsIPedHv6rfCso5bQrXkBi9emHgHoSVe+t1Bt49csHJ7wfjLDVHe24A2n4JYAGAO
         zjU7ByiQLtSb+qkU0KV5QSXtgKR4yELlwK6MLUFdJ+UNPyGcp7lKWdU8BVa0VDx8amUB
         EdEdYQMfGLNJ2qZno/Si77VP29dWoP+LZIHBqcE8vIRDY5sVTMkHebSniCZpGTD+HQJH
         2+RKyKEaI/arw4DHxaGCZN33Ey0GAHNcxRZxa1nCtLuEr6w+XzYCOBEuWKyttElCGyKl
         Sl/g==
X-Gm-Message-State: AJIora//DEcNUWXmGoZ0UxNGTnuH6QGTFE3mghXLoAxzPj5RABcunj4f
        J7KlPB/XrS9qeFAdA0EmWruAHzSB3cwncQ==
X-Google-Smtp-Source: AGRyM1vFTaSMiSRGpOF33y4BBk8NEA0MsIE4LCK0TVhGQ9rRWaXcxOExPpnTCiNQgHBroF/wf4Glfw==
X-Received: by 2002:a05:600c:b5a:b0:3a3:186f:a564 with SMTP id k26-20020a05600c0b5a00b003a3186fa564mr2342980wmr.71.1658913206348;
        Wed, 27 Jul 2022 02:13:26 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::22ef? ([2620:10d:c093:600::1:754a])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c1d1500b003a326b84340sm1642856wms.44.2022.07.27.02.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 02:13:25 -0700 (PDT)
Message-ID: <06afa5b9-95d9-a58b-3b03-5a43faa582cf@gmail.com>
Date:   Wed, 27 Jul 2022 10:12:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [axboe-block:for-5.20/io_uring-zerocopy-send 23/23]
 io_uring/notif.c:52:23: error: implicit declaration of function
 'io_alloc_req_refill'; did you mean 'io_rsrc_refs_refill'?
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <202207271204.TWHjABcr-lkp@intel.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <202207271204.TWHjABcr-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 05:31, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.20/io_uring-zerocopy-send
> head:   fbe6f6bc3210e853aab74f20da776c15c5b052fe
> commit: fbe6f6bc3210e853aab74f20da776c15c5b052fe [23/23] io_uring/zc: notification completion optimisation
> config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220727/202207271204.TWHjABcr-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>          # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=fbe6f6bc3210e853aab74f20da776c15c5b052fe
>          git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>          git fetch --no-tags axboe-block for-5.20/io_uring-zerocopy-send
>          git checkout fbe6f6bc3210e853aab74f20da776c15c5b052fe
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>

Looks like I forgot to send a patch it depends on, thanks!


> All error/warnings (new ones prefixed by >>):
> 
>     In file included from include/linux/export.h:33,
>                      from include/linux/linkage.h:7,
>                      from include/linux/kernel.h:17,
>                      from io_uring/notif.c:1:
>     io_uring/notif.c: In function 'io_alloc_notif':
>>> io_uring/notif.c:52:23: error: implicit declaration of function 'io_alloc_req_refill'; did you mean 'io_rsrc_refs_refill'? [-Werror=implicit-function-declaration]
>        52 |         if (unlikely(!io_alloc_req_refill(ctx)))
>           |                       ^~~~~~~~~~~~~~~~~~~
>     include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
>        78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>           |                                             ^
>>> io_uring/notif.c:54:17: error: implicit declaration of function 'io_alloc_req'; did you mean 'xa_alloc_irq'? [-Werror=implicit-function-declaration]
>        54 |         notif = io_alloc_req(ctx);
>           |                 ^~~~~~~~~~~~
>           |                 xa_alloc_irq
>>> io_uring/notif.c:54:15: warning: assignment to 'struct io_kiocb *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>        54 |         notif = io_alloc_req(ctx);
>           |               ^
>     cc1: some warnings being treated as errors
> 
> 
> vim +52 io_uring/notif.c
> 
>     > 1	#include <linux/kernel.h>
>       2	#include <linux/errno.h>
>       3	#include <linux/file.h>
>       4	#include <linux/slab.h>
>       5	#include <linux/net.h>
>       6	#include <linux/io_uring.h>
>       7	
>       8	#include "io_uring.h"
>       9	#include "notif.h"
>      10	#include "rsrc.h"
>      11	
>      12	static void __io_notif_complete_tw(struct io_kiocb *notif, bool *locked)
>      13	{
>      14		struct io_notif_data *nd = io_notif_to_data(notif);
>      15		struct io_ring_ctx *ctx = notif->ctx;
>      16	
>      17		if (nd->account_pages && ctx->user) {
>      18			__io_unaccount_mem(ctx->user, nd->account_pages);
>      19			nd->account_pages = 0;
>      20		}
>      21		io_req_task_complete(notif, locked);
>      22	}
>      23	
>      24	static inline void io_notif_complete(struct io_kiocb *notif)
>      25		__must_hold(&notif->ctx->uring_lock)
>      26	{
>      27		bool locked = true;
>      28	
>      29		__io_notif_complete_tw(notif, &locked);
>      30	}
>      31	
>      32	static void io_uring_tx_zerocopy_callback(struct sk_buff *skb,
>      33						  struct ubuf_info *uarg,
>      34						  bool success)
>      35	{
>      36		struct io_notif_data *nd = container_of(uarg, struct io_notif_data, uarg);
>      37		struct io_kiocb *notif = cmd_to_io_kiocb(nd);
>      38	
>      39		if (refcount_dec_and_test(&uarg->refcnt)) {
>      40			notif->io_task_work.func = __io_notif_complete_tw;
>      41			io_req_task_work_add(notif);
>      42		}
>      43	}
>      44	
>      45	struct io_kiocb *io_alloc_notif(struct io_ring_ctx *ctx,
>      46					struct io_notif_slot *slot)
>      47		__must_hold(&ctx->uring_lock)
>      48	{
>      49		struct io_kiocb *notif;
>      50		struct io_notif_data *nd;
>      51	
>    > 52		if (unlikely(!io_alloc_req_refill(ctx)))
>      53			return NULL;
>    > 54		notif = io_alloc_req(ctx);
>      55		notif->opcode = IORING_OP_NOP;
>      56		notif->flags = 0;
>      57		notif->file = NULL;
>      58		notif->task = current;
>      59		io_get_task_refs(1);
>      60		notif->rsrc_node = NULL;
>      61		io_req_set_rsrc_node(notif, ctx, 0);
>      62		notif->cqe.user_data = slot->tag;
>      63		notif->cqe.flags = slot->seq++;
>      64		notif->cqe.res = 0;
>      65	
>      66		nd = io_notif_to_data(notif);
>      67		nd->account_pages = 0;
>      68		nd->uarg.flags = SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN;
>      69		nd->uarg.callback = io_uring_tx_zerocopy_callback;
>      70		/* master ref owned by io_notif_slot, will be dropped on flush */
>      71		refcount_set(&nd->uarg.refcnt, 1);
>      72		return notif;
>      73	}
>      74	
> 

-- 
Pavel Begunkov
