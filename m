Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF85667D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiGEKY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiGEKWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:22:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BABA14D15;
        Tue,  5 Jul 2022 03:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E65E0B81737;
        Tue,  5 Jul 2022 10:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE68C341C7;
        Tue,  5 Jul 2022 10:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657016537;
        bh=e+WVKuABy3B4xWh28IvAUjhEPi40vu/COnqPvOhrMoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDtUtxSoYssZ9G/EseASqj9GalQsG0zIeMjglYle0ekV91V4RO7GlrBvlHZ4aRWGN
         6OytFcdCF91f6rJwujR2muRmGPeqZRE9i7HZrJYuXAl4Hi9AuU/GgPZkWXepkwDUZL
         XOxy8VJfjAVmBug9ZydUs1AOOIRwbIjuxFpIsK4U/re1lEbIgEmdyGZiDZKpECB/O2
         VnVvXktULpOC4ZSiE1P/Eq9Dso7mDAanlrECGpvpCtzZoqHb2Jxgn12E2pmsbAPhHx
         YTB14FCn+Xcu56wRsd8Q1YUyi9LpQx5ZvJYEIGHNjl2E2uZq/0EObUP0Fmrnyoa3W5
         s7HfRM38xyy9g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8fhC-00056D-2U; Tue, 05 Jul 2022 12:22:18 +0200
Date:   Tue, 5 Jul 2022 12:22:18 +0200
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
Subject: Re: [PATCH 09/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: add
 example node
Message-ID: <YsQQ2o8aYJnnWuNa@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-10-johan+linaro@kernel.org>
 <8271f4d5-e12e-ddf0-46ab-86a39577755a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8271f4d5-e12e-ddf0-46ab-86a39577755a@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:10:29PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 11:42, Johan Hovold wrote:
> > Add an example node based on a cleaned up version of msm8996.dtsi.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Squash it, please.

Why? It's a new addition to the schema.

Johan
