Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A604AB7B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbiBGJ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345113AbiBGJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:24:40 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8019AC043181;
        Mon,  7 Feb 2022 01:24:40 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F1BC5C004E;
        Mon,  7 Feb 2022 04:24:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 07 Feb 2022 04:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=5u2gDx2Jv1BB9+
        oD6pkaVUCAX+p6JTFrufAW9YUCSWg=; b=pVsh8iT1cLGmJQt83gL0hn2I8fvxO6
        bp/zynf4goHePHg0JTUOL9CM2KXo2TnvAhJPuMZCmRuRB5nFswrbsqMKgot8coDj
        hlfQHIqcV4Bv+DHBqw8Jp2MbaGOhBdzpVxYcTSh/Af3HZ7X7rupEmAmnHcyKpNGO
        69qOGW9bSh6oADNTX36KrnsyQ4ZtN3X6p1CpZ0q9aLLnlymyQv5az8aejfxcI+Gg
        f/ykjiLHlc5EhEKzlmlWvfeXQCEXK4u6+6UyoonfHDPP0t7syS6pxKOYKgDJl9dj
        2VACZXulZP9PMvTzYqaCpw3dFeNPiU6nPDOp5Hd2Exzm1uCAztsC9dcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=5u2gDx2Jv1BB9+oD6pkaVUCAX+p6JTFrufAW9YUCS
        Wg=; b=SVuyVJy8OJCqIV1QhN06nguuZyc4enO12NqobzBh+EqinLIsghWhi35po
        inRQ+QbNyjyhklXGUJmAdtPR+BJtP9Zi3eML1152dTFD8ruIpk0xC2FcchPuJ6Dw
        7m38GN0aa15C3RX/A1BMWvvydNHGm/D2OvF4cD6XOwvr0hDGkbx7MAYGNewwfoXG
        VCEMVWe1DWVBw/DVYCVDVsId3R1g2rP0LgoL0zoB8/DtvXHNjvexOEVwYD8FEtOu
        fSV1HGXMIKVQGhRW52mM4hEMSvJiubfcMjIcGX5v3Kng4n7khuuXm85qNnn9KQ7L
        tr/qJyiwB3zecw8U7AEDIXQgueiog==
X-ME-Sender: <xms:VuUAYjaAagIvhCJavzBS_WhS7AERZoDrs7aVaQZnYD932vPowaxNsg>
    <xme:VuUAYiY3RwQbsNFSrKiGvfNWJIQ0odTkoGv2rNwwUEeFAhN466_LyRznCz1O7oeZu
    jzBpW81yg7wqflrXa8>
X-ME-Received: <xmr:VuUAYl_3RpDUl2I9JX4xljX71pdPnY1FjGW5gkehyR7F4_qlwRIoaDqFkI8i90_yeFRkhY0rJ8XfRghjFA-zt6YkugUhtgWV1wcWApk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:VuUAYpoZ7uLHcwRGkkoGsW-P4HZvNJ612yhGsMHN4OtCJxsMKj9w_g>
    <xmx:VuUAYuoGneyOS8bNcxQSOwgRtmg1Yo1XLwVsP9xXeFfgqNKsujHXvw>
    <xmx:VuUAYvTJsJ9lIy5IaxeGqpaYa5AXgJA2OsDpVLiZQCMGfjzyiH841Q>
    <xmx:VuUAYuLWJNSR5x-2JfLd4GZZ91MYi_6ytYJltJYJVSkcjKA53Y1Tqw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:24:37 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH] ARM: dts: sun8i-h3: Drop args in 'thermal-sensors'
Date:   Mon,  7 Feb 2022 10:24:32 +0100
Message-Id: <164422586926.25686.332222517638922550.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204002802.1214602-1-robh@kernel.org>
References: <20220204002802.1214602-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 18:28:01 -0600, Rob Herring wrote:
> The "allwinner,sun8i-h3-ths" thermal sensor has 0 argument cells, but
> the consumer has an argument cell. It is ignored by the code, but the
> error was found with some upcoming schema validation changes. The schema
> and code both agree that 0 cells is correct.
> 
> 

Applied to sunxi/linux.git (sunxi/dt-for-5.18).

Thanks!
Maxime
