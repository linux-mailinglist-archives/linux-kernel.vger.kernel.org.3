Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD03A574A21
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbiGNKHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbiGNKHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:07:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC0F51406;
        Thu, 14 Jul 2022 03:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDCDD61FC7;
        Thu, 14 Jul 2022 10:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32832C34114;
        Thu, 14 Jul 2022 10:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657793234;
        bh=bSKkH2jvKSAI3EiQUqhslwIC6F4g+v4LiBs8ZL7Da80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POcam2qFW9ucCQKozq6eRb7dLksw5QSsF4HPhST5L9cJchZbGVS8pZhrB+OFfFgg6
         va14SjilQwkXkHBRd0ETpPGywkoc1wW1bhF3SoFMUvAhv/hOyDfnOl5b3+hE/EZSA6
         vOTOZ4TCW5mSGa01x0fc6FZWZtDWq3B25oI2njoolmQMgGu6hu3EQWPawXK+beKJDF
         XExxqSBY0jyixrLSyEW1rNP488WG/wOjifSRX6/CVfmyNZkapZcFYXTxJ7ONkBps7v
         yAx7LBSlwdHWDLnRkKW/Z7mgSmvef8DxJEEeDMyJnKzjXX2IWLgj6udaTPoCmhkReU
         xNLfgaBbO5HGw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBvkb-0008Qr-Uv; Thu, 14 Jul 2022 12:07:18 +0200
Date:   Thu, 14 Jul 2022 12:07:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/30] dt-bindings: phy: qcom,qmp-ufs: add missing
 SM8450 clock
Message-ID: <Ys/q1crMhS3Ou+qu@hovoldconsulting.com>
References: <20220707134725.3512-1-johan+linaro@kernel.org>
 <20220707134725.3512-17-johan+linaro@kernel.org>
 <e8046961-9555-07b7-721c-eeb278cb2ec7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8046961-9555-07b7-721c-eeb278cb2ec7@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:21:52AM +0200, Krzysztof Kozlowski wrote:
> On 07/07/2022 15:47, Johan Hovold wrote:
> > Add the missing "qref" clock used by the SM8450 UFS QMP PHY to the
> > binding.
> > 
> > Fixes: e04121ba1b08 ("dt-bindings: phy: qcom,qmp: Add SM8450 UFS phy compatible")
> > Fixes: 07fa917a335e ("arm64: dts: qcom: sm8450: add ufs nodes")
> 
> The second fixes seems not appropriate here, because you are not fixing
> a DTS. A fix for DTS would be a fix for that one.

I wanted to highlight the fact the binding wasn't amended when the DTS
started using the new clock, which it should have. But sure, that would
have gone in a separate patch. I can replace the second Fixes with a
Link to the dts submission as a reference instead.

Johan
