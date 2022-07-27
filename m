Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E155829E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiG0Poz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiG0Pog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:44:36 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09680481F1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:44:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C12E13200920;
        Wed, 27 Jul 2022 11:44:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Jul 2022 11:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658936662; x=1659023062; bh=Qm/fV3e8Bp
        LbWEiy/4YYHnMxdCQ/aMAIZgA5gQ/Scq0=; b=J68T7KimGceRsQ04wgLX4a0ZT1
        IhKh3ymi5ikudwQ06MBGiha2pKbbSdlIpU4n9qO78Lurnje0H9+SzkF2c/k1mIW3
        D/C6DtW+OjpIn1TJH2Pwh4xaWWKMFWlEYosr+pshzWAjJfbQiI0W1l/sp7PZWmld
        TXJITpZp+ThNLEAfun61Va9CJ2j1C4cbzMuw0UTpBy+H3mwoAFkrt9T87rl2D5kh
        i8WITVWdASaA7gcYUVO1yrTxon6AVXvDAumxUW8s0WieMCtCLwlaMZeEwIRQl6XL
        TwH1sUqJnWhof0K163TVvouT49pcMPRSv/FXk0Yz/SC8Kx6LCHrwva4xsPYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658936662; x=1659023062; bh=Qm/fV3e8BpLbWEiy/4YYHnMxdCQ/
        aMAIZgA5gQ/Scq0=; b=u3D1XBbTIW1xuT2qJzaDsDXXBQTfJw3UcVbz4yXmqfV4
        q+kJBAyK/IrTqE3bGOTQj4mIV2yzKFaDUWENfvrkfrmuJ8jtkUmoftZX96L6oFks
        KrMyqvJzbiXUcSNHT9ABzgrOuV0IQPHfgyQAFX80fmwaSLx1ZC90t8tXPdjjqnvR
        6XJ12GrWb68cF6FtVvrQW2tvkFR1DABuroR1wM0hQkSpJgeEIq9f5JV/ob4/izAq
        W3ixCZc2PRZAkMGKKDBmeN965HzOBKCfATHTYlfuWujICaarEEgrseMhDRPGE0Iv
        myZgxpvIgiWyTBnpcOURlaptM5sJPaIXKpJIqw9YBA==
X-ME-Sender: <xms:VV3hYldidI9OrTb62Pzqd-TyK_FhIuMBmjZ7vgfGyUTmjVgL7yQnuA>
    <xme:VV3hYjMlEge85w2dofqUH6fe4y9GijMiofpMHIAbz39a8IZhMI6LvE7VDViZ3W1l_
    C5XS69cGP-rhFGOpI4>
X-ME-Received: <xmr:VV3hYugAisxa40cgCrpa0eZKqwJCbBdDoEcoq03cF6R3aG5tHptKJJvAgrnXpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduvddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:VV3hYu8-Vl4-oVw2vv_BZMY9q_oIPVG7uWBu674KfUcWKr5xJC5Ecg>
    <xmx:VV3hYhtK2ymjTTZO-KkK2a_XX-Y12qObxix7ukHa8qab6pCuEDqB5A>
    <xmx:VV3hYtFrvRLavp8iVfmHQ_1dJ8nPi5FQF630Ph_4M-F4cxCnVnzUnA>
    <xmx:Vl3hYpIaP1qixXJnXF8BxoStj16wGRso9PUcspc26bl3J-hgj6ee0Q>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Jul 2022 11:44:20 -0400 (EDT)
Date:   Wed, 27 Jul 2022 09:44:18 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <YuFdUj5X4qckC/6g@tycho.pizza>
References: <Ys2PwTS0qFmGNFqy@netflix>
 <20220713175305.1327649-1-tycho@tycho.pizza>
 <20220720150328.GA30749@mail.hallyn.com>
 <YthsgqAZYnwHZLn+@tycho.pizza>
 <20220721015459.GA4297@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721015459.GA4297@mail.hallyn.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wed, Jul 20, 2022 at 08:54:59PM -0500, Serge E. Hallyn wrote:
> Oh - I didn't either - checking the sigkill in shared signals *seems*
> legit if they can be put there - but since you posted the new patch I
> assumed his reasoning was clear to you.  I know Eric's busy, cc:ing Oleg
> for his interpretation too.

Any thoughts on this?

Thanks,

Tycho
