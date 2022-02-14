Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F894B3ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbiBNBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:18:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBNBSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:18:43 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C53E527D3;
        Sun, 13 Feb 2022 17:18:35 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.43:40520.1301825991
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 2E9CA1001F0;
        Mon, 14 Feb 2022 09:18:31 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-vjdjk with ESMTP id 750ecf3745c54b01ab0aef2812fb2f0d for joe@perches.com;
        Mon, 14 Feb 2022 09:18:34 CST
X-Transaction-ID: 750ecf3745c54b01ab0aef2812fb2f0d
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <dfc864fd-0918-9f0d-3e42-a9d363af3c48@189.cn>
Date:   Mon, 14 Feb 2022 09:18:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 7/7] MAINTAINERS: add maintainers for DRM LSDC driver
Content-Language: en-US
References: <20220213141649.1115987-1-15330273260@189.cn>
 <20220213141649.1115987-8-15330273260@189.cn>
 <3141331e10cdbc7a3859887d5e8038eff777e3ad.camel@perches.com>
From:   Sui Jingfeng <15330273260@189.cn>
To:     undisclosed-recipients:;
In-Reply-To: <3141331e10cdbc7a3859887d5e8038eff777e3ad.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SCC_BODY_URI_ONLY,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/2/14 07:12, Joe Perches wrote:
> On Sun, 2022-02-13 at 22:16 +0800, Sui Jingfeng wrote:
>> From: suijingfeng <suijingfeng@loongson.cn>
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -6453,6 +6453,15 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>>   F:	drivers/gpu/drm/lima/
>>   F:	include/uapi/drm/lima_drm.h
>>   
>> +DRM DRIVERS FOR LOONGSON
>> +M:	Sui Jingfeng <suijingfeng@loongson.cn>
>> +L:	dri-devel@lists.freedesktop.org
>> +R:	Li Yi <liyi@loongson.cn>
>> +S:	Maintained
>> +W:	https://www.loongson.cn/
>> +T:	git git://anongit.freedesktop.org/drm/drm-misc
>> +F:	drivers/gpu/drm/lsdc/
>> +
> M then R then L please
>
> DRM DRIVERS FOR LOONGSON
> M:	Sui Jingfeng <suijingfeng@loongson.cn>
> R:	Li Yi <liyi@loongson.cn>
> L:	dri-devel@lists.freedesktop.org
>
>
oh, I will correct it at next version, thank you.
