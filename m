Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E68A463B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbhK3QOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:14:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:61859 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243958AbhK3QNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638288596; x=1669824596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2QWtVNSkRc85nLajFxYVSBdaIfBbfoV5BCiAUQVnQlg=;
  b=pP+pHZwnH32P4iINOUteFiT2NV+aaO7TeALhAfY7NdbCdSrEglrRFimH
   dMrtWTm/kP/Rp+V2mOpJV+M9HVkD39hITMitr19GNTfOiWEOC+m15BE02
   syy/RfrmtL8OqkmaorI32vikAbS/hm7M3ZL28bbsFXj1Y0SgeMIw9Cb4n
   LJcPDS3cq25dO6YasxlOa3FjyT2wSyg/TtjzdXj+8ZJJjHUoOCPvOuF9A
   30VRi24OQZ29R/tfGtbk02nC7RRPJbhzYFG01GSnxFpoVswlHzDJX80iP
   bbi+mfHMDVNaaIZNHUU/SjKpSewAOuizlrktpTR7oDHhMNSukR9dFP+a+
   A==;
IronPort-SDR: Ws5lURyfgKd+UvWPvnUKveK6akZpm8XCHEOWm6eWkrRIYRqWEWghkULvYFOUEzF+ZctQMQBdf5
 7CvS1SnIcxAuKKQJafCqPlfG3jokf2Qd3IVjWJhSuyQNrfpcuLUaHZEuZdWD8oFbSnbW3mGKfq
 0qxQoqMAOC0b2D6wPhOahcy2HAslVrFfLqIYilUgeq20z9PaAsoQpTqOuDuxKUJ+ezGRITRcbR
 AkU/LOGC4+fr6mX8mJYFFPefONRVzlnzekUtMKatjKAuqiRFrUScctszUot9mWpi76y4H6O8Sm
 2MypZtqj5bFylXBJBnSDcOwU
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="145009024"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Nov 2021 09:09:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 09:09:48 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 30 Nov 2021 09:09:48 -0700
Date:   Tue, 30 Nov 2021 17:11:41 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>, Vinod <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH resend v4 1/3] dt-bindings: phy: Add lan966x-serdes
 binding
Message-ID: <20211130161141.pat3h5sojddr2ne6@soft-dev3-1.localhost>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
 <20211116100818.1615762-2-horatiu.vultur@microchip.com>
 <CAMuHMdUkr3n-m8dadyzb=s7F9ns6PXMLgOkZaG=XTYNKnaaORg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUkr3n-m8dadyzb=s7F9ns6PXMLgOkZaG=XTYNKnaaORg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 11/30/2021 15:02, Geert Uytterhoeven wrote:
> 
> Hi Horatio,

Hi Geert,

> 
> On Tue, Nov 16, 2021 at 11:16 AM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:
> > Document the lan966x ethernet serdes phy driver bindings.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> Thanks for your patch, which is now commit fd66e57e46a3d1b7
> ("dt-bindings: phy: Add lan966x-serdes binding") in phy/next.
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
> 
> > +examples:
> > +  - |
> > +    serdes: serdes@e2004010 {
> > +      compatible = "microchip,lan966x-serdes";
> > +      reg = <0xe202c000 0x9c>, <0xe2004010 0x4>;
> > +      #phy-cells = <2>;
> > +    };
> 
> So this overlaps with the switch registers, cfr.
> Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> in net-next/master?
> 
>     switch: switch@e0000000 {
>       compatible = "microchip,lan966x-switch";
>       reg =  <0xe0000000 0x0100000>,
>              <0xe2000000 0x0800000>;
>       ...
>     };

Well, they will overlap, but the switch will not use the registers used
by the the serdes. The 'lan966x_main_iomap' inside lan966x_main.c will
decide which parts of the resource will be used.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
/Horatiu
