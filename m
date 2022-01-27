Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495E149E85A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244312AbiA0RGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiA0RGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:06:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251EC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:06:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u24so4510301eds.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QMS9fD/WrWFkaVLvvHnWkd5VT+VDxZ6T//qmHJ+4+4c=;
        b=qVoJJfnyibWSf36Pm2N2SPhy9vcLXbq1PZ3JWBxOuzKfvLHz7SRAIPm/nje0xtsVq/
         tJ+lGd/VB3dN1PbiaKZGUftm7TGrHFoKalvnXnfvSqVBWxmYJxbLiO6ISOQvYyKhkZ+f
         +QM7p2SX905hFGmcuq5gvQvL7MBNrX8+aRVOaurqc9CKQrrBtox2fJ1MIX4OYXZCOtXE
         k1oeI+GUvgBGiGQFug8diHWRPo0V964fWlraxXjtGMkPRugGbenM/BQNMn3XVlWjbx+b
         q5y4JBRfCDSaBQGHwRer5wjKDconnlY1ZcXxytG7sL/8gOpNLJrZkZdLGRPu+nLLN9Xa
         Ba5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QMS9fD/WrWFkaVLvvHnWkd5VT+VDxZ6T//qmHJ+4+4c=;
        b=WCqOEAscNvF42xVI9TVvDhJKpDJt+w7FGxxk14fzRQ4zbYXwpMHoXATRId+cJV774h
         Gwqaa044u8t3RuiKBlJLvbZEvj8dX2a5aO3XNLlcghJ6UsCfPnBA4zF+sd91Avfqifot
         HyT2cnEG+p68KpDd9Zbw6XekKDqXjOqbIUvk41S6Hdfg9mrhe/mYlpa6m366d4h4gIgD
         TILN8wD/eDrxx8oN6saO0g4RCSuM6DdcJz0ckXI/HXxUwvDKqmxnjPA6yUGBWg8kfvGf
         bG6VP9VliCQBoUlHllf8ADIKskCChGWpwPnMvbd/vkI4W17IeaEoiA5nTYpPeTAH1itQ
         Ln6Q==
X-Gm-Message-State: AOAM530M7uVaSRCQWujCOgon0g15LNYlHpk21ys2P90MYV4JBFbtKBXi
        5kvAle0tPfI4gMbBla2DoQA=
X-Google-Smtp-Source: ABdhPJyszo4zBZb8TzfgxUrfRI901tPnpok7/CKn0J2WsWlYDQP77Q2m0NVRALZfxuccs5N51D54sA==
X-Received: by 2002:a50:ee97:: with SMTP id f23mr4474666edr.31.1643303158993;
        Thu, 27 Jan 2022 09:05:58 -0800 (PST)
Received: from skbuf ([188.27.184.105])
        by smtp.gmail.com with ESMTPSA id l3sm8898616ejg.44.2022.01.27.09.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:05:58 -0800 (PST)
Date:   Thu, 27 Jan 2022 19:05:57 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] arm64: dts: ls1028a-qds: define mdio slots for
 networking options
Message-ID: <20220127170557.v7lg3harlf2skeqi@skbuf>
References: <20220126092650.19962-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126092650.19962-1-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:26:50AM -0600, Li Yang wrote:
> The ls1028a QDS board support different pluggable PHY cards.  Define the
> nodes for these slots to be updated at boot time with overlay according
> to board setup.
> 
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This fixes:
=> tftp $fdt_addr_r fsl-ls1028a-qds.dtb && tftp $fdt_ovr_addr_r fsl-ls1028a-qds-85bb.dtb
=> fdt addr $fdt_addr_r && fdt resize 0x100000 && fdt apply $fdt_ovr_addr_r
failed on fdt_overlay_apply(): FDT_ERR_NOTFOUND

>  .../boot/dts/freescale/fsl-ls1028a-qds.dts    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 177bc1405f0f..19d3952dbffe 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -107,6 +107,30 @@ qds_phy1: ethernet-phy@5 {
>  				reg = <5>;
>  			};
>  		};
> +
> +		mdio_slot1: mdio@4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <4>;
> +		};
> +
> +		mdio_slot2: mdio@5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <5>;
> +		};
> +
> +		mdio_slot3: mdio@6 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <6>;
> +		};
> +
> +		mdio_slot4: mdio@7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +		};
>  	};
>  };
>  
> -- 
> 2.25.1
> 
