Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363A557C6A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiGUInm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiGUInl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:43:41 -0400
X-Greylist: delayed 3494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 01:43:38 PDT
Received: from 19.mo583.mail-out.ovh.net (19.mo583.mail-out.ovh.net [46.105.35.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902E0FE3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:43:38 -0700 (PDT)
Received: from player726.ha.ovh.net (unknown [10.110.115.111])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 47F6A245E0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:15:24 +0000 (UTC)
Received: from RCM-web2.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player726.ha.ovh.net (Postfix) with ESMTPSA id 096522CC42DE3;
        Thu, 21 Jul 2022 06:15:16 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 21 Jul 2022 08:15:15 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 3/9] arm64: dts: bcmbca: update BCM4908 board dts
 files
In-Reply-To: <20220721000707.29557-1-william.zhang@broadcom.com>
References: <20220721000707.29557-1-william.zhang@broadcom.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <07a566d45cf48baff70f027e52264aa8@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17220639077199358939
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudelkedgtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeevjefhffffveeludejfedtvdfftdekgffghfegieeliedvfeeigfejteejjeekfeenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejvdeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeef
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-21 02:07, William Zhang wrote:
> Append "brcm,bcmbca" to compatible strings based on the new bcmbca
> binding rule for BCM4908 family based boards. This will break drivers
> that use the old compatible string for binding. Fortunately there is no
> such usage in linux and u-boot.

Why should an extra "compatible" value break anything? I don't think it
will happen unless some driver does some really crazy stuff (like
checking full list of "compatible" values).


> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Other than confusing commit message:

Acked-by: Rafał Miłecki <rafal@milecki.pl>


> ---
> 
>  arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts | 2 +-
>  .../dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts     | 2 +-
>  arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts | 2 +-
>  .../arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git
> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
> b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
> index 2dd028438c22..d8b60575eb4f 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
> @@ -7,7 +7,7 @@
>  #include "bcm4906.dtsi"
> 
>  / {
> -	compatible = "netgear,r8000p", "brcm,bcm4906", "brcm,bcm4908";
> +	compatible = "netgear,r8000p", "brcm,bcm4906", "brcm,bcm4908", 
> "brcm,bcmbca";
>  	model = "Netgear R8000P";
> 
>  	memory@0 {
> diff --git
> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
> b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
> index 064f7f549665..296393d4aaab 100644
> --- 
> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
> +++ 
> b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
> @@ -7,7 +7,7 @@
>  #include "bcm4906.dtsi"
> 
>  / {
> -	compatible = "tplink,archer-c2300-v1", "brcm,bcm4906", 
> "brcm,bcm4908";
> +	compatible = "tplink,archer-c2300-v1", "brcm,bcm4906",
> "brcm,bcm4908", "brcm,bcmbca";
>  	model = "TP-Link Archer C2300 V1";
> 
>  	memory@0 {
> diff --git
> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
> b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
> index 04f8524b5335..787c7ddf9102 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
> @@ -6,7 +6,7 @@
>  #include "bcm4908.dtsi"
> 
>  / {
> -	compatible = "asus,gt-ac5300", "brcm,bcm4908";
> +	compatible = "asus,gt-ac5300", "brcm,bcm4908", "brcm,bcmbca";
>  	model = "Asus GT-AC5300";
> 
>  	memory@0 {
> diff --git
> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
> b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
> index 3c2cf2d238b6..23b96c663239 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
> @@ -3,7 +3,7 @@
>  #include "bcm4908.dtsi"
> 
>  / {
> -	compatible = "netgear,raxe500", "brcm,bcm4908";
> +	compatible = "netgear,raxe500", "brcm,bcm4908", "brcm,bcmbca";
>  	model = "Netgear RAXE500";
> 
>  	memory@0 {
