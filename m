Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536A44E3FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiCVN4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiCVNzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:55:55 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B760F26132;
        Tue, 22 Mar 2022 06:54:20 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:34226.1760787978
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id C6CF010021F;
        Tue, 22 Mar 2022 21:54:10 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id ca0c77cdffc64f6694d6679e66913f76 for jiaxun.yang@flygoat.com;
        Tue, 22 Mar 2022 21:54:18 CST
X-Transaction-ID: ca0c77cdffc64f6694d6679e66913f76
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <629311ac-f847-dd57-689e-eaa97aae8480@189.cn>
Date:   Tue, 22 Mar 2022 21:54:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 5/7] dt-bindings: display: Add Loongson display
 controller
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-6-15330273260@189.cn>
 <YjkITWpbnCmhKaX+@robh.at.kernel.org>
 <f7eb61bc-6784-c77a-083f-7408c0a17e05@189.cn>
 <66ae2436-aa86-f583-85b4-d652273188e9@flygoat.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <66ae2436-aa86-f583-85b4-d652273188e9@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/22 21:08, Jiaxun Yang wrote:
>
>
> 在 2022/3/22 2:33, Sui Jingfeng 写道:
>>
>> On 2022/3/22 07:20, Rob Herring wrote:
>>> On Tue, Mar 22, 2022 at 12:29:14AM +0800, Sui Jingfeng wrote:
>>>> From: suijingfeng <suijingfeng@loongson.cn>
>>>>
>>> Needs a commit message.
>>>
>>>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>>>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>>> Same person? Don't need both emails.
>>
>> Yes,  suijingfeng@loongson.cn is my company's email. But it can not 
>> be used to send patches to dri-devel,
>>
>> when send patches with this email, the patch will not be shown on 
>> patch works.
>>
>> Emails  are either blocked or got  rejected  by loongson's mail 
>> server.  It can only receive emails
>>
>> from you and other people, but not dri-devel. so have to use my 
>> personal email(15330273260@189.cn) to send patches.
> In this case you can just use your company's email to sign-off
> code and sending with your personal email. It's common practice.
>
> If you don't want to receiving kernel email in your company mailbox,
> you can add a entry in .mailmap .
>
|I'm using `git send-email -7 --cover-letter --annotate -v11` command to 
send patches, it will automatically sign off patches with the my private 
emails. |

> Thanks.
> - Jiaxun
