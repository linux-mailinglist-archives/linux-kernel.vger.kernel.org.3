Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0795AA651
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiIBD0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIBD0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:26:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C70A71BEA;
        Thu,  1 Sep 2022 20:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GJjAcM3GmyI6PjX3K2R26l59/UA4pSwDavyDI8Mg5+w=; b=wR+XeUdDcCp5w/WqaMHOa4LqNP
        itSDr0ERIL0een/N4cx+/EdywehuJpWEcqBS7hxyzrWD47RfuUAl2uTewRiCxAC0kQdR8o6m6dVtX
        AoVA7DWiPFWmbAwOaIRsCX7aPIBtdKNlH4rlI8RYgW+9ymsQFR0UAaQ3WjQmhdMUGN2VGv5Dfzwes
        +qfsbMb2xsQlHj/j6vi1yoet2887S3mBA/skGa3YmHlJxEFgSz6eAFHejT7Eke9yEbrX+1x2OGHAH
        RizT0LBjNhOCIXA+zfCA+oVd+6ttqpBHksIDqmxEnij+bKaKGYrdVsQ09uRg3lBVCgQhQsAuclzFp
        5Et1VsiA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTxK7-00HKiG-2d; Fri, 02 Sep 2022 03:26:27 +0000
Message-ID: <a8ac77b7-60a9-3e62-0d07-fa03c5600740@infradead.org>
Date:   Thu, 1 Sep 2022 20:26:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: linux-next: Tree for Sep 1 (Kconfig for VIDEO_MEDIATEK_VPU)
Content-Language: en-US
To:     moudy ho <moudy.ho@mediatek.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20220901171832.78d88aed@canb.auug.org.au>
 <f19684d4-9ef0-6308-8245-73c9a4511e67@infradead.org>
 <e213e9d8ef900db665fee08b484181e1d47c5171.camel@mediatek.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e213e9d8ef900db665fee08b484181e1d47c5171.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/22 19:55, moudy ho wrote:
> Hi Randy,
> 
> Thanks for your efforts on this matter, the warning is due to not
> setting V4L_MEM2MEM_DRIVERS on defconfig which the VIDEO_MEDIATEK_VPU
> depends.
> Could I send a patch to add a V4L_MEM2MEM_DRIVERS selection in MDP3
> Kconfig to avoid this warning?
> 
> Regards,
> Moudy

Hi,
That sounds good to me.

Thanks.

> 
> On Thu, 2022-09-01 at 13:38 -0700, Randy Dunlap wrote:
>>
>> On 9/1/22 00:18, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> News: there will be no linux-next releases tomorrow or on Monday.
>>>
>>> Changes since 20220831:
>>>
>>
>> on i386 or x86_64:
>>
>> WARNING: unmet direct dependencies detected for VIDEO_MEDIATEK_VPU
>>   Depends on [n]: MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y]
>> && MEDIA_PLATFORM_DRIVERS [=y] && V4L_MEM2MEM_DRIVERS [=n] &&
>> VIDEO_DEV [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y])
>>   Selected by [y]:
>>   - VIDEO_MEDIATEK_MDP3 [=y] && MEDIA_SUPPORT [=y] &&
>> MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] &&
>> (MTK_IOMMU [=n] || COMPILE_TEST [=y]) && VIDEO_DEV [=y] &&
>> (ARCH_MEDIATEK || COMPILE_TEST [=y]) && HAS_DMA [=y] && REMOTEPROC
>> [=y]
>>
>>
>>
>> Full x86_64 randconfig file is attached.
>>
> 

-- 
~Randy
