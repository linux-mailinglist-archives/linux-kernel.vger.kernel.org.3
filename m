Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23AA4E3F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiCVNKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiCVNJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:09:58 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE7ADF25;
        Tue, 22 Mar 2022 06:08:30 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 14C5B32013BE;
        Tue, 22 Mar 2022 09:08:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 22 Mar 2022 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=OMRHkwKrqTNPvZ
        BpmQ6WmDl0jpezKoqEw5HOCaOA9RA=; b=1idvj3QIH5becCDN3HXGsuHjLnIx+N
        Yp+XgaUvfFJQXqIqX97fxmFuVjg7L3ubqZTCwJAcKdO2sTKsNdiBQy8XDotZU6er
        p1pq8BwLR2qjv12m5dGlo67r0Ty8ybYgs9LmBprvS028NZ7UWTIIVbwIZ+sCsA9F
        thIPZgbwlidWszPPe4EvNfTtGowJyKiJhSfEydGOo7S/kbZQOWYwmkS3VTIQKRXe
        ImCBXLYFX+L5lv1m9YAocGtiz+KSf2/XjczfmKPiqSPwXODIZdB+TZrLVfr80yfG
        lLWH6cZzBewcji3LX02JNQiL/ImdUFJNv7vGEf25eQu8OeHCRrgnu/BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=OMRHkwKrqTNPvZBpmQ6WmDl0jpezKoqEw5HOCaOA9
        RA=; b=CdhKh+gH3iao6fjugrlhu46nlpKbPxrVe+7FTGVnBDNGMVqFsrZzDGebl
        ioYHjXX44CEAEC8xmbQyX6sb/7uWxwsOEtlv7a5BS4EGYvs7q4DdYng9oRst0C0n
        jQ7pKKJdSVfqQGjG2y80jT/wzEPaMmoVGo7G4hoMI3WCFcrD+iV4skS0dgU1sg8o
        oXuO+OBduByIrKXgFXaaFOg8yVGxumsST8FRHOaOm68P76ekE8jy4PTj6fUPLrRS
        ebu5jK3kGoRYLPYRAFQPWCGZpQX7/JNxGmNHdzp2rlS5W99IXGlThfgdKDXMTtzc
        VZSbBD4aeHCLw5P9taNda1IkOgO7Q==
X-ME-Sender: <xms:Sco5YiAhS-n9sjVu45L98Aqrg4UKe2ytx1UMVblIwS-lUccz0vSCnw>
    <xme:Sco5Ysj2NWbepEO_akFofkrUC2RManEz5zyUhlpXB-SLn-FYYyd21JXGYnj9rHCCa
    dp2F2ej_yZIQjsIko8>
X-ME-Received: <xmr:Sco5YlkbcujgErZLOU43fbSqV6WRBpsp_EoWsfmeke45cESbxCzcsGOpcNIXePk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeghedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehieduvdevhfekjeeftddtkeeitefhudekvdeiueeulefgleei
    jeeghedvkeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:Sco5YgwHFyaoWi1CZloJlE_TTBFuNSAjw6ZUpPbLeJntkOE7C1gvzw>
    <xmx:Sco5YnSMdgs9nMV2VyYdXHAHNxPaQh7r5djQRegOyLGfGAd0uxtcfw>
    <xmx:Sco5YrahgPdgJLyN3L05ZMsdW2mg_r2oeub8DiX9_5gFJUxsnkrb-g>
    <xmx:S8o5YmBLB-TAVq4lraZedTXhXPLWDNep5MnRXmghRbAPYvRJ_RZRwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Mar 2022 09:08:23 -0400 (EDT)
Message-ID: <66ae2436-aa86-f583-85b4-d652273188e9@flygoat.com>
Date:   Tue, 22 Mar 2022 13:08:22 +0000
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
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <f7eb61bc-6784-c77a-083f-7408c0a17e05@189.cn>
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



在 2022/3/22 2:33, Sui Jingfeng 写道:
>
> On 2022/3/22 07:20, Rob Herring wrote:
>> On Tue, Mar 22, 2022 at 12:29:14AM +0800, Sui Jingfeng wrote:
>>> From: suijingfeng <suijingfeng@loongson.cn>
>>>
>> Needs a commit message.
>>
>>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>> Same person? Don't need both emails.
>
> Yes,  suijingfeng@loongson.cn is my company's email. But it can not be 
> used to send patches to dri-devel,
>
> when send patches with this email, the patch will not be shown on 
> patch works.
>
> Emails  are either blocked or got  rejected  by loongson's mail 
> server.  It can only receive emails
>
> from you and other people, but not dri-devel. so have to use my 
> personal email(15330273260@189.cn) to send patches.
In this case you can just use your company's email to sign-off
code and sending with your personal email. It's common practice.

If you don't want to receiving kernel email in your company mailbox,
you can add a entry in .mailmap .

Thanks.
- Jiaxun
