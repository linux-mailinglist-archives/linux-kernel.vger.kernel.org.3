Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8824FAC8B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiDJHaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 03:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiDJHaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 03:30:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9A52DA99;
        Sun, 10 Apr 2022 00:27:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A6B3B80A39;
        Sun, 10 Apr 2022 07:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF98C385A1;
        Sun, 10 Apr 2022 07:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649575671;
        bh=YzGXDlYnNncDbrCmQDBWKW1BaIk5s78v/1hoNSGUe/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BzEdy6SzPyPdEBHTxiqN1qhLmwXWfOFJep58yRrbbFebbdrNgPjsO2jVchOlT0otH
         w6bYNdvtapd6VoJSX2Pz1+9uzhpvOuDXdtMrfqncR215ekgX86eEGycsr9bdcCE17s
         CJyDT+oAS8DrW9KvEvYfGjDYXNLMzN1QLAN5yUacLYl4AkGbPucCAoLfw8NK+QyUEG
         S720hZ89RPaBo+FuaGRApGdHjagvvBvoCzHuTbkjnz8+FsKN8/fFIEFiryRfC1Fawk
         9g4vBL1eX+/a6IwrdD7MTwxB+C7HPM/jOXeOiZbhl5J2we5QV/VMgrXXTl8/b846b0
         7s+pz5YaeHjmg==
Date:   Sun, 10 Apr 2022 15:27:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ARM: dts: ls1021a: remove "simple-bus" compatible
 from ifc node
Message-ID: <20220410072745.GN129381@dragon>
References: <20220322022818.9860-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322022818.9860-1-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 09:28:13PM -0500, Li Yang wrote:
> The binding of ifc device has been updated.  Update dts to match
> accordingly.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

I only received patches #1, #2, #4 and #5, while it claims there are 6
patches in the series.

Shawn

> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 2e69d6eab4d1..52835d3dfa1b 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -123,7 +123,7 @@ msi2: msi-controller@1570e08 {
>  		};
>  
>  		ifc: ifc@1530000 {
> -			compatible = "fsl,ifc", "simple-bus";
> +			compatible = "fsl,ifc";
>  			reg = <0x0 0x1530000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>  			status = "disabled";
> -- 
> 2.25.1
> 
