Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51B958B738
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiHFRJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 13:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHFRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 13:09:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3137CE0E3;
        Sat,  6 Aug 2022 10:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0B17B8055F;
        Sat,  6 Aug 2022 17:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBFDC433D6;
        Sat,  6 Aug 2022 17:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659805757;
        bh=3IaGu2oBhS+OaZaEspVsjKtafiJKtrRdiWBzpL6AIN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNh2Cja2wey/saX8ZVQ33r/c1kMBgmxkH4if/QfP4pkTkcLXAqrAEJoKIy5bzXwfe
         vl/TbXcA4rmRAWKnd38E7oUAwfg5WifMcIv90l4+PygLa3AG/1D9Bn3PNTexvCw+Hj
         54aiizOHU5oUMuQxJWXS7Kp8VfBFjdboW8OqGMfXZa+54jr5s9xGoo/vPL8H/dGzeq
         TVUqjmE1gCuIMw9pd9MDMXon9suo0lCggid/Vzvs5Z1pWJx733vAkOTDecB7wJ4YcR
         SHgjzjxFtYmK9tVG5SKPlofSU09fhU035q1aW3Rpb5ShNyYdxXajr/DCvlRNN+m7Ov
         HXySMQc0tKTIA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oKNJ2-0003Xr-CD; Sat, 06 Aug 2022 19:09:45 +0200
Date:   Sat, 6 Aug 2022 19:09:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 7/9] dt-bindings: usb: qcom,dwc3: add wakeup-source
 property
Message-ID: <Yu6gWHt5BphADaNR@hovoldconsulting.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-8-johan+linaro@kernel.org>
 <20220806150848.GH14384@thinkpad>
 <Yu6ZwePzzkl7tewV@hovoldconsulting.com>
 <20220806165238.GM14384@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806165238.GM14384@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 10:22:38PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Aug 06, 2022 at 06:41:37PM +0200, Johan Hovold wrote:
> > On Sat, Aug 06, 2022 at 08:38:48PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Aug 04, 2022 at 05:09:59PM +0200, Johan Hovold wrote:
> > > > Add a wakeup-source property to the binding to describe whether the
> > > > wakeup interrupts can wake the system from suspend.
> > > > 
> > > > Acked-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > 
> > > So this is based on the fact that Qcom glue wrapper is supplying the wakeup
> > > interrupts. But isn't it possible that on other platform, the DWC IP can supply
> > > wakeup interrupts?
> > 
> > Yeah, possibly, and that's why Rob suggested keeping the 'wakeup-source'
> > property also in the core node.
> > 
> > > In the driver, the wakeup-source parsing has been moved to the Qcom glue driver.
> > > But this contradicts with the binding.
> > 
> > That's irrelevant. The core driver does not implement wakeup support. It
> > was just added as a hack for the Qualcomm driver, and you won't get
> > wakeup-capability for other platforms by just parsing the property in
> > the core driver.
> > 
> > When/if wakeup support for such a platform is added, then the core
> > driver may need to look at the property again.
> > 
> 
> My point is, the platform drivers are free to add "wakeup-source" property in
> the DWC node. Then in that case, the DWC driver should handle the capability,
> isn't it?

No, not really. They wouldn't violate the current binding, but it would
arguably still be wrong to do so unless that platform actually supports
wakeup without involvement from a glue layer.

Perhaps we should reconsider reverting the binding update adding this
property to the core node and only add it selectively for the platforms
for which is actually applies (if they even exist).

> I know it is broken currently, but moving the wakeup parsing code is not
> helping either.

It's not even broken. It has never even been implemented.

Just because someone added a hack that should probably never have been
merged in the first place, doesn't mean we should somehow pretend that
we support it.

> And... I'm aware of the fact that the binding should describe the hardware and
> not the limitation of the driver. So perhaps we should document it in the
> driver as a TODO or something?

I'd rather just revert the binding update to avoid having discussions
like this. We don't even know if it's possible to support on any
platform yet (and remember that none of this has even been in an rc
release yet).

Johan
