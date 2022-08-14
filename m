Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770255926BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 00:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbiHNWCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 18:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbiHNWB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 18:01:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80BD11C1A;
        Sun, 14 Aug 2022 15:01:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5540D5C0039;
        Sun, 14 Aug 2022 18:01:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 14 Aug 2022 18:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660514496; x=
        1660600896; bh=/N3ZJwMAuJKQJaLlb+5nhdHUlf08GWvC6v41/Xejl+U=; b=x
        lK5hEAvRjyvkoTXfINnBahnjIYJHP+GfNL0MaIZxCfWpEegPDjesCrG4oETdCh2T
        JpxLIWJh11b28A0E3qpAcdHzp5ng8BlJsPNF9zg/LIAC3JuSBfZOcVBPdxN/ALSZ
        JQLHpTH7nHHG6pD5kQO45vqgHj7BlVTf9CBIjGOVP56qfEdkz9OyWJSSJYjtgrJP
        67ZAi59dU4sJX8z9EKTAgvNnA5Q8VCVOx6Hy5WBJ/pRZ30bhAC1bJivfIbDy2BVh
        QIsZItddkgpeY3Tj1V14QZgl+qes/mwCek38q/9NHWhvB5x6fc7Ho1nyNRMYYO32
        VjZnrH3yc1VSoXc2SCQxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660514496; x=
        1660600896; bh=/N3ZJwMAuJKQJaLlb+5nhdHUlf08GWvC6v41/Xejl+U=; b=J
        NQaUkm4Fe/AlZMS5GBleTwq4sC7yCbf0SqagIxbXqpe1CXbbEkk/WBfeDz8bIQVp
        x4SgQD/pjUnvd2X0V5959jefvXqSkU/kiUyCjDBNJcKSJzQWYDVqLms0dXmP2a/I
        PZqaqyMRW1fvFYSlkBuRxWU/h8uwECfcuwzUYPZj7VnKnsieSi+zjyratj3qBlsz
        axPRn8Fzj/kI5Hg1wzGRJ5vHvZiNWW6nrGqQRQnEHR2FgXKXy8B80nO7bCZnmZQR
        Msjys/sU5YDzi8TobV8WXB8jCNHFXHoxgbqf7foeIog1s/SqCwufY1EVQPP1hiPe
        gsiZMveKvFlTmRFFY1pWA==
X-ME-Sender: <xms:vnD5YsV1vQ3t6ALRWjpPp33qCgjgTKbRYQQ_O2d98f3lCRQ0Qjca7A>
    <xme:vnD5Ygk_DMGmx__aEbWR0z7dCYMjGf38XDgsVqbNTwMgE0BqKp370G_jvfujoOtv5
    fs063N9h6MdYwmMC_U>
X-ME-Received: <xmr:vnD5YgZFhRS0qPf4xt93VxKcOatQuGXL-zAEtWe3cSTduvh6GDOuslRdclOtVpNl2oH_8rB6fG6oalSRhP756kJjrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflrghr
    rhgrhhcuifhoshgsvghllhcuoehkvghrnhgvlhesuhhnuggvfhdrthhoohhlsheqnecugg
    ftrfgrthhtvghrnhepvedtgeffledtjeegkeevfeegieevgffhveeuteduleeileetffel
    hfduheevhffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhgvrhhnvghlsehunhguvghfrdhtohholhhs
X-ME-Proxy: <xmx:vnD5YrUzLZOhvg1AQ4ACTDahXthnJVg1Q2f8HipwqI4rPYT3cUuVfA>
    <xmx:vnD5Ymlm0yNblouP4Nc17d3aBbdNXyrGfQAKHDcIhL4IQ95gk-jnCg>
    <xmx:vnD5YgeNtyZLKZ21XaVsz-LZs8VXPwDo24fa8iC5MXbcWvi3PQhe2g>
    <xmx:wHD5Yrir-iNt9pquSWGrIzaAPRu8b4qZxo-ndXRFG-1Q4ShX6-OfmQ>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 18:01:30 -0400 (EDT)
Message-ID: <821647de-be45-557a-e1eb-2e70e186f2d8@undef.tools>
Date:   Mon, 15 Aug 2022 08:01:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] media: rockchip: rga: Fix probe rga_parse_dt bugs
Content-Language: en-AU
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
References: <20220814040806.7523-1-kernel@undef.tools>
 <CAMdYzYoD9kM_RNs0t=7qc9Tyt9j-cD0DEQD0sR5cEkkGifFSSA@mail.gmail.com>
From:   Jarrah Gosbell <kernel@undef.tools>
In-Reply-To: <CAMdYzYoD9kM_RNs0t=7qc9Tyt9j-cD0DEQD0sR5cEkkGifFSSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 8/14/22 23:12, Peter Geis wrote:
>>          ret = rga_parse_dt(rga);
>> -       if (ret)
>> +       if (ret) {
>>                  dev_err(&pdev->dev, "Unable to parse OF data\n");
> If this can return EPROBE_DEFER, shouldn't this be dev_err_probe
> instead of dev_err?


Looking into it that does make more sense. I suspect it wasn't done this 
way originally because dev_err_probe isn't used elsewhere in rga.c. I'll 
send a v2 with that change shortly.


Thanks for the review.

