Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5095554F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358381AbiFVP1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359386AbiFVP1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:27:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE61D39165;
        Wed, 22 Jun 2022 08:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81CB6B81F99;
        Wed, 22 Jun 2022 15:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CF9C34114;
        Wed, 22 Jun 2022 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655911620;
        bh=LofunbVPsAFbpla4sYsGRa5somVhJXmX25y4hisPFLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iO9wu6LuSXMwYekG555g50Hr2oFdpIYyQCDO13mFFXKh8nvTyB8I44mTfXYTvlXJl
         6EYUFkKrVjcm88QWmgznWlYtnCAwDMZGOeozOy8qA1ZnfhVBnWK45C9D1pNjpGoJDZ
         1IyngjrXXhi8+tzPD0j3UIOB40LjoNd0eLYelq9WKa44VyVIYqkASKERgtbQFL2PVZ
         23ixMA8XKowPVtPTcJ1Jpaxzc7K5lMWP9uZAI20kmeg9kIYdqhyBH4dYdpJfpQyZ9T
         s7P0wmOsIoaHrLUjbSr72tbNG+1GL/YWc/ey/3oBTp2bggi/gI+6bdZKiFAvGjF6Ki
         3WzF+Cl2Ev6lA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o42Fq-0007Hf-IN; Wed, 22 Jun 2022 17:26:55 +0200
Date:   Wed, 22 Jun 2022 17:26:54 +0200
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
Message-ID: <YrM0vhXpY3uWgprs@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-5-bjorn.andersson@linaro.org>
 <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
 <YrMccQXwsz/zC/gl@hovoldconsulting.com>
 <9d0c1897-195f-0548-ea5d-ffc35768f518@somainline.org>
 <b2c9faf0-95a8-772f-c211-f1599b35f8f8@linaro.org>
 <51965fa3-d146-70f1-2ad8-db6197989348@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51965fa3-d146-70f1-2ad8-db6197989348@somainline.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:10:50PM +0200, Konrad Dybcio wrote:
> 
> 
> On 22.06.2022 16:48, Krzysztof Kozlowski wrote:
> > On 22/06/2022 16:36, Konrad Dybcio wrote:
> >>
> >>
> >> On 22.06.2022 15:43, Johan Hovold wrote:
> >>> On Wed, Jun 22, 2022 at 02:33:02PM +0200, Konrad Dybcio wrote:
> >>>> On 22.06.2022 06:12, Bjorn Andersson wrote:
> >>>
> >>>>> +&qup2_i2c5 {
> >>>>> +	clock-frequency = <400000>;
> >>>>> +
> >>>>> +	pinctrl-names = "default";
> >>>>> +	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
> >>>>> +
> >>>>> +	status = "okay";
> >>>>> +
> >>>> I think all device DTs generally have 'status = "okay"' at the beginning. Should we change that?
> >>>>
> >>>
> >>> No, quite the opposite, status go at the end.
> >> Then all other device DTs should be updated, as in dts/qcom/
> >> everybody keeps it first in non-SoC/PMIC files.
> > 
> > The word "should" is a bit too much here, but I agree, we can update all
> > of them to match one, chosen approach.
> > 
> > However the location for "status" property is more important for the
> > definition of nodes in DTSI, because it's the least important piece
> > there and also kind of expected - here go properties + I disable it. For
> > me this is more important.

Right, and this is the argument for keeping status last, something which
is well defined.

If you look at some of the qcom dtsi it's hard to determine whether a
node is disabled or not because the status property does not actually go
"first" but is rather typically mixed up somewhere in the middle (or
upper part) of nodes.

> > For node redefinition in DTS, I see benefits in two approaches:
> > 1. Let me first enable the node and then configure it.
> > 2. Let me configure the node and enable it.

So for consistency, just put status last everywhere (dtsi and dts) and
be done with it.

> I looked around non-qcom device trees and it looks like the common
> consensus is 2. Although I personally visually prefer 1. and it's
> been used in all qcom arm64 DTs to date, I don't think there are any
> blockers for us to switch to 1. going forward to keep it consistent.

You mean inconsistent with the majority of dts? ;)

> That's if we want to clean up the existing ones, as changing the rules
> and not applying that to the older files will make for a huge mess as
> time goes on and will unnecessarily prolong the review process (as
> existing DTs are commonly a source of reference and people make
> certain choices based on those).

That's a fair point. Consistency is good, and dt snipped tends to be
copied, but it's not the end of the world to not update old dts either.

> I don't think the DTS specification or the Linux docs explicitly which
> one to choose though.

No, but a praxis has been developed over time (e.g. compatible first,
reg second, status last).

Johan
