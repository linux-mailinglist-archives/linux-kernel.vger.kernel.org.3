Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BAF565DFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiGDTaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDTaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:30:17 -0400
X-Greylist: delayed 5322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 12:30:15 PDT
Received: from out.tornado.email (out.tornado.email [77.40.237.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A93A214;
        Mon,  4 Jul 2022 12:30:15 -0700 (PDT)
Received: from [92.221.249.155] (helo=[192.168.1.10])
        by out.tornado.email with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <d@ja.vu>)
        id 1o8QNx-00Amu0-Fj; Mon, 04 Jul 2022 20:01:25 +0200
Message-ID: <44f85603-8a34-7654-54cf-987a62e44778@ja.vu>
Date:   Mon, 4 Jul 2022 18:01:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] block: Fix spelling mistakes in comments
Content-Language: en-US
To:     Zhang Jiaming <jiaming@nfschina.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220704012328.6507-1-jiaming@nfschina.com>
 <20220704100557.6429-1-jiaming@nfschina.com>
From:   "Daniel K." <d@ja.vu>
In-Reply-To: <20220704100557.6429-1-jiaming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: daniel@cluded.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 10:05, Zhang Jiaming wrote:
> Fix spelling of dones't and waitting in comments.

Version your patches, you're now at v2. [PATCH v2] ...

Please find a few suggestions below as to what can be fixed in this
block of text as you're making a pass over it.


> @@ -1327,9 +1327,9 @@ static void r5l_write_super_and_discard_space(struct r5l_log *log,
>  	 * superblock is updated to new log tail. Updating superblock (either
>  	 * directly call md_update_sb() or depend on md thread) must hold
>  	 * reconfig mutex. On the other hand, raid5_quiesce is called with
> -	 * reconfig_mutex hold. The first step of raid5_quiesce() is waitting
> -	 * for all IO finish, hence waitting for reclaim thread, while reclaim
> -	 * thread is calling this function and waitting for reconfig mutex. So
> +	 * reconfig_mutex hold. The first step of raid5_quiesce() is waiting

                          held

> +	 * for all IO finish, hence waiting for reclaim thread, while reclaim

              all IO to finish

> +	 * thread is calling this function and waiting for reconfig mutex. So
>  	 * there is a deadlock. We workaround this issue with a trylock.
>  	 * FIXME: we could miss discard if we can't take reconfig mutex
>  	 */

There are several mentions of 'reconfig mutex' that should probably be
'reconfig_mutex'. What's the correct way to refer to a mutex in comments
like the above?


Daniel K.
