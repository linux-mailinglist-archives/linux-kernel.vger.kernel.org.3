Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162B046591D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353551AbhLAW2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:28:13 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:60165 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353470AbhLAW2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638397491; x=1669933491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=crTZ2a/2yB7/AUlebdFt1Mo2mkX4VhYfwG1XMxzOUb4=;
  b=ZqpcNdEk4jCogH6yVGIXnE0D5Zm/tj0qe6ZUppEIKONIKMPDgST++Bl2
   kwUEqHv+jyUIqx6Y7221pcFVXxvS0h1N43wML4lG3xivVypgc2FIUKLE7
   TwnfXEHSPCMJvhveZdbB7OwyIb4Jrc7WrrxxeehMVfRNWkmUT/ZUQT3Za
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Dec 2021 14:24:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 14:24:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 14:24:49 -0800
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 1 Dec 2021
 14:24:48 -0800
Date:   Wed, 1 Dec 2021 14:24:47 -0800
From:   Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add SDX65 pinctrl
 bindings
Message-ID: <20211201222447.GA586@quicinc.com>
References: <cover.1637048107.git.quic_vamslank@quicinc.com>
 <06234768890dc7572226f23d432e5a69a4d5b305.1637048107.git.quic_vamslank@quicinc.com>
 <YaFZTxDcTMqeA/42@robh.at.kernel.org>
 <CACRpkdYpCmhXhJV1x42hu6QoncXX7eWcGPk22de19sSEC7B=oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdYpCmhXhJV1x42hu6QoncXX7eWcGPk22de19sSEC7B=oQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 01:07:16AM +0100, Linus Walleij wrote:
> On Fri, Nov 26, 2021 at 11:01 PM Rob Herring <robh@kernel.org> wrote:
> > On Mon, Nov 15, 2021 at 11:39:45PM -0800, quic_vamslank@quicinc.com wrote:
> > > From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> > >
> > > Add device tree binding Documentation details for Qualcomm SDX65
> > > pinctrl driver.
> > >
> > > Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 195 ++++++++++++++++++
> > >  1 file changed, 195 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
> >
> > This fails dt_binding_check:
> >
> > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.example.dt.yaml: pinctrl@f100000: 'serial-pins', 'uart-w-subnodes-state' do not match any of the regexes: '$-state', 'pinctrl-[0-9]+'
> >         From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
> >
> > The DT list was not Cc'ed so checks never ran nor was this reviewed.
> 
> OK that's annoying, I didn't notice it wasn't posted to the DT list.
> I reverted the patch, Vamsi can you please reiterate the patch
> and include devicetree@vger.kernel.org on subsequent postings.
> I have kept the kernel code in place, optimistically assuming the
> bindings will be fixed soon-ish.

I'm sorry for overlooking this. I will fix this and post a new patch soon.

Thanks,
Vamsi
> 
> Yours,
> Linus Walleij
