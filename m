Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51058B124
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbiHEVa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiHEVaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:30:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A0DCE01;
        Fri,  5 Aug 2022 14:30:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E8425C0193;
        Fri,  5 Aug 2022 17:30:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 05 Aug 2022 17:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659735023; x=1659821423; bh=Z3kAfDDHZi
        MWfE1loWKkH4N3TfbNAIObShduimNijm0=; b=RUdc9qrcM8RLyp6kwEZOxkWzbg
        eeAfYciZr1tjgmCCDflgpNH/T7nlaXzeCZCtyVSo6agdArlQMyP68yYQM7loYnNE
        idAHyNFIZDDw83U5edTUJjjdx00oUDTqYSzmru+zl7wunA8N+Hl3X4Egvx33JL0o
        U6BKXL5BoqpGqJQeZ0ntHpF3bHoaNoo894dViu17zqU01l8mE96QU+DTep6qXaz9
        6gLPaG1RN+ObQ2tPBqbiRPACDx8RO4FsTYkchn6nMeZAXRxsH1zzHY7xpo0CgCQX
        MH9GzfTbfTNJ4a4vaH8XEiK20fJKiGUj+bTiCwEOVdAUVjstrEfKTTfgdAGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659735023; x=1659821423; bh=Z3kAfDDHZiMWfE1loWKkH4N3TfbN
        AIObShduimNijm0=; b=oHOJMIH1hgh8dTxeOl/38oDtGdEIGmG85qYJAR8YmHFS
        +ZZm5kNN6oo42WtGmcw4MaKDbI1Fm7/xVbQUowRUJXCo9UhnwOejB1ySUhtf3VX/
        IVz1QMUoGe04VMZn3ue2x2FDvcsXRWOJczCktUBz/WCPC7LmBWEohbiCC6wgyvLE
        bz3RlXu3JdijgSnt7ZOfsUDUGYS5GPFxQRaBTQHGhiu4UwaBcWlw774b5zF1z6IG
        9O1C6OfUnxbQ4Hp8SEbYFCG9E6O2GyIPBlbdZ7IPXCnpeUaM0ZDNBTzHCQlBnknC
        FV3397lhFVvXWVrJ1iNe1a254BoEPyL017vf72XXbg==
X-ME-Sender: <xms:74vtYk_f2-plhgN7sD2TKy8WaA0dZJMqPSGJqAkP_2BnJJtYbsUZIQ>
    <xme:74vtYssqCTFnrkfHOCCbYeP-bjD1XZOmz4BpSDpVAh1PT5l5Dnc8G0CUPMGO8jQuT
    5rAtU0gY7JtE5aRiGk>
X-ME-Received: <xmr:74vtYqDy3ZHJHa4fgtvJYHxeIanUnEnRuV9VnNVOx8cPhMmzSctSlaFm8MSnrCh3wZ3tXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefuddgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpedvvdegledtheefieejgfevgeefiefhtdevteefteduhfevtdefleethfetgeeluden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:74vtYkd63zOaXmuGJ1LH532UvQRFVB4XgIeoso43ncRdG0DnSYvKrQ>
    <xmx:74vtYpOeumU4QuQLjBlscxzKOziVVS-4qEkjVfIJ46UVNjjDW28ELQ>
    <xmx:74vtYukyWCX9dlxMu8_jEmEiavp66YyDpoQrsCsCDpqwc3ET6udE2Q>
    <xmx:74vtYibLlfrQoBEPf5vLFzXHDfgYXfJp4xyEDvEB6JM_Cno3Nkxj1Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 17:30:18 -0400 (EDT)
Date:   Sat, 06 Aug 2022 09:30:07 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 0/5] asus-wmi: Add support for RGB keyboards
To:     Pavel Machek <pavel@ucw.cz>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7QV5GR.SLNVJBURF77S2@ljones.dev>
In-Reply-To: <20220805120539.GA20036@duo.ucw.cz>
References: <20220805081909.10962-1-luke@ljones.dev>
        <20220805120539.GA20036@duo.ucw.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be sure to do that when I next adjust things. Thanks!

On Fri, Aug 5 2022 at 14:05:39 +0200, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
>>  This is a patch series to add RGB support for ASUS laptops.
>>  The laptops with this RGB tend to be the TUF series of gamer 
>> laptops.
>> 
>>  The first step is initial bringup of support using the multicolor 
>> LED API.
>> 
>>  These types of keyboards implement a slightly more complex 
>> interface than
>>  just RGB control however - they also have modes with can be static 
>> LED,
>>  blinking, rainbow, color cycles, and more. They also have some 
>> custom
>>  animations that can play depending on device state, such as 
>> suspended
>>  playing a fancy colour cycle, or playing a "wave" animation.
>> 
>>  Two of the patches add support for these features.
> 
> Please Cc: LED maintainers with LED patches.
> 
> Best regards,
> 								Pavel
> 
> --
> People of Russia, stop Putin before his war on Ukraine escalates.


