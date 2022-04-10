Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B914FAB49
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiDJBHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiDJBHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:07:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6DE66F92;
        Sat,  9 Apr 2022 18:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9220BB80761;
        Sun, 10 Apr 2022 01:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA32C385A0;
        Sun, 10 Apr 2022 01:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649552727;
        bh=bTsT+8yXMqSQJsb6gvK5lObJcH0TfbeN7xES95MTLYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5okBHW+b2JSp8epeXkcjgbFOQvSyUrYE7TG+vZ709fRrMMFTUCCCXqKQrhV6c8cn
         o+Q9yD7ymQJfSjWpc7NaYPHtBUdfqy087YICLogC32HnqDB+qS76id4A+lMk0KBAzU
         YaQvzvsF11ud+ersCiK32+l+1xy0mVFnq5UN0nAoJafnU3DQzy54ue7O1sdowX9ULX
         20e5tMhxRqqS1YtdwlzpbqGyEPCmf4nMJwVz5gWKpFc3yu4m+7OOpi+usrskzoldSR
         T0rkExjyx2lZTcOjfnM1rT9mLttsNSQcxOxfe9lXOX/UhyliNE8jNsSs+Qr0HTnRcR
         mJN5DZF1keR2Q==
Date:   Sun, 10 Apr 2022 09:05:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Harninder Rai <harninder.rai@nxp.com>,
        Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>,
        Zhang Ying-22455 <ying.zhang22455@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1012a: correct the size of dcfg block
Message-ID: <20220410010521.GF129381@dragon>
References: <20220317185941.3650-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317185941.3650-1-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:59:37PM -0500, Li Yang wrote:
> Fixes: ba3213602d28 ("arm64: dts: Add support for FSL's LS1012A SoC")

Sorry, I do not take patch with no commit log.  Fixes tag doesn't count.

Shawn

> 
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index 50a72cda4727..b1ae15547e15 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -282,7 +282,7 @@ sec_mon: sec_mon@1e90000 {
>  		dcfg: dcfg@1ee0000 {
>  			compatible = "fsl,ls1012a-dcfg",
>  				     "syscon";
> -			reg = <0x0 0x1ee0000 0x0 0x10000>;
> +			reg = <0x0 0x1ee0000 0x0 0x1000>;
>  			big-endian;
>  		};
>  
> -- 
> 2.25.1
> 
