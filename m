Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F14F89A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiDGWLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiDGWKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:54 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05892C9903;
        Thu,  7 Apr 2022 15:06:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6837F5C021A;
        Thu,  7 Apr 2022 18:06:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 07 Apr 2022 18:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=06FJnN1XVgmNd4
        4sTYWmSIeLqce0O5OHT4AOf34aFqM=; b=YQEZRQQOQW24kGfnrQIp8NL3nMa9lw
        NQ7lQhfh20lOiOWdJE4lMK3FQ6S+GFJZvEa0cSrfXtclM1h6aowYBfpfR8V0Rc3c
        I1ZMIiAMXEane0Kn2YYp0nLip3Dm3Qifv7Jala66CDq5USbye6eM23gSxEmbhHh9
        uT6jOW2zYNYwtQBSVNY5Ovz03Y5cw5rVdojjkE3M5xO54K0Er0S7gMKNxq+utNyx
        y35h8Zwa8UqUt19112FlOPkJkHucyVjK5jkWEbfCWC0z4jMkI0QJxI1sPPHZD3hk
        c328185cNAi8cHxWUm2Svsn3DGXBh2MkUEehI6aVe53uqPM43gMH5YUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=06FJnN1XVgmNd44sTYWmSIeLqce0O5OHT4AOf34aF
        qM=; b=e6F2r/OKEDdkknDuKwiu4Zt+yLnZnmWEtj5JcmPIIJCayZc4B9y4Q/YJu
        I/M2wTM/I1XyAl4DF2PjYjRz2df+nBeMgUFfNowCZr78GT+zidehFlhBJajjU+IC
        qYsJW21CIC/rNpZPI8zDFsKn4+RKUiwmylQ6/yzkm+JRQA2hw4Ppk0kfrCkfEykq
        uUfSjXOMrzBtb5diQUF1Sc5b4uWW5BdEaQc182FJVzNeOV6ywgN+fTnK0RiapOxx
        3tZWgp+7EiCdqn2KSH0hK8W9HPiLX1vTuQ3rdHIjKw4wFyAUE+PFQ4WllQTp3cs1
        Tpp++eUmH+C+VyAFTgNpnHhjnRbZA==
X-ME-Sender: <xms:SmBPYgrKrns4AcluQ0cuCAyjOa8kvfNQn2dHGaJeiF_I3FBTmhnLwQ>
    <xme:SmBPYmoeH-iyQy8rssq4GZD9z9KEZCWhYtmKT77CNeYln6GVkZ4rmhS91vHtwZT7s
    ipqQgstO9pOZlUHew>
X-ME-Received: <xmr:SmBPYlOHq7dnbI2eMpEvTFybUBCjTO_U7XM5LSpEs62J5EAngZ3BRyzqF0nM2KKVnV3r0nI7_UrgYqOKQExdqsQiYVl_EYyh5mVF3X3H6RVUCgrCCw32uIu5Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:SmBPYn6cBE-n3WsrIV01cYdaw7piGP6GbdBaCQb7jpEqbNROb9te1A>
    <xmx:SmBPYv6Z-41A8SFTfv0w3omFyuDA0oPBKuA4NLqvmhOzG6VLAPrjOA>
    <xmx:SmBPYnhhiTsQ1NnCVHcQpDycq3PnBxIoXq3lmkMMulAoY6LURxTQOw>
    <xmx:S2BPYiYXlai98REUoKEGAJ0JvyqRv2l32n8zUHFuFMLME7pWdYme7w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Apr 2022 18:06:01 -0400 (EDT)
Subject: Re: [PATCH v4] arm64: dts: allwinner: a64: olinuxino: Enable audio
To:     Philip Rinn <rinni@inventati.org>, wens@csie.org,
        jernej.skrabec@gmail.com
References: <4fc41278-c46c-6486-a336-f2a329bd6bd0@sholland.org>
 <20220407155145.10891-1-rinni@inventati.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <40976a35-2241-a2f0-c9be-dd32c1b51814@sholland.org>
Date:   Thu, 7 Apr 2022 17:06:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220407155145.10891-1-rinni@inventati.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 10:51 AM, Philip Rinn wrote:
> Enable the audio hardware on the Olimex A64-OLinuXino board family.
> Tested on the A64-OLinuXino-2Ge8G-IND variant.
> 
> Signed-off-by: Philip Rinn <rinni@inventati.org>

Acked-by: Samuel Holland <samuel@sholland.org>

Thanks!
