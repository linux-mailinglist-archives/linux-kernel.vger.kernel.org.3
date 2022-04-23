Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337B050CB18
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiDWOP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbiDWOP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:15:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B93710BF;
        Sat, 23 Apr 2022 07:12:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 99BC11F468EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650723148;
        bh=BWx5mSvodMtkWlhuz51Cu0E0Psrafg88NNLUjQ4EV70=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I7hNx8xPopottQnaSXAf3ZPnGpLjzm3RrsH7R9L/DWaM5w6iQc7Q3I9J/zHRhTjQu
         EUy0zVQQQQVoMOSn2frcrCu8NvNhbQ3jjDxJhzV54BkK6S0HtQ3rojwRGQ4hqDFZKl
         OJK4mnxtQVfqpgdoT91Psg7zSbZ0CyadE79vXONe0JAKsiIMWjmjpbwVkz5pTGDQT/
         r6kU75BRr0O8uxVn6Q+jar1ttDRwlJlIatcJPU09XOvxYH8yS3x7EudHo1YgKCxc73
         xE6soZzvYvVyL98FJUGJIdehHdY4F5+eMs5jd7MPJfVMQijdYxomcf2Ps5tzr2PhHf
         59xEJoaYXol9Q==
Message-ID: <cdb243d7-af84-b647-ee29-e4d4ab04834b@collabora.com>
Date:   Sat, 23 Apr 2022 17:12:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: gnss: Add Broacom BCM4751 family bindings
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david.heidelberg@collabora.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220414214337.311880-1-linus.walleij@linaro.org>
 <f4deb182-ec18-6744-2c4c-adaed4ef7a33@collabora.com>
 <CACRpkdbZnWJgkS2a0xXs_WG40jz6+aTSPt743Zigd0KZ8R=yww@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CACRpkdbZnWJgkS2a0xXs_WG40jz6+aTSPt743Zigd0KZ8R=yww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/22 00:50, Linus Walleij wrote:
> On Mon, Apr 18, 2022 at 1:19 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> 
>> What are the chances of seeing the kernel driver for BCM4751+?
> 
> The kernel does not normally drive the GPS. The kernel has a small driver
> dealing with hardware power on/off of the GPS and exposing
> /dev/gnss0 to userspace.
> 
> See Johans lecture at:
> https://events19.linuxfoundation.org/wp-content/uploads/2017/12/The-GNSS-Subsystem-Johan-Hovold-Hovold-Consulting-AB.pdf

IIUC, driver also should be needed for the firmware uploading, similarly
to the BCM WiFi/BT chips, isn't it?

>>  There are
>> myriads of Android devices using that GPS chip. Previously the
>> proprietary firmware interface of BCM4751 was an obstacle for addition
>> of the driver to upstream kernel, did anything change?
> 
> Actually there is nothing stopping us from anyway merging device tree
> bindings, even if no driver is on the horizon for Linux. The DT bindings
> are not a Linux kernel thing. Actually we merged bindings like that in
> the past. It makes it possible to create complete device trees, which
> is nice. A driver for Linux can be slotted in at a later point.
> 
> Anyway, that is the boring answer.
> 
> Many if not all GPS:es (as all Wireless chips) have proprietary firmware
> interfaces. This is normal. GPS:es are special since by tradition the
> stack using them is in userspace. There exist free software userspace
> stacks for misc GPS:es.
> 
> gpsd is the most common userspace daemon for GPS.
> gpsd will then talk to /dev/gnss0 as any other TTY IIUC.
> 
> Replicant has a free implementation of the "MEIF" API for this GPS,
> I think what is needed is really for someone to pick up, polish and
> contribute that to gpsd
> https://git.replicant.us/contrib/PaulK/bcm4751/

My main curiosity is about whether you already have a working driver
prototype, something you could share with us all, so we could start
playing with it too :)
