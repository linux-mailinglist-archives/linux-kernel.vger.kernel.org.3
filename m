Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF3458977E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbiHDFrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbiHDFra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568FF6112C;
        Wed,  3 Aug 2022 22:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1AD60B37;
        Thu,  4 Aug 2022 05:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64E0C433C1;
        Thu,  4 Aug 2022 05:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659592034;
        bh=oBnjJsXz4st/AhWXkw/35nnhSdryA9L3ctDSbT4kYYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PigLpKCzgDCtvZD8FGLEUp194kz1Y+ZtklAiEMS+fx2mo7ZFS3b7kBhCJncF8CP/7
         4aaU6VEzIPu/oDdwtI/SF+0/b0O1B7AmR9oAuKwRLyxjRaDsatSOewn160Es1AM7w+
         6MKSjNcZ+p7rRiuueFL9oKuWMjIrDE/fsGBMtaIrpUYytFTTdI9wnyMTZMZLaKBXrk
         g1LbKhnLQt944t8wJxRUaaoHwumlnHI+xmBtrnucihR53K/tjBmDngfc3FeEpu+gTI
         dgGmShV+CEmRllN4o1CasqE8ZROo77lYHwDhTDwBrsNJFcSgkLn7/anVrtyV3n19Tr
         PM6XQGX3/bc0Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJThn-0003RB-4d; Thu, 04 Aug 2022 07:47:35 +0200
Date:   Thu, 4 Aug 2022 07:47:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <Yutdd7kWx2sc1yQu@hovoldconsulting.com>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-6-johan+linaro@kernel.org>
 <CAL_JsqL5ZCzfd06rxOdQodFjk4G3QpDCsxA5heM71x0q5d-hCw@mail.gmail.com>
 <YuokOn0KHEqv/CR4@hovoldconsulting.com>
 <20220803232644.GA2806113-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803232644.GA2806113-robh@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 05:26:44PM -0600, Rob Herring wrote:
> On Wed, Aug 03, 2022 at 09:31:06AM +0200, Johan Hovold wrote:
> > On Tue, Aug 02, 2022 at 11:17:22AM -0600, Rob Herring wrote:
> > > On Tue, Aug 2, 2022 at 9:14 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> > 
> > > > It should also not be used to
> > > > work around Linux driver implementation issues such as how to coordinate
> > > > the glue and core dwc3 drivers.
> > > >
> > > > For the Qualcomm dwc3 controllers, it is the glue device that manages
> > > > the wakeup interrupts, which may or may not be able to wake the system
> > > > up from system suspend.
> > > 
> > > While the reasoning to add this may have been for QCom, having this
> > > property for other users makes sense. On some platforms, 'snps,dwc3'
> > > is the only node (i.e. there's no wrapper node). So I don't think this
> > > should be reverted.
> > 
> > Fair enough. Let's keep it in the core child node then where we can
> > still retrieve from the glue parent directly.
> > 
> > (I assume you're not suggesting also adding 'wakeup-source' to the qcom
> > glue node, which is where the actual wakeup interrupts live.)
> 
> 'wakeup-source' belongs wherever the interrupt that causes wakeup is 
> defined.

Thanks for clarifying. That was my understanding as well, but I
misinterpreted your wish to keep the 'wakeup-source' property also in
the core node.

My thought was that if it turns out that there are systems that do not
use a glue node but that do indeed support wakeup, then such a property
could be added back later.

But let's keep it in the binding then.

Johan
