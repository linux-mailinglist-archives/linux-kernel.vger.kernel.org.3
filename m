Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488FF57C24C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiGUCdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGUCdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:33:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85049774A4;
        Wed, 20 Jul 2022 19:33:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E7FF55C0101;
        Wed, 20 Jul 2022 22:33:13 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 20 Jul 2022 22:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658370793; x=1658457193; bh=/yfj/PjdcA
        cazXFx3w+y281UesI0amFCc8gQXZmr7jw=; b=FCkpsXqJBkkmkdSeCduKJovVk1
        b0CtQPcnafn5MH/nm9Em1qqEg800tVDa4v3pplSHjPTJciW/YKC1Z78KgKXMqAdX
        C0OZPluA4C9fkePVyw8tENqvRtzwhxBmP5F3xBeJbXej9vDTxFwI1cm5/mSDfCM2
        n6Ru3+JpBXofoApD0Tn/q8heR8MMIoHPd/368jxpUYQkHGmMoZvyWxCiyB/4z2tX
        dOAbzVESQPvE0HQjg00qex2hurKKdWT2NuVvq/OOvL8wr1aNjArYREYqfr+PJAVP
        HiGtKNttvkClU4IHnZn9XeyNtSO3WLaHDoWuDIf63cxCDDFIkvEW83F93HGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658370793; x=1658457193; bh=/yfj/PjdcAcazXFx3w+y281UesI0
        amFCc8gQXZmr7jw=; b=VCwm2VxHJBFT4nidQr0c90ODRRK57B6AhdljiX7HuXGf
        f6boYFm7AILiWMsUYm3oLsEA9CYlQKN5jZe1Gqg1Otjeu75F0OOSpFX+qkA6FiSh
        nuxZNJG04enyjJgAICGI88CxYoBe9usXleqvkkAJZQ2kNmlbFYJSg8kQ4+l4cK3o
        ebO35yehnthB0tfFMNCPZygKtHCwxdE7mjzI8/fz+mdtYr/mfKmrdI4/QNi3pipu
        CtVUcI51LXi6e5HiXF08XClAt0Di9115ziOw+RgCNqEjavdw1qDFh4U4EWmWMUIJ
        cPu5GeSdkGi0pdPgsRmJWmuYV0d8qyQpcYp+H9VoRg==
X-ME-Sender: <xms:6brYYnuGXAB0XoNRBtlwDXl3a4ML-JLj-prDQwn4grW2uozkiANfEg>
    <xme:6brYYofgkTPl4DHdhZJeSYuyKtUbS8FgHdeQoppgTlO4HHvnUrTm-QziHm8y_iKW3
    Eiihk-SH-erHLP0jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:6brYYqw7qgrfy7p7XDzZw2T8FvnbPESbFAmc-yWMmm1LVzujTL6DzA>
    <xmx:6brYYmNci-tlVGT1RW5mejMvg3bLZ7ADk8KL9mVEMfG4TPr6OA-A4w>
    <xmx:6brYYn8M38ByWvs1-QX6uq_TTy9qHX20NDv8ZGK9NJT4DjTOqHFh9w>
    <xmx:6brYYnyAtIv9Z-KJTsk5uGYQAhijFy2bSfYKw5wjr5_yIwtp3g1ZoQ>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AFBF8170007E; Wed, 20 Jul 2022 22:33:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <854eb3ca-abd6-4d9a-b461-cdb3a1ad22aa@www.fastmail.com>
In-Reply-To: <20220611095828.1090-5-aladyshev22@gmail.com>
References: <20220611095828.1090-1-aladyshev22@gmail.com>
 <20220611095828.1090-5-aladyshev22@gmail.com>
Date:   Thu, 21 Jul 2022 12:02:52 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Konstantin Aladyshev" <aladyshev22@gmail.com>
Cc:     "Supreeth Venkatesh" <supreeth.venkatesh@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: aspeed: ethanolx: Enable VUART
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2022, at 19:28, Konstantin Aladyshev wrote:
> Enable virtual UART for BMC<->Host communication.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
