Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2209596BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiHQIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiHQIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:50:28 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A02877558;
        Wed, 17 Aug 2022 01:50:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 55DFB5C0158;
        Wed, 17 Aug 2022 04:50:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Aug 2022 04:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660726227; x=
        1660812627; bh=qjCTliriPTIj2jcyPtsg+UorPFtVEycVX2NzPCDuQ1Y=; b=n
        4TqT6htuV5DDkJQllXEPBAe+9G/Ua75/SNBIBpNemkwXrUrKhc6zEkA55QvdDpuk
        YBPNLZKoTnnsQkIvBgNZtJIe+YXcNSJPoyeQYtZhtrCNpFmSjtWTJWe+8+UEkOzu
        xfmSzryfPUx9N09it9ksnHgyKSHEHPwIuHk9jMw0hR7oI7AyxC7GvLxpiAnLN5KB
        ayvDiD+X8bpH7e6vhOAg/+mBNplc1xeEvd/sLGMsonII7Syr7CYMgVM5ZIEh0BZA
        ap9IFTMFllCNxqALfY1rA9zrIJdFClVJKYrDYd/Ow07gKU+XvwWEKwX5+5hcfiI9
        odCcUOCcCLQZE7Xz9zX7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660726227; x=
        1660812627; bh=qjCTliriPTIj2jcyPtsg+UorPFtVEycVX2NzPCDuQ1Y=; b=c
        +FQ5CCTxLKG2ztDpB+x7aZs8pucpadcRkvekSVxmYoBrhuynQSV/3ROzdCag8lPU
        8cOikptRAozmbmAhywXZ5WJxSMUDSnIjPAD/aGz7IaGfGfrwk5yhLSl6jYvuO5Pn
        r8cqL/1IBzy/bvHFO1DVx/yoMPBKDqHpzQODBGvV/Hub7QkiHpXYreP8qA5pvdyR
        f6V4uydr24uHTYhjFeJJypGdbp3Om0MaSqZDWN7me69ey7s1DL0ncO4iwqGCJ6zy
        PL7xKuUnVDdLt2vzHxNsvrGd3DykCPHKixcWXTiTyVaR2w+wN4dAQpceIvxenTLl
        2ll0eihSwxktA11mf8eWg==
X-ME-Sender: <xms:06v8YmoHN7kI6wTPzueiA3_uaZAQbsY8xqHzG_3FoFGakWBicZ5niw>
    <xme:06v8YkqAxVZ40h8J0YtBSpdlr-dotGPl563H6cJxjKRk167WUhwKrarJM-6UU4_Jj
    nNGwgw_k0ZxYLOy-Q>
X-ME-Received: <xmr:06v8YrNz8spwMZy8wA9IARNClAuRwoNvMUECcicsBQGQpMbo-IItn2iAYR1Q4DIif1uru3dcfVrmjRQ0t_MvjCzWSARc3r-Z_FCSjS5uaZK5oPQ52rCVsOEhOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:06v8Yl6BFWVVpZqSn16Vq6zsQ0ZVMbDaZtanCM_DiT6LmZXaMA5Agg>
    <xmx:06v8Yl5NTl9Ks7FXPdNO76GXESntVrSaAyg-3qXemTHp-hlubPpfRw>
    <xmx:06v8YlgBaEUh2HHDIPVn5HExrSUGtdiSPyRzEIyGensf8IYEJ2vx4g>
    <xmx:06v8Yizzeq4ZB7gqcOKdC54_-g37gi9PH07JROmBaoG3Rs9N1K5k_g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 04:50:26 -0400 (EDT)
Subject: Re: [PATCH v3 4/4] soc: sunxi: sram: Only iterate over SRAM children
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-5-samuel@sholland.org>
 <e5969030-0a17-d10e-7eef-8d906e8a4dc4@linaro.org>
 <82fedf98-1d94-514a-ba03-f88b4e1d888b@linaro.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <a0e02ec6-b1e2-e4f7-8902-2768543f56fd@sholland.org>
Date:   Wed, 17 Aug 2022 03:50:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <82fedf98-1d94-514a-ba03-f88b4e1d888b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 5:03 AM, Krzysztof Kozlowski wrote:
> On 16/08/2022 13:01, Krzysztof Kozlowski wrote:
>> On 15/08/2022 07:34, Samuel Holland wrote:
>>> Now that a "regulators" child is accepted by the controller binding, the
>>> debugfs show routine must be explicitly limited to "sram" children.
>>>
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> ---
>>>
>>> (no changes since v2)
>>>
>>> Changes in v2:
>>>  - New patch for v2
>>>
>>>  drivers/soc/sunxi/sunxi_sram.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
>>> index 92f9186c1c42..6acaaeb65652 100644
>>> --- a/drivers/soc/sunxi/sunxi_sram.c
>>> +++ b/drivers/soc/sunxi/sunxi_sram.c
>>> @@ -120,6 +120,9 @@ static int sunxi_sram_show(struct seq_file *s, void *data)
>>>  	seq_puts(s, "--------------------\n\n");
>>>  
>>>  	for_each_child_of_node(sram_dev->of_node, sram_node) {
>>> +		if (!of_node_name_eq(sram_node, "sram"))
>>
>> You should not rely on node names. They can change in DTS. Why do you
>> need to test for the name?
>>
> 
> Ah, it is not a device node but a child property, right? In such case,
> it's of course fine.

It is a child node.

> The device node names could change and should not be considered ABI (at
> least I hope should not...).

The node names are limited by patternProperties in the controller binding. I can
check the child nodes for compatibility with "mmio-sram" if that is better.

Regards,
Samuel
