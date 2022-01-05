Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6035E484F41
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbiAEIYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:24:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59604 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiAEIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:24:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4801760FD2;
        Wed,  5 Jan 2022 08:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA530C36AE9;
        Wed,  5 Jan 2022 08:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641371073;
        bh=Glpkj1KcZnNZbZ/VBEkml8yh5tq2RrH+wGMUlhm4xr0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Su4fBo4tiV2LtzQZzXRQUmn0MRG3NinY0sl8mNRTF7aj38iJGax1OU79k8Vo86xzm
         mTUklWGcG0jnpxtWVBR7utItSaqc5xwFi4Z/4uBX/crnNi/fmoftsiV0AvGunRZAAM
         xyKRVly+TsaFeVeqIo42haTnPK+iNuJrZipWaCf54rSL6oWtnXYY4yS+WqYnipnphx
         auz3ZT9qlTh+apyho14i1jOQdeNY+c1EMfyKCCXRGa3zQTmPgjHw+vn3l0IkFSNAwd
         o78eDD/8B7VToOz66JwPcR8O1ju5rJhL/omIJquxJ5wJ1Y+uKSTmwNDLvR9VRVBeFa
         xgi5v2fkyvikA==
Message-ID: <73f0b849-223a-11a8-8238-4d29a3ccef0b@kernel.org>
Date:   Wed, 5 Jan 2022 10:24:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] dt-bindings: interconnect: imx8m-noc: Add
 fsl,icc-id property
Content-Language: en-US
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220103192900.946521-1-abel.vesa@nxp.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220103192900.946521-1-abel.vesa@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On 3.01.22 21:28, Abel Vesa wrote:
> Add documentation for fsl,icc-id property.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>   .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml      | 5 +++++

Please CC the DT mailing list.

>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> index b8204ed22dd5..4924743e8cb1 100644
> --- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> @@ -47,6 +47,11 @@ properties:
>     operating-points-v2: true
>     opp-table: true
>   
> +  fsl,icc-id:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description:
> +      unique ID used for linking i.MX bus or ddrc node to inteconnect

s/inteconnect/interconnect/

Thanks,
Georgi

> +
>     fsl,ddrc:
>       $ref: "/schemas/types.yaml#/definitions/phandle"
>       description:

