Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC02F59C98F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiHVUG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiHVUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:06:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C173ECF6;
        Mon, 22 Aug 2022 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661198784; x=1692734784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cjbm02nhLq/yvBwocNL850XgZfOqljzpsTMUZOzel3Q=;
  b=XDsKhI2WCfM+Op4ZAOFcOo843yFKndfMUO1C/rdZ5B56eEBbI9rz6Rca
   DX3oy3jeGbCI6eKYrsK3wywzIYMOPF+LZ3IfgDRjcVYuIp7iN9Hw3yAKI
   nfGpF3kxndCx8BlYRCuG0Wx70j2/q+JfiBW4dGxdmzwouzsNGGeZH4Ua5
   poYfJTmLyF10x9GWuBPSt1bv+m1I3SLsw1FTV9ATaBIJeDzXdzw/3NCBp
   GnuDWO/Oqy/AN4+u+0xuPxYmKzq1xbaGH2Vpqgl31IfEHn0JwdJygJTNk
   2bJtl5iYU+kwbWmc7CwzNDerglxWiovYTrNj70y/4RZSsWpuRDG1f094z
   w==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="170410083"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2022 13:06:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 22 Aug 2022 13:06:17 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 22 Aug 2022 13:06:17 -0700
Date:   Mon, 22 Aug 2022 22:10:31 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: lan966x-otpc: document Lan966X OTPC
Message-ID: <20220822201031.yhi6bbbzgt5pvchr@soft-dev3-1.localhost>
References: <20220818164405.1953698-1-horatiu.vultur@microchip.com>
 <20220818164405.1953698-2-horatiu.vultur@microchip.com>
 <550e652e-4541-c1e6-33a7-d5555f0cb266@linaro.org>
 <20220822060456.sl343a3a3uifini7@soft-dev3-1.localhost>
 <20220822181701.GA89665-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220822181701.GA89665-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 08/22/2022 13:17, Rob Herring wrote:

Hi Rob,

> 
> > > On 18/08/2022 19:44, Horatiu Vultur wrote:
> > > > Document Lan966x OTP controller.
> > > >
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: microchip,lan966x-otpc
> > >
> > > No wildcards in compatible (which will also affect the file name as it
> > > should match the compatible).
> >
> > Ok, I will replace lan966x with lan966 as the SoC is defined (SOC_LAN966)
> 
> Pretty sure that's still a wildcard for the SoC family. 9668 or 9662 are
> the ones we already have. Yes, there's already a bunch of 966x
> compatibles, but that's not a pattern that should continue.

OK, I can use the lan9668 and lan9662 as compatible string.
But then how should the file be named? As it need to match the
compatible string.

> 
> Rob

-- 
/Horatiu
