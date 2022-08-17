Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40350596DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiHQL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiHQL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:57:31 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D247782D3B;
        Wed, 17 Aug 2022 04:57:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 830E72B059F6;
        Wed, 17 Aug 2022 07:57:29 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 07:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660737449; x=1660741049; bh=nMczVAGpca
        7H++XwV1RmIcObkzLoHhiXbmBHdwyghyU=; b=WLdp1RQQHgQVxczuf7pW15tSAX
        2fY2owzazhdQ4Vag4SdC9OvQD8X0ecFf+Jh6e8dyXMnXQuMPp/BdL+jyeMnuOE4H
        OPnuYzkxkoycBiFkTuCPpA1UXkQ9QdD/Dox/EZ+pXrpaTck4gM7ixADCvMqyuSMd
        Z0DxqNifJ4mCdf+mow2fZTea6WzwqGYe3tYwdI7gu8iPV7JJYqmIVBPsO0keMjWQ
        /0Y7t79djaGZTlH9vwhfsT8EAcZhY4/yQ1MUG8wwd2ENASQ0Rge0IG/taXYjwcaP
        FB69dJMdB3vd398ro1EN64h4y1T4rPL2Q/l+OONmI1Z/JnP8AXYl/OSWIBfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660737449; x=
        1660741049; bh=nMczVAGpca7H++XwV1RmIcObkzLoHhiXbmBHdwyghyU=; b=R
        iAymQvL3bRE/7i5N7wzVWFFiIJBHAFb9Iu1SgWK8qjROI9K64jqeK8ZKnhYQZyYc
        E9FctukwQssAcs4io5G+Jl26u3y3uOV/DrRmHiP1+rdSQI0sxSiofx0G12aApgls
        1iWyAfjYhXJkKLtg8UIIwYDshHkyGJLPnedA+BfpDtKhBtDTNcHjWf3ece6tSOla
        +V3kY2eVhXAceF72W+Xkpwaw7Y79WUh2ec7tTlXK22PQ6lJpNwipV1GifC/D20yD
        5N07Zu0GJ0jZU9Gm2Md5ntVrhFtHR2nRVeNZeYrMEcoHpGyqADP4Vwav26oCD2/h
        eNREEVANYr+vdC9Fj1fLg==
X-ME-Sender: <xms:qNf8YszTflyRWtfnrTxUUjg5vtRs0YnAhDZLgZM9DI6hIEFW3eGaTw>
    <xme:qNf8YgSST8TyNSyW0qTaLH1_5GzFK-FAK813JKzPUDrf6NI-mwezl6hbW4eIsTo9o
    y_IhV5Q2bkabBP5ts0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepveeghfeiveehvdeukedvtedtfefhuddtleekffek
    keefheeivdehgfffleeileehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegt
    ohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:qNf8YuUbIR5u7-J8-kfy02ZP1F7u2Lr4nnPsg4WUZUQWmxablxAV_A>
    <xmx:qNf8YqgKKCVBREfK53UjS7SVMpKYhYxd8pJn9jWhhN-6rXyZYng_6A>
    <xmx:qNf8YuA9w4okB2zFZj1q-14wr4jP22Qrphc5rR0e7tEU5WA5crYjwA>
    <xmx:qNf8Yg3EuJ2WJnaeBEuH_VtUTLZmf1dJjyjoSUd_piCre7y6D9C7OsOuzjY>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 761291700082; Wed, 17 Aug 2022 07:57:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <8b361f8e-cc4f-466c-90f0-031a43436af2@www.fastmail.com>
In-Reply-To: <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
Date:   Wed, 17 Aug 2022 07:57:07 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        "Paolo Valente" <paolo.valente@linaro.org>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 17, 2022, at 5:52 AM, Holger Hoffst=C3=A4tte wrote:
> On 2022-08-16 17:34, Chris Murphy wrote:
>>=20
>> On Tue, Aug 16, 2022, at 11:25 AM, Nikolay Borisov wrote:
>>> How about changing the scheduler either mq-deadline or noop, just
>>> to see if this is also reproducible with a different scheduler. I
>>> guess noop would imply the blk cgroup controller is going to be
>>> disabled
>>=20
>> I already reported on that: always happens with bfq within an hour or
>> less. Doesn't happen with mq-deadline for ~25+ hours. Does happen
>> with bfq with the above patches removed. Does happen with
>> cgroup.disabled=3Dio set.
>>=20
>> Sounds to me like it's something bfq depends on and is somehow
>> becoming perturbed in a way that mq-deadline does not, and has
>> changed between 5.11 and 5.12. I have no idea what's under bfq that
>> matches this description.
>
> Chris, just a shot in the dark but can you try the patch from
>
> https://lore.kernel.org/linux-block/20220803121504.212071-1-yukuai1@hu=
aweicloud.com/
>
> on top of something more recent than 5.12? Ideally 5.19 where it appli=
es
> cleanly.

The problem doesn't reliably reproduce on 5.19. A patch for 5.12..5.18 w=
ould be much more testable.


--=20
Chris Murphy
