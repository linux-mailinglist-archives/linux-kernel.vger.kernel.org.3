Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A20E55CF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiF1DTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiF1DS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:18:57 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51761EC68;
        Mon, 27 Jun 2022 20:18:55 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 593873200956;
        Mon, 27 Jun 2022 23:18:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 27 Jun 2022 23:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656386330; x=
        1656472730; bh=/YpMypc4CtUEpSm1nrTuU0i+0ewy87iAcDekmp+xtcA=; b=U
        BZcVDfchVaWFO56Wp9ddD3Kb5jzex7CQrh0fAzLw9+tJxlvf6RNiq1EHMZDE6z3Y
        SCe/zhclh2hLgnv2273e5KEABKupjZjmdlmz0gDHI9S2CUJkRE+qeeVxMRd44XQ7
        unUpKkqe+1A4iaRF5yV8pTsgbyObVdpX8JMQ7L3vhfmZzec0gJo8flQBc+SlEtmX
        CjyZBdZml+uLp5oQb3enjovrte4QPB+jGwOSvE3dMlRsaA8oPt/4ywJcwcIV3Kdt
        m+oZ8xgOW0Kuyav4Y+LGRQtDGX+IUhdImTSiKALNwQ7GJ93HwTt4AV8SdDbn6kwo
        GF1QevF8+P6eipMt/HqDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656386330; x=
        1656472730; bh=/YpMypc4CtUEpSm1nrTuU0i+0ewy87iAcDekmp+xtcA=; b=H
        rDg86DII921aq69Gy4ZvLxZyipPCHUXDdsip8zmaFj43+zDzBaGgoKz7G19hxtC5
        Vyn4al/oeY6p3IvbMaJV8u1dqG8qMdcnPILXYwG0XlEVWAmjtIs1JcH49BRwckR5
        64CMBsQjOWPq3yZstOiEGJqiY8S7IzY+ltFhAEKOB9yqLxXWIg/0mwgnpO7PZ0vW
        abp9UPhxqfX5C3SlGIhT/zN0d6uJOPaXuQ6CMkQI2zn6443ccHS2YZsKQtRGFoG2
        E9r5VBieX9W4Q3SCBaT4ZsQ4x6byMAnXNBLK6gJh0/AcSDZQRMmDyd2h4H2QjWUs
        lYzNGVb+RHe3e8hHk3tWw==
X-ME-Sender: <xms:GXO6YhiTJQ0pARW7mR7Vjc1SCoVR9SVhQdWlC5hmJAIQ31SywnBakA>
    <xme:GXO6YmBNPQ0wahjvTUpqMUjCjrmTLTsrifi3F8cPxPuhKu3kJqazk7vj6P5iMSutQ
    9jR_RIt4lvMsqIj6A>
X-ME-Received: <xmr:GXO6YhGKfkIiBUE5ripN-wkxAOW4rLpI_Zk_fwa3cIzNEdK6Hfd3iKTdGKlIgQwcgTWcSctczuWZJkcuHnK_SsegJdayF3DXoEayUopfd0V90OJ2RGMKTate4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:GXO6YmR7e0p1cKQpM83Zlctpcw0hXu4RMLTHbNXC3sgW4zGSnvroEg>
    <xmx:GXO6Yuwl41vWCtpt6pDw9_zQH4IZLDEYvMjARqO87SaPJcpQLemSHA>
    <xmx:GXO6Ys7JP1K-CKiWyyoRbGYjv6YZ2BaYqUBn7chd8m6g6X5V7mRGFg>
    <xmx:GnO6YjoLT1qGFihLtcLS91hOQUXo8535d0onk1DbP7Zov7R5dIcqcA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 23:18:49 -0400 (EDT)
Subject: Re: [PATCH 2/6] pinctrl: sunxi: Add I/O bias setting for H6 R-PIO
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220626021148.56740-1-samuel@sholland.org>
 <20220626021148.56740-3-samuel@sholland.org>
 <4405996.LvFx2qVVIh@jernej-laptop>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <bfb768a8-8286-c596-8b10-28222c962ec3@sholland.org>
Date:   Mon, 27 Jun 2022 22:18:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4405996.LvFx2qVVIh@jernej-laptop>
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

On 6/27/22 3:34 PM, Jernej Škrabec wrote:
> Dne nedelja, 26. junij 2022 ob 04:11:43 CEST je Samuel Holland napisal(a):
>> H6 requires I/O bias configuration on both of its PIO devices.
>> Previously it was only done for the main PIO.
>>
>> The setting for Port L is at bit 0, so the bank calculation needs to
>> account for the pin base. Otherwise the wrong bit is used.
>>
>> Fixes: cc62383fcebe ("pinctrl: sunxi: Support I/O bias voltage setting on
>> H6") Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> Did you noticed any improvement with this properly set? In theory, 3.3 V bias 
> should always work, right?

I think it matters for inputs, which may not detect a high level state if the
bias (comparator reference) voltage is too high.

It looks like Orange Pi 3 has a 1.8 V supply for port M. I am not currently set
up to test the behavior with different bias settings, but I may do that if I get
the chance.

Regards,
Samuel
