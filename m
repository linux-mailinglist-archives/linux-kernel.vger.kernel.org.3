Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2625550C89
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiFSS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiFSS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 14:27:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165AF5FDC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=HqhUHLnn9zw43ykXrHZYC2UIAN9zAPBi5wljpUp4B+Q=; b=e44/ZDxh85JPkfu8AoyO9/r/ia
        HLA0w5CohluzAwJF8+mXvceE++6maHem6M/najnOm5WRhYrackqEFnKFSMfYQXCC7MxyTJh7s+ZZc
        XgWVcMGgsJG8Xa9jQNLLY223oPyBykc5JeMuBZxQ4A/nV5rGT/XdLWG2Tenxt1P+zX4HzuLUFMPNO
        a8PmfuKd2lXl7KyXv+v8mveHewMKHKCBE/3UaEdMas/tq1E7ONHHLM4yZLQLxmqOY8YlEcIY3DR+k
        GNiJlWlP1053tcObpHrcxECrmQuttUdRB409fZQSdepizR313OSJJWJqoxnrAdt1kKDoXV1hZSPVj
        QfUmZ+6w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2zdt-004XKY-Iz; Sun, 19 Jun 2022 18:27:27 +0000
Message-ID: <59cb24c1-1a4b-5472-e4f8-d87b309ad134@infradead.org>
Date:   Sun, 19 Jun 2022 11:27:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [DRM/hisilicon/hibmc] kernel robot reports build errors,
 patch(es) available but not merged
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xinliang Liu <xinliang.liu@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        John Stultz <jstultz@google.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        RongrongZou <zourongrong@huawei.com>
References: <9a0ed0bb-34c7-bacb-16a8-fdb158535ab2@infradead.org>
 <5eabd169-b8a0-fb8f-d70b-4495d3790f05@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5eabd169-b8a0-fb8f-d70b-4495d3790f05@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/22 07:27, Javier Martinez Canillas wrote:
> Hello Randy,
> 
> On 6/19/22 00:49, Randy Dunlap wrote:
>>
>> kernel robot reports today:
>>
>> * riscv64-linux-ld: ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
>>   https://lore.kernel.org/lkml/202206190651.smtms3Ay-lkp@intel.com/T/#u
>>
>> * ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
>>   https://lore.kernel.org/lkml/202206190523.0Ar6yQF7-lkp@intel.com/T/#u
>>
>>
>> and earlier:
>>
>> * ld.lld: error: undefined symbol: vmf_insert_pfn_prot
>> https://lore.kernel.org/lkml/202203281125.Jp08egXu-lkp@intel.com/
>>
>> * ttm_bo_vm.c:undefined reference to `vmf_insert_pfn_prot'
>> https://lore.kernel.org/lkml/202204081648.gV63Gt0t-lkp@intel.com/
>>
>>
>> I sent a patch for this on 2022-04-08 and again on 2022-05-30 (UTC).
>>
>> https://lore.kernel.org/all/20220409030504.16089-1-rdunlap@infradead.org/
>> https://lore.kernel.org/all/20220531025557.29593-1-rdunlap@infradead.org/
>>
>> Neither one has been applied or even had a comment.  :(
>>
> 
> Sorry that these fell into the cracks. Thanks for the patch, I think the
> change is correct but gave some comments about the Fixes: tag and commit
> description. There's no need to resend though, I can do it when pushing.

OK, thank you.

-- 
~Randy
