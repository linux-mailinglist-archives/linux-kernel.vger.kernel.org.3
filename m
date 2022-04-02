Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36014F01C8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354818AbiDBM6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347406AbiDBM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:58:46 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3603653716;
        Sat,  2 Apr 2022 05:56:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 99E4F5C010E;
        Sat,  2 Apr 2022 08:56:54 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 02 Apr 2022 08:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=q4l7MV2jndY75H8FnHCUzpg4YcczCi
        ys3j+UuAaOpCo=; b=pWDeCzLez7yRSldMPnQR+hjB7saJX3xzCUbvh4PVmiREX9
        HkmTBtgkcDZ4sJKK872C7AMconKDdX3R2XviAELGe1jvfFL61SiagHDRLK8r+wzu
        xxCCYdapE9sOS3qAxJEzM1MW1KYUX3DWAGg0CZg2ZD3pJ8BS9YCwgf6ajH6bb8RL
        OCIjz3AxNqRprgRkrESriD64ZfNyz021iMaaqjuXZWbKhdH/LwcAvnb3tqERRpTo
        qheocBcahVLMiCfb3gAckq+JqO2AZ4uxSm4tdEJ5x7MssmkIto5vpxgaJrJJ2FFk
        KlnBElOAnDw3O3AqjfBTlmkDpLY9yL/qOC/ZSdnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=q4l7MV2jndY75H8Fn
        HCUzpg4YcczCiys3j+UuAaOpCo=; b=Sv4+nDrezxHf6UxpuFCp534+ptYEOnbto
        Kb5wPekK9iJEytE3YcAgy5zMO4XOxb2tRxrJT7GqEuCyVKk+tVwuJS/THyd94o9G
        pSC4uZHwwNq6bkHpFq81vTBPxdEk0RTjFtvdpC+Qpb3fRnsNSwsjylAbovx7UXBg
        7ekN6yoSwXxW6BLJG+h+6dc7tWBCOTH5KillIZLReeWu9jBEY6xjmeHFlpyVQztc
        M74QA4oLGNSbHUN1XVa+Rhxj4U7HiwXPvD8H8NimO9j310DVFg/zFzWA4yTYXxuY
        /6mPWi61DY4mmNUjDg8Axb92pQuAt9oW+L6jzqgkZIJax/xNi+nAA==
X-ME-Sender: <xms:FkhIYhR42kiK1FqHXRbwcpRhLEyp4c0o2SnWS8E7vQBTiOW99kxpFg>
    <xme:FkhIYqw0TZ-9IsJIwAQScShpMxOL00j3WYV4uyJiF6evc4fILw6oYguD5-s--DqiE
    QIZy9G8juUeUtxhyQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:FkhIYm1NIt_VAA7H9sjXR0BWW-OwbyMdJW6hsxPB60SrumlA5YpShw>
    <xmx:FkhIYpBRiv7pfe-37u_9jFsSclDR-b-8hCPMCJtEUE1DVNiKvc93Bw>
    <xmx:FkhIYqjeL_O-acQxdQXBWP6jPy7wyjd0aZb5DVzk4N-kG57Ie229FA>
    <xmx:FkhIYvZqa5Md2ZEEBpOw8Uw73yBY-BIPD9dip8eseRSBsZ9oV45_Ig>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2F0E727402C7; Sat,  2 Apr 2022 08:56:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <3166b80d-d8a6-45d5-9e3b-2f9998aca0d3@www.fastmail.com>
In-Reply-To: <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
Date:   Sat, 02 Apr 2022 14:56:32 +0200
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

On Tue, Mar 22, 2022, at 14:13, Arnd Bergmann wrote:
> On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>>
>> Apple SoCs such as the M1 come with multiple embedded co-processors
>> running proprietary firmware. Communication with those is established
>> over a simple mailbox using the RTKit IPC protocol.
>>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>
>> +
>> +#define rtk_err(format, arg...) dev_err(rtk->dev, "RTKit: " format, ##arg)
>> +#define rtk_warn(format, arg...) dev_warn(rtk->dev, "RTKit: " format, ##arg)
>> +#define rtk_info(format, arg...) dev_info(rtk->dev, "RTKit: " format, ##arg)
>> +#define rtk_dbg(format, arg...) dev_dbg(rtk->dev, "RTKit: " format, ##arg)
>
> I generally don't like the custom printing macros, please just open-code
> the prints where they are used, that makes it easier for other kernel
> developers to see exactly what is being printed.
>

Sure, I'll remove them.

>> +enum { APPLE_RTKIT_WORK_MSG,
>> +       APPLE_RTKIT_WORK_REINIT,
>> +};
>> +
>> +enum { APPLE_RTKIT_PWR_STATE_OFF = 0x00,
>> +       APPLE_RTKIT_PWR_STATE_SLEEP = 0x01,
>> +       APPLE_RTKIT_PWR_STATE_GATED = 0x02,
>> +       APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10,
>> +       APPLE_RTKIT_PWR_STATE_ON = 0x20,
>> +};
>
> This is an odd indentation style, I would insert a newline after the 'enum {'

Yeah, I blame clang-format and me not double-checking the result for that one.
I'll add the newline.

>
>> +static int apple_rtkit_worker(void *data)
>> +{
>> +       struct apple_rtkit *rtk = data;
>> +       struct apple_rtkit_work work;
>> +
>> +       while (!kthread_should_stop()) {
>> +               wait_event_interruptible(rtk->wq,
>> +                                        kfifo_len(&rtk->work_fifo) > 0 ||
>> +                                                kthread_should_stop());
>> +
>> +               if (kthread_should_stop())
>> +                       break;
>> +
>> +               while (kfifo_out_spinlocked(&rtk->work_fifo, &work, 1,
>> +                                           &rtk->work_lock) == 1) {
>> +                       switch (work.type) {
>> +                       case APPLE_RTKIT_WORK_MSG:
>> +                               apple_rtkit_rx(rtk, &work.msg);
>> +                               break;
>> +                       case APPLE_RTKIT_WORK_REINIT:
>> +                               apple_rtkit_do_reinit(rtk);
>> +                               break;
>> +                       }
>> +               }
>
> It looks like you add quite a bit of complexity by using a custom
> worker thread implementation. Can you explain what this is
> needed for? Isn't this roughly the same thing that one would
> get more easily with create_singlethread_workqueue()?

I originally had just a workqueue here but I can only put
one instance of e.g. APPLE_RTKIT_WORK_MSG onto these.
There could however be a new incoming message while the previous
one is still being handled and I couldn't figure out a way
to handle that with workqueues without introducing a race.


>
>> +#if IS_ENABLED(CONFIG_APPLE_RTKIT)
>
> Instead of allowing the interface to be used without CONFIG_APPLE_RTKIT,
> I think it is sufficient to allow the driver itself to be built with
> CONFIG_COMPILE_TEST (as you already do), and then have
> drivers using it marked as 'depends on APPLE_RTKIT'
> unconditionally.

That's indeed much simpler and what I wanted to achieve. I just couldn't
figure out how to do it. I'll use your approach! 

>
>> +/*
>> + * Initializes the internal state required to handle RTKit. This
>> + * should usually be called within _probe.
>> + *
>> + * @dev: Pointer to the device node this coprocessor is assocated with
>> + * @cookie: opaque cookie passed to all functions defined in rtkit_ops
>> + * @mbox_name: mailbox name used to communicate with the co-processor
>> + * @mbox_idx: mailbox index to be used if mbox_name is NULL
>> + * @ops: pointer to rtkit_ops to be used for this co-processor
>> + */
>> +struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
>> +                                    const char *mbox_name, int mbox_idx,
>> +                                    const struct apple_rtkit_ops *ops);
>> +
>> +/*
>> + * Dev-res managed version of apple_rtkit_init.
>> + */
>> +struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
>> +                                         const char *mbox_name, int mbox_idx,
>> +                                         const struct apple_rtkit_ops *ops);
>
> Do we need to export both of these?

No, only devm_apple_rtkit_init needs to be exported.


Thanks,


Sven
