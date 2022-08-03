Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10275887FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiHCHbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbiHCHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:30:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E79FF2;
        Wed,  3 Aug 2022 00:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B8F9B821A5;
        Wed,  3 Aug 2022 07:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E87C433C1;
        Wed,  3 Aug 2022 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659511848;
        bh=TyMeEqWBu5IifHReIBRw1bgA+Mfnb0FI1r7G9D1jkLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABFSsOPJVQ0vYhOl0vmk1f9ZZRJ2Jgb9fm+bK4TccFFZg1kKdvTJA+TdRy73eFCuv
         QoLYn4wuL+y2ZMpQVyJwESGS+RP1Zq/+d7a/SFs/VXtI2JiK1e1s9B/MwjVPqkJ9NH
         fGD0MyfqyoddyH/32g6Vfmf3f2C/94xNFRFKDgvQJJLZbh/UxKXOJn26cGXTughDz8
         VV5a7kzy1kE9iVJLD6uDJS3ZCMMX9R9Af/C97KPQXx6i4WMwEi1g7hg14DXrPO3sXh
         1LrRxqXCXuv1bHBcWQqYaA/XgIkoDDwUGJPJ8SZ+RfsPmandC9GpMN0K+S5VcA7hmc
         P4mSt0rBdUP4Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJ8qQ-0004OS-Mm; Wed, 03 Aug 2022 09:31:06 +0200
Date:   Wed, 3 Aug 2022 09:31:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] Revert "dt-bindings: usb: dwc3: Add wakeup-source
 property support"
Message-ID: <YuokOn0KHEqv/CR4@hovoldconsulting.com>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-6-johan+linaro@kernel.org>
 <CAL_JsqL5ZCzfd06rxOdQodFjk4G3QpDCsxA5heM71x0q5d-hCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL5ZCzfd06rxOdQodFjk4G3QpDCsxA5heM71x0q5d-hCw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:17:22AM -0600, Rob Herring wrote:
> On Tue, Aug 2, 2022 at 9:14 AM Johan Hovold <johan+linaro@kernel.org> wrote:

> > It should also not be used to
> > work around Linux driver implementation issues such as how to coordinate
> > the glue and core dwc3 drivers.
> >
> > For the Qualcomm dwc3 controllers, it is the glue device that manages
> > the wakeup interrupts, which may or may not be able to wake the system
> > up from system suspend.
> 
> While the reasoning to add this may have been for QCom, having this
> property for other users makes sense. On some platforms, 'snps,dwc3'
> is the only node (i.e. there's no wrapper node). So I don't think this
> should be reverted.

Fair enough. Let's keep it in the core child node then where we can
still retrieve from the glue parent directly.

(I assume you're not suggesting also adding 'wakeup-source' to the qcom
glue node, which is where the actual wakeup interrupts live.)

The glue and core parts needs to work in concert even if the current
implementation tends to make that harder than it should be.

Johan
