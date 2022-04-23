Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB250CD3B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiDWTsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbiDWTsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:48:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401CED88;
        Sat, 23 Apr 2022 12:45:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A59735C013A;
        Sat, 23 Apr 2022 15:45:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 23 Apr 2022 15:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650743107; x=
        1650829507; bh=h1ToIWPq6OSSwLnJ0g8sY57Xw3btjZPjZHe3fJxISP0=; b=q
        jK62bDYmKLKKt7KIUq6xRKJoE9LOG6WmubRZJw6MAXLxh0+w3zCbfVsCN3BJEP4O
        DP4Ynb1murUnVqduMpPcpfywxEomaHp3YoKKy2GK9P0CZWW0FCuo9+ikOMnC7Ruh
        m4JUVTbVikFl2YjVMP6WKilRp4u/nSNuUDETgZ1nUi5RvqTh5qUdqQ2/4msX+FZE
        AotYMdHyAunPRRIPCLi3WyJvIm75bCQY+UgIj4qrQ4ISd/cQNr+gs1EVda7H10xx
        Q2Apl+gfgJm1JCaAD5F0RHv4EbiE+KYqrm7yqBzyfts0zmqV0FTQxhVwuQg+5Ayp
        CAG1iwHnR8KxLQ6bVy24A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650743107; x=1650829507; bh=h1ToIWPq6OSSw
        LnJ0g8sY57Xw3btjZPjZHe3fJxISP0=; b=wJiL1f87DzHpR5NY7Vmu0j2wSacSG
        vg30qER4x3PQEpEjXZ5WtXA+PVm1kjxHWyfMBSWj3U6jj9ZjOLFvoFWtYLe6e52D
        CwKAezzvsJvbEtAomXvIWJg7c3hQm8UiMYk4EDDbkdDlkIoZkj361LwyNP0fI3s/
        gCjF/fXsgg2OjK2xWjQyGBOMzHaz+7sdXTVpT2dTUREa5DH/NPDCBT/1nOevNgCa
        H5GAMbtS/SqCMPkGqx7SW7IxNGOJ8oqHB+8MhwfmQxIUfl6wPfat46HkH1yEehN6
        YBxJqs5d64vVsuK9XCzTrZyR3/yzVXWKrfv0dTLxjytjZfwD5/cVXT4eg==
X-ME-Sender: <xms:QldkYq0yGPeCcj2zuuAfsqrrwf5mCgn_S6X6qJWDrmjxLPHJQAqL1g>
    <xme:QldkYtEdR_j79gElvu6_BbJp-NWaDZQMhn10FMUerF80yNUhLszFN2-eJMc-hGDdJ
    EgwOexab4muuhW57A>
X-ME-Received: <xmr:QldkYi7QHU2bDKXYJ-N6rWbTffII6DPN-LOxkKw1Yo6acQZMpA-dLDr0_dDbqTEu9aCZzKJyXQ-Fz5OLs0sRE_UMy8RAIasOYZ7v-a3DKJHrrRcn4hfKc2o_fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeigddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:QldkYr1jBrKeelkkuwOD-r59eBSOqsHEa8Bvr0B-JBTihudOGKXTUw>
    <xmx:QldkYtEJ1J50S5nTvvBEhpJHPmGM2gVaP4JzkK4_PTfQJuxA4M2lpg>
    <xmx:QldkYk-QrOwx2TXK33_pf7Hz5IH8pONIjT_fLx5-GN01Ken5JSrNJQ>
    <xmx:Q1dkYmMYMmdHBvGc6_3Xwuj-4Pe3Yj9mNgs81i3_JowvdbhuMGXtfw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 15:45:06 -0400 (EDT)
Subject: Re: [PATCH] clk: sunxi: sun9i-mmc: check return value after calling
 platform_get_resource()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     wens@csie.org, maxime@cerno.tech
References: <20220421134308.2885094-1-yangyingliang@huawei.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <9ebabc53-72de-bbec-895c-fa3760ed5374@sholland.org>
Date:   Sat, 23 Apr 2022 14:45:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220421134308.2885094-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 8:43 AM, Yang Yingliang wrote:
> It will cause null-ptr-deref if platform_get_resource() returns NULL,
> we need check the return value.
> 
> Fixes: 7a6fca879f59 ("clk: sunxi: Add driver for A80 MMC config clocks/resets")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
