Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3D15A6757
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiH3PZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiH3PZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:25:03 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87368AE55;
        Tue, 30 Aug 2022 08:24:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D3E25C0145;
        Tue, 30 Aug 2022 11:24:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Aug 2022 11:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661873095; x=1661959495; bh=OmTYbgq3ym
        zCgFNPdz53oo2sqm/UojddZkcXYiaY6/Y=; b=DK/jbJuBUTMb2rnbkv3gjAsJ7J
        HjQO4m97NmbnoU2zN7G9Jcxom9ZgWKM+7UJdMMu1Iw6uQEg10L6ANuhZF2k4ePgs
        sOApNWqNga7snlviFv0u+fyxvTPuXm1idcp95F+cYMJbKD1mdCdk3jJVbt+yJvjv
        pZty9VL9bhBBv+ERPI/KyJaUX19iPWIDDGHYFIg/wXpgppHOwp4tN0juWqVA+Wbz
        KS4ESEt3Zvphn0ZML4mb4EcBVlxdnApsMi9YnTtvjj5j2150R/XhMvbKgk7lPBMv
        P8GfMAN7+xNjNtxcxgcJt5AIS0oD8+Tvu5/IF4auSLp3vB9PKJA4PLgCZ0Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661873095; x=1661959495; bh=OmTYbgq3ymzCgFNPdz53oo2sqm/U
        ojddZkcXYiaY6/Y=; b=PwtgwiJZ3o8XBj6Lugz0r9hm0EgOY5LiojD7i1Gu+MuS
        H2BYUL4UhMu4DEzBfmMicAfWteDidaDwn4VELaSx/BMlSJ1cGGXxhDWKTCdB/rmM
        Aw+jZYoQz1U50pc16E6rj0MtLkIMy7Bb/ao/4j2RvfgTfXqKnCj/Q+aIVBaLij+c
        soQEyxbs2Wodp22L2fN2a/QGudSNfLrcYdukCddq5D1wFL0+f0ttwTMyv9/kIAv7
        CT81bGmNJeupv4FSt/Igbhpa2T0wFtq5v92+XTrd/jiAmOmQpF51EazQMW6rJVzX
        YmWt2VreniHBpFjfxPd+bfsazty699sI33aRTqR/kw==
X-ME-Sender: <xms:xSsOY9DMnqYirKCyFPHiP1Xn7lqcnfWqOpfGXlR-A8_zPqvGBxN6kw>
    <xme:xSsOY7gwVhXPUl5Xqv_N9HEDQjM-ca42ERNmS4unvIT4b9cJxnVXqbwFDoOHW7R1L
    a9Tchm06Aw8gQ>
X-ME-Received: <xmr:xSsOY4lmePaeEyhJkUs9yt5NFYKoWglTyUErRIGgJ6RHLaQNRWANuXdazW-3DGFirkzH7Ti1fqx4EDfBN6jyfkEU_ghwi78K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekfedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:xSsOY3wqkrZTt3PynE_fWlKb6QdUo8LzjROFEFhJVU7sNZphETUufw>
    <xmx:xSsOYyRD-_yqOU-fL3wT7J5s802ay2FWRELA1Un8_QmnRqjyn0LQ1A>
    <xmx:xSsOY6aKZBN2qc__t4NGnyuDpqFvNW9Gj8TjvsgcE01Z_omwMtzPhA>
    <xmx:xysOY7RmvrOEnA6nIg7eDS5aUYhy_dXpHyIkkFw6-JQk9IBZa9UZrg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Aug 2022 11:24:53 -0400 (EDT)
Date:   Tue, 30 Aug 2022 17:24:49 +0200
From:   Greg KH <greg@kroah.com>
To:     cgel.zte@gmail.com
Cc:     stern@rowland.harvard.edu, skhan@linuxfoundation.org,
        richard.leitner@skidata.com, tasos@tasossah.com,
        wsa+renesas@sang-engineering.com, ingo.rohloff@lauterbach.com,
        cui.jinpeng2@zte.com.cn, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] usb: core: remove redundant variables ret
Message-ID: <Yw4rweh3lKeWkZJ5@kroah.com>
References: <20220830143318.299640-1-cui.jinpeng2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830143318.299640-1-cui.jinpeng2@zte.com.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 02:33:18PM +0000, cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Rturn value directly from usbdev_do_ioctl() instead of
> getting value from redundant variable ret.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

As stated before, please read the documentation for how to handle stuff
coming from research tools like this and properly document it in your
changelog text.

Also, why is this being sent from a gmail account?  How do we know this
is really from a zte.com.cn address?

thanks,

greg k-h
