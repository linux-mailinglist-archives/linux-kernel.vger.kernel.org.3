Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519E75AB4E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiIBPTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbiIBPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:18:46 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15223845B;
        Fri,  2 Sep 2022 07:51:45 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F38F51BF218;
        Fri,  2 Sep 2022 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662130304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xclzXnMYmVfvBNVyfFnKWw9O2ZLmh2rrfaJFl9XWajc=;
        b=pAvxH9rh1NPVqP6/k/KyNjguhfKVfrq/eIsFKdJbtsXXSjPWWPYI5oqg9ug2BXruXSSL32
        P1LLyQOSckSihX8Uac2e9mPEVMs093uOg7zRF/B/0D17hTG2ATx/mpLbuO7L1PNOMWsXRu
        drKoOYKZUtSN31CurNlfs7kjRJkridCFYtL+VaoaTl17ID3m+bWEeVYgzfPDGSNQ1DGMdf
        d1KhMV7el5VIDxlDtfDm7iX1jveolzZkxlE/dpLYaEpob4DeihnTK4EqarsJilVPM6ohSA
        jH/qlMRkw58QYofHFyIr7DzqITS4mcCabYAQ7dJqBxihuKcTRZg44iju0Cwrvw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Marek =?utf-8?Q?Beh?= =?utf-8?Q?=C3=BAn?= <kabel@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] ARM: dts: mvebu: Add definitions for PCIe
 legacy INTx interrupts
In-Reply-To: <20220817165034.ymmha6swsi5iju27@pali>
References: <20220712164108.30262-1-kabel@kernel.org>
 <20220817165034.ymmha6swsi5iju27@pali>
Date:   Fri, 02 Sep 2022 16:51:41 +0200
Message-ID: <87r10tesn6.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Hello! What is state of these patches? I see no response for more than
> month.

Actually I didn't received the second version of the series, but I
manged to find it in lore and so I applied it on mvebu/dt

Thanks,

Gregory


>
> On Tuesday 12 July 2022 18:40:58 Marek Beh=C3=BAn wrote:
>> As suggested by Gregory [1] (although he suggested it only for armada
>> 380), add definitions for PCIe legacy INTx interrupts into every DTS
>> file used by the pci-mvebu.c controller driver.
>>=20
>> It was tested on 88F6820 (A385) and 88F6281 (Kirkwood) SoCs.
>>=20
>> [1] https://lore.kernel.org/linux-arm-kernel/87wnhxjxlq.fsf@BL-laptop/
>>=20
>> Changes since v1:
>> - dropped armada-385 patch, which was already applied
>> - added commit messages
>>=20
>> Pali Roh=C3=A1r (10):
>>   ARM: dts: kirkwood: Add definitions for PCIe legacy INTx interrupts
>>   ARM: dts: dove: Add definitions for PCIe legacy INTx interrupts
>>   ARM: dts: armada-370.dtsi: Add definitions for PCIe legacy INTx
>>     interrupts
>>   ARM: dts: armada-xp-98dx3236.dtsi: Add definitions for PCIe legacy
>>     INTx interrupts
>>   ARM: dts: armada-xp-mv78230.dtsi: Add definitions for PCIe legacy INTx
>>     interrupts
>>   ARM: dts: armada-xp-mv78260.dtsi: Add definitions for PCIe legacy INTx
>>     interrupts
>>   ARM: dts: armada-xp-mv78460.dtsi: Add definitions for PCIe legacy INTx
>>     interrupts
>>   ARM: dts: armada-375.dtsi: Add definitions for PCIe legacy INTx
>>     interrupts
>>   ARM: dts: armada-380.dtsi: Add definitions for PCIe legacy INTx
>>     interrupts
>>   ARM: dts: armada-39x.dtsi: Add definitions for PCIe legacy INTx
>>     interrupts
>>=20
>>  arch/arm/boot/dts/armada-370.dtsi         |  28 ++++-
>>  arch/arm/boot/dts/armada-375.dtsi         |  28 ++++-
>>  arch/arm/boot/dts/armada-380.dtsi         |  42 ++++++-
>>  arch/arm/boot/dts/armada-39x.dtsi         |  56 +++++++--
>>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi |  14 ++-
>>  arch/arm/boot/dts/armada-xp-mv78230.dtsi  |  70 +++++++++--
>>  arch/arm/boot/dts/armada-xp-mv78260.dtsi  | 126 ++++++++++++++++---
>>  arch/arm/boot/dts/armada-xp-mv78460.dtsi  | 140 ++++++++++++++++++----
>>  arch/arm/boot/dts/dove.dtsi               |  28 ++++-
>>  arch/arm/boot/dts/kirkwood-6192.dtsi      |  14 ++-
>>  arch/arm/boot/dts/kirkwood-6281.dtsi      |  14 ++-
>>  arch/arm/boot/dts/kirkwood-6282.dtsi      |  28 ++++-
>>  arch/arm/boot/dts/kirkwood-98dx4122.dtsi  |  14 ++-
>>  13 files changed, 516 insertions(+), 86 deletions(-)
>>=20
>> --=20
>> 2.35.1
>>=20

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
