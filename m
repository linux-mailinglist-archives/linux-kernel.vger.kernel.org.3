Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919BA567E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiGFGDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiGFGD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFAA2253B;
        Tue,  5 Jul 2022 23:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6A9F61D2D;
        Wed,  6 Jul 2022 06:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF9FC341C6;
        Wed,  6 Jul 2022 06:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657087393;
        bh=p1ZUq2pNMs+JaHQv52RmH17QKMuz3XFF0vibOHT4vKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPeRLhGHR+v2UjPV0qwKjV2xSKUJFIpEuZUu9axLWxqi2vn6rcausfFNLf4DVdknc
         gxkmh0o7uC7vN0aC9nYaH9wTtkHBFxIZBf6A22dGqdAw16uUCzS0e9XJY5xTVHaY13
         CpwABG6Jsqr+Xu0pVNWXmYMhLSo9hwnsTB7OQpBhVVkDsFihzpGa/6ssm3l3u5JJe0
         /EaTFCcDOB1hwEnVsZAenuXV2055rxN4b4C7MieAs9wyvjFF7Bbk40+B4vfiuy4uaL
         3Twt2dJDyfpMKax1t51/YhVXtNIb/9h7kY2fDBL3g2nYR9dgjXpjvw/CyYFmzLHAS2
         y7ZZ3S8Cq/9cw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8y81-0004aa-Qv; Wed, 06 Jul 2022 08:03:13 +0200
Date:   Wed, 6 Jul 2022 08:03:13 +0200
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
Subject: Re: [PATCH 16/43] dt-bindings: phy: qcom,qmp-pcie: drop unused
 vddp-ref-clk supply
Message-ID: <YsUlob0Cj9WmDzcF@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-17-johan+linaro@kernel.org>
 <d3a49c05-0fd0-920e-bd0a-f821e8e27b8b@linaro.org>
 <YsQkmUVla9+CDYly@hovoldconsulting.com>
 <8d739c84-ba61-a030-ea8a-63a3f45c642c@linaro.org>
 <YsQx1SMEsMnmoQ2d@hovoldconsulting.com>
 <5b6f5e15-f3fd-badb-3ada-eb2f58053857@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6f5e15-f3fd-badb-3ada-eb2f58053857@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 08:13:55PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 14:43, Johan Hovold wrote:

> > So you suggest we keep this regulator for all PHY variants even though
> > it was probably only needed for UFS on some older SoCs?
> 
> No. I commented only that reason is not a good one. The proper reason
> could be: there is or there is no such pin in the device or the history
> tells that adding it for all variants was a mistake.

Ok, I'll include it since it was there as an optional regulator from the
start and hence implicitly made part of the binding for later PHYs even
though it likely only applies to the older MSM8996/98.

If anyone has access to the documentation they can drop it later.

Johan
