Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7417D57DEB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiGVJdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiGVJdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:33:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826B2DA5FD;
        Fri, 22 Jul 2022 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658481732; x=1690017732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cXYoAQfzHqIkqRatI1Z+3s2u1CFs8OJ8WmJ6anWvBso=;
  b=FwvXV76oZC/d+pKvfkBGx/MMlgV/PWeBDxJ/dtR5eMoNYdqQh0EC4GSX
   e2rLee9u1Jge3Duog3L2HNuJLfValMlwIwBLhGNwQPdrOb22vzDgB2Z3J
   3ASJPl2C21CSB9PA04tcymqPYTX6Kh+zTegovZGA+11oprF1kxMQF7An2
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Jul 2022 02:22:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 02:22:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 02:22:10 -0700
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 02:22:07 -0700
Date:   Fri, 22 Jul 2022 14:52:03 +0530
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: introduce sa8540p-ride dts
Message-ID: <20220722092203.GA12635@hu-ppareek-blr.qualcomm.com>
References: <20220721154057.15276-1-quic_ppareek@quicinc.com>
 <d960d442-4b0a-ef33-04da-8fe3a3c8fb90@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d960d442-4b0a-ef33-04da-8fe3a3c8fb90@somainline.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:41:34PM +0200, Konrad Dybcio wrote:
> 
> Hello!
> 
> On 21.07.2022 17:40, Parikshit Pareek wrote:
> > Create new dts file specific for Qdrive board based on sa8540p chipset.
> Is the SA8540P any different than SA8295P? My wild guess is that they're
> binned versions of each other with different DVFS levels.. That could
> use a separate SoC DTSI to hold these differences should that be true..
> 
> 
> > Introduce common dtsi file sa8295p-adp.dtsi, to be included for adp and
> > Qdrive board.
> > 
> > Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 378 +----------------
> >  arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi     | 385 ++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts |  15 +
> >  4 files changed, 403 insertions(+), 376 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi
> >  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index 9e2a13d75f9d..fa0abcf7660b 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
> > +dtb-$(CONFIG_ARCH_QCOM) += sa8540p-adp-ride.dtb
> This needs to be a tab.
> 
> 
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > index 9398f0349944..adb6637117bc 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > @@ -2,388 +2,14 @@
> >  /*
> >   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> >   * Copyright (c) 2022, Linaro Limited
> > + * Copyright (c) 2022 Qualcomm Innovaion Center, Inc. All rights reserved.
> Please add a comma after the year to keep it consistent.
> 
> 
> >   */
> >  
> >  /dts-v1/;
> 
> [...]
> 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi b/arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi
> > new file mode 100644
> > index 000000000000..75ef77b7cac1
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi
> Are the boards based on each other? Or on a similar base platform?
> Maybe sa8295p/sa8540p/sasomethingelse-automotive.dtsi could be a 
> better name in the latter case?
Thanks, agreed.
> 
> 
> [...]
> 
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2022, Linaro Limited
> > + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sa8295p-adp.dtsi"
> > +
> > +/ {
> > +	model = "Qualcomm SA8540 ADP";
> So "Qdrive board" == SA8540 ADP == SA8540 ADP Ride? Or is there
> a base platform for all of them? Maybe the Qdrive is simply based
> on the ADPs? Is there a clear distinction between ADP and ADP Ride?
Yes, Qdrive board" == SA8540 ADP == SA8540 ADP Ride. ADP is common to
many boards, one being Qdrive or ADP ride.
> 
> Konrad
> 
> > +	compatible = "qcom,sa8540p-adp-ride", "qcom,sa8540p";
> > +};

Regards,
Parikshit Pareek
