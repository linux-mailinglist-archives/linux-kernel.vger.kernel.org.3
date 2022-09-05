Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3D5AC90C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiIEDVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiIEDUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:20:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291631903E;
        Sun,  4 Sep 2022 20:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1BF6BCE1011;
        Mon,  5 Sep 2022 03:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DD2C433B5;
        Mon,  5 Sep 2022 03:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662348046;
        bh=YJW7ljYFCro0bg5Hltu7oDDFTem6uLnWPoqrel1gXz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9rMrhj8JDg5q1UkQdCVASbe2G/7fLdPx59tx2ONXQg8YSY5ntiRdc83FAaF9WNgY
         ME+0SPouqIb2dkIEwk6hRArNbwLy9CrPgmt8aaVbwPXkiuuEOyxOvUH5UjmlBAADCV
         m91tcftpuzXswc/m3bYq9W5sPf5CvYLWPQ3hlWBYTo6wD8DaTBRe/blm9vzzdSltXz
         WxFAhPSUNwd4z0s6P3jj5y9lZf6akwCtwUnv5GLQhEXqJTJLRs5Ltjs558O/FjoQYL
         zWO9Z8VDEcsBHM6lq6zT+Ao3LmeNplwzaYDcVh4aTAUPndlof9HN/wqPEyrstBKfdb
         XMLK6RA4lDHow==
Date:   Mon, 5 Sep 2022 11:20:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 2/6] arm64: dts: imx8ulp: correct the scmi sram node
 name
Message-ID: <20220905032039.GG1728671@dragon>
References: <20220831142552.43393-1-peng.fan@oss.nxp.com>
 <20220831142552.43393-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831142552.43393-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:25:48PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Follow sram/sram.yaml to update the sram node name.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 8460a3cba107..7a88d7016b49 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -112,7 +112,7 @@ sram@2201f000 {
>  		#size-cells = <1>;
>  		ranges = <0 0x0 0x2201f000 0x1000>;
>  
> -		scmi_buf: scmi-buf@0 {
> +		scmi_buf: scmi-sram-section@0 {

While the commit log mentions sram/sram.yaml, the binding doc says:

  $nodename:
    pattern: "^sram(@.*)?"

Does scmi-sram-section match the pattern?

Shawn

>  			compatible = "arm,scmi-shmem";
>  			reg = <0x0 0x400>;
>  		};
> -- 
> 2.37.1
> 
