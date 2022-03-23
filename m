Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBC4E4D10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbiCWHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiCWHJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:09:14 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E02C71EF2;
        Wed, 23 Mar 2022 00:07:44 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:52698.1965467250
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 71D7210023D;
        Wed, 23 Mar 2022 15:07:41 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-vjdjk with ESMTP id 5fe13736b6734204a16a00a71691bb7f for jiaxun.yang@flygoat.com;
        Wed, 23 Mar 2022 15:07:43 CST
X-Transaction-ID: 5fe13736b6734204a16a00a71691bb7f
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <c9357494-6472-e0a0-50a8-e62df56dceb0@189.cn>
Date:   Wed, 23 Mar 2022 15:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 2/7] MIPS: Loongson64: dts: introduce ls3A4000
 evaluation board
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Maxime Ripard <mripard@kernel.org>,
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
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        chenhuacai@kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        liyi@loongson.cn
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-3-15330273260@189.cn>
 <2644866a-8db2-923e-4227-2aa6d8e375fe@flygoat.com>
 <2c671752-6684-f87b-7b2d-90568d36adde@189.cn>
 <005099b5-33ed-4cb7-f8e4-10e1de780311@flygoat.com>
 <abe784ce-eb9e-0143-dbc3-d415bbedbb81@189.cn>
 <87d4f869-2ae8-f8d3-a55f-1a563cb21115@flygoat.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <87d4f869-2ae8-f8d3-a55f-1a563cb21115@flygoat.com>
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


On 2022/3/23 10:29, Jiaxun Yang wrote:
> If you want to blame somebody for the problem then please don't
> blame us. We tried very hard to fit all those stuff into kernel's model
> of devices. You should blame those who did the initial design of
> Loongson's boot interface that failed to introduce a proper way
> to describe the platform. 

I am not blame anybody, please do not misleading.
I am report problem and try to seek a better solution.

I have my intention and ideas, i just don't want to solve
all of the problems in one shot.

I could provide one more patch wire all board specific dts up.
But i don't know what's the opinions of other reviewers, does
this is plausible?

