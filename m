Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646F2465942
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353606AbhLAWa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:30:29 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:17042 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353610AbhLAWaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638397624; x=1669933624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AMYlyWRGk0rGyJ8aOEHYyVAkZ0ZG0osDorr4K/cqWvQ=;
  b=ULQTbgZz1z3aOzvCR1XCX92sxQQKOTE2+O4FVLjlsXX7CBHPOv3hkc9V
   UyA42k15SXtlXXghHCtl4r5A8tZbz+547HOxgCSrXlAWyIs9sc64HFZqv
   CwbLg6iU+t/Ol/+WtCFavOXFneExMP/9YZjcYIghTz0ZZLUYxdDgPYHz9
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Dec 2021 14:27:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 14:27:01 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 14:26:40 -0800
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 1 Dec 2021
 14:26:40 -0800
Date:   Wed, 1 Dec 2021 14:26:38 -0800
From:   Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v5 6/6] dt-bindings: clock: Introduce pdc bindings for
 SDX65
Message-ID: <20211201222638.GB586@quicinc.com>
References: <cover.1637302009.git.quic_vamslank@quicinc.com>
 <538438f41153587043741747db5218e9f575c0f5.1637302009.git.quic_vamslank@quicinc.com>
 <YaF2eBKMkIvGapCY@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YaF2eBKMkIvGapCY@ripper>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 04:06:16PM -0800, Bjorn Andersson wrote:
> On Thu 18 Nov 22:11 PST 2021, quic_vamslank@quicinc.com wrote:
> 
> > From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> > 
> > Add compatible for SDX65 pdc.
> > 
> > Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> 
> Sorry for not spotting this before, but as you can tell from the path of
> the file you're changing, this has nothing to do with "clocks".
> 
> git log on qcom,pdc.txt shows that $subject should be:
> 
>   dt-bindings: qcom,pdc: Add compatible for SDX65
> 
> Also, as this is unrelated to clocks, Stephen is not going to merge this
> patch. You will have to repost it, with Marc Zyngier as recipient to get
> it merged; per get_maintainer.
> 
> 
> I think it's fine to keep the reviews and acks while adjusting $subject
> and reposting this patch  - separate from the other 5 patches.

Thank you for the review. Will repost this as a new patch.

Thanks,
Vamsi
> 
> Thanks,
> Bjorn
> 
> > ---
> >  .../devicetree/bindings/interrupt-controller/qcom,pdc.txt        | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> > index 98d89e53013d..ce631d853db4 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> > @@ -23,6 +23,7 @@ Properties:
> >  		    - "qcom,sdm845-pdc": For SDM845
> >  		    - "qcom,sdm8250-pdc": For SM8250
> >  		    - "qcom,sdm8350-pdc": For SM8350
> > +		    - "qcom,sdx65-pdc": For SDX65
> >  
> >  - reg:
> >  	Usage: required
> > -- 
> > 2.33.1
> > 
