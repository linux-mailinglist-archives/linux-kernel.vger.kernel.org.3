Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FDF5A6224
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiH3LjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiH3Lie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:38:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7577228E30;
        Tue, 30 Aug 2022 04:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A84AFB81A60;
        Tue, 30 Aug 2022 11:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DC5C433C1;
        Tue, 30 Aug 2022 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859435;
        bh=EYBRvvBGDd6OFvpW88VMSSaRRt5bbgJi+wdWKcCg88M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcTzFLWNeGw294xYrs5lPduDPIgiOiXr5GIlpOknRxEry/14FwMDYggldm2YTI2B2
         CdFHbLcVlHQvtSfofi/JPsZ2zFfldHLZs3q0vm+ECP/cnRJSmv7wyLn1TyIPYilZgy
         T1PGV0dCM1EN4LFWT6m7jJBL5+mZiWZHeE1llodoMR2b/iGfrwGWIZ6+l3q4y1LxR6
         ya2X+psVY5Hj7xguBvllrp9omFUKjoc+i/MN4d8QyG0CXkOIzzT32OvM5CfF96IF6o
         8Q5cSZHv1r1+wq11XL9GaWs49D/8SebazGxE/8SUoC0rgYSZQjIyYW8FRexAUFVpGH
         TKDCkX7RcBjSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oSzYO-0008Sb-M5; Tue, 30 Aug 2022 13:37:12 +0200
Date:   Tue, 30 Aug 2022 13:37:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/30] phy: qcom,qmp: fix dt-bindings and deprecate
 lane suffix
Message-ID: <Yw32aOuN3rkTBJAy@hovoldconsulting.com>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
 <Yw2a44l9a6zz5qTJ@matsya>
 <Yw21t1SUGjCcUuuw@hovoldconsulting.com>
 <aeec2729-e610-f266-f336-847675cf85ec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeec2729-e610-f266-f336-847675cf85ec@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:32:04PM +0300, Dmitry Baryshkov wrote:
> On 30/08/2022 10:01, Johan Hovold wrote:
> > On Tue, Aug 30, 2022 at 10:36:43AM +0530, Vinod Koul wrote:
> >> On 14-07-22, 14:43, Johan Hovold wrote:
> 
> [skipped]
> 
> >>> The final patches add support for the updated binding to the (recently
> >>> split up) PHY drivers. Included is also a related combo PHY cleanup.
> >>
> >> This fails at patch 2 for me on v6.0-rc1, please rebase and resend
> > 
> > Are you sure you haven't applied anything to your local tree that causes
> > this?
> 
> When doing the QMP split, we ended up in a similar situation if I 
> remember correctly. Most probably the easiest way is to provide a branch 
> for Vinod to pull in addition to the patches being sent to ML.

Hopefully v4 will just work now.

> > I just tried fetching the v3 series from lore and it applies just fine
> > on top of 6.0-rc1.
> > 
> > Note that if you've added a new compatible string locally, the second
> > patch which sorts the compatible strings is likely to fail to apply.

Johan
