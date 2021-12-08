Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0746CE11
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbhLHHHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244404AbhLHHHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:07:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506CCC061746;
        Tue,  7 Dec 2021 23:03:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11F74B812A8;
        Wed,  8 Dec 2021 07:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D23C00446;
        Wed,  8 Dec 2021 07:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638947035;
        bh=5TmFVWRIzPpL2pMVgyA/URIEo5/RPZX10R8V/Ivoc3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkmMoCfTc3gesuK/ROahJZ8dAqy/90AjlWlrZ9X7UNnV96VCeesVtPNkxWkJU5GrN
         b0QCk3Btc9O9g4EtQS29bFTma+I1NlfnKafjJYfhTIBlkWK3wAycFz2+zDxdjUjmiX
         Ncek0oV7yqYIWl+kEggLpXBsCwrp7HvfxYGsXP9l7yzaXTgjcdLlmZGzzrMqBAUPG9
         CAR1M7weAOUtZSUSF0wdHYTZTtkuJZuqywKzYl1bIlE90bwh+fpE308QwmaFTlpOcw
         bspmW+DY7RoQG6CAHOLUdchdfBSYwu3xHOWJKeDTMf1Uw6aqQ8NcQ7SJvKFNNNBQUY
         wk8t8Lo18hUOw==
Date:   Wed, 8 Dec 2021 12:33:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM8450 DT
 bindings
Message-ID: <YbBY16TxTwdGUpkY@matsya>
References: <20211201072557.3968915-1-vkoul@kernel.org>
 <20211201072557.3968915-2-vkoul@kernel.org>
 <Ya/UYuHYD+Uc2B+F@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya/UYuHYD+Uc2B+F@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-12-21, 15:38, Rob Herring wrote:
> On Wed, Dec 01, 2021 at 12:55:56PM +0530, Vinod Koul wrote:
> > The Qualcomm SM8450 SoC has several bus fabrics that could be
> > controlled and tuned dynamically according to the bandwidth demand
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
> >  .../dt-bindings/interconnect/qcom,sm8450.h    | 171 ++++++++++++++++++
> >  2 files changed, 182 insertions(+)
> >  create mode 100644 include/dt-bindings/interconnect/qcom,sm8450.h
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > index 3fd1a134162d..cbb24f9bb609 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > @@ -104,6 +104,17 @@ properties:
> >        - qcom,sm8350-mmss-noc
> >        - qcom,sm8350-compute-noc
> >        - qcom,sm8350-system-noc
> > +      - qcom,sm8450-aggre1-noc
> > +      - qcom,sm8450-aggre2-noc
> > +      - qcom,sm8450-clk-virt
> > +      - qcom,sm8450-config-noc
> > +      - qcom,sm8450-gem-noc
> > +      - qcom,sm8450-lpass-ag-noc
> > +      - qcom,sm8450-mc-virt
> > +      - qcom,sm8450-mmss-noc
> > +      - qcom,sm8450-nsp-noc
> > +      - qcom,sm8450-pcie-anoc
> > +      - qcom,sm8450-system-noc
> >  
> >    '#interconnect-cells':
> >      enum: [ 1, 2 ]
> > diff --git a/include/dt-bindings/interconnect/qcom,sm8450.h b/include/dt-bindings/interconnect/qcom,sm8450.h
> > new file mode 100644
> > index 000000000000..786fce091c84
> > --- /dev/null
> > +++ b/include/dt-bindings/interconnect/qcom,sm8450.h
> > @@ -0,0 +1,171 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> Dual license.
> 
> Can Qualcomm/Linaro please get their licensing in order.

Yes I will get that fixed, this one should be dual..

-- 
~Vinod
