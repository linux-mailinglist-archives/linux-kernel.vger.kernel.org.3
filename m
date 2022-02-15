Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C244B7741
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbiBOSzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:55:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiBOSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:55:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07D7DF4B2;
        Tue, 15 Feb 2022 10:55:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C865B81C38;
        Tue, 15 Feb 2022 18:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D2BC340EB;
        Tue, 15 Feb 2022 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644951321;
        bh=gfU6juJAppsF7FTy6N8V5lW5Ezbm9GSdyT28JV/ZGvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w755QU6OcIzIK8XG76gj1td78Gi9gbqLkL+9HHdYMQh57QegPGogLInVFP5jGJWEX
         fxFkxlIZAmPql2ebDtEMXaXhCIK5GN4skyJjivbcdA5sn2sO40/m/j2pp4Pp9mFSpk
         jiK4bpO+IDqNt4nOMg6mDIfHkdfc4SD6fUNCcvkk=
Date:   Tue, 15 Feb 2022 19:55:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v20 5/5] arm64: dts: qcom: sc7180-trogdor: Add nodes for
 onboard USB hub
Message-ID: <Ygv3FSDS/fq1oePy@kroah.com>
References: <20220119204345.3769662-1-mka@chromium.org>
 <20220119124327.v20.5.Ie0d2c1214b767bb5551dd4cad38398bd40e4466f@changeid>
 <YgJMkFAxjazkUDZd@kroah.com>
 <YgLCswtX/0THkzXT@google.com>
 <CAD=FV=WMP8M5HTRNv9_scvrytbpE0iBdUack=XaHoypGNLJeVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WMP8M5HTRNv9_scvrytbpE0iBdUack=XaHoypGNLJeVA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 09:54:54AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Tue, Feb 8, 2022 at 11:21 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Tue, Feb 08, 2022 at 11:57:20AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Jan 19, 2022 at 12:43:45PM -0800, Matthias Kaehlcke wrote:
> > > > Add nodes for the onboard USB hub on trogdor devices. Remove the
> > > > 'always-on' property from the hub regulator, since the regulator
> > > > is now managed by the onboard_usb_hub driver.
> > > >
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > >
> > > No DT maintainer approval yet?  :(
> >
> > Bjorn usually just picks DT changes into the QCOM tree when they are
> > ready, so I wouldn't interpret anything into the lack of an explicit
> > Ack.
> 
> Right, so the expectation is that this patch wouldn't land through the
> USB tree but would instead land through the Qualcomm tree, probably a
> revision after the code lands in the USB tree to avoid dependency
> problems.

But our tools pick up the whole series.  I can't just do "i will pick
patches 1-4 only" easily, and neither can any other maintainer.

Why not just get their ack so that I know it can come through the USB
tree?  That's what normally happens for other changes like this where a
driver change is required first.

thanks,

greg k-h
