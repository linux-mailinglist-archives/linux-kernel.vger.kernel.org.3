Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B333A52DE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbiESUCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiESUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:02:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD936D187;
        Thu, 19 May 2022 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=EyvcIebdJVNbSUKi/O56+u29Bdx5ONtpdCn9+GlRuGc=; b=ImYzwvN78w3/qFJn8r7MNseyWF
        e4McVD2zl9Xfio2tPR8MHFE9jAY5yXUIsP2QMHnxd3rGUULaBEpwwQ1kuIkoDsywGk2FknfRD+PE8
        mKB0RTH55YuMV4rtN20z7S1Gb4jN31bBOdPrwG0GFUxXWdwiW+2VVpso2Tkb5YUZg2ta801XlrEo+
        Vk3FCyD/0FARw0bX0Xp4QqW9VpJG8AqloiMqCMM4BdYK55Oink5fYL1+k7AnO8ghmvPZ8qG9AEKI3
        jqDLZ8eBLjzOH1unE5AzWMP5JARLfnXAbJV40/GHp/OC6gBCvK/RIHu+s3ZNUd4CNcK3xW4CE2xgO
        BmQkaoxA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrmM3-00D3rP-8l; Thu, 19 May 2022 20:02:39 +0000
Message-ID: <6f38a339-41b5-aafe-c788-bd34a1806d52@infradead.org>
Date:   Thu, 19 May 2022 13:02:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        sachinp@linux.vnet.com, mputtash@linux.vnet.com,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
 <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
 <fc5f8b96-3c93-5400-b917-a1d991cbe7c9@suse.de>
 <900f57bc-9978-9ba6-22fb-48f03fcf5011@kernel.dk>
 <c2d252a1-7223-4899-e5c9-e4bb27e2fc8a@kernel.dk>
 <268233c7-88ad-6b5c-6991-e3a4f1ac2540@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <268233c7-88ad-6b5c-6991-e3a4f1ac2540@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/22 06:02, Hannes Reinecke wrote:
> On 5/19/22 14:42, Jens Axboe wrote:
>> On 5/19/22 6:40 AM, Jens Axboe wrote:
>>> On Thu, May 19, 2022 at 6:38 AM Hannes Reinecke <hare@suse.de> wrote:
>>>>
>>>> On 5/19/22 14:14, Jens Axboe wrote:
>>>>> On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
>>>>>> Greetings,
>>>>>>
>>>>>> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>>>>>
>>>>>> Console Logs :
>>>>>>
>>>>>> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
>>>>>> make -j 17 -s && make modules && make modules_install && make install
>>>>>> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>>>>> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
>>>>>> make: *** [Makefile:1914: modules] Error 2
>>>>>> make: *** Waiting for unfinished jobs....
>>>>>
>>>>> Christoph, can you fix this up?
>>>>>
>>>> Cannot reproduce with commit 21498d01d045c5b95b93e0a0625ae965b4330ebe.
>>>> Please share details.
>>>
>>> The kerneltest bot also reported this a few days ago, you might be able
>>> to find the details there as that includes config etc.
>>
>> Here: https://lore.kernel.org/linux-mm/202205190527.o9wVEvHI-lkp@intel.com/
>>
> Right. Send a patch.


https://lore.kernel.org/all/20220518045704.GA30131@lst.de/

but it needs to be sent as a formal patch.

-- 
~Randy
