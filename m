Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB595565F91
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 01:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiGDXBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 19:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiGDXBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 19:01:00 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B98B863;
        Mon,  4 Jul 2022 16:01:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A26B15C00A9;
        Mon,  4 Jul 2022 19:00:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 04 Jul 2022 19:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656975659; x=
        1657062059; bh=yDzegWi/w3t3IboOKOd9v7GKJ0RaQsugOqeevFrP7ZU=; b=A
        P1O9tMpWP9G4/R+PmxmbTkkpDBb7ku6CqOS7y59uyGiydgzqgpo6BdDJfhDpYYTr
        UFlrpILJrvCXXEFyjr+OI/j2lTGUknQMdai+OC70F0L+9bixPQKD0UWNFJxeZ/dB
        Lpo/pcSNo4+GwtP6OGs0wlW2PxANOjHHTbGGH45OH/wbve9Kn8+RmSTnQe6J9a/W
        8iGfwrUxnxo6xspX30+8OMVzLBQEG1fgi7cEGQpk1L/A8uajzj1a7l3mAwoh66Di
        Ueze47S3756J/bItNzFzqRIwsUByreDDmBz+gAo+5RReWaPi/ExPSStje1g3ln9d
        1KYsq3ky8pK7o5vsyKgkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656975659; x=
        1657062059; bh=yDzegWi/w3t3IboOKOd9v7GKJ0RaQsugOqeevFrP7ZU=; b=B
        t9qcRW1TsKh2EyHS8iROGaT0yNc2oDl8MH1e7ycmcC1rFQjrR5ms1SjK29OTLK4H
        XB+t0dszoWKO9GlP31eprI/2Na/QJx+3GZfky/lp58ZPDHqOOKrq3S5h/Q1po807
        RXHl73ShVV9ZLz9Y76lOx2jUHE0TsByEOcNpcxYZZU/b8zVuN8kW1CGHZYFuN5z4
        5STE3xJ13k2+dsJvSGYt6TUTVq29CE3p4J1jL4wFpIS9VfXrdoam/K2C8WzAGK6a
        aZ9+Bjtt9A6aDw9mX7ruqzTls1ED7/jP3jpjjBGOyeoJLHBOKXYhELl0LKsT6Ydg
        BXMPyEMwNRdRwSZvdGMUA==
X-ME-Sender: <xms:K3HDYmRbMFkJiHHprjAGx8V3AvyZdEQHcpXb_af36WK_J2EBMlgt_A>
    <xme:K3HDYrzd2KuV2SL1FOADR6uRkybDEgZ3Rxkw9ixOulmgIBnqn73SWRLoBQ7TSQxIY
    VEimr7JQ1rukLnNFg>
X-ME-Received: <xmr:K3HDYj2pPWuhs4FFGk9MMMl0yU_FmUAOHIHICcrp5QeMNYOybZn53tONktsfliRO1BJN90JDX9CLtxJRltNTKK5j6OC_Mbl_KWst40BIOISYgO9qE7yh595Trg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:K3HDYiBJbT65aF2KXbXlmVfc_6pqIHWURKwAuyHUc5vGfdlOz491xw>
    <xmx:K3HDYvim_ilxU45FBKcjmsPk9iX5a9X8ANgrEGBIEyfvPUub2j_KZw>
    <xmx:K3HDYuqD9ih5kevO3ADBpqlttcz10DTeF3PwQ_bWSMO2F4U_8-L3tA>
    <xmx:K3HDYqQC89xOmhmkKTeYmGHhb4_fdXjcgvIxKMUclwfROvNcqZZPIg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 19:00:58 -0400 (EDT)
Subject: Re: [PATCH v4 3/7] ARM: dts: sun8i: v3s: Add mbus node to represent
 the interconnect
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220525185853.695931-1-paul.kocialkowski@bootlin.com>
 <20220525185853.695931-4-paul.kocialkowski@bootlin.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <72660162-8de0-f76f-f69a-a73af806064d@sholland.org>
Date:   Mon, 4 Jul 2022 18:00:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220525185853.695931-4-paul.kocialkowski@bootlin.com>
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

On 5/25/22 1:58 PM, Paul Kocialkowski wrote:
> The V3s uses the mbus interconnect to provide DRAM access for a
> number of blocks. The SoC can only map 2 GiB of DRAM, which is
> reflected in the dma-ranges property.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
