Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF4E522C74
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbiEKGie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiEKGi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:38:29 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B817513B8C3;
        Tue, 10 May 2022 23:38:26 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aeb08.dynamic.kabel-deutschland.de [95.90.235.8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4F8BB61E6478B;
        Wed, 11 May 2022 08:38:25 +0200 (CEST)
Message-ID: <d5aecbb9-a897-9423-833f-432907b5be87@molgen.mpg.de>
Date:   Wed, 11 May 2022 08:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] md: remove useless INIT_LIST_HEAD()
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1652237069-11486-1-git-send-email-baihaowen@meizu.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1652237069-11486-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Haowen,


Thank you for your patch.

Am 11.05.22 um 04:44 schrieb Haowen Bai:
> list candidates has been inited staticly through LIST_HEAD,

initialized statically

> so there's no need to call another INIT_LIST_HEAD. Simply remove
> it.

Please reflow for 75 characters per line.

> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>   drivers/md/md.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 707e802d0082..eb2b23ef5ecc 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6491,7 +6491,6 @@ static void autorun_devices(int part)
>   					 struct md_rdev, same_set);
>   
>   		pr_debug("md: considering %s ...\n", bdevname(rdev0->bdev,b));
> -		INIT_LIST_HEAD(&candidates);
>   		rdev_for_each_list(rdev, tmp, &pending_raid_disks)
>   			if (super_90_load(rdev, rdev0, 0) >= 0) {
>   				pr_debug("md:  adding %s ...\n",


Kind regards,

Paul
