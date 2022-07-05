Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D7F5667BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiGEKV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiGEKVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:21:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB3D140AC;
        Tue,  5 Jul 2022 03:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC50FB8174A;
        Tue,  5 Jul 2022 10:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725AFC341C7;
        Tue,  5 Jul 2022 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657016477;
        bh=My2bfryJFl4wIdTf2/BEKso8md3hI2FZf7UQSG30KSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXXXIQXFkrsj7/rIYJXiRO8dTXW+bjCoET2ZFYi9Tt3G8FksGIfwFhxeTgBszBGK+
         Lb8PoXpMRIOO1P5Ck/a4AUU3MzRuOkjoIUDmY0BTWVMVTPdW1vsfoQyPE0pbW2P4aE
         1rUAbPFfK+CD5o4iwiBIfwJRqpsF45tqHK/LCCVT1/sW7z6JX6NU2VnRd+tmfeAulT
         0J88flnbnEzUnDezLlRy7sBBBYlZNNDSbTKgTpnffH+gJWapS7cWIVSdTPWpnPwqij
         7/EFg7R9vMLw73bGZ7fCYx17NjT8hYoeST5gRoXO+EejHp5kWOc/yEroqjczDe/8tP
         zC8a7lGRWpN8Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8fgD-00055i-Pj; Tue, 05 Jul 2022 12:21:17 +0200
Date:   Tue, 5 Jul 2022 12:21:17 +0200
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
Subject: Re: [PATCH 07/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: clean up
 constraints
Message-ID: <YsQQnT5ixHtSo+vk@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-8-johan+linaro@kernel.org>
 <4b1a9ded-24b1-faf1-e105-f18afef57682@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b1a9ded-24b1-faf1-e105-f18afef57682@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:09:19PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 11:42, Johan Hovold wrote:
> > Drop the compatible conditional and tighten the property constraints.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Squash it with previous patch. Does not make sense to add new file and a
> patch later change it.

I beg to differ, for the reasons I just spelled out in my previous
reply.

Johan
