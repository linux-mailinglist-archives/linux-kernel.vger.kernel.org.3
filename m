Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516F257D842
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiGVCMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVCMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:12:49 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAF9748B;
        Thu, 21 Jul 2022 19:12:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 347B132009E6;
        Thu, 21 Jul 2022 22:12:46 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 21 Jul 2022 22:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658455965; x=1658542365; bh=oh3EK6pguS
        h3YvsKEtAinLDMrGio2WQJD8fWhZQjcTI=; b=gjYPRNUZOhyBYuDDR0c70bkGDm
        fwbS9RcypoA/D++wtyrbQzez58FVFMu3o0l8NO4WvqQadshFBykRRdmh9xOhxMCn
        fwg8egRBbjXA/v6JzvM5/sIsW+UvkSs8ICXfKHCISDc4bdvAyIq5XrGpKo9FbPyM
        X0SeoZcnNlls+lmy6BbkD8Ii9DxR1c8HkRWVBW0MCuJCUhJkFgjdVGdLh5WLEv0u
        Jw/JMbQEz93VVg3bkxNYeA94gqcqQ5v9saJQdwn0H0Mc5sf/O91LoqqpcH8sq6+w
        djRIKG2k9scJm8xd0CyJP+NUq+dWvpmzfbi78Jf3NyLJKPdSeExnGa7IzFTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658455965; x=1658542365; bh=oh3EK6pguSh3YvsKEtAinLDMrGio
        2WQJD8fWhZQjcTI=; b=zIHrZfLVNKeOn9PHDV/C2r4/BvHpULAzux7GCqMdWvdt
        osKzEcKkB0yEdOMS8Y6tW2cLPOJOxpgfhhwhC0PwP71/eJS5wKRdkj3TN3AmbjDn
        0sj3a1LTBfHdqUImQueJ3AK1rFvsACGnkiTcrCdk3NeljSwEF0cRZleRPLWvwzsq
        Wt082GjZKApoFOMgAYP0yhe6StDYpHs2bUtNZSUi73NYeqx/OgETLNzMPYkR+l+u
        mT67mrUz7w3nOmNY0gmMfxZi0NpvyIJ9GB6vV+mbC+dtD1EehgeC3Ldp3fEn1R54
        GwPp1XimDvHJfTkSVQYbknBQI4R/Chmczsm2NZwLBw==
X-ME-Sender: <xms:nQfaYi1LfRqUJyNBMuRwiT2TJRge-ytrzR0NySBDnlsSR54CEK4lmA>
    <xme:nQfaYlGMVXTNWXQE4EfFyU0U_m5MAvPNSouIUw0quZ5tmFOXeCJYt046a4HeJvXcr
    zMHK-3jQp1qpsiJ7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:nQfaYq7cifREyVglBwm1Ne2Z0NGGyB7CaXr2UKbsRpap4i8t-bELgg>
    <xmx:nQfaYj22QpTGrbywTdvejbW-dLa-359tWDSFxUu9yFRMwustGIvkZw>
    <xmx:nQfaYlEqojI9laJSMK-XQkyB7ou-Gxiqrtcx06pZ_ijPrxBG1JHKYg>
    <xmx:nQfaYs3M7htzb81KfCU-smjeDLK9pTVNZ-qZ4VrLSQGVU6lxFr-9VQ>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3C373170007E; Thu, 21 Jul 2022 22:12:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <735f5f36-e25a-49f3-855f-a551e365ee53@www.fastmail.com>
In-Reply-To: <CAK8P3a1j=WUq8=VZz9aY5zkPeEMaF11w4PJF7evmY_JTsFoFZQ@mail.gmail.com>
References: <20220721072415.11424-1-krzysztof.kozlowski@linaro.org>
 <CAK8P3a1j=WUq8=VZz9aY5zkPeEMaF11w4PJF7evmY_JTsFoFZQ@mail.gmail.com>
Date:   Fri, 22 Jul 2022 11:42:23 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Arnd Bergmann" <arnd@arndb.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "Olof Johansson" <olof@lixom.net>, arm-soc <arm@kernel.org>,
        "SoC Team" <soc@kernel.org>, "Joel Stanley" <joel@jms.id.au>,
        "Rob Herring" <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>
Subject: Re: [GIT PULL] ARM: dt-bindings: aspeed for v5.20
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Jul 2022, at 22:25, Arnd Bergmann wrote:
> On Thu, Jul 21, 2022 at 9:24 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Hi Arnd and Olof,
>>
>> My two patches documenting existing Aspeed board compatibles were waiting for
>> some time, so a month ago I decided to pick them up and include in the
>> linux-next, so other developers - like David - can base their work on these.
>> Unfortunately the responsibility for the patches was not cleared as I was
>> waiting for some replies Joel and Andrew, so I also did not push them out to
>> you. And then rc7 appeared and it is quite late now. That's my mistake, I
>> should sort it out earlier.
>>
>> But anyway these were for a month in linux-next and other work [1] will need it.
>>
>> Can you grab them last minute? If not, could you queue it for v5.21?
>
> Merged into arm/dt for 5.20 now.

Thanks, and apologies again for being a bit MIA here.

Andrew
