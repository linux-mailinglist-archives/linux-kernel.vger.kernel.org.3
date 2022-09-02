Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5758C5AB777
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiIBR0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiIBR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:26:37 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2F80486
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:26:31 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id u5-20020a4a5705000000b0044b34c2c89cso473227ooa.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5YEXvqR+vx/Umcehqyrubxd7/QR3N0wzSkpi6lMpvlM=;
        b=O+yG3V/tDsWo9zDQBgva45Mv6BiwFMSlpOrEqSXo5i1B/b3z3qe0Q5nXPqQZz26vX1
         RAY9f1NcJMgBI1g/ZAEsylLBpq0nZscyHFwagSSjEObaZco2AFTof9XDjiI9nY9zwJx5
         QJbN5Kdc4uH/9br/Cl+BTjXWFnXhunRzDsyw1JmHTZbEjTghVdQ1n7+zk9+9Ay4JpJJP
         vkch1ajLO2QXpwNHsbYUCcIVRBgm1aQfqd7LW98WkANMuDUoQHcIoP9wlHORQHs+MbXQ
         KSzQj95C04bzjFrdA7COuCyMR6zIWM/EDdbHtUl2DxUeLiZdmDLmZyvyT+HI4+l8i33Y
         wyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5YEXvqR+vx/Umcehqyrubxd7/QR3N0wzSkpi6lMpvlM=;
        b=pdqaTGWhkJqUkXcYhTnUHePu6+UXslTvwnAJIcsZlLYP3ioNIJr7TFfEYEgiNDGqj6
         tFK//DlA6XGl5bWsyjVNUxhK3M9vxdEMeOg1ZVM5BneCnheLs2leoKymtHWqhdk1+eAi
         FwxVbpH3+Twph6T591ZvzZb1k5gtUkQeKQAirvbqdCQiuTkfuw1jnLAzEnwFMQvOo28d
         SKzMQ9+tEJpok7EfGo4Ce90xXJmHq/Wy3U14NBCGIFQ6MroL31O4aFpBFYw9Pz48l68r
         jjk0czFgnDnu7I1WyepYHOmUGoDJMhD7ARJhMQaexIFXGqszmM+wvx1YVLndgynETkkJ
         gMiw==
X-Gm-Message-State: ACgBeo0pQ74O5kUejNMOPCcLXZBXvbhOe01YzNe/fhusz6OVqCKf2t4G
        G74cYUL6U5qUJ0j0twUuml3x/QrKhsf/dhukgsDpog==
X-Google-Smtp-Source: AA6agR7si9Ke79mR4M0LW2O+RbrCfYe42jelsn8TPWXCR4mhJKEFZA2yRB9prUJpTuJ+VSgtMlX/d3Hhhn1KvbiYtC8=
X-Received: by 2002:a05:6820:609:b0:44a:8ba7:a9ab with SMTP id
 e9-20020a056820060900b0044a8ba7a9abmr12768974oow.95.1662139590112; Fri, 02
 Sep 2022 10:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220516124828.45144-1-robert.marko@sartura.hr>
 <20220516124828.45144-10-robert.marko@sartura.hr> <CA+HBbNF2R--984SdB0v42GMQOwAx4pTEz_FHifTtebN05ELU-Q@mail.gmail.com>
 <87mtbm5gaf.fsf@BL-laptop> <CA+HBbNG13dspUspWMrT=LWpCnMCZ-r-K8zR4RaoLf8HxhzStSQ@mail.gmail.com>
 <87ler1er7z.fsf@BL-laptop> <87czcdeovj.fsf@BL-laptop>
In-Reply-To: <87czcdeovj.fsf@BL-laptop>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 2 Sep 2022 19:26:18 +0200
Message-ID: <CA+HBbNEQ7dJEU7ug4X1F5+houpk=J==4O3sSE34cDyyw-8BTvw@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] arm64: dts: marvell: add support for Methode eDPU
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 6:13 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Gregory CLEMENT <gregory.clement@bootlin.com> writes:
>
> > Robert Marko <robert.marko@sartura.hr> writes:
> >
> >> On Tue, Aug 30, 2022 at 9:42 AM Gregory CLEMENT
> >> <gregory.clement@bootlin.com> wrote:
> >>>
> >>> Robert Marko <robert.marko@sartura.hr> writes:
> >>>
> >>> > On Mon, May 16, 2022 at 2:48 PM Robert Marko <robert.marko@sartura.hr> wrote:
> >>> >>
> >>> >> Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.
> >>> >>
> >>> >> They feature the same CPU, RAM, and storage as well as the form factor.
> >>> >>
> >>> >> However, eDPU only has one SFP slot plus a copper G.hn port.
> >>> >>
> >>> >> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >>> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> >> ---
> >>> >> Changes in v2:
> >>> >> * Make the DTS split a separate commit
> >>> >> ---
> >>> >>  arch/arm64/boot/dts/marvell/Makefile             |  1 +
> >>> >>  arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts | 14 ++++++++++++++
> >>> >>  2 files changed, 15 insertions(+)
> >>> >>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> >>> >>
> >>> >> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> >>> >> index 1c794cdcb8e6..104d7d7e8215 100644
> >>> >> --- a/arch/arm64/boot/dts/marvell/Makefile
> >>> >> +++ b/arch/arm64/boot/dts/marvell/Makefile
> >>> >> @@ -1,6 +1,7 @@
> >>> >>  # SPDX-License-Identifier: GPL-2.0
> >>> >>  # Mvebu SoC Family
> >>> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
> >>> >> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
> >>> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
> >>> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
> >>> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
> >>> >> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> >>> >> new file mode 100644
> >>> >> index 000000000000..57fc698e55d0
> >>> >> --- /dev/null
> >>> >> +++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> >>> >> @@ -0,0 +1,14 @@
> >>> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >>> >> +
> >>> >> +/dts-v1/;
> >>> >> +
> >>> >> +#include "armada-3720-uDPU.dtsi"
> >>> >> +
> >>> >> +/ {
> >>> >> +       model = "Methode eDPU Board";
> >>> >> +       compatible = "methode,edpu", "marvell,armada3720", "marvell,armada3710";
> >>> >> +};
> >>> >> +
> >>> >> +&eth0 {
> >>> >> +       phy-mode = "2500base-x";
> >>> >> +};
> >>> >> --
> >>> >> 2.36.1
> >>> >>
> >>> >
> >>> > Hi Gregory,
> >>> Hello Roberto,
> >>>
> >>> > Is there something else that I can improve in the series?
> >>>
> >>> Sorry for having missed this series. At first view it seems OK, I am
> >>> going to have a closer look this week.
> >>
> >> Thanks, that sounds good.
> >
> > Hello,
> >
> > could you send again patch 8, I managed to apply all the other ones
> > excepting this one.
>
> Finally I managed to sort it out, all the series is applied on mvebu/dt64

Thanks,
Regards
Robert
>
> Thanks,
>
> Gregory
> >
> >
> >>
> >> Regards,
> >> Robert
> >>>
> >>> Gregory
> >>>
> >>>
> >>> >
> >>> > Regards,
> >>> > Robert
> >>> >
> >>> > --
> >>> > Robert Marko
> >>> > Staff Embedded Linux Engineer
> >>> > Sartura Ltd.
> >>> > Lendavska ulica 16a
> >>> > 10000 Zagreb, Croatia
> >>> > Email: robert.marko@sartura.hr
> >>> > Web: www.sartura.hr
> >>>
> >>> --
> >>> Gregory Clement, Bootlin
> >>> Embedded Linux and Kernel engineering
> >>> http://bootlin.com
> >>
> >>
> >>
> >> --
> >> Robert Marko
> >> Staff Embedded Linux Engineer
> >> Sartura Ltd.
> >> Lendavska ulica 16a
> >> 10000 Zagreb, Croatia
> >> Email: robert.marko@sartura.hr
> >> Web: www.sartura.hr
> >
> > --
> > Gregory Clement, Bootlin
> > Embedded Linux and Kernel engineering
> > http://bootlin.com
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
