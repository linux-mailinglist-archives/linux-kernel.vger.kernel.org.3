Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86F5A7C02
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiHaLMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:12:19 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC36CEB26
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:12:18 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11f0fa892aeso15007178fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sJH+8p5AtjeeuMnWmoPAbxDcXoEr/hihkiuokZEt+xs=;
        b=KiHcHM7+/5UKpbapOwznFZR+Awj8ouNl6UC4vXytttIEdsVgifeBzD2mFOC0nysXjy
         j+LfgrC0EMFd1d+rpQJlfSQv+v+iy8RUPqvtBJkMzH4K6zpq845PiL5bm+fsundOZtlg
         7CH3Aq/njUBZHYZDr2Y9vlA6bX12QAX/wTU/NSGTCikvSk6j0+5Le//qA6sSuYZghXsU
         yOqKhMJaSwLlMXZ9emDmLZE3yUB2VfZbLCRZdaEhngusL7vIIWe7Ougj247KuHxdnv04
         +9ZrYV0aWbsuuifnhkg5PtIm35Sa7qp1UqLPEl2qVNKSlZ47KPgtFzp7Ghq+xj/8HVVx
         MgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sJH+8p5AtjeeuMnWmoPAbxDcXoEr/hihkiuokZEt+xs=;
        b=gcwOepJnOBQSLfYWGOr1GgUnbffrzfdYYaauPS0gVE0L1OYwITE66WIYiP1LcUc0rR
         BQmfdpWG9Jba7sYdx6d2SqYtABKtGUesfiKH3VdMQfAeaZ7iH2NLoR0o/Lr0KPk/Qg7e
         nj4/Q47o+63dfKLpf1TGtd173fVcKhJ5EpS9SMmAbibwtLb/LHVzKyPWlPYp0srWhbRf
         Ci5/cLFySeG46zCBDLiO27HoQUbwwfvo1psvcEoH/KXJqc4xQTYz9YNiBowyAKqnCoCY
         1ugvg0ugSh7RFCkgbgTP+mq1KLE4LjBxIhyaPpK6N55S7ixiM5A0rFuLvqPOJmxtoB10
         CjVA==
X-Gm-Message-State: ACgBeo2Mxi173uRhtJKxwHMkWn/uy2P3yBDxwMGrYj03j4bOzyM+uFCE
        lvfDEnf0BuBJwTdrSJczGiHTKINAn0sEFsfJHNlY5g==
X-Google-Smtp-Source: AA6agR6Otmzk4Kk/s43tJZQHK9B9/4L56sa/82Eewo7SR4MuZgVfgMuFa/XtqxbidkOI8YYMGIiazDGLGbxY19x9ouk=
X-Received: by 2002:a05:6870:783:b0:11c:7d1c:6ede with SMTP id
 en3-20020a056870078300b0011c7d1c6edemr1091545oab.239.1661944337671; Wed, 31
 Aug 2022 04:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220516124828.45144-1-robert.marko@sartura.hr>
 <20220516124828.45144-10-robert.marko@sartura.hr> <CA+HBbNF2R--984SdB0v42GMQOwAx4pTEz_FHifTtebN05ELU-Q@mail.gmail.com>
 <87mtbm5gaf.fsf@BL-laptop>
In-Reply-To: <87mtbm5gaf.fsf@BL-laptop>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 31 Aug 2022 13:12:06 +0200
Message-ID: <CA+HBbNG13dspUspWMrT=LWpCnMCZ-r-K8zR4RaoLf8HxhzStSQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 9:42 AM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Robert Marko <robert.marko@sartura.hr> writes:
>
> > On Mon, May 16, 2022 at 2:48 PM Robert Marko <robert.marko@sartura.hr> wrote:
> >>
> >> Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.
> >>
> >> They feature the same CPU, RAM, and storage as well as the form factor.
> >>
> >> However, eDPU only has one SFP slot plus a copper G.hn port.
> >>
> >> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >> Changes in v2:
> >> * Make the DTS split a separate commit
> >> ---
> >>  arch/arm64/boot/dts/marvell/Makefile             |  1 +
> >>  arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts | 14 ++++++++++++++
> >>  2 files changed, 15 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> >>
> >> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> >> index 1c794cdcb8e6..104d7d7e8215 100644
> >> --- a/arch/arm64/boot/dts/marvell/Makefile
> >> +++ b/arch/arm64/boot/dts/marvell/Makefile
> >> @@ -1,6 +1,7 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  # Mvebu SoC Family
> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
> >> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
> >>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> >> new file mode 100644
> >> index 000000000000..57fc698e55d0
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> >> @@ -0,0 +1,14 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "armada-3720-uDPU.dtsi"
> >> +
> >> +/ {
> >> +       model = "Methode eDPU Board";
> >> +       compatible = "methode,edpu", "marvell,armada3720", "marvell,armada3710";
> >> +};
> >> +
> >> +&eth0 {
> >> +       phy-mode = "2500base-x";
> >> +};
> >> --
> >> 2.36.1
> >>
> >
> > Hi Gregory,
> Hello Roberto,
>
> > Is there something else that I can improve in the series?
>
> Sorry for having missed this series. At first view it seems OK, I am
> going to have a closer look this week.

Thanks, that sounds good.

Regards,
Robert
>
> Gregory
>
>
> >
> > Regards,
> > Robert
> >
> > --
> > Robert Marko
> > Staff Embedded Linux Engineer
> > Sartura Ltd.
> > Lendavska ulica 16a
> > 10000 Zagreb, Croatia
> > Email: robert.marko@sartura.hr
> > Web: www.sartura.hr
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
