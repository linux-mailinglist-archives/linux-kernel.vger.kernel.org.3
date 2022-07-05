Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB6956629E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiGEFH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEFHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:07:55 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDB013D06;
        Mon,  4 Jul 2022 22:07:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8208B5C003B;
        Tue,  5 Jul 2022 01:07:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 05 Jul 2022 01:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656997672; x=
        1657084072; bh=9nY5RE/bGNXng/ITS0f9EUPsxcwltUGdSfZPvL271To=; b=T
        9k1HVY0weVxBaMWNkBqWADMO9f51TEejqMhkprOAaWP7A+GsRVnwtSoMS6CODWNN
        xcrAEAnHeIc5uCfJZ38Irt9v/MBuFIgtobkKO5l9Gy1b8MdpwSRfDBfrZ8Jge9LY
        OxVgwJ3zNgUUdzdovDAvUaBe9mDEbgkuZ5/KOEz2r7xopV4WSIAqBgcgz7x3jZ5L
        7gefundRif3T9n5pNfYJjodIi6ceVbypq8b6eedZ7R6K8Kkc6iqYdcswBMmSpyv/
        y2CnHppqbMLfFF5a2aoKZysla6u0T66GuCthie4pk9HD2gXMXpGcED+RpFrkeGTh
        F4zn1A99TlL8RiZdmmaYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656997672; x=
        1657084072; bh=9nY5RE/bGNXng/ITS0f9EUPsxcwltUGdSfZPvL271To=; b=i
        iAb0VeIi7nUD5mvNBQIRan6fKs7Y5EXWQYwu1fsjqkKilP/2Gw0utNYB2RR8DvK5
        pQpx+SpFC9pAi42/Gj+5OUrCwpCL2SmLpzan9srOWIhaw4GqOoSuYOxasR49O6xE
        5PMIJb87MKAY6gXkMh9o6Nm9NJrJIWP4SRPX3m2xjc+mx9erNqnT38WSC1+BWfqt
        XziI0IsgreK39Ub/yBUPIZ/2OvOyWfw+JuDIKsV3T3r9f0kH+mWeyz8SLgyt5yen
        rBDZ2AR2zTQb9htKBwI4IxFYNVnwCYZSkdrmxWbf6v7nlO3KI9y2QFyAr4dxtxN+
        khnQXi3Jh9Az+cgatBF1w==
X-ME-Sender: <xms:KMfDYhVpC0qJbBv5rhTX0DfOyMtLPS8hTdFu3vmjdbe5q8Ywll_NdA>
    <xme:KMfDYhm4liRTYzgXU-exIxT85Lqd1wGGICxnWSg5SHcGIby9S56wHMsrla52GanP_
    RWnFvaSZajS_YeVQw>
X-ME-Received: <xmr:KMfDYtYw_1l9CU3ZVQaqhAnnyy4xHUbQ7F11wDwaPRAJGM13LqV7rDt3cwhhh8hn4YXtRGuICDcqok0PXQlsfQfYdAg93RDnLvF3nNkWhdkBg_ipoL6-h3-T3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:KMfDYkV7s3VcgtsH5SnnQ9xEqB7UsNoZ0pnYCtQJ75zj4QIcC7QaMg>
    <xmx:KMfDYrk-CxRRG008UoyjfZKqVXT7x0CaFch7_HMVGOm0cijNROQX0g>
    <xmx:KMfDYheHlmTralLxPOkkUG62STM1NvTMvlaj6EeANtGZqVqTdbVZwQ>
    <xmx:KMfDYkfxkom3UfDUb5XnB22GIH7LnyvZjfTfLEk_uw5Y8H7s6AZ4vA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Jul 2022 01:07:50 -0400 (EDT)
Subject: Re: [PATCH v5 3/3] ARM: dts: sun8i-r40: Add thermal trip
 points/cooling maps
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220517013607.2252-1-qianfanguijin@163.com>
 <20220517013607.2252-4-qianfanguijin@163.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <75c9edeb-edfd-b910-7f72-53f7694b456d@sholland.org>
Date:   Tue, 5 Jul 2022 00:07:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220517013607.2252-4-qianfanguijin@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 8:36 PM, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> For the trip points, I used values from the BSP code.
> 
> The critical trip point value is 30°C above the maximum recommended
> ambient temperature (85°C) for the SoC from the datasheet, so there's
> some headroom even at such a high ambient temperature.
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>

which took quite a while to hit the passive trip point:

# cat /sys/class/thermal/cooling_device0/stats/time_in_state_ms
state0  1374892
state1  1499
state2  0
state3  0
state4  0
