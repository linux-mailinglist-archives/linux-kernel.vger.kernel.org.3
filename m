Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDA95A8D46
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiIAFWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiIAFW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:22:29 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5731090B8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:22:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0B88A3200645;
        Thu,  1 Sep 2022 01:22:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Sep 2022 01:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662009743; x=
        1662096143; bh=BJ9kO3y+F5B9vhnPYodaWrEIPZN3sG3lmA5wMvJHDY8=; b=s
        t7CEzJarjXCA7WHESAhaLVixwWZRB4a/MUC8LDuf/BTPsLZUU1h4qEMpFQgGuKwI
        6i1ozFymQdO8GlOSOjHXVQbYyDFOut/z2YAhfznoXr5xMQQNlmXP/qtX+UPpLOnU
        WlGn6GjjLP8KpXg+TTbTny4YK/iA9tq8g7xAzCvPhumZ14I95ZN3aCdfqFovYIqj
        IYh/w08K9l7nenVY/lDa4MrukrK54Qww+KOO1NaBGXeupZeBAoPOA95lR2rbeSac
        a3fkbYEd2e4NkZ6ZW17d74C/p7B8fq/xIpIAWcJBd56ikmKQ8BJbj9VNsAVN9Ril
        dYpERcgN3iqzkJHb+Ut8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1662009743; x=1662096143; bh=BJ9kO3y+F5B9v
        hnPYodaWrEIPZN3sG3lmA5wMvJHDY8=; b=Dtq2A7D01s2T2mY5kJSwqiPZDlLun
        KdPp/DCEvIqa3WkZib6OAbXUI7bKVHHJeQVQ+En1Gs5dPL5THaX2TMkxep0IWVwz
        UelTGP4uf9Rre+4XNf4xQ3H4VTgS20CVJyIFBLh7MP829UzQkwq1b9IYmsXA92Vi
        E3KlbKlBe2L6lxyPolEavjY7NLUzRZK89LBixFkbcmAA6p2JpWzlUAwK7veQd+3K
        CrSyAQ7uoJ0KKCcG+1wCb+WXVgstRML0sOQgdrn1cTkAOPRu4NTRu0G+4n8R2atS
        Nhk9T3VcgIOUJy+k3sZzWwPIuj3crW+P57fTKWrJy2D/DIyRsAbaU4uAA==
X-ME-Sender: <xms:j0EQY_Wity28wTHUna-30bgkEuxyxsGkEZYsCLed9oY5bN05LR3yeg>
    <xme:j0EQY3mcamu8kRhtWgyln97At0oVHtAUw5Gu9n0FWy60FqC9oW9CFi2Ch2P2urj0O
    HEBAx1Fab2zhZ1T7dE>
X-ME-Received: <xmr:j0EQY7at5alrnB49VNwr4w3JudP7kR-O_mEB3Cm3frYi-9n-FWms-APodh6kMUstaOzzBLvn72gnuRGvMkhHGkqX1CxY3zQGxyQ3iR_QlNIyaNAztNLOfqz0Y9FCRH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekjedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrthhh
    vgifucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenuc
    ggtffrrghtthgvrhhnpeeiieefheeiieeuledufefgtdevfeejffetgedvveduffffleeh
    jedtjeegleelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
X-ME-Proxy: <xmx:j0EQY6Xmh-2jFMoJPTfmSrdWn0H8cC1wmZLu9CI8Ln9hw7x2FbuAsA>
    <xmx:j0EQY5k2dS50WFJCqFFBHjGxmT4KldHcHjllDF5hFlYkJIoQBl5Nvg>
    <xmx:j0EQY3dR6JoqtLFPNzzdwBw-s8UdBzCXEoX2lICbU83EsZ89-X5uZg>
    <xmx:j0EQYyCP7MkHRmZvSD3PUfTEzwUuj9SqNW_vpljxFizeg2Sh07g5ug>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Sep 2022 01:22:21 -0400 (EDT)
From:   Mathew McBride <matt@traverse.com.au>
To:     Li Yang <leoyang.li@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mathew McBride <matt@traverse.com.au>
Subject: [PATCH 0/1 RESEND] update Kconfig for DPIO to select FSL_GUTS
Date:   Thu,  1 Sep 2022 05:21:48 +0000
Message-Id: <20220901052149.23873-1-matt@traverse.com.au>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20220620043243.32235-1-matt@traverse.com.au>
References: <20220620043243.32235-1-matt@traverse.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of a patch from June, it has already been reviewed.

I was missing the soc list in To: so it may have not been noticed.

Mathew McBride (1):
  soc: fsl: select FSL_GUTS driver for DPIO

 drivers/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.30.1

