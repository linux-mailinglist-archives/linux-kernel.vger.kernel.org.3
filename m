Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D8E57C515
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiGUHNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiGUHNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:13:33 -0400
Received: from 13.mo582.mail-out.ovh.net (13.mo582.mail-out.ovh.net [188.165.56.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131F57B1DA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:13:28 -0700 (PDT)
Received: from player758.ha.ovh.net (unknown [10.110.208.183])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 2D0C523486
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:13:27 +0000 (UTC)
Received: from RCM-web2.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player758.ha.ovh.net (Postfix) with ESMTPSA id D07AF2CD18D4F;
        Thu, 21 Jul 2022 07:13:14 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 21 Jul 2022 09:13:14 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
In-Reply-To: <193845cb-6149-1ae6-5eb6-6b01ffcf763b@linaro.org>
References: <20220721000658.29537-1-william.zhang@broadcom.com>
 <a635754e-bf41-4058-5fbb-57ead36b7128@linaro.org>
 <883c2ad4c36220b488519a8902ad72bc@milecki.pl>
 <193845cb-6149-1ae6-5eb6-6b01ffcf763b@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4b5100e4a6e9e581f4b8ab58e5ca4927@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 18201016422655699931
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudelkedgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeevjefhffffveeludejfedtvdfftdekgffghfegieeliedvfeeigfejteejjeekfeenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-21 09:01, Krzysztof Kozlowski wrote:
> On 21/07/2022 08:51, Rafał Miłecki wrote:
>> On 2022-07-21 08:44, Krzysztof Kozlowski wrote:
>>> On 21/07/2022 02:06, William Zhang wrote:
>>>> Append "brcm,bcmbca" to BCM4908 chip family compatible strings. Add
>>>> generic 4908 board entry.
>>> 
>>> This does not explain at all why you are doing it. Improve your 
>>> commit
>>> messages.
>> 
>> To clarify it from my side (and maybe help a bit):
>> 
>> 1. As I understand it BCMBCA is a one big family of SoCs.
>> 2. BCM4908 is a subset of that family (a subfamily?) designed for a
>>     specific group of devices.
>> 
>> If that's correct I think William it's what you should describe in 
>> your
>> commit message. That would make binding more accurate and should be a
>> good argument for your change (I believe).
> 
> That's better argument. But what's the benefit of adding generic
> compatible? Devices cannot bind to it (it is too generic). Does it
> describe the device anyhow? Imagine someone adding compatible
> "brcm,all-soc-of-broadcom" - does it make any sense?

OK, I see it now. I can't think of any case of handling all devices
covered with suc a wide brcm,bcmbca binding.

This leads me to another question if we should actually totally drop
brcm,bcmbca from other SoCs bindings, see linux-next's
Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
