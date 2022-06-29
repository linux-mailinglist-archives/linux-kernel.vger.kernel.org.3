Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCC55F366
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiF2C1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiF2C1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:27:18 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351AF1A385;
        Tue, 28 Jun 2022 19:27:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 40F883200905;
        Tue, 28 Jun 2022 22:27:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 28 Jun 2022 22:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656469633; x=
        1656556033; bh=RezzKQz5lCHiF85I1womsS66xU9W7I5xMpCJe6Reo0Q=; b=r
        tA5QkwwPaOJHCryzlW7yMURGrR4xbEWjEEuvvB9tkbE+8i/uAt0g+TFVAglDD6YE
        rI2vzWjFDNb06sHh0Ym+TJbtJxJstax3owmPe7IW5r/svaInj/xgbu4qita684UZ
        X8i18zvOl/QNB6CqoYO0xdn5Iq4Ekgtbn6uk2N3PE9Lu46ptN1JzjCDEmZPT1L5F
        efcY3IXXIiPSfcw8MqsEcnB944W74FyL+/HPmBd8rP+YTlxHw6PltlMP40f5pWO1
        yUNZEWJBcKV98K4KLYFGIihfeGDqlhUXbIhXFNek4bfFa6Uc9uYx92Ovme0lAe3L
        GfvJe7Xg5+0mkAlpnmQCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656469633; x=
        1656556033; bh=RezzKQz5lCHiF85I1womsS66xU9W7I5xMpCJe6Reo0Q=; b=w
        kw2P3jrLEKEuonZbPOIfF9RYg5jyk/qy5JBEV804zPeivGWmCjsE3q8BgMzD+o7/
        0o4OHvHqwUaV4QVJ38KWDpiZKssE/Gir86O5beLk67WGW63UEBMsfcUAldP/a+8u
        yU3/SKpRilxUps7gpWRKilDv7WTcO5+MICFsHPVl9lsj//j2GszbbRPVGsOF/7N6
        A2zgFJtua8KwlFcJ/9WK9H/iwucbYflDvlYXjgjq95IOy46AFGTHuuddeCIXk8x/
        qbsYHSliluEvX4jx4jMkyKFIKu+77CQc3/Ox0mQeYXGWEt3nFWdLEhjSF9il/ERS
        br2rA7rPB9/IfiRL8cbQg==
X-ME-Sender: <xms:gbi7YspBxefnNoz9en_O90ic7KNi3oQVzArzqEe9cTWo720GvkPxQQ>
    <xme:gbi7YiqbRgI_WWRk7q1BmXfaehLTv_l3DsUFKEKli2LUUde7bx-HeSGfpogCQO2G7
    OBG2Sce1KqP13qckg>
X-ME-Received: <xmr:gbi7YhMlkNXtTZ14Dc5opIlrazRNH0pUuYT4zvdO30svOKHvoQ6q7st3kYoBuCoXI7Ta8t23rHXb5s9y47iRI5MXTq00cG2bBN3dBQ9jwhw71GU3D1-nunu1vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegkedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeelteejffdvgeehkedtkeevueeuteffteffhedufeeujedvudef
    udetieeijeevleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:gbi7Yj5HFlxN08pkH_od1MMSIW0iJCUKUH0Bcpd6ruAL9dODVyOPlg>
    <xmx:gbi7Yr7N6eb5hmW8rVc96n3d8TmxrwCL2dX4gre8h6Ok5nmj2t2zpg>
    <xmx:gbi7Yjjqc1A2hSUT2pKUdlgEtiycT1RoaACXQiHrH05m_NLrM6gOWg>
    <xmx:gbi7YuZDlSLKer43a1_VRpPX_HOgXUQakUJxFxpmJFaDYOyh0w71eQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jun 2022 22:27:12 -0400 (EDT)
Subject: Re: [PATCH v2 2/4] mfd: axp20x: Add AXP221/AXP223/AXP809 GPIO cells
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
References: <20220621034224.38995-1-samuel@sholland.org>
 <20220621034224.38995-3-samuel@sholland.org>
 <CACRpkdaxodnaJsKfFMvYHWtPwZyACiec4iX3ZXSBL5Ptfa6mRg@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <ffe66c81-9a2c-e2b3-ad9c-ad46824fe76e@sholland.org>
Date:   Tue, 28 Jun 2022 21:26:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaxodnaJsKfFMvYHWtPwZyACiec4iX3ZXSBL5Ptfa6mRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 9:03 AM, Linus Walleij wrote:
> On Tue, Jun 21, 2022 at 5:42 AM Samuel Holland <samuel@sholland.org> wrote:
> 
>> These PMICs all contain a compatible GPIO controller.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> If I can get Lee's ACK on this patch I suppose I can apply patches
> 1-3 to the pin control tree?

Looks like he already applied v1 of this patch (which was identical):

https://lore.kernel.org/lkml/YrnZof9lwsIQCqu7@google.com/

Regards,
Samuel
