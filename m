Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5FF554C97
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358199AbiFVOQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358162AbiFVOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:15:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F36393F5;
        Wed, 22 Jun 2022 07:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAE01B81F31;
        Wed, 22 Jun 2022 14:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824FEC34114;
        Wed, 22 Jun 2022 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655907315;
        bh=OR7xiTCWZs1tjxHWPG20iS6R15OoZpcmvJbr8d4jd0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+Iz6+HniIaTGnxsu76Y1gwTDILMFU8si5DqybZK+lWvIPucw/FbW2BM5nq0AbAOT
         x05bP8sk04ZgZTR9lXHMq18vKi9rguum7xWKGJH8WNZTnSHrmzObQzPxwnh/l64WbL
         AuGsHUk59tKIjzEKUtltV7E0oKQSCyOf90GxMZeEsNt3MoN4rpBBV9rkqdDToF0zRo
         QeC+IMpB/AsuIAD/EtbhYPkqt9/iT0P8HZ5e5Hz9bZCvuyTUZd1idY23fk21sG6Znu
         GlUHbPTpgR1qMmlCMnXXm7/mwYs6k7m9nB2uxwVGsTTqiMJdG6d7yJhtn2Qk4/TtnQ
         RZW/yQX/FE2Lw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o418S-0006kJ-N9; Wed, 22 Jun 2022 16:15:12 +0200
Date:   Wed, 22 Jun 2022 16:15:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: add SA8540P and ADP
Message-ID: <YrMj8HS2aMexHHLx@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-6-bjorn.andersson@linaro.org>
 <8fc661d7-6f75-59d8-fa19-76193ed2f4fe@somainline.org>
 <YrMc0Y7PIDQpP2xw@hovoldconsulting.com>
 <f7e066d0-3493-f531-3357-10dca20e1f95@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e066d0-3493-f531-3357-10dca20e1f95@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:11:15PM +0200, Krzysztof Kozlowski wrote:
> On 22/06/2022 15:44, Johan Hovold wrote:
> > On Wed, Jun 22, 2022 at 02:37:02PM +0200, Konrad Dybcio wrote:
> >> On 22.06.2022 06:12, Bjorn Andersson wrote:
> > 
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> >>> @@ -0,0 +1,427 @@
> >>> +// SPDX-License-Identifier: BSD-3-Clause
> >>> +/*
> >>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> >>> + * Copyright (c) 2022, Linaro Limited
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +
> >>> +#include <dt-bindings/gpio/gpio.h>
> >> Can be moved to SoC dtsi.
> > 
> > No, the SoC dtsi does not use any defines from that header file.
> 
> Even if the DTSI used these constants, it is a good practice to include
> headers in each file using them. The same as we always do for C code.

Yes, that's what I said in my slightly more verbose answer to the same
comment to one of the other patches.

Johan
