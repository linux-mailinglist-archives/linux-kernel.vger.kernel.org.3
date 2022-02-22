Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0DC4BFA63
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiBVOIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiBVOIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:08:36 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCB513113F;
        Tue, 22 Feb 2022 06:08:10 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21ME7MkP005019;
        Tue, 22 Feb 2022 08:07:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645538842;
        bh=8HPnjRNTg1rgRuGDrTg7AuCbtaoqyKy2IHjGLaHD7Fs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ctwrzo4XA7iB3hzjs0/vCaLdhyfnlm9x8Tdm/vef0FUl6cqTWqKcvKg8na866ipQ3
         LkfBXKjRm6agy3zbZ0R+Hv1+oLn5AMKHSzkk/YA4GXqoL7gpruaaFDcenNcJOSZymK
         u2NjCkYLufIp1G3dAt7RFNAxpFND1thYMo9NUp/8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21ME7MSc086515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Feb 2022 08:07:22 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Feb 2022 08:07:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 22 Feb 2022 08:07:21 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21ME7LqE034437;
        Tue, 22 Feb 2022 08:07:21 -0600
Date:   Tue, 22 Feb 2022 08:07:21 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jan Kotas <jank@cadence.com>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [RFC PATCH 8/8] arm64: dts: ti: use 'freq-table' in UFS node
Message-ID: <20220222140721.bzbspfcethml2psm@running>
References: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
 <20220219184554.44887-1-krzysztof.kozlowski@canonical.com>
 <20220221131340.q3hjpjevqrfvhggv@specimen>
 <19705501-2391-14a4-0eac-4b2b647a9735@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <19705501-2391-14a4-0eac-4b2b647a9735@canonical.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:20-20220221, Krzysztof Kozlowski wrote:
> On 21/02/2022 14:13, Nishanth Menon wrote:
> > On 19:45-20220219, Krzysztof Kozlowski wrote:
> >> The 'freq-table-hz' property is deprecated by UFS bindings.
> >> The uint32-array requires also element to be passed within one <> block.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> >> index 599861259a30..c3afef0321ae 100644
> >> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> >> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> >> @@ -1257,7 +1257,9 @@ ufs@4e84000 {
> >>  			compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
> >>  			reg = <0x0 0x4e84000 0x0 0x10000>;
> >>  			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> >> -			freq-table-hz = <250000000 250000000>, <19200000 19200000>, <19200000 19200000>;
> >> +			freq-table = <250000000 250000000
> > 
> > <min max> is much more readable and less error prone in case of a large
> > set.
> 
> Pairs are easily visible if split per line, so readability is similar.
> Not much is lost.
> 
> > 
> >> +				      19200000 19200000
> >> +				      19200000 19200000>;
> > 
> > are you sure the removal of the tuple adds value?
> 
> DT schema requires it, or rather: I do not know how to express uint32
> tuples in DT schema. All my tries failed.

https://www.kernel.org/doc/Documentation/devicetree/bindings/opp/opp-v1.yaml
comes to mind..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
