Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D911D57C481
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiGUGcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGUGca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:32:30 -0400
Received: from 7.mo575.mail-out.ovh.net (7.mo575.mail-out.ovh.net [46.105.63.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC690BC31
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:32:28 -0700 (PDT)
Received: from player750.ha.ovh.net (unknown [10.110.115.215])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 9F4C223790
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:25:23 +0000 (UTC)
Received: from RCM-web2.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player750.ha.ovh.net (Postfix) with ESMTPSA id 38BDD2CBF8089;
        Thu, 21 Jul 2022 06:25:10 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 21 Jul 2022 08:25:10 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 4/9] arm64: dts: Move BCM4908 dts to bcmbca folder
In-Reply-To: <20220721000720.29578-1-william.zhang@broadcom.com>
References: <20220721000720.29578-1-william.zhang@broadcom.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9e81a389e165685cc69236245819d863@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17389242590046825435
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudelkedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeegvdffjeelvdeggeetheegveejieetgeeiiefggeelveejffehieekhfduueelhfenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejhedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-21 02:07, William Zhang wrote:
> Move the BCM4908 dts files to bcmbca folder. Use CONFIG_ARCH_BCMBCA to
> build all the BCM4908 board dts. Remove bcm4908 folder and its 
> makefile.

This will be a but painful for projects like OpenWrt or Buildroot. They
have scripts that look for dtb files in specific directories. Now they
will have to be made kernel-version-aware which may not be an option.

Still I think it's a nice & needed cleanup!

Just in case someone knows some intermediate solution let me know
please.


> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  arch/arm64/boot/dts/broadcom/Makefile                        | 1 -
>  arch/arm64/boot/dts/broadcom/bcm4908/Makefile                | 5 -----
>  arch/arm64/boot/dts/broadcom/bcmbca/Makefile                 | 4 ++++
>  .../broadcom/{bcm4908 => bcmbca}/bcm4906-netgear-r8000p.dts  | 0
>  .../{bcm4908 => bcmbca}/bcm4906-tplink-archer-c2300-v1.dts   | 0
>  .../arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4906.dtsi | 0
>  .../broadcom/{bcm4908 => bcmbca}/bcm4908-asus-gt-ac5300.dts  | 0
>  .../broadcom/{bcm4908 => bcmbca}/bcm4908-netgear-raxe500.dts | 0
>  .../arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4908.dtsi | 0
>  9 files changed, 4 insertions(+), 6 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/broadcom/bcm4908/Makefile
>  rename arch/arm64/boot/dts/broadcom/{bcm4908 =>
> bcmbca}/bcm4906-netgear-r8000p.dts (100%)
>  rename arch/arm64/boot/dts/broadcom/{bcm4908 =>
> bcmbca}/bcm4906-tplink-archer-c2300-v1.dts (100%)
>  rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4906.dtsi 
> (100%)
>  rename arch/arm64/boot/dts/broadcom/{bcm4908 =>
> bcmbca}/bcm4908-asus-gt-ac5300.dts (100%)
>  rename arch/arm64/boot/dts/broadcom/{bcm4908 =>
> bcmbca}/bcm4908-netgear-raxe500.dts (100%)
>  rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4908.dtsi 
> (100%)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile
> b/arch/arm64/boot/dts/broadcom/Makefile
> index e8584d3b698f..05d8c5ecf3b0 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -8,7 +8,6 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
>  			      bcm2837-rpi-cm3-io3.dtb \
>  			      bcm2837-rpi-zero-2-w.dtb
> 
> -subdir-y	+= bcm4908
>  subdir-y	+= bcmbca
>  subdir-y	+= northstar2
>  subdir-y	+= stingray
> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
> b/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
> deleted file mode 100644
> index 6e364e304d4f..000000000000
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_ARCH_BCM4908) += bcm4906-netgear-r8000p.dtb
> -dtb-$(CONFIG_ARCH_BCM4908) += bcm4906-tplink-archer-c2300-v1.dtb
> -dtb-$(CONFIG_ARCH_BCM4908) += bcm4908-asus-gt-ac5300.dtb
> -dtb-$(CONFIG_ARCH_BCM4908) += bcm4908-netgear-raxe500.dtb
> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
> b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
> index 38f14307184b..d30fa75f0611 100644
> --- a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
> @@ -1,5 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_BCMBCA) += \
> +				bcm4906-netgear-r8000p.dtb \
> +				bcm4906-tplink-archer-c2300-v1.dtb \
> +				bcm4908-asus-gt-ac5300.dtb \
> +				bcm4908-netgear-raxe500.dtb \
>  				bcm4912-asus-gt-ax6000.dtb \
>  				bcm94912.dtb \
>  				bcm963158.dtb \
> diff --git
> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
> b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
> similarity index 100%
> rename from 
> arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
> rename to 
> arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
> diff --git
> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
> b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
> similarity index 100%
> rename from
> arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
> rename to 
> arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi
> b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906.dtsi
> similarity index 100%
> rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi
> rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4906.dtsi
> diff --git
> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
> b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
> similarity index 100%
> rename from 
> arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
> rename to 
> arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
> diff --git
> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
> b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-netgear-raxe500.dts
> similarity index 100%
> rename from 
> arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
> rename to 
> arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-netgear-raxe500.dts
> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
> b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
> similarity index 100%
> rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
> rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
