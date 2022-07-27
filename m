Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3358249A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiG0Kjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiG0Kju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:39:50 -0400
Received: from 14.mo582.mail-out.ovh.net (14.mo582.mail-out.ovh.net [46.105.56.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D2422D8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:39:47 -0700 (PDT)
Received: from player773.ha.ovh.net (unknown [10.110.171.96])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 3632824F6F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:39:46 +0000 (UTC)
Received: from RCM-web1.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player773.ha.ovh.net (Postfix) with ESMTPSA id D7A9D2D172357;
        Wed, 27 Jul 2022 10:39:33 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 27 Jul 2022 12:39:33 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        dan.beygelman@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, krzysztof.kozlowski@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] arm64: dts: bcmbca: update BCM4908 board dts files
In-Reply-To: <1004391f-fb6c-5f84-de28-8f76dc3471e5@broadcom.com>
References: <20220725055402.6013-1-william.zhang@broadcom.com>
 <20220725055402.6013-4-william.zhang@broadcom.com>
 <20220725233238.GA2960972-robh@kernel.org>
 <1004391f-fb6c-5f84-de28-8f76dc3471e5@broadcom.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0af44be8f5802e66011b4642de4632d4@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1581326421855153115
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduvddgfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeetgfekfeduveehuedvgeefhffhieevhfejteeggfefieevffdtueeukedugeelieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-26 03:09, William Zhang wrote:
> On 07/25/2022 04:32 PM, Rob Herring wrote:
>> On Sun, Jul 24, 2022 at 10:53:56PM -0700, William Zhang wrote:
>>> Append "brcm,bcmbca" to compatible strings based on the new bcmbca
>>> binding rule for BCM4908 family based boards. This will break drivers
>>> that use the old compatible string for binding. Fortunately there is 
>>> no
>>> such usage in linux and u-boot.
>> 
>> How does adding an additional compatible break things?
>> In theory when some crazy code tries to match the entire string. But 
>> not
> in linux, u-boot code and hopefully not in other bootloader and Os
> does that. But this does change an existing compatible string so
> Krzysztof suggested to add comment about the breakage in the commit
> message. I can remove this and send v3 if you guys think it is
> necessary.

Krzysztof commented on ABI breakage [1] when you tried removing
"brcm,bcm4908" from the "compatible" list in your patch
[RFC PATCH 3/3] arm64: dts: bcmbca: update bcm4808 board dts file [2]

In this version of your patch you don't remove "brcm,bcm4908" anymore so
this change doesn't break anything. Adding a new "compatible" string
doesn't break things. You can remove that info from the commit message.

[1] 
https://lore.kernel.org/linux-arm-kernel/d93e55fa-3359-2609-aad5-c80eca78f380@linaro.org/
[2] 
https://lore.kernel.org/linux-arm-kernel/20220712021144.7068-4-william.zhang@broadcom.com/
