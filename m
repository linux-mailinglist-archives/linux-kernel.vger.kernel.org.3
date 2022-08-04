Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1847589890
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiHDHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiHDHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:40:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED422B3B;
        Thu,  4 Aug 2022 00:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D294B82245;
        Thu,  4 Aug 2022 07:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7ADC433C1;
        Thu,  4 Aug 2022 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659598824;
        bh=Ah06rLZ4P9R/uZ+rl/z6T5V8R+Zu0TXa61Ms+9cM+e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6Zy3n5vwolf1+DFA4lW+ulv1MkhFPGNi5yg2HtakmJBeXRq/SLpxEX8gz4wSmVIs
         goi0xzpQ7jM5uE+3IKwF66oxwe0hUqycy619LVWITrAR/E8hLRdLNFAW+d2/MahrV4
         Yz3SckBbkiYTiJuhv9QstOmIKZH/iBplZ/S5s3jIZK1pIC6Jgot6zjJwnUeN5wyxPe
         YR+EhOJAuhc74CXFrWmh24WSKnsUi/ESVopK5V03O03sBxlwxJAnjW1MoncLOncZmT
         +PsI0kCuJ7ndTQAk4tNg8jqY+HfPxrbi8jvC9MNE3GWj6HLUEuiHesY0gBksmj+wNT
         tpLIRqjd5I9dQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJVTI-00038p-QO; Thu, 04 Aug 2022 09:40:44 +0200
Date:   Thu, 4 Aug 2022 09:40:44 +0200
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
Message-ID: <Yut3/PA/ClacgJsw@hovoldconsulting.com>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-6-johan+linaro@kernel.org>
 <CAL_JsqL5ZCzfd06rxOdQodFjk4G3QpDCsxA5heM71x0q5d-hCw@mail.gmail.com>
 <YuokOn0KHEqv/CR4@hovoldconsulting.com>
 <20220803232644.GA2806113-robh@kernel.org>
 <Yutdd7kWx2sc1yQu@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yutdd7kWx2sc1yQu@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 07:47:35AM +0200, Johan Hovold wrote:
> On Wed, Aug 03, 2022 at 05:26:44PM -0600, Rob Herring wrote:
> > On Wed, Aug 03, 2022 at 09:31:06AM +0200, Johan Hovold wrote:
> > > On Tue, Aug 02, 2022 at 11:17:22AM -0600, Rob Herring wrote:
> > > > On Tue, Aug 2, 2022 at 9:14 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> > > 
> > > > > It should also not be used to
> > > > > work around Linux driver implementation issues such as how to coordinate
> > > > > the glue and core dwc3 drivers.
> > > > >
> > > > > For the Qualcomm dwc3 controllers, it is the glue device that manages
> > > > > the wakeup interrupts, which may or may not be able to wake the system
> > > > > up from system suspend.
> > > > 
> > > > While the reasoning to add this may have been for QCom, having this
> > > > property for other users makes sense. On some platforms, 'snps,dwc3'
> > > > is the only node (i.e. there's no wrapper node). So I don't think this
> > > > should be reverted.
> > > 
> > > Fair enough. Let's keep it in the core child node then where we can
> > > still retrieve from the glue parent directly.
> > > 
> > > (I assume you're not suggesting also adding 'wakeup-source' to the qcom
> > > glue node, which is where the actual wakeup interrupts live.)
> > 
> > 'wakeup-source' belongs wherever the interrupt that causes wakeup is 
> > defined.
> 
> Thanks for clarifying. That was my understanding as well, but I
> misinterpreted your wish to keep the 'wakeup-source' property also in
> the core node.
> 
> My thought was that if it turns out that there are systems that do not
> use a glue node but that do indeed support wakeup, then such a property
> could be added back later.
> 
> But let's keep it in the binding then.

I realise it may not have been clear that the patch I suggested to
revert was first merged for 6.0-rc1, in case that makes any difference.

But I'll drop the revert unless I hear otherwise.

Johan
