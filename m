Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220DC57C59E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiGUH6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGUH6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:58:44 -0400
X-Greylist: delayed 6197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 00:58:43 PDT
Received: from 6.mo583.mail-out.ovh.net (6.mo583.mail-out.ovh.net [178.32.119.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F35A1F625
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:58:43 -0700 (PDT)
Received: from player761.ha.ovh.net (unknown [10.108.1.219])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 629FB24778
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:50:22 +0000 (UTC)
Received: from RCM-web2.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player761.ha.ovh.net (Postfix) with ESMTPSA id 292062CD894E0;
        Thu, 21 Jul 2022 07:50:09 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 21 Jul 2022 09:50:09 +0200
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
In-Reply-To: <c5b37e68-dc1f-cdae-83e4-23aa0216db69@linaro.org>
References: <20220721000658.29537-1-william.zhang@broadcom.com>
 <a635754e-bf41-4058-5fbb-57ead36b7128@linaro.org>
 <883c2ad4c36220b488519a8902ad72bc@milecki.pl>
 <193845cb-6149-1ae6-5eb6-6b01ffcf763b@linaro.org>
 <4b5100e4a6e9e581f4b8ab58e5ca4927@milecki.pl>
 <c5b37e68-dc1f-cdae-83e4-23aa0216db69@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1d39bbba3f267086eb2884ffcbf4807b@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 377739420184194011
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudelkedgvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeegheefkeffffelvdfflefhfefhgeffleeihfdvgeehvdeuhfehueetteelkeevffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeeiuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfe
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-21 09:36, Krzysztof Kozlowski wrote:
> On 21/07/2022 09:13, Rafał Miłecki wrote:
>>> That's better argument. But what's the benefit of adding generic
>>> compatible? Devices cannot bind to it (it is too generic). Does it
>>> describe the device anyhow? Imagine someone adding compatible
>>> "brcm,all-soc-of-broadcom" - does it make any sense?
>> 
>> OK, I see it now. I can't think of any case of handling all devices
>> covered with suc a wide brcm,bcmbca binding.
> 
> Maybe there is some common part of a SoC which that generic compatible
> would express?
> 
> Most archs don't use soc-wide generic compatible, because of reasons I
> mentioned - no actual benefits for anyone from such compatible.
> 
> But there are exceptions. I fouun socfpga and apple. The apple sounds 
> as
> mistake to me, because the generic "apple,arm-platform" compatible 
> looks
> like covering all possible Apple ARM platforms. I think Apple ARM
> designs in 20 years will not be compatible at all with current design,
> so such broad compatible is not useful... but that's only my opinion.

Let's see if William / Broadcom guys can provide a valid argument for
the brcm,bcmbca.


>> This leads me to another question if we should actually totally drop
>> brcm,bcmbca from other SoCs bindings, see linux-next's
>> Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> 
> This would be tricky as it was already accepted, unless all sit in
> linux-next and did not make to v5.19-rc1.

5.19-rc7 has only 1 case with brcm,bcmbca, see ff6992735ade7
("Linux 5.19-rc7"):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml?id=ff6992735ade75aae3e35d16b17da1008d753d28

So we can still clean it up for the 5.20-rc1 or 5.20-rc2.
