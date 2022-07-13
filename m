Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEAC573B91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiGMQtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGMQta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:49:30 -0400
X-Greylist: delayed 17347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 09:49:28 PDT
Received: from 14.mo550.mail-out.ovh.net (14.mo550.mail-out.ovh.net [178.32.97.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA7513F88
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:49:28 -0700 (PDT)
Received: from player792.ha.ovh.net (unknown [10.110.171.131])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 6437D23D91
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:00:19 +0000 (UTC)
Received: from RCM-web6.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player792.ha.ovh.net (Postfix) with ESMTPSA id 19EB52C978016;
        Wed, 13 Jul 2022 12:00:07 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 13 Jul 2022 14:00:06 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] arm64: dts: bcmbca: update bcm4808 board dts file
In-Reply-To: <7cf0e9b7-4316-1a23-3484-03e5f0491393@linaro.org>
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-4-william.zhang@broadcom.com>
 <d93e55fa-3359-2609-aad5-c80eca78f380@linaro.org>
 <900ac3ed-a77c-3cc0-f5ab-c45267a1a4ba@gmail.com>
 <b350020eee4de0caf36f88f299e61930@milecki.pl>
 <7cf0e9b7-4316-1a23-3484-03e5f0491393@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b653ba68e070d00853367de9344abd81@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12957700555834698715
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudejjedggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeevjefhffffveeludejfedtvdfftdekgffghfegieeliedvfeeigfejteejjeekfeenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-13 13:09, Krzysztof Kozlowski wrote:
> On 13/07/2022 12:55, Rafał Miłecki wrote:
>> On 2022-07-12 17:36, Florian Fainelli wrote:
>>> On 7/12/22 00:47, Krzysztof Kozlowski wrote:
>>>> On 12/07/2022 04:11, William Zhang wrote:
>>>>> Update compatible string based on the new bcmbca binding rule
>>>>> for BCM4908 famliy based boards
>>>> 
>>>> Typo - family
>>>> 
>>>> Please explain why breaking the ABI (and users of these DTS_ is
>>>> acceptable.
>>> 
>>> This will be largely targeted towards Rafal who supports these kinds
>>> of devices with an upstream kernel. My understanding is that this is
>>> OK because we will always ship a DTB matching the Linux kernel, and I
>>> believe this is true for both the way that William and his group
>>> support these devices, as well as how OpenWrt, buildroot or other
>>> build systems envision to support these devices.
>>> 
>>> Rafal, does that sound about right?
>> 
>> Right - in all cases I'm aware of - Linux gets shipped with DTB files.
>> So such change won't actually break anything in real world.
> 
> We don't really talk here about Linux, but other projects, like
> bootloaders or *BSD...

Right, let me more specific.

BCM4908 uses pkgtb firmware images. Those images contain:
1. bootfs (atf, u-boot, kernel, DTB files)
2. rootfs (filesystem)

So when you flash BCM4908 firmware it always contains:
1. U-Boot and DTB for it
2. Kernel and DTB for it
(+ more stuff)

There isn't any on-flash DTB file that doesn't get updated when flashing
a new image.
