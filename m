Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B59D554F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358215AbiFVPhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiFVPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A1139835;
        Wed, 22 Jun 2022 08:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E396157C;
        Wed, 22 Jun 2022 15:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D86C34114;
        Wed, 22 Jun 2022 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655912237;
        bh=UGfFuwgO/IwQw1+m5Tf2hAd0hgeP99xh4yZPDG+4Z+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOgFZW+rKF+5eNWFoj6aDv3NSYeFyvI27LG8uGG4L9Q+jp+9d3RvfOtdOcLsFoXrt
         CZND3ZM28MRW931Ok7Dsit+P9P+lO/Ubb0np5mUP2jqiH3c54mEV7AmJbFz9fikxMu
         ebsD5XfDiH3/V3B6yek/R1osLDxNdy8PZHLrDrDIGMpp5oR5Mp63ZRhAO9FmLFWsoe
         Hkidfi6lt5e6lJNmK0KgsdU8BDEMQX9uwsU36gfouWMPxPX2pGE86/Fgc5ywIZH4QU
         Lyfu2mJkneUEU9DY7abGIPg1svkkDGHYBv+2hxZJvYDDMqpx8YskF213uphmkevkgU
         y/2WvCUcMvnJQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o42Pq-0007Lq-05; Wed, 22 Jun 2022 17:37:14 +0200
Date:   Wed, 22 Jun 2022 17:37:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sc8280xp: Add reference device
Message-ID: <YrM3KX3HLjsYrQvf@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-5-bjorn.andersson@linaro.org>
 <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
 <YrMccQXwsz/zC/gl@hovoldconsulting.com>
 <9d0c1897-195f-0548-ea5d-ffc35768f518@somainline.org>
 <b2c9faf0-95a8-772f-c211-f1599b35f8f8@linaro.org>
 <51965fa3-d146-70f1-2ad8-db6197989348@somainline.org>
 <YrM0vhXpY3uWgprs@hovoldconsulting.com>
 <e7d9150b-8332-6394-f6cf-0e59d0cf931b@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d9150b-8332-6394-f6cf-0e59d0cf931b@somainline.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:30:24PM +0200, Konrad Dybcio wrote:
> On 22.06.2022 17:26, Johan Hovold wrote:
> > On Wed, Jun 22, 2022 at 05:10:50PM +0200, Konrad Dybcio wrote:
> >> On 22.06.2022 16:48, Krzysztof Kozlowski wrote:
> >>> On 22/06/2022 16:36, Konrad Dybcio wrote:
> >>>> On 22.06.2022 15:43, Johan Hovold wrote:

> >>>>> No, quite the opposite, status go at the end.
> >>>> Then all other device DTs should be updated, as in dts/qcom/
> >>>> everybody keeps it first in non-SoC/PMIC files.
> >>>
> >>> The word "should" is a bit too much here, but I agree, we can update all
> >>> of them to match one, chosen approach.
> >>>
> >>> However the location for "status" property is more important for the
> >>> definition of nodes in DTSI, because it's the least important piece
> >>> there and also kind of expected - here go properties + I disable it. For
> >>> me this is more important.
> > 
> > Right, and this is the argument for keeping status last, something which
> > is well defined.
> > 
> > If you look at some of the qcom dtsi it's hard to determine whether a
> > node is disabled or not because the status property does not actually go
> > "first" but is rather typically mixed up somewhere in the middle (or
> > upper part) of nodes.
> > 
> >>> For node redefinition in DTS, I see benefits in two approaches:
> >>> 1. Let me first enable the node and then configure it.
> >>> 2. Let me configure the node and enable it.
> > 
> > So for consistency, just put status last everywhere (dtsi and dts) and
> > be done with it.
> That works.

Actually, it looks like a lot of the qcom dtsi already do this too (i.e.
put status last). The dts may be more inconsistent on this matter
judging from a quick look.

> >> I looked around non-qcom device trees and it looks like the common
> >> consensus is 2. Although I personally visually prefer 1. and it's
> >> been used in all qcom arm64 DTs to date, I don't think there are any
> >> blockers for us to switch to 1. going forward to keep it consistent.
> > 
> > You mean inconsistent with the majority of dts? ;)
> Not like anything involving Qualcomm was ever consistent or compliant
> with the majority :D

Heh. :)

Johan
