Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422D357D8BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiGVCoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVCol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:44:41 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3B289A7D;
        Thu, 21 Jul 2022 19:44:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7027432009ED;
        Thu, 21 Jul 2022 22:44:39 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 21 Jul 2022 22:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658457878; x=1658544278; bh=XDg/JTeepS
        Y/EfsVsA29YcGjoEzuSt6+4EI1pFHO4Ok=; b=hUKqTsOU0TwjlrJwox7IMflh6r
        kewF5mXoii2LMCD3hjwUNMbjSNXB/Ih6pIuM/dyUw7EpsoH2SgQW23miDuMYFxGP
        6Lx7SvDG3v6xgxJ7pk6I+IOBDyzlJHkRiFZuVClz6xXgOrdxzeJx10QGon2Bs/Nv
        cx79Eb8Au04cneG51bEpRYrtb1ebpTyCOg7Vxsws990QYFVESlV8CkNB9pwXV4Zq
        xJnwLoJB2lrjFj+uqSx1NT6/Q8VMpR5DW0WEwSi0rfZUBCNZArF7f2l5I5l7ry4Q
        JaQRJLRVRxe9vyVg+Z9JQKiXYAlc4LxBAI5eDgwyh1xaF2i+KZPyrKRq4dQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658457878; x=1658544278; bh=XDg/JTeepSY/EfsVsA29YcGjoEzu
        St6+4EI1pFHO4Ok=; b=haPlDvjU5HypPODSHzKRmU2me7LDxGUJvHwI9cxci+oR
        kYxs7g7Mm85zVzShl8PISQ+1ubU3uV2yCT+2hmkrWVemBi82NXcnDY71I59HlQ+B
        RZfvOYZSAw1/gkPToiJh0dydFxqLrs9eNA8hFIiYkWaprk1muhJ/VWRlXYm/4TfJ
        +PRWDS8pnlC4alfApQ+iEWSiPEqVhCRnW2TD+RucOrSHyFJJcC5OewPreX3sGPz2
        UdefW+0Rq++gb44nXku+mhYbQjMrHinutbBzvRTdeZhDpZB4TQNIgS0w1dkhvz3d
        TBv8VxBvR++YCKbd2Z8UPlMvEG+P0mMBB/+JX1HTIw==
X-ME-Sender: <xms:Fg_aYqY_iqMWKlvXKcWFMBdXmIsCypGAhiAXful8Ys4q_qfmhENRig>
    <xme:Fg_aYtZZCsD7rwXolJPsfJYOeVVM25zZTw1X6LRKpEXljur5FA5vNv_PUHgyLkjYW
    y9s3caf4Yb5McsNUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:Fg_aYk_cxm1gILvNSOsK34Pc2Ot13N7i-AnJewQqzke696sNXwqp7g>
    <xmx:Fg_aYsozUkfp5XNzAHGHR07z6vSfKgu1B3jN8gMtGj2ZMXEsrIOm_Q>
    <xmx:Fg_aYlpNA1-F_WMBTuD3PAZObquz0xy44JREULwYqXUrT21muFnJVQ>
    <xmx:Fg_aYg3b4xTjTdxqJDZoEQtUdqbIQ64NMw0iVATOLlPBs78c8miatg>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B8CC9170007E; Thu, 21 Jul 2022 22:44:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <580e2700-e4e5-4226-beb5-d21d815acdb3@www.fastmail.com>
In-Reply-To: <20220529104928.79636-7-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-7-krzysztof.kozlowski@linaro.org>
Date:   Fri, 22 Jul 2022 12:14:18 +0930
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
Subject: Re: [PATCH 7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
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
> "qualcomm" is not a documented compatible and instead "qcom" should be
> used.
>
> Fixes: 3719a1b13056 ("ARM: dts: aspeed: Add Qualcomm Centriq 2400 REP BMC")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
