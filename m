Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053D9469044
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 06:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhLFF5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 00:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbhLFF5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 00:57:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA61C0613F8;
        Sun,  5 Dec 2021 21:53:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CC59B80FAC;
        Mon,  6 Dec 2021 05:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D7FC341C4;
        Mon,  6 Dec 2021 05:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638770017;
        bh=i9XFs4nrGRb2QLJHobGekhAGFvqfHOhbrTS/fO7WAi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqFVoVuN5cdAgtTuw99pkAcd1W2D0ZtTr7MyC5gbEzXUklC7MXgkTW6CqhZE0MxVG
         /VNbW4hSF2jKC70FMDoLvokeMHAI3se8gJZ71rsYLudIIHS+j6jCBwZnavkkKYaNgj
         OCcBVmt5KzuFtHkwaF5P9ZbNsEqiyrwGyihrtxHWChhpObVYsU2wvPEdB/JQIehSF3
         1RkPpfmqqZ5RSnCrSkD3C6pk/wY0Ksr279xk8Bv0Fpix8s0GomE5Cm7znRlMOlzHXJ
         sarEC+aPYXs/cGGBM/hBXF1/weoILARzHunXiRhYvBQfBu4yyG69lFVTip3Bb2Rj1q
         J2abFtSWPtWNg==
Date:   Mon, 6 Dec 2021 11:23:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] arm64: dts: qcom: sm8450-qrd: Add reserved gpio
 range for QRD
Message-ID: <Ya2lXXDzN83pYxqn@matsya>
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-5-vkoul@kernel.org>
 <7449e40f-d8ac-3ee9-c453-163c1310ca9d@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7449e40f-d8ac-3ee9-c453-163c1310ca9d@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-12-21, 16:07, Konrad Dybcio wrote:
> 
> On 01.12.2021 08:29, Vinod Koul wrote:
> > Some tlmm gpios are reserved, so mark them as such in QRD DTS
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > index 127d32502555..8dcd41c4e5ab 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > @@ -24,6 +24,10 @@ &qupv3_id_0 {
> >  	status = "okay";
> >  };
> >  
> > +&tlmm {
> > +	gpio-reserved-ranges = <28 4>, <36 4>;
> > +};
> > +
> >  &uart7 {
> >  	status = "okay";
> >  };
> >
> Personally I'd squash this into the patch that introduced the DT and

I feel it is the right things to do, a patch should not touch a
different file. soc dts and board dts and two different entities and
should be patched separately!

> move it to the end of the series, but I reckon it's fine either way..
> 
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Thanks for the detailed review.

-- 
~Vinod
