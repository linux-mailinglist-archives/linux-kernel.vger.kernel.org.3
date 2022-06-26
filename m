Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A34755AF7B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiFZG3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiFZG3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:29:47 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7010540;
        Sat, 25 Jun 2022 23:29:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AC8DC5C00E7;
        Sun, 26 Jun 2022 02:29:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 26 Jun 2022 02:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656224983; x=
        1656311383; bh=pwG7sEVgNFjSS0CEBeOdBdBpcXWqXm7bNQLMb/mnchU=; b=X
        Veiai14cTVihknyEpgzOD1VJ8SYum6VStjGhX/eDjCCUR4JB0DF9FbwNF0rfBaM+
        Tw/G9F2xcsxKlFNFaAGsqyGVk36TLeBtSZj1PGphyeNMb1ykx1DCK2ooaHnqozWy
        VW7yPe0igUdtMT9LlmkVRyoxPECoasJMCxZLJXfC0tDpIAJsriD38cRA/VIc8wC5
        e5SiYiV9Qs+R7eEO0+QWXXP1Jhibu/PzqcI+NQhfWzb3ufUCjzsLopsF+XlgfwDi
        uEmU0+S/ijHSIbJfQH46bES1LaRexV/EmV8iBfVps37v7qYEuO5i29sL3tIKpDp7
        5Ngg3cNHyOtWezbFTmn7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656224983; x=
        1656311383; bh=pwG7sEVgNFjSS0CEBeOdBdBpcXWqXm7bNQLMb/mnchU=; b=o
        0/l6ozPHYPqvTWfzU5NKMv4u0Hl9Dl00k2lgqCX3N4JBbTY1WJWC+bJh5PQNecyC
        ci7V4G8AKI45EV2MLU5plP88iixuxNUzhHEjajIBSzbbbTy0aEgJK8DN+xTClezf
        /VwaUKVXNagBHuLKzVN1lyuANRaQgqlsktXUmtlyOPj2S/y//o9edD16hRXP2KWT
        PgGac8BDmYlKoHHK0flWBbsUXWbWMfERBcdIp+7TqhV0KIvu2/SGM/fIh9tT+YzT
        HoZDpf2z6cnc/5bgtdcos6EodXX2Q5zo3UoYj9ehGfNq5mtwAZ/EwrE16auw2izG
        /USaqGKf4wmRLhvBgfJ1A==
X-ME-Sender: <xms:1_y3YgjUmk4nxju7eA_39xcdBr--jjCxydASnEX72Zu3aMuIbXZN6Q>
    <xme:1_y3YpCTwUGIlM1uwiV_5ppo6T6lfbqVvEt4U500dKUivfUt_XPGjr3SXDr-wsXRZ
    056OosPadaGjgaoRQ>
X-ME-Received: <xmr:1_y3YoGMH8odrTL6WwfyWO8f4SkmFaWZoqpsKve5pnMcjiAofm6vyTsXYDyWMh2bJt9FojEgLwTb0fwZkSmdzNvB9nOiAaV_RTSqp_zKNu5Kk1oTJ16ZbuYggg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnheptdevhfehhefgvdekteffleduueduheduuedvtdevleelkeev
    vdeuvdeihfekueehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:1_y3YhQlehFZDsMraFc4zdBySutWOWBTOak2EPHhbSL3WyWmIk4-iQ>
    <xmx:1_y3YtyFBfGzH3laay3K3oc8qG07AjWOIlJEfULEqrKohsy7ADNnzQ>
    <xmx:1_y3Yv5CVEVVl9Kxi90UvMw0iknne7jrGKz2FPV6ds7DLmpmpG3eTw>
    <xmx:1_y3Yswh9wSkZ6MEt3CXBeGViZEGOHlG_8Btw64PvCVbLD0vhldJsA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jun 2022 02:29:42 -0400 (EDT)
Subject: Re: [RESEND PATCH] rtc: sun6i: add support for R329 RTC
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220626042756.58961-1-samuel@sholland.org>
 <b3a6ca6a4af7773f68f29b443fa5a4e106727e83.camel@icenowy.me>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <cef572e3-c643-cfdb-d91c-d6f29f436dc9@sholland.org>
Date:   Sun, 26 Jun 2022 01:29:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b3a6ca6a4af7773f68f29b443fa5a4e106727e83.camel@icenowy.me>
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

On 6/25/22 11:31 PM, Icenowy Zheng wrote:
> 在 2022-06-25星期六的 23:27 -0500，Samuel Holland写道：
>> From: Icenowy Zheng <icenowy@aosc.io>
>>
>> Allwinner R329 has a RTC with a similar time storage with H616 but a
>> slightly different clock part.
>>
>> As we have already handled the R329 RTC clocks in the CCU driver, add a
>> compatible string to RTC driver to allow probing of the RTC.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>> Resending this patch separately from Icenowy's R329 series[1] because it
>> is also needed for D1 (which has R329 as its fallback compatible[2]), so
>> I would like to get it in to 5.20.
> 
> Thanks!
> 
> BTW when will you put D1 DTs into kernel?

I am preparing a series for the stacked interrupt controller at the moment.
After I send that, I will send an initial devicetree series, hopefully by the
end of the weekend.

Regards,
Samuel
