Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268FF58C017
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 03:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbiHHBrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 21:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243236AbiHHBqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 21:46:30 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8CD14D00;
        Sun,  7 Aug 2022 18:36:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3B7E75C00B7;
        Sun,  7 Aug 2022 21:36:34 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sun, 07 Aug 2022 21:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659922594; x=1660008994; bh=wPmZAZ1DOC
        5MLpgXHbfw9hWoYqDBWz9rz/oL4D0HM1w=; b=jWLobC4KPvbg4opjCJE24ctar8
        4vKMEgATegq39xYhxy79X4t94s3PuN5ZeqzIsW0IJSUM5xCZAr9LfL02pw4l7ri6
        RFhh5Kq8B9fAa1ECXD011prOSP4Sf34OF4+gRkWYv+6eYq6EF+Z44E6XdyPHlTSa
        PO6FHZAGQUknDiPWSFzZ+kNNQdq4eFqWK67+dcijI0xJHWbAMYjbPE9E+IEK2/Vn
        41kN0tNp0LdsmdfwVP2cougvStOo2j7WlGs96ntRNfM0+as5nmCHB1rkO4umYDcw
        lN5pn1cUJo/SGamyDbgCNgxC+c2dStM47RoyWRIB9tmbMAn/ckFUI1vUobrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659922594; x=1660008994; bh=wPmZAZ1DOC5MLpgXHbfw9hWoYqDB
        Wz9rz/oL4D0HM1w=; b=xAhHkPXBvZN+cz4fYh1GTzYn27ucz3ALKXh5T4jKsh8h
        XbV7kxXcwHFSK4t1TllrLGYkW32kckvfCLPK55Dqxu8Ua+w07Z1KS4kWIrCl3Fke
        r0UFUUpp1JddC7on7aCXrLI8pof0bvOG5IWcOJRNgepedjUG0ZJmASg6GK5jWBEF
        w2rLtRBonyNWra8QUdqgdsA0SuzkyYnQwmp0DohT/pSCU/Mw4lEVhx3Egy1HbYbJ
        dkn/Zq14wWDiFC73VCDntCEl45aNjfVH+dSDWV50RALnvh3uu3RMYiD12wvAZPSI
        pOd+z8fOCmSInRyXJTIRn6dlDXZDp1qVow6G2w2Y0A==
X-ME-Sender: <xms:oWjwYr-uoWmnfz7HWwthonOruXdquO70096DnmncXZIRzw4T6Ha6HQ>
    <xme:oWjwYnsd4T7u0bkmLRT93B53kjBa65-nzDDqedk_siLeL7yh7Pr187RAoQXeb91Vo
    xob7V2J502-4BKlwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:omjwYpBnGtU7Vz2r5qfUHltHtwgRTxmHc069jsaYl6exqCt3IQjwpw>
    <xmx:omjwYnfk7BJ8yqXPc5GNGOmV9Gsee9-SBTWF_J-0jc6faxCJxfrepw>
    <xmx:omjwYgP1F_C0VCb6ZZktmcgWdgbM5k3-ejjVwx9cpY9o499cEa_hFA>
    <xmx:omjwYv3blxSGTyawhohXyObalajxIa7HME0KHFMsdqwPiUgjbGGLEw>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DAF71170007E; Sun,  7 Aug 2022 21:36:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-758-ge0d20a54e1-fm-20220729.001-ge0d20a54
Mime-Version: 1.0
Message-Id: <86969f10-9eb1-4c1e-955c-1a00890d10dd@www.fastmail.com>
In-Reply-To: <20220804092727.64742-1-krzysztof.kozlowski@linaro.org>
References: <20220804092727.64742-1-krzysztof.kozlowski@linaro.org>
Date:   Mon, 08 Aug 2022 11:06:13 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ast2600-evb: correct compatible (drop -a1)
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Aug 2022, at 18:57, Krzysztof Kozlowski wrote:
> Due to copy-paste, the ast2600-evb and ast2600-evb-a1 got the same
> compatible.  Drop the '-a1' suffix from the first to match what is
> expected by bindings.
>
> Fixes: aa5e06208500 ("ARM: dts: ast2600-evb: fix board compatible")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
