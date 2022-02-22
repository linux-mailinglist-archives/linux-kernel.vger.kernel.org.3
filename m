Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772184BEF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbiBVCSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:18:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiBVCST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:18:19 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAC922B12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:17:54 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 814625C00C6;
        Mon, 21 Feb 2022 21:17:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Feb 2022 21:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=IjwyPT5tARkpjx
        wBtQqRGrMpxTKMg/PwPRx5plN7W/Y=; b=KwNOcmv8LGKUjm0DZ5souwCxasMEna
        h+d9WaunCvGU7MXJ0qE24DNpEW/Lg13+OIHAyYiues4xjcdkX4pAXIYJ2D01/RFk
        zk0ipCbx9WWO/HXXyvC5wnh3ddCFZH+YDSW+mj2mv4lAVTvdCUtOuHfSHmnE3zKt
        k4RLtcmWDpCELEmgmooxwsMVb7dlEDwS3dyAX5VGX/RWgRhX7kU6v5jWibo4J2dx
        aRBQHayJGN2G9xO5cgBjsTIhpdxs2luk78kQRsaawgnbDiAx8OH/YYmxSs1/Lp8c
        aBTXNILOOz7KHCOqffYO4y08av2kpcDQAJt4xSqaLb3j/aR/LeI5tnSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=IjwyPT5tARkpjxwBtQqRGrMpxTKMg/PwPRx5plN7W
        /Y=; b=UMQaOMmbd27zP76a9a31uiBOFqEi3uc03bMJiqjiEDUGoZWClwj2XztlD
        Wz+bznBMeiIos8/B006GBqEvldMVX144VVqzT78gaAODUXuQA8APas1ovIp681YR
        NA/W1CvWIOWkEgb9546Xz5d+bErrSlCIfYC+gfG4Wkpyf7G08bpr3DFwbHFCvjoX
        9h+qqcnZaHPziqUY6/qcpFRhPxa3TARroblnX8YR2iTDbMCJoJHsgNGxLqSjLodI
        uX4HBWFAq1PRTabox0dmR19ed72lQ2BLkbJADe2cHzPpg8aPDEkDOIgEOhX7aoQ6
        CBvbRh1A9MPjEwbY05qLrz9tId2Lg==
X-ME-Sender: <xms:z0cUYrXC-HR_NSmPCB43nsDZAkgyZ6co5KduWW1L-moLhTLdRGV5IA>
    <xme:z0cUYjmhqwnAV_J8wlViHHuyZojENcq3J4SYyR_3QuR80R1EDtgHec3zv5pTsg3Lu
    -uvKixBYRIxr_8p8A>
X-ME-Received: <xmr:z0cUYnYz2Vb8BP34lOFUkvpfWZLr5PjARE-qTguKLuvnM4p5nsGt7I7wXxf1dwGIE4fTwti9YEkqYkaS1c11bw8HICdjo-ENb7SIU3h3rRaK7tXxdknX5zZ1KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeejgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:z0cUYmVZYiiPMFzfFNxsiU7YHmfIDzd590baNBpAldUjYcS5Y0rskA>
    <xmx:z0cUYlmSkMm3xEseOqS9ed2QHcSuHKPx_O3-ZAQLwGBNXWMQ4jdEXw>
    <xmx:z0cUYjfi_E7o4wXoy93a1F-C6SYnUC1RwCekxmP4hoe23n6z7B0_vA>
    <xmx:0EcUYuAoNQMvQ7ikhPSO48A0stfuOEzT8QvrcJoXlCfALvP-2C_3oQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 21:17:51 -0500 (EST)
Subject: Re: [PATCH] MAINTAINERS: Update Allwinner SoCs maintainers
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mripard@kernel.org,
        wens@csie.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
References: <20220220210714.2484019-1-jernej.skrabec@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <35a019e5-be7d-fc14-5cec-cf89d981a2bf@sholland.org>
Date:   Mon, 21 Feb 2022 20:17:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220220210714.2484019-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/22 3:07 PM, Jernej Skrabec wrote:
> Maxime is stepping down as a maintainer, I'll take more active role and
> Samuel joined the team.
> 
> Maxime, thank you for your effort! Samuel, welcome!
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Samuel Holland <samuel@sholland.org>
