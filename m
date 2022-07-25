Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0641757FA7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiGYHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGYHvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:51:49 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073FA189;
        Mon, 25 Jul 2022 00:51:47 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P7F7lZ006902;
        Mon, 25 Jul 2022 09:51:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=Oy9dBYlQek27bG4HQfXQQ/9dXXCgDDTWpiS8zzZ74YI=;
 b=w8Y7mn4jZK6ZOlbh93MdunWAmLoxdYTAfBWD/r9F4+JdDdM1UyV0yrZi5Bp+388pNQlA
 ZLd1ExU7EhyLsRbf+MfsoTUueL645FDAXfxG4TzWvLDJeDGR1zCCDfNsECZU6HJCOURY
 p7SKI5GW4cPNTwg9deWEc2Zl7qKh6lEYbvg3kWKzUtopGj/vCaMfqiSQ5hbqMNZwsaJR
 0UMOPhFA2U2/bgcCasX6dOfbxEZORN/IWDmSHGfYjvo2QBmbPqIZxdAG/FoGq1uEzmxg
 Ad8EFKZTOyu2mrazTfqgFHhFWmZN2VMOeLNKyMIFiYQcoLDrV7kWDpFOkT5jGXkRsIqr vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hg6dkg543-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 09:51:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 93F7910002A;
        Mon, 25 Jul 2022 09:51:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E7CD212302;
        Mon, 25 Jul 2022 09:51:26 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.75.127.51) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 25 Jul
 2022 09:51:26 +0200
Date:   Mon, 25 Jul 2022 09:51:20 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>
Subject: Re: [PATCH 1/2] ARM: dts: stm32: add spi nodes into stm32mp131.dtsi
Message-ID: <20220725075120.GA429410@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com
References: <20220721153455.3805586-1-alain.volmat@foss.st.com>
 <20220721153455.3805586-2-alain.volmat@foss.st.com>
 <c7e13adb-8584-6e24-11f3-9a27c7122da4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c7e13adb-8584-6e24-11f3-9a27c7122da4@linaro.org>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-23_02,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

thanks for the review. Will push a v2 fixing those points.

Alain

On Thu, Jul 21, 2022 at 06:32:18PM +0200, Krzysztof Kozlowski wrote:
> On 21/07/2022 17:34, Alain Volmat wrote:
> > Add the 5 instances of spi busses supported by the stm32mp131.
> > 
> > Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> > ---
> >  arch/arm/boot/dts/stm32mp131.dtsi | 70 +++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
> > index da9e8a6ca663..db3d1b900d5c 100644
> > --- a/arch/arm/boot/dts/stm32mp131.dtsi
> > +++ b/arch/arm/boot/dts/stm32mp131.dtsi
> > @@ -97,6 +97,34 @@ scmi_shm: scmi-sram@0 {
> >  			};
> >  		};
> >  
> > +		spi2: spi@4000b000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			compatible = "st,stm32h7-spi";
> > +			reg = <0x4000b000 0x400>;
> 
> Unusual order... rather first compatible then reg.
> 
> Best regards,
> Krzysztof
