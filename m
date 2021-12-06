Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8390B469047
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 06:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhLFGBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbhLFGBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:01:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DE5C0613F8;
        Sun,  5 Dec 2021 21:58:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11A25611AB;
        Mon,  6 Dec 2021 05:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945BEC341C2;
        Mon,  6 Dec 2021 05:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638770298;
        bh=xUyeOfDWCmhl+OkbPQiV6GQlxjknO51Ug8n+l8xaFm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/g4n4uj1r/B5nx1bDJXe6d3csmDEsZRzl+lVxdw3EQ9zT1yJ/dn125yYhglw4HwG
         cffg+Rvpc4pir0fM71/GmAoU74MljEsJW7p7+s79SakEIBvZaq5Exq18UuzDNhKGM7
         Mxgj36FiPMCb5YUBcCbmop3MBF3oFQ5v3Z7mwpbk27Z8NRc78ewI0kBlmfvhjLTV4b
         eFCcxayNYEKFgT/eseYjaHtldtKXBiOTSDz2av84GouDnhL2hf+rqDHtpjw4vCzluH
         oIOyiZnbk0jgDnC366Vo+DFFwv5lKaN6Vzh/o4ot1iZLpvE2DjejgWGd3BMOd8sCWK
         A6GDDUDmmNcvw==
Date:   Mon, 6 Dec 2021 11:28:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] arm64: dts: qcom: sm8450-qrd: enable ufs nodes
Message-ID: <Ya2mdlhWCmgiAvvK@matsya>
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-10-vkoul@kernel.org>
 <bef7e4bf-6d4d-c665-b96a-84b28ed19a33@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef7e4bf-6d4d-c665-b96a-84b28ed19a33@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-12-21, 16:18, Konrad Dybcio wrote:
> 
> On 01.12.2021 08:29, Vinod Koul wrote:
> > Enable the UFS and phy node and add the regulators used by them.
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > index 218eb3ce1ee5..3e65d662ab8c 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> > @@ -5,6 +5,7 @@
> >  
> >  /dts-v1/;
> >  
> > +#include <dt-bindings/gpio/gpio.h>
> 
> This should probably go to the SoC DTSI, as it's generally used
> 
> in every DT if you have anything more than serial console working..

But arent the gpios added in board dts typically? I am okay either
way... Bjorn where would you like this to be..?
Seems like we have this is both board as well as SoC DTS
> 
> 
> Konrad

-- 
~Vinod
