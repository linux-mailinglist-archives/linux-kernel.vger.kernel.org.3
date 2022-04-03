Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E066C4F08CD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 12:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356536AbiDCKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiDCKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 06:47:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CF527B3A;
        Sun,  3 Apr 2022 03:45:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D0B65C00D3;
        Sun,  3 Apr 2022 06:45:43 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sun, 03 Apr 2022 06:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=6HZ8iNjIAgCAQB38qTd7x41iMNLuwq
        OQ9SJlAr84yCw=; b=Re+wfepUSGd24kXAN+aOcQk46N3d8rSjQVtmfQsYrsJLcz
        yvph+Je0dmODjAi/N0cAGJUomEZm1wx0E568bQrmI5bPxmdFWRCGBhlEPmU3xVwz
        svtO8k7IzaC5OvMw7tUgzwm3nAg0DwXhppr0BJKykCF88b2l3zn/pbq6mF0slXfU
        NH8F0X3srNr2qwkxqPwet8jw9D3Kq9jpF6cDAs5cJeIwxw87oZwRwXkGjiMrS7rK
        EepDG1XQpKRsEQ4wbiG/VNMFZ1tJhtTD9BrRrfNiXQq4ILHFAPaPl9h8hJNy6sJF
        36DxKL780Y0lTZTBx4DKO2ZHKvEd8nScnHZOolSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6HZ8iNjIAgCAQB38q
        Td7x41iMNLuwqOQ9SJlAr84yCw=; b=Q/iNwYhgZr3xWp9c+SDxCqgCi5567v+2T
        5Qw2wV9sfui/iIOCoKn0HYKhW+WYtQaggMfov9qN3+Hb0GhOFmkP7WH8R/Lli2tE
        DyZlMUvc+qBryMUSiR5Xb46X1086KfW+1KPDWDvVgL/K/cwaZzQKNIs0OcGoj5dZ
        xcQ5P6B+mM6soVFSGA763gayBAYrkNDY4W80xTExazYdvYkk1idLL/uqKHHkNvjV
        rN9RmviJVC+oC2D8G4Z5zX9ZqFOvzxt7sNfPRsvUIW8KvEo31mt7WbTbZc3ac6QV
        Q+jxzioQcB6RBpXAXOtnH2uC+IQucpsi3zuti/jGb5MZf/BjoQGLg==
X-ME-Sender: <xms:1npJYjUunK47VUj6Dj-riL_eT76cKddHb65gdOQ9M51WvMsAV6V_OA>
    <xme:1npJYrlm1YBg4Plq2VsXkwGdY8sYrbNAZ-36ulNMtoWBdHCdzUcS8cZ6Byg9hmDev
    PEZA_ba1-CwQ4T7TWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejtddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:1npJYvZKE60-WFGOdTMMM1V-V42hYv755AfmQIRRUyWvnD6F6MyBPw>
    <xmx:1npJYuVaO7pGTxWR8Bc1oQ_qv23RE0Opk3nXc-PkLxyRA0VyvpIIeQ>
    <xmx:1npJYtk1TzyriWRGtRjkuSBMJdJ5_XZLl-mmiT5AO9-Rvja0roaPlQ>
    <xmx:13pJYmfwQkXlp9Nm6ckGY_dr8ms-WOJA-cGtoTga6_AVmeU5zYyoUQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 12E0B27402C7; Sun,  3 Apr 2022 06:45:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <877f8b56-8ad7-45ff-ac2f-06ce939578ee@www.fastmail.com>
In-Reply-To: <CAK8P3a1=Q7JSBLOmxZxGArUx+3Ex8SjDx7Z5csms5k+_yES9zA@mail.gmail.com>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
 <3166b80d-d8a6-45d5-9e3b-2f9998aca0d3@www.fastmail.com>
 <CAK8P3a1=Q7JSBLOmxZxGArUx+3Ex8SjDx7Z5csms5k+_yES9zA@mail.gmail.com>
Date:   Sun, 03 Apr 2022 12:45:21 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "Marc Zyngier" <maz@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, Apr 2, 2022, at 20:30, Arnd Bergmann wrote:
> On Sat, Apr 2, 2022 at 2:56 PM Sven Peter <sven@svenpeter.dev> wrote:
>> On Tue, Mar 22, 2022, at 14:13, Arnd Bergmann wrote:
>> >> +static int apple_rtkit_worker(void *data)
>> >> +{
>> >> +       struct apple_rtkit *rtk = data;
>> >> +       struct apple_rtkit_work work;
>> >> +
>> >> +       while (!kthread_should_stop()) {
>> >> +               wait_event_interruptible(rtk->wq,
>> >> +                                        kfifo_len(&rtk->work_fifo) > 0 ||
>> >> +                                                kthread_should_stop());
>> >> +
>> >> +               if (kthread_should_stop())
>> >> +                       break;
>> >> +
>> >> +               while (kfifo_out_spinlocked(&rtk->work_fifo, &work, 1,
>> >> +                                           &rtk->work_lock) == 1) {
>> >> +                       switch (work.type) {
>> >> +                       case APPLE_RTKIT_WORK_MSG:
>> >> +                               apple_rtkit_rx(rtk, &work.msg);
>> >> +                               break;
>> >> +                       case APPLE_RTKIT_WORK_REINIT:
>> >> +                               apple_rtkit_do_reinit(rtk);
>> >> +                               break;
>> >> +                       }
>> >> +               }
>> >
>> > It looks like you add quite a bit of complexity by using a custom
>> > worker thread implementation. Can you explain what this is
>> > needed for? Isn't this roughly the same thing that one would
>> > get more easily with create_singlethread_workqueue()?
>>
>> I originally had just a workqueue here but I can only put
>> one instance of e.g. APPLE_RTKIT_WORK_MSG onto these.
>> There could however be a new incoming message while the previous
>> one is still being handled and I couldn't figure out a way
>> to handle that with workqueues without introducing a race.
>
> Are you trying to avoid dynamic allocation of the messages then
> and have no other place that you can embed it in?

Yeah, I didn't want to allocate anything because of the added
complexity here like you mentioned.

>
> If you kmalloc() a messages that embeds a work_struct, you can
> enqueue as many of those as you want, but the allocation adds
> complexity through the need for error handling etc.
>
> I wonder if you can change the mailbox driver to use a threaded
> irq handler, which I think should ensure that the callback here
> is run in process context, avoiding the need to defer execution
> within the rtkit driver.

Hrm, I just realized that's already the case. mailbox_client.h documents
rx_callback as "Atomic callback to provide client the data received"
but since we know rtkit will only ever be combined with that specific
Apple mailbox we could get away with just ignoring that.
It's a small hack but it might be worth it since it would reduce
the complexity inside rtkit.

Sven
