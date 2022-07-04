Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F82564F1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiGDHwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiGDHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:51:52 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF9A472;
        Mon,  4 Jul 2022 00:51:49 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aede6.dynamic.kabel-deutschland.de [95.90.237.230])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D72F261EA1923;
        Mon,  4 Jul 2022 09:51:46 +0200 (CEST)
Message-ID: <a4aeb494-7ffd-86ee-856f-5d3091cdb705@molgen.mpg.de>
Date:   Mon, 4 Jul 2022 09:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] block: Fix spelling mistake in comments
Content-Language: en-US
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com, song@kernel.org
References: <20220704012328.6507-1-jiaming@nfschina.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220704012328.6507-1-jiaming@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Zhang,


Thank you for your patch. Some nits.

Am 04.07.22 um 03:23 schrieb Zhang Jiaming:
> There are some typos(dones't, waitting) in comments.
> Fix it.

Please add a space before the (. “Fix it.” also fits on the line above, 
and maybe use plural in the commit message summary. For the body, maybe:

Fix spelling of dones't and waitting in comments.

> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>   drivers/md/raid5-cache.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index 83c184eddbda..4b799005eb6e 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -125,7 +125,7 @@ struct r5l_log {
>   					 * reclaimed.  if it's 0, reclaim spaces
>   					 * used by io_units which are in
>   					 * IO_UNIT_STRIPE_END state (eg, reclaim
> -					 * dones't wait for specific io_unit
> +					 * doesn't wait for specific io_unit
>   					 * switching to IO_UNIT_STRIPE_END
>   					 * state) */
>   	wait_queue_head_t iounit_wait;
> @@ -1327,9 +1327,9 @@ static void r5l_write_super_and_discard_space(struct r5l_log *log,
>   	 * superblock is updated to new log tail. Updating superblock (either
>   	 * directly call md_update_sb() or depend on md thread) must hold
>   	 * reconfig mutex. On the other hand, raid5_quiesce is called with
> -	 * reconfig_mutex hold. The first step of raid5_quiesce() is waitting
> -	 * for all IO finish, hence waitting for reclaim thread, while reclaim
> -	 * thread is calling this function and waitting for reconfig mutex. So
> +	 * reconfig_mutex hold. The first step of raid5_quiesce() is waiting
> +	 * for all IO finish, hence waiting for reclaim thread, while reclaim
> +	 * thread is calling this function and waiting for reconfig mutex. So
>   	 * there is a deadlock. We workaround this issue with a trylock.
>   	 * FIXME: we could miss discard if we can't take reconfig mutex
>   	 */

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
