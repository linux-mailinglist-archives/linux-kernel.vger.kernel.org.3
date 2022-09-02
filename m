Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC455AB65B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbiIBQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbiIBQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:16:25 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0C6DEA79;
        Fri,  2 Sep 2022 09:13:07 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6C9D7FF803;
        Fri,  2 Sep 2022 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662135185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vg0Ow2Wlxy45PIHiHnVEioKxms+Qp0llN/7M0XoKma4=;
        b=i/F5clX8UD2+J57eHw7iWb0WYy6CA3pXxKlAfipwJYwDFBh3vM8/0WT2jbYS+WZgTePEq1
        EXPrbe/wbT1sMVqAxilaRNK0vh2Mu6I8gNn3nyV6Xev07BP/mAtLZLkP+mCHM0gnDHTAyG
        fER59lTWN+bHLjeYV25/5tc1/1wNegZqXzIeO8A1xdKJ0vqi8AQgUa9fxWOJbXMTi/ktYV
        ecfKG64wrsfjIbZkjBzx5R197yDc0PirSu3ejh0Rp8pqOMKNj5r8t4cR+7jYFyTQXvK7z2
        qXOI4m/9Kvv+mlP36E1QNVv/YIBfKRqvn7T1mgRKRO8meczb+CusIIVmsBJEuw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 10/10] arm64: dts: marvell: add support for Methode eDPU
In-Reply-To: <87ler1er7z.fsf@BL-laptop>
References: <20220516124828.45144-1-robert.marko@sartura.hr>
 <20220516124828.45144-10-robert.marko@sartura.hr>
 <CA+HBbNF2R--984SdB0v42GMQOwAx4pTEz_FHifTtebN05ELU-Q@mail.gmail.com>
 <87mtbm5gaf.fsf@BL-laptop>
 <CA+HBbNG13dspUspWMrT=LWpCnMCZ-r-K8zR4RaoLf8HxhzStSQ@mail.gmail.com>
 <87ler1er7z.fsf@BL-laptop>
Date:   Fri, 02 Sep 2022 18:13:04 +0200
Message-ID: <87czcdeovj.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory CLEMENT <gregory.clement@bootlin.com> writes:

> Robert Marko <robert.marko@sartura.hr> writes:
>
>> On Tue, Aug 30, 2022 at 9:42 AM Gregory CLEMENT
>> <gregory.clement@bootlin.com> wrote:
>>>
>>> Robert Marko <robert.marko@sartura.hr> writes:
>>>
>>> > On Mon, May 16, 2022 at 2:48 PM Robert Marko <robert.marko@sartura.hr> wrote:
>>> >>
>>> >> Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.
>>> >>
>>> >> They feature the same CPU, RAM, and storage as well as the form factor.
>>> >>
>>> >> However, eDPU only has one SFP slot plus a copper G.hn port.
>>> >>
>>> >> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> >> ---
>>> >> Changes in v2:
>>> >> * Make the DTS split a separate commit
>>> >> ---
>>> >>  arch/arm64/boot/dts/marvell/Makefile             |  1 +
>>> >>  arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts | 14 ++++++++++++++
>>> >>  2 files changed, 15 insertions(+)
>>> >>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>>> >>
>>> >> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
>>> >> index 1c794cdcb8e6..104d7d7e8215 100644
>>> >> --- a/arch/arm64/boot/dts/marvell/Makefile
>>> >> +++ b/arch/arm64/boot/dts/marvell/Makefile
>>> >> @@ -1,6 +1,7 @@
>>> >>  # SPDX-License-Identifier: GPL-2.0
>>> >>  # Mvebu SoC Family
>>> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
>>> >> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
>>> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
>>> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
>>> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
>>> >> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>>> >> new file mode 100644
>>> >> index 000000000000..57fc698e55d0
>>> >> --- /dev/null
>>> >> +++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>>> >> @@ -0,0 +1,14 @@
>>> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> >> +
>>> >> +/dts-v1/;
>>> >> +
>>> >> +#include "armada-3720-uDPU.dtsi"
>>> >> +
>>> >> +/ {
>>> >> +       model = "Methode eDPU Board";
>>> >> +       compatible = "methode,edpu", "marvell,armada3720", "marvell,armada3710";
>>> >> +};
>>> >> +
>>> >> +&eth0 {
>>> >> +       phy-mode = "2500base-x";
>>> >> +};
>>> >> --
>>> >> 2.36.1
>>> >>
>>> >
>>> > Hi Gregory,
>>> Hello Roberto,
>>>
>>> > Is there something else that I can improve in the series?
>>>
>>> Sorry for having missed this series. At first view it seems OK, I am
>>> going to have a closer look this week.
>>
>> Thanks, that sounds good.
>
> Hello,
>
> could you send again patch 8, I managed to apply all the other ones
> excepting this one.

Finally I managed to sort it out, all the series is applied on mvebu/dt64

Thanks,

Gregory
>
>
>>
>> Regards,
>> Robert
>>>
>>> Gregory
>>>
>>>
>>> >
>>> > Regards,
>>> > Robert
>>> >
>>> > --
>>> > Robert Marko
>>> > Staff Embedded Linux Engineer
>>> > Sartura Ltd.
>>> > Lendavska ulica 16a
>>> > 10000 Zagreb, Croatia
>>> > Email: robert.marko@sartura.hr
>>> > Web: www.sartura.hr
>>>
>>> --
>>> Gregory Clement, Bootlin
>>> Embedded Linux and Kernel engineering
>>> http://bootlin.com
>>
>>
>>
>> -- 
>> Robert Marko
>> Staff Embedded Linux Engineer
>> Sartura Ltd.
>> Lendavska ulica 16a
>> 10000 Zagreb, Croatia
>> Email: robert.marko@sartura.hr
>> Web: www.sartura.hr
>
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
