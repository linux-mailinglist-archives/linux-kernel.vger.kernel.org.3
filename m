Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE253E6BB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiFFMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbiFFMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96955A5FE8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20035611B8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045BDC3411C;
        Mon,  6 Jun 2022 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654519093;
        bh=LHCT0MVuCWKJIHCjZdFCmlTd+JmsLHutx4baX8nUikQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=AlwNeBSlk9KylwFTPfiSs0wIuQi7c8M/GqQvt0KNkr85qthmz7w3yKMy+mgGlQiIz
         jjAJlMuY00OXT9DxeFAMwEZ5VbeZJLtNQ3/zTZYVe7D+Zuz4KVziNnIXO2q9K5ZHqI
         bITBC/Pa8HvKeHlmMqmmDDL3pxmL3G6s0j0Ho2iKh/Hw8ac48Z85i6Ja/CSWUiji8k
         PE8J2CutOOUKzioRuKjMSJFydJqW3Etcqa7S+BJsws8dpyEtKxzmBuqbnbxY7BV68G
         +MngPM5fcUjfeJnGTf4YLjATyvaCmx/PhBwjPe10RriwgwPRPMgqg1nq6aNpM3SERF
         9O0SFFTiYHwDQ==
Message-ID: <d17777de-13ab-5dcc-e2e7-c8bf1caedbfa@kernel.org>
Date:   Mon, 6 Jun 2022 20:38:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Content-Language: en-US
To:     Yue Hu <huyue2@coolpad.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, shaojunjun@coolpad.com,
        Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20220605070133.4280-1-huyue2@coolpad.com>
 <Ypxl/MsOGQ6W4Rlf@debian>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Ypxl/MsOGQ6W4Rlf@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/5 16:14, Gao Xiang wrote:
> Hi Yue,
> 
> On Sun, Jun 05, 2022 at 03:02:04PM +0800, Yue Hu wrote:
>> I have been doing some erofs patches. Now I have the time and would like
>> to help with the reviews.
>>
>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> 
> Thanks for working on EROFS these months! Hopefully EROFS could have
> a healthier development then...
> 
> Acked-by: Gao Xiang <xiang@kernel.org>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> 
> + Jeffle Xu
> 
> (BTW, I'd like to request Jeffle as a EROFS reviewer too due to
>   the fscache feature. Not sure if he's interested in it...)
> 
> Thanks,
> Gao Xiang
> 
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d2691d8a219f..2d0e28d7773b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7308,6 +7308,7 @@ F:	include/video/s1d13xxxfb.h
>>   EROFS FILE SYSTEM
>>   M:	Gao Xiang <xiang@kernel.org>
>>   M:	Chao Yu <chao@kernel.org>
>> +R:	Yue Hu <huyue2@coolpad.com>
>>   L:	linux-erofs@lists.ozlabs.org
>>   S:	Maintained
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
>> -- 
>> 2.17.1
