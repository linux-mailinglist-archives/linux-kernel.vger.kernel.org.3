Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5B46BFE9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhLGPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhLGPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:55:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE6C061574;
        Tue,  7 Dec 2021 07:51:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B8543CE1B60;
        Tue,  7 Dec 2021 15:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12039C341C1;
        Tue,  7 Dec 2021 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638892291;
        bh=N8C2cyy1aD6EBxvqHRKefgoAmGh3QwqytD9RR4kkMSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhFfo/o/NRdp/79Q7xADbNnEKHjOlVkNDsWwWhiEAMEgUudTaeIL15p/RGc7gC+Yg
         CaL9oi8XZk9UJCzgk1pEew8HRhr50XEx+E5VryMBE0aFXW9Xwf/xykZj1PL8cBO2Az
         ++iQZYtDb2SC2HRp7bGTjwfR5msmabgSVUINflCKl2WnGgfsY9bzwGgu88Qi6WBN39
         GRHgrZXnK1+79SZ3asiEkJJYg9DgHCqu8XvPkm4GHQgDZybAHu+ZwTeQ9Nl8ECeDsI
         9ZbGt8I7BGeAE28tCYA9peq00w8EJn0cyOGDX4n2bXGjMHSbw6PgijGEJH1zQg6Pdh
         t3ragvQxFho7w==
Date:   Tue, 7 Dec 2021 21:21:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] arm64: dts: qcom: sm8450-qrd: include pmic files
Message-ID: <Ya+C/+VRENHfJARo@matsya>
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-13-vkoul@kernel.org>
 <eb2373bc-f9f5-d97a-13ec-d3d580566101@somainline.org>
 <Ya94IRoUg4ArHjSO@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya94IRoUg4ArHjSO@ripper>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-12-21, 07:05, Bjorn Andersson wrote:
> On Wed 01 Dec 07:23 PST 2021, Konrad Dybcio wrote:
> 
> > 
> > On 01.12.2021 08:29, Vinod Koul wrote:
> > > SM8450 QRD platform has bunch of PMICs, include the common ones PM8350,
> > > PM8350b and PMR735b
> > >
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > > index 3e65d662ab8c..48228888f500 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > > @@ -8,6 +8,9 @@
> > >  #include <dt-bindings/gpio/gpio.h>
> > >  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > >  #include "sm8450.dtsi"
> > > +#include "pm8350.dtsi"
> > > +#include "pm8350b.dtsi"
> > > +#include "pmr735b.dtsi"
> > >  
> > >  / {
> > >  	model = "Qualcomm Technologies, Inc. SM8450 QRD";
> > >
> > Again, this could have gone into a single "add board DTS" patch, but this
> > 
> > works too, I guess..
> > 
> 
> I like that suggestion, putting the qrd.dts as a single patch at the end
> of the series would look nice.

I can do that.. I think I would do a dts patch but would keep
regulator one separate..

-- 
~Vinod
