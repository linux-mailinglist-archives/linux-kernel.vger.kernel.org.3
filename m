Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7044B3EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiBNBi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:38:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBNBi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:38:56 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 989924A901;
        Sun, 13 Feb 2022 17:38:47 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:35884.1788859523
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 730831002AB;
        Mon, 14 Feb 2022 09:38:43 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id 9c6f08157a064b8eadf3c9fc28a5e4ab for joe@perches.com;
        Mon, 14 Feb 2022 09:38:46 CST
X-Transaction-ID: 9c6f08157a064b8eadf3c9fc28a5e4ab
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <a1fd4df6-c3dd-81d3-fce5-d4fc5f3b4113@189.cn>
Date:   Mon, 14 Feb 2022 09:38:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 7/7] MAINTAINERS: add maintainers for DRM LSDC driver
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>, Li Yi <liyi@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220213141649.1115987-1-15330273260@189.cn>
 <20220213141649.1115987-8-15330273260@189.cn>
 <3141331e10cdbc7a3859887d5e8038eff777e3ad.camel@perches.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <3141331e10cdbc7a3859887d5e8038eff777e3ad.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SCC_BODY_URI_ONLY,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
Thanks for you take time to review my patch, I am not notice that, I 
will correct it at next version.
