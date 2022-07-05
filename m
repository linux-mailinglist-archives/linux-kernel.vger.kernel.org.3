Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712F8566A1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiGELqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiGELqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:46:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8722E1707E;
        Tue,  5 Jul 2022 04:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25E6760F69;
        Tue,  5 Jul 2022 11:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83181C341CE;
        Tue,  5 Jul 2022 11:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021593;
        bh=g9kyp+0dqAAFhiEd0vppJfgTzCC43SYBYOZLu2V0sgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BV2AyIIK1FKrm5uJx7f2fQJU5dXNzlYlA9nCPEiHIhAfRKUPoNR63d45CV8hKNk41
         MvlsW0mf5/KvVMJhqRNi76PqRFEPwfrrIoqZB79KwuaUSITaRvaSdlFX7lsn6gVZDq
         FnF4S2KbzTiMzYuMZ39sM3wxgKN5y+bY29r1aKr09NB7VaG9Ypl3oWOKgXGs/zvuZ7
         Luy/ybkDrNIEOvDb2PA0VO90Hz3u9rTAO6NqlJIT6PKaY8myVBoK/TFophbp7M2lYs
         n6pLS/UH1Nn130fVA22aQAepSNimte77Xvu9v6k7XBVnKpazywMOBzSwXFdy4QbZke
         +7fsJfjTyiaqg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8h0j-00062C-Hr; Tue, 05 Jul 2022 13:46:34 +0200
Date:   Tue, 5 Jul 2022 13:46:33 +0200
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
Message-ID: <YsQkmUVla9+CDYly@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-17-johan+linaro@kernel.org>
 <d3a49c05-0fd0-920e-bd0a-f821e8e27b8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a49c05-0fd0-920e-bd0a-f821e8e27b8b@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:16:34PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 11:42, Johan Hovold wrote:
> > Only UFS PHY nodes in mainline have a vddp-ref-clk supply. Drop it from
> > the PCIe PHY binding.
> > 
> 
> That's not really good reason. Either the hardware uses ref-clk supply
> or not. Now it looks like you copied everything from common schema and
> clean things up. That's not how it should be organize.

Yes, and I've been pretty clear that that's how I'm going about to
disentangle the current binding.
 
> It's okay to copy existing bindings which are applicable and then in
> separate patch deprecate things or remove pieces which are not correct.
> But all this in assumption that the first copy already selected only
> applicable parts.

But how would you be able to tell what parts I left out from the
original copy unless I first do the split and then explicitly remove
things that were presumably *never* applicable and just happened to be
added because all bindings where combined in one large mess of a schema?

Johan
