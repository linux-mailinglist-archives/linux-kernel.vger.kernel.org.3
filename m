Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365C15ABCB5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 06:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiICEAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 00:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiICEAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 00:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D0303D8;
        Fri,  2 Sep 2022 21:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 745C860FA7;
        Sat,  3 Sep 2022 04:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA8CC433D6;
        Sat,  3 Sep 2022 04:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662177615;
        bh=apABGTiEOoGfIPT9+Tkf1BuC1/ydmIPqIlXxDqiDLek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fk27PVvQTQXaLJxR1dc7AO7QKVLZ/5eu4IoSNCGyffY9MMVYPoeGNX4VXwgK9q7d2
         NldTxYkW7rJbLBydKyyvAEv+y6Wn7FcxvL+dTcbq4AW47ZghDrg+zHEh+hHBDMFdXz
         2D2PUgwJBptQ9fOxOLHIXLGFRmW2LKRE2Omj3FD3E8UXQR+A9RxvzOeGQKBWGx4Q2m
         o3ndNZ+OTl6VnS2nDQDBdDEGWelUEy+2VWK3nIFkfZuAbyW+1gQO4AwZyxL5vDdDKS
         cslvdPESbzGprN1xgO4DAV/I8nEfkMoCdrh6bcshmY9BXkNZxla79cUZf5Em8fRDpX
         ay8Cn2UpLgxIQ==
Date:   Sat, 3 Sep 2022 12:00:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: arm: fsl: Add MSC SM2S-IMX8PLUS SoM
 and SM2-MB-EP1 Carrier
Message-ID: <20220903040010.GH1728671@dragon>
References: <20220823140124.1469989-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823140124.1469989-1-martyn.welch@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 03:01:21PM +0100, Martyn Welch wrote:
> Add DT compatible strings for a combination of the 14N0600E variant of
> the Avnet (MSC branded) SM2S-IMX8PLUS SoM on it's own and in combination
> with the SM2-MB-EP1 carrier board.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
