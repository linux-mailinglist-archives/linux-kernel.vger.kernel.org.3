Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF8585665
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 23:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbiG2VQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 17:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiG2VQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 17:16:53 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866D476973
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 14:16:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 93FF12B0591C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 17:16:51 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 29 Jul 2022 17:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1659129411; x=1659133011; bh=OQgsCaN30Y
        tpOi52gr465cNgerVnBnzLxxf71r0CZ0w=; b=Y7Q1bTcQpR9jwBsORnDx29b9DP
        ADKzJFRMJz4W+ZNLViltQZxH0t16fgM6KB4KG9ISfJw6tDD+KveHUN0ZKuRRspFr
        I7OQ1XFQ6cmr69UJJbs7gEPtaQik0vwQwlrZ3KQDHrMkbc7AdC5zdxSfmbuJxI+O
        MMXu4DYP4XDDz3JyUo0b/jVm0RDTOKevTAqDpr4PLpa4jQMzAPbUwMBtxRawCiES
        W/gqYGp3xATGv8NMENzkJJ3Bcl9YcatZlBXKnJWt2RnEHsD65OZYHTGJ7fopXeZ/
        zCMywuKgEr7AT7i6oBqEIjuj3tkxHJLW0LFfqJrhMHUPMmMOO/agwCmB/6dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659129411; x=
        1659133011; bh=OQgsCaN30YtpOi52gr465cNgerVnBnzLxxf71r0CZ0w=; b=M
        hBtsZAWsqgjzDZD9isEYB88VhdvVwrKiTLKdd4cUoLu3OcBKTmj/9VPP1HwDQm5E
        b+1pK2uvHoGa1Q/uuuze1TY+jUEGD/QRjtnuEss4lV7L+pySIHm397fWzedxoOzk
        7D7n4bjakr4f5AzI0np01cJNpHuiyg2qbzMK4cJcgmsAMId7QoP8jjj5AQMQgDTx
        P3nDP7DPm0X9PGlzi/+Gx83rO9OjiJREiCmnu2n+XDa/xnCI5/aNk8hLOIKZorQJ
        elvf13+2VB4BjsHizHAbhBLgLVO2l6f3BHMSwJlyajMKEPocShZVcC8L2o6u0Zi5
        8kHeU2jaZMqAubrB4NGKw==
X-ME-Sender: <xms:Qk7kYsqZu5Q02ZA1PHekCwZyxGeBO4mUCjPa1IJmiKhZ2YbZTGYT_g>
    <xme:Qk7kYioTOhrKRZvm8BwqkkdXNM-1u8bBINOClW4n9pJA0ymYcYKCsfq8H59JmYjhY
    F9IQAZnBfwwa4Rj2ho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddujedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgho
    lhhorhhrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepjedvjeekieeugf
    elgfetkeekjeeljeelgfeuteeiheeileehgeeghfeikeeiteetnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghdpphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvggu
    ihgvshdrtghomh
X-ME-Proxy: <xmx:Qk7kYhM9CmZB1D6JzV8ufPHIYa0Gl2D6_0b1gkh2uGemIFQP29m9wg>
    <xmx:Qk7kYj5_orEVgxOI82zyr2uJxBcsXst9HMydgenraMF6BEwaYeiX2g>
    <xmx:Qk7kYr6l7e2Ezhz06CS6JrTXic4GiNGZCprDVHFEmmqLTMKu3tHgGw>
    <xmx:Qk7kYtGzNe1dWycb3hjRFX1L6pz0bK_hGErhb1VLNz_yYjENXcJOJp1eUS9ZGW5T>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A819B1700083; Fri, 29 Jul 2022 17:16:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-758-ge0d20a54e1-fm-20220729.001-ge0d20a54
Mime-Version: 1.0
Message-Id: <8e7b6f89-31bc-4fe5-9d08-502fadd9b375@www.fastmail.com>
Date:   Fri, 29 Jul 2022 17:15:11 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: compiling linux 5.11.0 with gcc 12.1, subcmd-util.h issues
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to do a git bisect between 5.11 and 5.12, on Fedora 36 with gcc-12.1.1. But I'm running into this problem:

https://lore.kernel.org/lkml/20220129010215.781601-1-jforbes@fedoraproject.org/t/#mf3292bb5f13677e3bf9e829ec85febe6f81088c9

I suppose I could downgrade to gcc 11 to get around it, but thought I'd ask here first. Thanks.

Compile fail details:
https://pastebin.com/raw/nGFHE6Wp


--
Chris Murphy
