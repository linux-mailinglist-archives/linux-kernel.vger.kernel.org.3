Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE66850C7A6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 07:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiDWFeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 01:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiDWFeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:34:20 -0400
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E72E5;
        Fri, 22 Apr 2022 22:31:20 -0700 (PDT)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 31B84267CE;
        Sat, 23 Apr 2022 05:31:18 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id AED893F15F;
        Sat, 23 Apr 2022 07:31:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 0A7472A381;
        Sat, 23 Apr 2022 05:31:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Cl0X8p721LZJ; Sat, 23 Apr 2022 05:31:14 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 23 Apr 2022 05:31:14 +0000 (UTC)
Received: from [172.16.34.145] (unknown [121.33.114.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3E0644006D;
        Sat, 23 Apr 2022 05:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1650691873; bh=w40/85VIv5BQZf+43/3bBfUU3+lju+R6jndNVZ1NoDo=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
        b=s7mWDm4qE8QFgZ5iFz1SuzvyRKqdDicOrOnmOqccLA8xDTGTEUt3kIRvxKpwFnbjZ
         oUh8/CivdVevTOY6GHkZvwlwHt+nhOqMbmkG3pXasQyqnxix0EbB8TJzi/MFYNhCvS
         TEgMh7jrTC5+d3yFhjnGnrkepNXpj53Ceu0W3Ebg=
Message-ID: <9525d336040d2fc89005d2923f0d8ee98597ac86.camel@aosc.io>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: sun8i-thermal: add binding
 for R329 THS
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CA+E=qVfMm=8aQOM_HW_3EeqqLi-Fgn1Ex3h6kor89FQ0KfTvRw@mail.gmail.com>
References: <BYAPR20MB24721F9954252BECBEF486ACBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
         <CA+E=qVfMm=8aQOM_HW_3EeqqLi-Fgn1Ex3h6kor89FQ0KfTvRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Sat, 23 Apr 2022 07:51:54 +0800
User-Agent: Evolution 3.40.4 
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-04-22星期五的 11:44 -0700，Vasily Khoruzhick写道：
> On Fri, Apr 22, 2022 at 9:12 AM <icenowy@outlook.com> wrote:
> > 
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > R329 has a thermal sensor controller that has only one sensor, and
> > the
> > structure of it is like the H6 one.
> > 
> > Add device tree binding for it.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml  | 3
> > +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-
> > ths.yaml
> > b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-
> > ths.yaml
> > index 6e0b110153b0..87b4103e0a5f 100644
> > --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-
> > a83t-ths.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-
> > a83t-ths.yaml
> > @@ -20,6 +20,7 @@ properties:
> >        - allwinner,sun50i-a100-ths
> >        - allwinner,sun50i-h5-ths
> >        - allwinner,sun50i-h6-ths
> > +      - allwinner,sun50i-r329-ths
> > 
> >    clocks:
> >      minItems: 1
> > @@ -63,6 +64,7 @@ allOf:
> >              enum:
> >                - allwinner,sun50i-a100-ths
> >                - allwinner,sun50i-h6-ths
> > +              - allwinner,sun50i-r329-ths
> > 
> >      then:
> >        properties:
> > @@ -85,6 +87,7 @@ allOf:
> >          compatible:
> >            contains:
> >              const: allwinner,sun8i-h3-ths
> > +            const: allwinner,sun8i-r329-ths
> > 
> >      then:
> >        properties:
> 
> There's also a check at line #99 that requires clock, clock-names and
> resets properties for thermal sensors in other Allwinner SoCs. Are
> these not required for r329?

Thanks for this tip, I will add R329 to this check in the next
revision.

> 
> Also are you planning to add a node for thermal sensor to r329 dtsi?
> 
> 
> > --
> > 2.35.1
> > 


