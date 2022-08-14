Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637465926B3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiHNVpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHNVpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:45:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9A13DE3;
        Sun, 14 Aug 2022 14:44:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 337BE5C0097;
        Sun, 14 Aug 2022 17:44:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 14 Aug 2022 17:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660513497; x=1660599897; bh=jqlD7yVSqZ
        yD6KOheU8+muzUY2FRZEPS38bOB3ZJl/8=; b=K45A4r0OO5nLuD8E2dCYXo0FIJ
        xoK1nv0p9A2O/Xd63Qguz31IqkZ0eJM/NV4LIESz2aXNP0ESfCm6s06hZRB+s8Hq
        iS6HOtN1NaGuvdeJ/pMmo98gzrWAd6q5bfX2odvsSxciqnK87+Ib4H9IJbrhrGwb
        jym2pNpFBFA683dyYsdyQ9Q16yRP8uH4L1GZNwODi6r2/tZfVReQIVQeC1ujar4j
        Z9maq2RlgO4Ypj6NXhEhAwteQqaJ+cfj1qQtO6T7Na/79i2Y8wEBcXaUG63hxwSD
        m64DnzDKYCL94ItXcvQFqxh1QGDWzmDTHzAlWIev9VN3Dqbb+lfqYRbcMYIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660513497; x=1660599897; bh=jqlD7yVSqZyD6KOheU8+muzUY2FR
        ZEPS38bOB3ZJl/8=; b=OGrGwPoXZmxtxvnajD7xISXwjgfmy4op+GjQ3jPpyXYk
        cMhP4guBVKEw3YX3iM5QtO74n1EEysHaEy/cZB7JIL27WZ2USNkBk4vl7TpK54aK
        7b2I6YDzxlJ1uVaEmOLWAz0KP9ew4jHvtIAUH2vlz/lvUo7Y52zXWggV3XIB4fqR
        mDFn3TwepHHMRGZraMvAqQdkX9Q2KLdA/9s3FeXfI+1HyeuDXM1BYuURPkvUXJ6f
        PvBn0U9DECriJMJjQvyJVMEu0s7elmUVbdaQk3/2cgANWUaUh767wbHBuPpApr+f
        TXpIngdPBZoydFk/natk0+5AQp55P5jriSG3gTF4Wg==
X-ME-Sender: <xms:2Gz5YnR2JSdmpgoqOO7YTfhRwfeFny0nGfSRFBML3g8hoQqQcP2hKw>
    <xme:2Gz5YozDRWaINUXVJz_QI13VR3cpvbusRoHNgoCg-UljpyzxIdWGhcHkLUNgXxjKA
    US86WmUha41l_3If-4>
X-ME-Received: <xmr:2Gz5Ys1i1N1bQW_hF8c6On66G_89ojnV_Inm9qWxd1v7INH4zBJF7YJ1SuYc4vlzhpXJhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:2Gz5YnCrEWQisfTpAx5oZZwxq6allFa6sV4RuCALUFc0Lxf0YbY19Q>
    <xmx:2Gz5YghjEOPiFndFb01CQWtrTkS2KFc9vS7h9r4hmd2oLd7e-U1ZIg>
    <xmx:2Gz5Yrr2OSPvc4c2E2Fk616P4CN2pSqkiNbtaK1rUFuz9ovuP489Zg>
    <xmx:2Wz5YjvJkXfUn3WoJ532ff8ya7cThzyvrPqmRihviBoNPyYxAbY18A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 17:44:51 -0400 (EDT)
Date:   Mon, 15 Aug 2022 09:44:35 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
To:     Lukas Wunner <lukas@wunner.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <BEKMGR.6HATWYKRRTJQ1@ljones.dev>
In-Reply-To: <20220814104210.GA22519@wunner.de>
References: <20220813092624.6228-1-luke@ljones.dev>
        <20220813105533.GA3258@wunner.de>
        <56171d4f65c02d3cba64d2f6d49e190107c12a18.camel@ljones.dev>
        <20220814104210.GA22519@wunner.de>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Aug 14 2022 at 12:42:10 +0200, Lukas Wunner <lukas@wunner.de> 
wrote:
> On Sun, Aug 14, 2022 at 09:09:43PM +1200, Luke Jones wrote:
>>  On Sat, 2022-08-13 at 12:55 +0200, Lukas Wunner wrote:
>>  > On Sat, Aug 13, 2022 at 09:26:24PM +1200, Luke D. Jones wrote:
>>  > > Support the hardware GPU MUX switch available on some models. 
>> This
>>  > > switch can toggle the MUX between:
>>  > >
>>  > > - 0, Dedicated mode
>>  > > - 1, Optimus mode
>>  > >
>>  > > Optimus mode is the regular iGPU + dGPU available, while 
>> dedicated
>>  > > mode switches the system to have only the dGPU available.
>>  >
>>  > Could you please integrate this with the framework provided by:
>>  >
>>  >   include/linux/vga_switcheroo.h
>>  >   drivers/gpu/vga/vga_switcheroo.c
>>  >
>>  > vga_switcheroo will then automatically expose a sysfs interface.
>> 
>>  I did investigate this first before submitting. The way asus does 
>> it is
>>  not standard at all. On switch you must reboot, and the change isn't
>>  reflected by the ACPI get method until reboot. It's very reflective 
>> of
>>  how they used dgpu_disable to work around windows issues that we do 
>> in
>>  Linux by removing the device from the device tree.
>> 
>>  The key thing is a reboot is required. This is not done on-the-fly. 
>> I
>>  have a two year old GX502 which has the same method as exposed here,
>>  and also a 2022 TUF laptop with same method. My understanding of 
>> this
>>  pariicular method is that it isn't the same one as what Nvidia is
>>  advertising, and ASUS is perhaps misadvertising it - the suspision 
>> is
>>  raised by the fact that my GX502 machine predates what Nvidia is
>>  advertising.
> 
> I see, thanks for the explanation.  You may want to add that
> background information to the commit message if/when respinning.
> Indeed vga_switcheroo facilitates GPU switching at runtime,
> not upon next reboot.
> 
> Thanks,
> 
> Lukas

Good point, yes I will do that after reviews.


