Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9E1597AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242490AbiHRBIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiHRBIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:08:30 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653422D1DE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:08:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C44C55C01C1;
        Wed, 17 Aug 2022 21:08:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 21:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660784903; x=1660871303; bh=WmFWT9Wj5/
        JuOHgFegqTlFpnEJ5IUU83+EJpdPWqW/w=; b=quI3kB4wEkefeGCSr3rxiFLRSc
        7d9OZXkTpm76sK12vCLfvYrs5TPmdrk7irIsiWwo4FaG792oOVk84uuq6t0kwuSQ
        31yEgjmFmyTtQALQIrTi1b3BuuAjXtsPaHMYTpYJ/h/yKeafoS0m1tBh4GBJdVbS
        uT60bxT4Qyrc1bFWf88XUqQMMso+j2WvuwWbwgvHNp6uXtZQLta/SW3wE4x5dywO
        2cJWJzBL5dnQrlWjwtbkjb2ai/MGtNBLvCOgsh4hzVvjRNZacch/6FLDQV/lYr3V
        WB6AinZH/IWybX8jCUGPA8QaSSljlr4V+Gy5P5Lq6ic55s57QqVH5pYn0wqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660784903; x=1660871303; bh=WmFWT9Wj5/JuOHgFegqTlFpnEJ5I
        UU83+EJpdPWqW/w=; b=M1lPXFJWvPbDg+qY1TznBhN9xRwXMPZK81r/mGUqeQ6M
        f/B4rJjYEs+Ie7hJZpVuXiV2WjeZUbTQDcfSp4L2CzkqZSlAPbpH+87cbUlJIS5q
        58HzD5uVE/DDqUEV3tc21K9F9M2GYbSR0YVxEMPIbsmBsR8YArWJzL+PuRtn1eT6
        QGBAX0w1JDyz7XNSxuy4qP5VESlNy8bnKPS1+3OwwU9+Z4OHrcKshG5YeCT4FNgw
        pPfrTcjn8Kh6WyZ43zETqmfM4qbEy48hxbLM58q4kKjVd8WK8Ed4QwHeuxEjvsq4
        F7QuJ0xeGqJGcsVXeNDCULRPmiuBxt32PHu5m3z/nQ==
X-ME-Sender: <xms:B5H9YqkWtJc_svelOjO_YNE6AiUqFh3UQN7tOJDVJqFng53ZijlFtg>
    <xme:B5H9Yh2Yyx2vZS80qmkEFZ3ch8riKJftaoKvcNUPNQYkv2IUXbceHaXkC_Ghb3B1J
    rq-yRRTz1cazZViiQ>
X-ME-Received: <xmr:B5H9YooqdvIaFh76B44j3FNqch_NmjvyiVHQKABpLJ0Tzh_YH2U8jARerxFxc9nxs_1ECyfrWHmgs83sXBW2oMe_YFRogVC1U4eFIEt5CxM-nRsYQkfNM_bpucyV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhephfegjedtudegveffteefjeeljedvgeetueelffdtffejgeffgeeggeff
    teegheeunecuffhomhgrihhnpegtihhrrhhushdqtghirdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgr
    iigvlhdruggv
X-ME-Proxy: <xmx:B5H9YumEo46BVCIODZdTWsIxMoFLlyDwNbGvogw4AgsHv1gO6Y2_2Q>
    <xmx:B5H9Yo2xGHZxsI1WdXJmJ681Jb2jUtIjr3GZbdgEV6N1Aa9MBgP5vg>
    <xmx:B5H9Ylvj6uz7LSeSMS5hagW0rou-bLMXLT2yXiMnkG0BpvFQfOmMPg>
    <xmx:B5H9YmCDoYgcVIVzByyfEoXE9I10UhMSNSKsBKcicO-0ODPRKN2z5g>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 21:08:23 -0400 (EDT)
Date:   Wed, 17 Aug 2022 18:08:22 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220818010822.hhqn353ddn3n2de6@awork3.anarazel.de>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgsnBpMfUDgD=mxzEWhA6=ff3D3qssva0DFkE_55DXkLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgsnBpMfUDgD=mxzEWhA6=ff3D3qssva0DFkE_55DXkLA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-08-17 10:12:18 -0700, Linus Torvalds wrote:
> On Sun, Aug 14, 2022 at 2:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > syscaller reports lots of crashes with the mainline kernel. The latest
> > I have seen, based on the current ToT, is attached. Backtraces are not
> > always the same, but this one is typical.
> 
> Ok, I just pushed out the pull of the virtio fixes, so hopefully this
> is all behind us.

FWIW, my much smaller automation turned green, building 274a2eebf80c
https://cirrus-ci.com/task/6357530606567424?logs=build_image#L3814
previously it failed to come back up after a reboot at that point.

And the first run of postgres' tests using that newly built image also passed,
so I'm reasonably confident that the issue is fixed, rather than made less
common.  Not that that is as likely to find problems as syscaller.

Greetings,

Andres Freund
