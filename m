Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B794B1664
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbiBJTfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:35:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243590AbiBJTfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:35:10 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E7D62;
        Thu, 10 Feb 2022 11:35:10 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21AJYxi7056840;
        Thu, 10 Feb 2022 13:34:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644521699;
        bh=/bJ9iS5dwRmi3cHk4NArM1//+U9uqS5txh7CfIsrBUk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=slO7lGXd+EMThj4PR2jsTrB2byPNkJgf6+5JQpgzVMeYZqWTWJ7cMDjzSUEXQtFj3
         V8B+R06c3AV39wMEvdFlBED5YcuMeufp3yzeoxoIcDVcOTm0T5gcujyeT7fkwNnGno
         4FVpqU0wg3KXGpuPRn3/RKENIM5lPRlrb+DE0sCw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21AJYxpL110267
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Feb 2022 13:34:59 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 10
 Feb 2022 13:34:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 10 Feb 2022 13:34:59 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21AJYxmX064678;
        Thu, 10 Feb 2022 13:34:59 -0600
Date:   Thu, 10 Feb 2022 13:34:59 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] arm64: dts: ti: Introduce base support for AM62x SoC
Message-ID: <20220210193459.nl6baranvmqs46bi@coastal>
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-5-vigneshr@ti.com>
 <bc6cb6e1adcf6860a595b71246778733@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bc6cb6e1adcf6860a595b71246778733@kernel.org>
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

On 19:10-20220209, Marc Zyngier wrote:
[...]

> > +&cbass_main {
> > +	gic500: interrupt-controller@1800000 {
> > +		compatible = "arm,gic-v3";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +		#interrupt-cells = <3>;
> > +		interrupt-controller;
> > +		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
> > +		      <0x00 0x01880000 0x00 0xC0000>;	/* GICR */
> 
> Usual rant: you are missing the GICC, GICH and GICV regions
> that are implemented by the CPU. Cortex-A53 implements them
> (they are not optional), so please describe them.
> 


-ECONFUSED. TRM for GIC500 refers to just GICD, GICR and ITS range[1].

Same thing is indicated by Generic Interrupt Controller Architecture
Specification[2] See table 1-1 (page 23).

I think you are expecting GICV3's backward compatibility mode (Table 1-2
in page 24), But in K3 architecture, are_option meant for backward
compatibility is set to true (aka no backward compatibility). I think
this did popup sometime back as well (first k3 SoC)[3]. I think the more
clearer description is available in [4].

I believe the argumentation that GICC/H/V is mandatory for A53 if GIC500
is used is not accurate. Please correct me if I am mistaken.


[1] https://developer.arm.com/documentation/ddi0516/e/programmers-model/the-gic-500-register-map?lang=en
[2] https://developer.arm.com/documentation/ihi0069/d
[3] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20180607233853.p7iw7nlxxuyi66og@kahuna/
[4] https://developer.arm.com/documentation/ddi0516/e/functional-description/operation/backwards-compatibility?lang=en

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
