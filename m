Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19A59B6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 02:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiHVAEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 20:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHVAE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 20:04:29 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537DE1E3E8;
        Sun, 21 Aug 2022 17:04:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F3CD05C0179;
        Sun, 21 Aug 2022 20:04:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 21 Aug 2022 20:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661126664; x=1661213064; bh=mPn3++NzcT
        ZNYJn9AdaHv9tQvAGSNSm562mzA+CXdyc=; b=ilFHpw8HUY3poGkFqCAHrPz6aw
        ZgN1BTG5aJJmgGVknaTTq9XZdmrj8jIHTr6/ilmi3p/FWrUNrwF6HnzvaCBtXLUW
        GiNGNBC4onqhlldQweTckLYJpNSLajxq3FetenaB1QWl+woB3elGKg5BqOCoFKHc
        Xea40SFZ//MuCMTPwK1WgsbVCag1Ygby/zxuDDkLTtY9D8bKDYIe+96dayl7ojVD
        CowK7aL5WE21b3xld+BxvC6MyAAF/Nx/P+KA6a58qOXdby9OJkl6Ks0l8DZOez5o
        9Dk370KewS+ZzTKivMVZuNgk3O6qYzKAUe+7XvKLFKSZMqPSFhwmL/69MfuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661126664; x=
        1661213064; bh=mPn3++NzcTZNYJn9AdaHv9tQvAGSNSm562mzA+CXdyc=; b=F
        QmgyuT/RSJ4NopJmNdtp+JHYiuDOzqyhs+v+AtH1/MbHHd0gRwQUvXK6HvdSbpe0
        OgnJkKuBr2lmI7u/LJ53G+Ez4IRLBP+o7SYs9UXDS9GeFsKkyxE9/+kwHQ1N7qUg
        GniPwYh9UVattk5sfi1FgZ3H8l4eFTViUlretv0P64ZzBQB461eXRT7FZgSVTfyN
        aNcw2tf4LktvuEFXPwF72UIk4AvzM6sHo6OdGZvS+X7FWtvKTxwMg+M0jRUdR3qj
        PBjo2QcUicomyhc/aEdlDiNO0fGQe+UO4dq0tNrzbCL+bXddsdh6NiT4hZQhhNcp
        ORHCEzVOVO/j/2U55JBeQ==
X-ME-Sender: <xms:CMgCYw8RZegTH2UV70DmeaL0NztqKw4LC-Qq7BxQaFFTBb6elpPmXA>
    <xme:CMgCY4vZJcTgmRS3JyQxGseGucI0KmI4-b6Z8NeEnJRUq290jxNJQAxcLcZ409ap1
    C_l2ZwoVEOhUexuJQ>
X-ME-Received: <xmr:CMgCY2DaFJOdIXat5bXQka5i_8-3aTlUUVC1yPV2UxkgPkujullImR74MGbNd2GtV7pWSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiiedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefvohhm
    ucfhihhtiihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
    eqnecuggftrfgrthhtvghrnhepkeeuieejfeeuffekkeetgeelveejieetheeivddtjeei
    vddvledvffdvvddtuefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepthhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:CMgCYwendjHYmerqjOVV4l5A79yOidGSe4Gy6prD1siSteQqwUN5CA>
    <xmx:CMgCY1MsTfKSaPshegZ9LNI5NF9BPCLZaKeksnJyK_-MLFjThhOJhQ>
    <xmx:CMgCY6kNGdi8WCTvEj466LGVVBCPUIohL2QHyk2aPiMBrOlyLnHSAw>
    <xmx:CMgCY8mxFG3gyMMX5jQ9R4gqR18e7YWILkCPfe2qdXGpMOPU4_YlRg>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Aug 2022 20:04:22 -0400 (EDT)
Message-ID: <da0e45e0-e1e8-35fd-53b5-142269b830b4@tom-fitzhenry.me.uk>
Date:   Mon, 22 Aug 2022 10:04:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
 <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
 <a11bc22e-a10e-7d15-72d2-6af1d4790695@linaro.org>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <a11bc22e-a10e-7d15-72d2-6af1d4790695@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/8/22 17:52, Krzysztof Kozlowski wrote:

> Still wrong.

My bad, I will fix this in v4.

> test your DTS with dtbs_check.
Will do.
