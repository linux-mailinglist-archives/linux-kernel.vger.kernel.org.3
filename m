Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7684E43EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbiCVQKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiCVQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:10:00 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53BE3E0D6;
        Tue, 22 Mar 2022 09:08:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5EA133200564;
        Tue, 22 Mar 2022 12:08:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 22 Mar 2022 12:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=A/5c5bupG84OpJ
        9bEkkXf8PI9y7r8U3800eihSiGiE8=; b=18E+aiAGbEKvLCc1HIOFK4DSMYY8CY
        YVUW0gPnE0UHeULwil7P8igMhQjhcYSX+mste7fHtCigAmXl0d3v7i7IdvUSibQg
        tPvBV78jOMf/euov14wpo5Sy20f38ZMZ0TW5DbnmSrH0vlSCJDpKYq+LGGsSkdUq
        Z9UFGH6uJovHg8xT7aI93rZDXirfIAljwy0vQfjkeBR9js2YK+CihXGEQLwdX+1+
        oeHiBEHm2tznQU1H79hF/i+AJUgS4asWr+LI7xfIuFgQL9e28N22/Ji4kB8n4kPE
        Tk9Zchc2Hbcp2ZVqtMZIILE37k4RlxEwMl5wkVx/hkBV4ZM+QAYYPulQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=A/5c5bupG84OpJ9bEkkXf8PI9y7r8U3800eihSiGi
        E8=; b=HFJ355QMuT8WJ19Prlzg8Ahdw5RJIbNbS+XWGBP7ZjCM2RyayVJFt9JvI
        8L81qxePti9vlE2qSPnXnLjtDDatfHeisj0EenJSksS/mYq0X+5KewHJt7i0UF7x
        UddLKCA1qTqIZg5pZ0FesO7UKmbpQF/ZdgLrMVkjTI+ZKTzZdWJH6GPK4PAWEfsu
        gAU7Ki2W63y1bpFmF/1owiAp3ZC65JH3vnkh1HIGHVoxi3MphL1FPvHuhHxpYmv3
        iVpac6FiYwYoPE62Seveh40Lz9jfjq/q1WMviYU5embqEgzhh6fkT5rRrvrgChcT
        pIpWbuwKRPW3lrFwvRE4K+ZPZnTaQ==
X-ME-Sender: <xms:efQ5YojCx5TxF5CKJIOFRoNzmf-5jXe0FtCgB_SsRhhr68bI4_F7UA>
    <xme:efQ5YhAgKl_YfiY_7Te8C7HUhE-FWokrdMZj142Xs_1aes_xD4JD74f3H7JzZMHIu
    oDcpVJBBVLbzA9YM8w>
X-ME-Received: <xmr:efQ5YgFf3sPRN830Pg1XIWHuLOCyczbEUlmTGh74KhzlOaUsanH28wAsld9XBb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeghedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehieduvdevhfekjeeftddtkeeitefhudekvdeiueeulefgleei
    jeeghedvkeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:efQ5YpTF2OaXpz9xSqp2bxnTBN9Al7sFpS4L9C5mZ6OjEDcZX7Fx2A>
    <xmx:efQ5YlzcgsRXPtpC6HWkNI0SOl7wItym_PjzT_223Jojt5DR93EuPw>
    <xmx:efQ5Yn4XaavvNjsBfuiiWm8fA7g9YJfoq7A5j7iKRep2CWQF4OJAvw>
    <xmx:evQ5YsjAuIe7atFDzt2b1ncioDpMSeg_zNFU3Go88YMnHNwqtRXGhg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Mar 2022 12:08:23 -0400 (EDT)
Message-ID: <cbf71968-0da4-dee9-3fd5-5a5283038146@flygoat.com>
Date:   Tue, 22 Mar 2022 16:08:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 5/7] dt-bindings: display: Add Loongson display
 controller
Content-Language: en-GB
To:     Sui Jingfeng <15330273260@189.cn>, Rob Herring <robh@kernel.org>
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
 <629311ac-f847-dd57-689e-eaa97aae8480@189.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <629311ac-f847-dd57-689e-eaa97aae8480@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/3/22 13:54, Sui Jingfeng 写道:
>
> On 2022/3/22 21:08, Jiaxun Yang wrote:
>>
>>
>> 在 2022/3/22 2:33, Sui Jingfeng 写道:
>>>
>>> On 2022/3/22 07:20, Rob Herring wrote:
>>>> On Tue, Mar 22, 2022 at 12:29:14AM +0800, Sui Jingfeng wrote:
>>>>> From: suijingfeng <suijingfeng@loongson.cn>
>>>>>
>>>> Needs a commit message.
>>>>
>>>>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>>>>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>>>> Same person? Don't need both emails.
>>>
>>> Yes,  suijingfeng@loongson.cn is my company's email. But it can not 
>>> be used to send patches to dri-devel,
>>>
>>> when send patches with this email, the patch will not be shown on 
>>> patch works.
>>>
>>> Emails  are either blocked or got  rejected  by loongson's mail 
>>> server.  It can only receive emails
>>>
>>> from you and other people, but not dri-devel. so have to use my 
>>> personal email(15330273260@189.cn) to send patches.
>> In this case you can just use your company's email to sign-off
>> code and sending with your personal email. It's common practice.
>>
>> If you don't want to receiving kernel email in your company mailbox,
>> you can add a entry in .mailmap .
>>
> |I'm using `git send-email -7 --cover-letter --annotate -v11` command 
> to send patches, it will automatically sign off patches with the my 
> private emails. |
The alternative solution is:

git format-patch -7 -v11 --cover-letter
git send-email ./*.patch

Thanks.
- Jiaxun

>
>> Thanks.
>> - Jiaxun

