Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5C58B516
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiHFKtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHFKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:49:13 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE0140F8;
        Sat,  6 Aug 2022 03:49:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 45F17320025E;
        Sat,  6 Aug 2022 06:49:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 06 Aug 2022 06:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659782947; x=1659869347; bh=Jitk9IypTB
        r8lg+yTJ+EV3Ams0eQlT8ggSEu1iXhmgc=; b=h00i9h2h5LeKmhLm4gqip352Tn
        kZiZPGDhjBkFxjQVf/W9A9LU8AuGHJxmkvGOQqWtDSjmTXLmMcmQO2RVvWOSeUvS
        rHdVm4QeNUz0IguRqZdk6XMin+F9AHenMU/3CCIE1tOnyzud+q0CVrupNo9zfiwH
        xJ8ZDvjQsZEohGa0GRY8Bhtwkxvl7eozIrJAaq5iLEVGBKDfWeXcR/tdCOL1DPvo
        +xdvxUQDURd6VuevzRoFNmUuZrYAeqZftE5a7sJ+UzEjkgpwKYSCwMhl2lnjvUta
        R7WtGy8puDFGat949NrkN4RLnmoxouhHzNwVYmRU57Obp997XfwgYrFo2HAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659782947; x=1659869347; bh=Jitk9IypTBr8lg+yTJ+EV3Ams0eQ
        lT8ggSEu1iXhmgc=; b=lKrk06sYit3nuqVa0PeGeoFqlmYv658TnM+S7EftIlLr
        TrMc8zRKG/Loh4TSvXOMDLzZR+3B3hYm5Dqpq0UVXsgO3m1n5ID1OW2tmDBmjFuv
        aH13xWVP6m1JdSI8DSz6gF+t2D1+qGWtU+R2D5pDQjfVcWbTOgD5HtQw3pQRRY6k
        79ZWIj/jAtB9mE+nH56NkVG6qtTe7eYtA3/5OujPEkzrw/01jTEq4d/Lf8ukmPCE
        FCC1IhWbzMA3tQBOPt7i+i1oZsqj8RMeaijkagJM2PcOWXrHr0QbRZQ5myrtVUcu
        eg0M9AqkvtvnVI85SYA3olANd0HSmEBGg6bVwtmc4g==
X-ME-Sender: <xms:I0fuYjm-bwLK4saX-6iveWg8zkRr_bi1gbxS4jeRMPXM8oObboCHsw>
    <xme:I0fuYm1Q_YBq2bf94_CUG3glttaaEkJwTP1qydgAaxacdgz0Luptgx_5Z3voFfcee
    4Bs6oskqaOky7Hh0MQ>
X-ME-Received: <xmr:I0fuYpqE-SM3VFF-no-Vr_iedU9j6GGlWPIpA9bJpF3DFQQIZGKr3BoL4TVgN0E2hiv5ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:I0fuYrk9O40qk981S5BuYNv5dm0bxwBw11hbAO3_J2MZYOSeVnA2tQ>
    <xmx:I0fuYh1CfewOH9ObnRe7rhLKIVhXNIe3kv6hmcljHiyElacSUeGi6A>
    <xmx:I0fuYqvQXdRjD9jPCA-PbBvKGeQF7qHv7ibmMTFxh_ZiMUYstkNHGw>
    <xmx:I0fuYvCVMZaZO3jH7PbHggXs4ZeYX_iath5LvakMwAAPN63nQvq4zg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 06:49:03 -0400 (EDT)
Date:   Sat, 06 Aug 2022 22:48:49 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 0/5] asus-wmi: Add support for RGB keyboards
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <DPW6GR.725XHI643Y0N2@ljones.dev>
In-Reply-To: <CAHp75VcrSe4aTYo_cVCfhX=y1LjZPOJG1yh9SrLt_XQBzNoGhA@mail.gmail.com>
References: <20220805081909.10962-1-luke@ljones.dev>
        <CAHp75Vd4iEGkAE1Ds_Zyqi0P+gQbOyqvGoJctpOHNmMD7cUG0g@mail.gmail.com>
        <J6T6GR.SW0RXSJSYG9R1@ljones.dev>
        <CAHp75VcrSe4aTYo_cVCfhX=y1LjZPOJG1yh9SrLt_XQBzNoGhA@mail.gmail.com>
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

I do agree. It's what I meant by prepped. I think I've addressed 
everything you've raised, so I'll leave it to bake a few days with my 
testing then submit new version on Tuesday (Hans please wait for v2).

Many thanks for your time taken to review this. I'm not an expert at C 
or the kernel by any stretch so reviews are critical for me. Also thank 
you for the link on git messages - I'll go through each patch and 
ensure they're better.

Kind regards,
Luke.

On Sat, Aug 6 2022 at 12:02:19 +0200, Andy Shevchenko 
<andy.shevchenko@gmail.com> wrote:
> On Sat, Aug 6, 2022 at 11:33 AM Luke Jones <luke@ljones.dev> wrote:
>>  On Sat, Aug 6 2022 at 11:10:37 +0200, Andy Shevchenko
>>  <andy.shevchenko@gmail.com> wrote:
> 
> ...
> 
>>  I do have another version already prepped
> 
> Hold on and try to address many more review comments. It seems the
> series needs much more work, otherwise it will be spam in the mailing
> list and demotivating reviewers to continue.
> 
> --
> With Best Regards,
> Andy Shevchenko


