Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9486B5A5D27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiH3HmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiH3HmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:42:06 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39894A221B;
        Tue, 30 Aug 2022 00:42:04 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 90C381C000B;
        Tue, 30 Aug 2022 07:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661845322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OlJsykSuKUj404P3HmaG9eK2FUUXIkKuT4JtjowBQZQ=;
        b=kb3YuCStxdgM8c7BnX9v8sq2Dq25KzFhRtYTBt14EnoPA4vS5/Ydpz2SXeC1kR3lmzHVK0
        PMyzQbQsYhwnCIpApS2jY0zpjSOosSNlI51XjqxgxiWi+89q48hrEAczm1LN0mEyIbtASk
        80VsTFVPGwpKhBXz4z/mRAt9vSk5gGGvB0+InLwVH+u5lOj96WudzIT/M95aegn6MVnTa3
        l1gN+u+hCD1ExxftigI+eU9iJL0Kd6tQFyuN7eJz38ZYKWxGU9uWTQ4kY/Rm6u30XUOGll
        mxJ9oVorjw4+CRw16xMf2/8bPbUzu3suARsCxdHONwJ2qvDOLvS02MHGWXdtyg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 10/10] arm64: dts: marvell: add support for Methode eDPU
In-Reply-To: <CA+HBbNF2R--984SdB0v42GMQOwAx4pTEz_FHifTtebN05ELU-Q@mail.gmail.com>
References: <20220516124828.45144-1-robert.marko@sartura.hr>
 <20220516124828.45144-10-robert.marko@sartura.hr>
 <CA+HBbNF2R--984SdB0v42GMQOwAx4pTEz_FHifTtebN05ELU-Q@mail.gmail.com>
Date:   Tue, 30 Aug 2022 09:42:00 +0200
Message-ID: <87mtbm5gaf.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

> On Mon, May 16, 2022 at 2:48 PM Robert Marko <robert.marko@sartura.hr> wrote:
>>
>> Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.
>>
>> They feature the same CPU, RAM, and storage as well as the form factor.
>>
>> However, eDPU only has one SFP slot plus a copper G.hn port.
>>
>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>> Changes in v2:
>> * Make the DTS split a separate commit
>> ---
>>  arch/arm64/boot/dts/marvell/Makefile             |  1 +
>>  arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts | 14 ++++++++++++++
>>  2 files changed, 15 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>>
>> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
>> index 1c794cdcb8e6..104d7d7e8215 100644
>> --- a/arch/arm64/boot/dts/marvell/Makefile
>> +++ b/arch/arm64/boot/dts/marvell/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  # Mvebu SoC Family
>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
>> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
>> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>> new file mode 100644
>> index 000000000000..57fc698e55d0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +
>> +#include "armada-3720-uDPU.dtsi"
>> +
>> +/ {
>> +       model = "Methode eDPU Board";
>> +       compatible = "methode,edpu", "marvell,armada3720", "marvell,armada3710";
>> +};
>> +
>> +&eth0 {
>> +       phy-mode = "2500base-x";
>> +};
>> --
>> 2.36.1
>>
>
> Hi Gregory,
Hello Roberto,

> Is there something else that I can improve in the series?

Sorry for having missed this series. At first view it seems OK, I am
going to have a closer look this week.

Gregory


>
> Regards,
> Robert
>
> -- 
> Robert Marko
> Staff Embedded Linux Engineer
> Sartura Ltd.
> Lendavska ulica 16a
> 10000 Zagreb, Croatia
> Email: robert.marko@sartura.hr
> Web: www.sartura.hr

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
