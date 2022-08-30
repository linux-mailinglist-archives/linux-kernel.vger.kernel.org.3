Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4016F5A6EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiH3VI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiH3VIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:08:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF847C1A3;
        Tue, 30 Aug 2022 14:08:53 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UL8kfG130221;
        Tue, 30 Aug 2022 16:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661893726;
        bh=NtKcwczTeR2CPHLoKmnqcAiFTJkPBNRBY1w2UEeVEY4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Ytan+20x+E6POnMychilOPBCWYZdKY4xPQXg53yvIKGSKxbdbm309bKG+dDX3U2b+
         vlY+PAc19pc0yhBrwcMo9/rp/+UgcdeMBcBOrUkauiQLG1q7XHPND0ZDhpcWNJz7Nj
         k+Yg51D1CzxTVtjx2bogG9ajBrE8bwlM7UiAvar4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UL8kFB017745
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 16:08:46 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 16:08:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 16:08:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UL8jt1085284;
        Tue, 30 Aug 2022 16:08:45 -0500
Date:   Tue, 30 Aug 2022 16:08:45 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am642-sk: Add DT entry for onboard
 LEDs
Message-ID: <20220830210845.tohj2gm5po4bndtl@bryanbrattlof.com>
References: <20220830123254.522222-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220830123254.522222-1-vigneshr@ti.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aparna & Vignesh!

On August 30, 2022 thus sayeth Vignesh Raghavendra:
> From: Aparna M <a-m1@ti.com>
> 
> AM642 SK has 8 leds connected to tpic2810 onboard. Add support for these
> gpio leds.
> 
> Signed-off-by: Aparna M <a-m1@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Reviewed-by: Bryan Brattlof <bb@ti.com>

Looks great to me!

> ---
> v3:
> Fix compile error due to missing header
> Fix whitespace issues
> 
> v2: https://lore.kernel.org/all/20220629075859.6939-1-a-m1@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 70 ++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 

Thanks for getting the leds working :)
~Bryan
