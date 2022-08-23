Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148F459E639
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbiHWPlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241545AbiHWPlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:41:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186C1760FC;
        Tue, 23 Aug 2022 04:36:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB5E0B81CCF;
        Tue, 23 Aug 2022 11:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFB8C433D6;
        Tue, 23 Aug 2022 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661254558;
        bh=lrNGnTi7OrnogAjkHr5SAO67riv511ycxt2FHZbAVZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtVawSmcELTO7GRiu4HkWLwofIZjcdKqhSOGEUNchQgbqdUh8kmXcNx4qh509zCqp
         vDQYqkIR5sxaxfw18R2rC0QKm2fxGCqPTVcTE20GgjVStR/IsD1hjqR33c7diC/d6a
         BEpkK257PLuu7ajgCm1hCE5rjYLXFkUv9V8L7Z9GZK5ARUImJ2bJsPCoM4GJA9pej4
         +dDy0SQtFTXytRDsEX3RdOkaxeARTM33b8Niq00VtzkMlmje+9YB2KwIq56tM89XLv
         YOv41TVBsMoRQsfdGjtifQ/szrgxwA6l5M/17Oduzr8LuMlvPtGJEwAolKRf2cFxpN
         cMqGeEIQCaRpw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQSCL-0002Q4-F8; Tue, 23 Aug 2022 13:35:58 +0200
Date:   Tue, 23 Aug 2022 13:35:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>, andersson@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: move USB wakeup-source property
Message-ID: <YwS7ndGJ5cgERJhz@hovoldconsulting.com>
References: <20220802152642.2516-1-johan+linaro@kernel.org>
 <YwOBEhViD1iY14yL@hovoldconsulting.com>
 <YwQDuXXkgwPAu55D@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwQDuXXkgwPAu55D@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 03:31:21PM -0700, Matthias Kaehlcke wrote:
> On Mon, Aug 22, 2022 at 03:13:54PM +0200, Johan Hovold wrote:
> > On Tue, Aug 02, 2022 at 05:26:42PM +0200, Johan Hovold wrote:
> > > Move the USB-controller wakeup-source property to the dwc3 glue node to
> > > match the updated binding.
> > > 
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > > 
> > > This one can be applied once the following series has been merged:
> > > 
> > > 	https://lore.kernel.org/all/20220802151404.1797-1-johan+linaro@kernel.org
> > 
> > The above series has now been merged (for 6.0):
> > 
> > 	https://lore.kernel.org/all/Yv56fFpuUsxCSxJ8@kroah.com/
> > 
> > so that this patch can be applied.
> 
> Please apply it together with "clk: qcom: gcc-sc7280: Keep USB GDSC power
> domains on when USB wakeup is enabled" [1], otherwise USB wakeup won't work,
> and worse, USB would be broken after returning from system suspend.

If you really need [1] for wakeup to work then it's already broken as
the hack added to 6.0-rc1 that kept the power domain on in suspend has
been reverted.

If [1] is also needed for USB to work after resume, we either have a
bigger problem as I alluded to in my comment to [1] (and the PD needs to
be always on) or this is due to the PHY no longer being powered down in
suspend.

Only in the latter case, does this patch need to be held of until [1]
has been merged AFAICT.

Johan

> [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid/
