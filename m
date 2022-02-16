Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446C64B8AED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbiBPOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:01:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiBPOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:01:33 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E862220BC3;
        Wed, 16 Feb 2022 06:01:20 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:52036.771379645
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 5D5DA100249;
        Wed, 16 Feb 2022 22:01:17 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id 548e00fac09a411c85fa6fb7ab0cae38 for krzk@kernel.org;
        Wed, 16 Feb 2022 22:01:19 CST
X-Transaction-ID: 548e00fac09a411c85fa6fb7ab0cae38
X-Real-From: 15330273260@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <3e34a508-3969-80d9-4ef7-7cb358c0147d@189.cn>
Date:   Wed, 16 Feb 2022 22:01:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 2/3] dt-bindings: ls2k1000: add the display controller
 device node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-3-15330273260@189.cn>
 <CAJKOXPfN+Ax8i_Mcax9LfbSG8VwM86YgUxuRUfSF_YEx4z0EaQ@mail.gmail.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <CAJKOXPfN+Ax8i_Mcax9LfbSG8VwM86YgUxuRUfSF_YEx4z0EaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/2/3 16:50, Krzysztof Kozlowski wrote:
> On Thu, 3 Feb 2022 at 09:26, Sui Jingfeng <15330273260@189.cn> wrote:
>> From: suijingfeng <suijingfeng@loongson.cn>
>>
>> The display controller is a pci device, its vendor id is 0x0014
>> its device id is 0x7a06.
> The same as your patch 3 - these are not bindings.
>
> Best regards,
> Krzysztof

Yes, you are right. As there is no compatible string in my driver to match against the compatible
in the dc@6,1 device node.

I don't know how to write YAML document now, it seems no similar case can be reference?

