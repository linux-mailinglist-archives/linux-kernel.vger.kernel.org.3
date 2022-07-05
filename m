Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C771566224
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiGEEPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiGEEPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:15:31 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9127A765F;
        Mon,  4 Jul 2022 21:15:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F3B895C0111;
        Tue,  5 Jul 2022 00:15:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 05 Jul 2022 00:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656994529; x=
        1657080929; bh=OIlVoKUqRNS0JTsxX6oVgzDx5cA0cwwSWzjKLk9Gqu8=; b=g
        TXNup1J2DVYM+LHokDyJZ6P1aEkHt1B34MdYhlafXUt3WeqzimYUUNBvy3JyA+xr
        HcVffJ584kam5A9ZeO979zof0fLADzS8GlJinh1Nx5NHkeqR79RHvGBztbADYUvO
        lsMlQANEVZTdPwW25mL490qnbTbU33Q+Hty0MtrlI74LXo6vaEReGQXTdPyHWP4U
        YtPZKiU3tM8InqjGQlNR4nTElcC34EAQCVgyEDSupqhP4xns4UDxV1/azGS6uPHs
        /A0BmyABMP9n5efdTxjswN9z5SYdRLtKI8bXfAOyk5oXvFwW179j92ZqcNggDvpU
        1Ktl7l9nSeD3Wc6eG7Ltw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656994529; x=
        1657080929; bh=OIlVoKUqRNS0JTsxX6oVgzDx5cA0cwwSWzjKLk9Gqu8=; b=t
        p7tw4JiMTSiOf6C3otxsGCaxjs7ftJgrme0lNuKkgrqSs9u3088JJJllKEnLl1wb
        cA9pBITUYtzGORzLa3ym6ooonaEd0XsasQ9vyXpvb/w7oj6aGdgiH6KpRAjHHcVu
        /M6KB8alO84zhDpbKUQyUsO7giB6SmoCvxRS9tvv0dQFpeOz+8WVbEF1xL5sIpfZ
        iaTmme5QFj+oxVXcozsfa3+dlKRvpaC9P+k1CIUORWxU38TdP1UCjvKR05W+pajM
        YtNNBAdH/KGBdkGGhdxEMnrPiG+0geR7akHn5lqZoLuDe7F7aQIpMCPtWEMrwczQ
        p0bWcgGTBdaeki1YtsLoA==
X-ME-Sender: <xms:4brDYiq_omisC6DyH1XIQwHE-Xl2AZqKMl3YDinkyHXNWgAcS9Jj0w>
    <xme:4brDYgo9ubMYp2GtSrbbn2ONbWWBO8_7QDjT4AcGVW3ij7WK_21HAl2BwbViJGhRD
    BVvb4qDiMENfZlvrg>
X-ME-Received: <xmr:4brDYnNRTtvPXs_eYdVNbk46DGO_fgtynO-kWtLwWzLKizHW8AT7sQdDkXFFnIUn6SH-Qw2e6JNpyLB5SjouXFu6Bp8toOoeUdRjpvusMFlQoEVo-fJfjUbo7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:4brDYh5sbdKmHAVNYy2kPGV7Y9RQj_ryvJPVgijGVgFJ8r8ByXUFPw>
    <xmx:4brDYh7BpdN5gawI4trXwnhKSI1DCSs_cNLQXVol3fKEKcH5FIr09g>
    <xmx:4brDYhjKopUlfywhbYs_5Q8FKWVGRPoskSOAS438KpnYUnRUohIifg>
    <xmx:4brDYuzWllqCLUpipgx0pNCseMZpEFknH_GcTh_ygAYDZtRap2_O0g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Jul 2022 00:15:29 -0400 (EDT)
Subject: Re: [PATCH v4 0/2] ARM: sun8i-r40: Enable usb otg support
To:     Icenowy Zheng <icenowy@aosc.io>, qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220518101706.26869-1-qianfanguijin@163.com>
 <a50307f826e8e5f4218bd2bfde23add8a26af0dc.camel@aosc.io>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <70bad34b-b72f-9719-185c-c79b46a4b704@sholland.org>
Date:   Mon, 4 Jul 2022 23:15:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a50307f826e8e5f4218bd2bfde23add8a26af0dc.camel@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 8:11 AM, Icenowy Zheng wrote:
> 在 2022-05-18星期三的 18:17 +0800，qianfanguijin@163.com写道：
>> From: qianfan Zhao <qianfanguijin@163.com>
>>
>> History:
>> =======
>>
>> v4(2022-05-18):
>> - Enable both musb and OHCI/EHCI support
>>
>> Tests:
>> ======
>>
>> All test cases were tested on bananapi-m2-ultra.
>>
>> 1. USB DEVICE(ping test)
>>
>> Enable usb gadget rndis network, ping m2u on ubuntu host:
> 
> Interestingly musb previous totally fail when I initially work on R40.
> Maybe some phy-sun4i-usb patches fixed it by accident?

I tested this series on my BPi M2U, and both host and device mode work fine. So
indeed whatever bug was there must have been fixed. Possibly it was e6f32efb1b12
("phy: sun4i-usb: Make sure to disable PHY0 passby for peripheral mode").

Tested-by: Samuel Holland <samuel@sholland.org>
