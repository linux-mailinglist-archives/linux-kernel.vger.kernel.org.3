Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C4057F840
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiGYCeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYCeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:34:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B6B21BE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:34:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C53845C00DB;
        Sun, 24 Jul 2022 22:34:06 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sun, 24 Jul 2022 22:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658716446; x=1658802846; bh=hPE2N2f6Pz
        RN1KjeuYB8e5WQn1u843l61OiuDowxp18=; b=iY2Py46qg8sbwdYqokq6cMY+d2
        fyNQOeGrsmERkRH90qWIx7Iwd6iqcx63+VYuoW98G4TuSUfwbBGSVIeytPuJ8R0M
        RG0Qyy76OzdGa9yLojUoMxT/1sf0NOhK495Lgm9L+sLRWAZ220a1BIrRQ0upB53i
        qLNstWmQorapTAn7pgVv104WeMzCLc47zXwePKhQtlPdtFslGBsG5YT8Mvd85ZNl
        llYwTcq1h+fYVvS/z1NnrCAM9eUt3KkuZPwTyxWS6UhFA0qdi+CC7ngyzXicU5PE
        o4hTvKvKbwVLnpPUoDjo6soGV7y9FhthPpilm6sT2et5r+Z9fytTCM9TeBzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658716446; x=1658802846; bh=hPE2N2f6PzRN1KjeuYB8e5WQn1u8
        43l61OiuDowxp18=; b=dzmZj9BCm9/igoh6IzycbTnlHBTst5+b0xfDat/0kBNi
        1cRIg1eQ0BqrKnj6UVwX8FmDjsZJNfSRTeBvyQPzCOGXvTq4IlVkKUO4QZr8v7ex
        Nzud/jc9BMLKyOfC+xd5QFTsGUOilQYf9j0clSnaTb3Z1UUmS5X0Rp+BGzKyH4lS
        72vHQkyLFDAqNtvZQUOCESyb68rGg6g/GLxwpKD9tRmbGkivymmUo1cnmLUVDCkJ
        MSLcbIgRVWK82fToXLdGfVUnmEoOu6Bgle46ujlNRGUMdXPBnSW0KiXtvtZWzy3J
        0cYP2eYMZOrRfaDrKzCJuT1OCywKcXEiHE2yfguahA==
X-ME-Sender: <xms:HgHeYvVL7FUgX1qa1cl8kA6KU8GKDDzRc4ZnOQCN5qUgYxl8M0IhhQ>
    <xme:HgHeYnmRrKXbLZ2u2gub9JKc5aBx9SV32fP_PyW19GLb4sJZZ5EOtXNXvdAHB4lFQ
    1NOVPDKjHASWrP5LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtjedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:HgHeYrb-GJYiMFY3t5CvfR0ugI7_t2YP08kOL-t6sibybbmKRCZQTQ>
    <xmx:HgHeYqVjJ0ZiWNmGcfwGML7yrVe0iKzkOeScbaRMaFlbPngFThpt0g>
    <xmx:HgHeYplvq3AAoRiwITQEzgfv7sL2c49pBtQCU7CwvyqHaDfUtZbviA>
    <xmx:HgHeYiAQj2l70JevPPryjRNkz_K8gSYy-5rKgM-C9Ez_Hsp8-0ps1g>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7B538170007E; Sun, 24 Jul 2022 22:34:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <9e0ed5ce-c542-4c2a-93d1-8c7a551921b1@www.fastmail.com>
In-Reply-To: <20220523060532.7864-1-juergh@canonical.com>
References: <20220523060532.7864-1-juergh@canonical.com>
Date:   Mon, 25 Jul 2022 12:03:45 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Juerg Haefliger" <juerg.haefliger@canonical.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Joel Stanley" <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        "Juerg Haefliger" <juergh@canonical.com>
Subject: Re: [PATCH] ARM: aspeed: Kconfig: Fix indentation
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



On Mon, 23 May 2022, at 15:35, Juerg Haefliger wrote:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
>
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
