Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94D858B6FC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiHFQlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHFQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:41:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243CC63EC;
        Sat,  6 Aug 2022 09:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBC31B801B8;
        Sat,  6 Aug 2022 16:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941C5C433B5;
        Sat,  6 Aug 2022 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659804070;
        bh=i0eUZa0syUDLoVS5dXzu7SE6flTNuo/I81QOxgvntMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yrx5LVtvqViGSGVYIovDvcJZw102jcOUylNTl7ClWIV8n+Ap2nxsqs+Gfw/olRAAJ
         trpeXuCbpimxH4RzG2K2hQB4l6NGHixwr9P92MwNnX9B5K7dmCYsYunNunyhVy34OL
         rgo5fGCnfhOA4pgb4tp76IFQLppa8Jf21tt4TK74XzNlBvpuGq1SqJTAPk2F4Uwcis
         0RMzYWwwFtsXY8vznGtu0/kW/VkyY36287GFol98fGpT9M8hSafAUqlU5Zc2fwSb+i
         RyM5xdHyAzjkU0sQkuh+QwBopzs8mVqyk7m/mjH6reLIrl9XOhY5NOcTT7WYnhlCvx
         k7+Z5R0BBI9gQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oKMrp-0003ST-9c; Sat, 06 Aug 2022 18:41:38 +0200
Date:   Sat, 6 Aug 2022 18:41:37 +0200
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
Message-ID: <Yu6ZwePzzkl7tewV@hovoldconsulting.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-8-johan+linaro@kernel.org>
 <20220806150848.GH14384@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806150848.GH14384@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 08:38:48PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 04, 2022 at 05:09:59PM +0200, Johan Hovold wrote:
> > Add a wakeup-source property to the binding to describe whether the
> > wakeup interrupts can wake the system from suspend.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> So this is based on the fact that Qcom glue wrapper is supplying the wakeup
> interrupts. But isn't it possible that on other platform, the DWC IP can supply
> wakeup interrupts?

Yeah, possibly, and that's why Rob suggested keeping the 'wakeup-source'
property also in the core node.

> In the driver, the wakeup-source parsing has been moved to the Qcom glue driver.
> But this contradicts with the binding.

That's irrelevant. The core driver does not implement wakeup support. It
was just added as a hack for the Qualcomm driver, and you won't get
wakeup-capability for other platforms by just parsing the property in
the core driver.

When/if wakeup support for such a platform is added, then the core
driver may need to look at the property again.

Johan
