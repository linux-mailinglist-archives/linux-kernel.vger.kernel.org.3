Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9F4567E34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiGFGGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGFGGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:06:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C22F7;
        Tue,  5 Jul 2022 23:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0E95B81A60;
        Wed,  6 Jul 2022 06:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5985AC3411C;
        Wed,  6 Jul 2022 06:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657087571;
        bh=jvOZq722r7H/JpYeXiuNKx8BxoPr4CD4sprkmcgtsHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBISZFg4Ge7GQRk6VQfVTF0yeKRCowRMpeEhSqfcgqOTkWKECP5WgnXEXnrA+Wa9R
         eeFmxIOC0Qxgez3KYCybtXaG4ryLGcV+6uNrYabuz6gsK0ZN+TndJmRB5CLbqG8+ai
         Aj3hvh/M9zGBWZl1H2Hh3mk07Ct6GjGlhxjF+bKEfiy47H6/OJKPw8vVeOOfV9soWc
         ezvm5XBPimU5RauYA17Htscla7WBVZ+/F13srgoW7V0YtPQ08z3OvAd5kyrov6RUmO
         wHYOGcdVtnhy8BdxrIydQdsdKoWLlThm3hG619QsiTgjsCYmUoA0l0G1X6yJxdodAd
         nu7FQDLJ6MNiQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8yAu-0004bk-7I; Wed, 06 Jul 2022 08:06:12 +0200
Date:   Wed, 6 Jul 2022 08:06:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/43] dt-bindings: phy: qcom,qmp-pcie: add missing child
 node schema
Message-ID: <YsUmVBXWPojz0woT@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-18-johan+linaro@kernel.org>
 <4bc79a1c-66b1-225d-5026-ddf3e6f7d22c@linaro.org>
 <YsQlzr6nyvz761Kz@hovoldconsulting.com>
 <963917cf-0f9d-600f-564e-9e687270b1af@linaro.org>
 <YsQqcKZAs1xAB9+S@hovoldconsulting.com>
 <cf61b071-aa31-6f67-07f1-4f15e0fe7511@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf61b071-aa31-6f67-07f1-4f15e0fe7511@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 08:21:12PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 14:11, Johan Hovold wrote:

> > Ok, so you want to flatten this by repeating also the register
> > descriptions?
> > 
> > That wouldn't hurt readability as much, but doing so would be more error
> > prone as it's easy to miss adding a new compatible in every group of
> > conditionals and there's no else clause to catch the mistake.
> > 
> > Right know the logic is
> > 
> > 	if dual-lane
> > 		items = 6
> > 	else
> > 		items = 3 or 4
> > 		if single-lane-exception
> > 			items = 3
> > 		else
> > 			items = 4
> > 
> > Flattening this gives
> > 
> > 	if dual-lane
> > 		items = 6
> > 	if single-lane-normal
> > 		items = 4
> > 	if single-lane-exception
> > 		items = 3
> > 
> > Which means that every compatible must now be listed in one of the
> > conditionals.
> 
> Yes, because it's explicit and easy to read. Handling compatibles in
> 'else' makes it opposite - one cannot use grep and cannot easily find
> what is actually covered by maxItems:4 (you need to check all 7
> compatibles to find what is not covered here).

I'll go with that then.

Johan
