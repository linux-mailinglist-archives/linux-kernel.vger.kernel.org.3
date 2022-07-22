Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2B57D8B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiGVCnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiGVCna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:43:30 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC45989A7D;
        Thu, 21 Jul 2022 19:43:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3812932009C7;
        Thu, 21 Jul 2022 22:43:27 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 21 Jul 2022 22:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658457806; x=1658544206; bh=nXICDDfsvk
        9tEKtACojymXPSAf/uavSaU0rgUGSdSIU=; b=gcHZ2I9RD9S5XMXF1EDDlqFpM+
        WZ5eA0X/qEVCkXbd9ciJyyC7pSbncocTfCTEnIkJQar6LTS2JhvYuSJkezM3enUm
        So82HwXQ0C5Y6Vb4CrwPqCA2SD9Vjl2cnZj0bPzIO3xQYROwOIZlKareIOQEpShm
        +buKWu6Of2N9XOUUM5Cb1RGM0ptOqO08UjepSQWUxbxAwzpICM79FPSIw21hvLSr
        kEiMytDmxebpb14pyar8SEiSlJp+mfGpI7KfQbgoJEdwJBaBMGejf7PSjTgaU3bV
        ezjUbPNp7njE/c+C/r9LkRNfHyWi3+m6QLjY2pJS+RgoillNq47qDEFzPcmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658457806; x=1658544206; bh=nXICDDfsvk9tEKtACojymXPSAf/u
        avSaU0rgUGSdSIU=; b=1qtwXbafvYWaxr6XhhAsnWo7Xf7T6cTNaiHk7p/VMGIj
        opeg4RTT4/Y3zC0+rc+JCbzkHzz2fCfHvu+lqZl9UBZEHgjbxgQawn0KC8z9l4uv
        RixkJ9X6Z1Rvcn+xFMMDDom/t49Q2ES/WV/2S7Fd/RdZtpXhKYRMSB8lSF8n88c+
        5WltiNA2y6/B/3sKZVPnGERIPwFfDFSD4FM+wZ2QCQoPH3s6Dm4cQJtQNetWyycH
        GcnERMxmiKpN7H+ScWFn5Rz7Rx7QZzMe2HeQWgvbXsUJ7qTpyjgv8af8g2xXsWjD
        9y2zhpSgsud3MDxy6BSqIvawTyeovqSZCjrJgveCrA==
X-ME-Sender: <xms:zg7aYrCvJq1n4vgEEv1QL_5YadX2ZR0X5g-llj5hwHJRWog-HecM1Q>
    <xme:zg7aYhgKh1k13kDKW85l76bwKuMxBUj5aHn8lq_H2MOXXvKZN8dF0ggfIoLSlOOS7
    z3nnM56HWO5VHE2Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:zg7aYmk0EYd9yywBwm48Rw-Wg1b9hcungIoB9dioiDdVBbJC7550-g>
    <xmx:zg7aYtwSGZtyB5GdCPZf2lNQuzjoyFJaDZcGN-tbMAe7e31CIDzHgQ>
    <xmx:zg7aYgR0svc-IcjvEU7C6_IdjdrnnPZlaKRSeAgYFOhVqyJcPGsN-g>
    <xmx:zg7aYp-iSLwQS2Q_HzxnjLuABo-Zm8MPgz0RxVsDlDg7Cnc9GXmacg>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1CE3E170007E; Thu, 21 Jul 2022 22:43:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <05cb7e99-3f57-4375-b1fc-0b880a17dcc8@www.fastmail.com>
In-Reply-To: <20220529104928.79636-4-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-4-krzysztof.kozlowski@linaro.org>
Date:   Fri, 22 Jul 2022 12:13:05 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>, "Arnd Bergmann" <arnd@arndb.de>,
        "Steven Lee" <steven_lee@aspeedtech.com>,
        "Ken Chen" <chen.kenyy@inventec.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     "David Wang" <David_Wang6097@jabil.com>
Subject: Re: [PATCH 4/7] ARM: dts: ast2500-evb: fix board compatible
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 May 2022, at 20:19, Krzysztof Kozlowski wrote:
> The AST2500 EVB board should have dedicated compatible.
>
> Fixes: 02440622656d ("arm/dst: Add Aspeed ast2500 device tree")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
