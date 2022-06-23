Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1527557341
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiFWGm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWGmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964E4E80;
        Wed, 22 Jun 2022 23:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 328E461423;
        Thu, 23 Jun 2022 06:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F66C3411B;
        Thu, 23 Jun 2022 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655966572;
        bh=WM63W4t+GfDhnclF1xtyqcOeZnCwVwt8C6UTIapLzkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIKZD7ziOL/HJRmCog8cjYEpmdWzMlegswjLhO/BzieT7AdJae2Z+HoRG7j6YSUx+
         cpepKiFpWvRgC5i23Xqw0QZzpfFoVm/TByhpkfO0uSjAoIDov6rnCwbJuYEL/vlUyj
         pOYxpQvZxYzVIpaWxRHeIvxOXvQgGuL6oH1zg6LnIm2iD86v1kK2hCg2U2BRssS8j2
         wE29jKkjo0Fy9wzO3AAOdG8jwyAJZbJU0aJS+LItFcelUIS2aUS7/1x9XAS6jLAKVd
         yPDtmmBzxF76PsGjqiVDuegrnNe1TZjcYCnXK6JDGJBq6I5EE6GDKmZPqsJgiJuBKZ
         xLpUo98oEShGA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o4GYC-0004Xe-Kd; Thu, 23 Jun 2022 08:42:49 +0200
Date:   Thu, 23 Jun 2022 08:42:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: add SC8280XP platform
Message-ID: <YrQLaGcB9NoCDQQM@hovoldconsulting.com>
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-3-bjorn.andersson@linaro.org>
 <YrP4qs+GIlaS7Wzy@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrP4qs+GIlaS7Wzy@matsya>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 10:52:50AM +0530, Vinod Koul wrote:
> On 07-06-22, 14:41, Bjorn Andersson wrote:
> > +	aggre1_noc: interconncet-aggre1-noc {

> s/interconncet/interconnect

Note that you're reviewing v1 and that this has since been fixed.

> Hmmm I thought it was required that node name should be interconnect@x

> > +		usb_0_hsphy: phy@88e5000 {
> > +			compatible = "qcom,sc8280xp-usb-hs-phy",
> > +				     "qcom,usb-snps-hs-5nm-phy";
> > +			reg = <0 0x088e5000 0 0x400>;
> 
> this doesn't match with node address above (I think W=1 would warn you
> of such mismatches, useful to run on new dts

This unit address is actually correct, but there were some other
mismatches that were also fixed in v2.

Johan
