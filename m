Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D12554B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357134AbiFVNo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiFVNoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:44:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D913F52;
        Wed, 22 Jun 2022 06:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4FF3CCE2066;
        Wed, 22 Jun 2022 13:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7259C34114;
        Wed, 22 Jun 2022 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655905491;
        bh=2qbKAxqW2ws2XcFv1gsXDg34ZprSbqIL5RPQVdld81E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p85ya3JaXiKlis3yd68bMW0W9XBWEMW5+gSgmEnutc0Sk85n3Xcfevxl0k1m6287M
         L2cJjkmu40yFPBfz6jQCW6EOfVUpYn3ZEhNsGQ7gEMEgLEDLbscf6bV6/Cg1n6h62R
         7Lfrpra9nkIk604sMj5I5XMmp4n2Htz+ciH9xi1x2PpTx2u4eaC8jFUdrNJnxhQzh1
         eJcIIXVT9QWTsCvMj42rTpH22bNA4h9wDUoB0lgbnVSTjOrp7nh0yOkrK8M6adhSFN
         epOx2m7WFZlyF80dCW5P/s8547Wrmx29F7YC9tL2IIroFoVW+GbEA11jJZXK184awL
         /NMA6tXqkf9hw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o40f3-0006Xn-5n; Wed, 22 Jun 2022 15:44:49 +0200
Date:   Wed, 22 Jun 2022 15:44:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: add SA8540P and ADP
Message-ID: <YrMc0Y7PIDQpP2xw@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-6-bjorn.andersson@linaro.org>
 <8fc661d7-6f75-59d8-fa19-76193ed2f4fe@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc661d7-6f75-59d8-fa19-76193ed2f4fe@somainline.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:37:02PM +0200, Konrad Dybcio wrote:
> On 22.06.2022 06:12, Bjorn Andersson wrote:

> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > @@ -0,0 +1,427 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2022, Linaro Limited
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> Can be moved to SoC dtsi.

No, the SoC dtsi does not use any defines from that header file.

> > +#include <dt-bindings/input/gpio-keys.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > +#include <dt-bindings/spmi/spmi.h>

> > +
> > +/* PINCTRL */
> Seems redundant.

See my previous answer to this.

Johan
