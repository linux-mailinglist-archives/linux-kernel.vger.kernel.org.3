Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A08554448
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354300AbiFVICm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349773AbiFVICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:02:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E7D37A84;
        Wed, 22 Jun 2022 01:02:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E7CF0DD;
        Wed, 22 Jun 2022 10:02:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655884956;
        bh=AXPp6eJK0PtXuZNZMvLyU001mnRYAyn50gy68ytRdyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trDCUOhmWaUzhOzZVhF6eg1wuJhDPezILSWuc10VxhRWFAqy4kS7J/Do+9XIoTpRO
         6Axjk/4p+DAje6oW/0zuAzdWPnByPFcBRrXdFe9XkQMYBaILKzGqP6YdtL9TtrJdpS
         Jto5IZKymQ5Etn39/jNOhy2JKq1jBIoNnmnndAOE=
Date:   Wed, 22 Jun 2022 11:02:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rahul T R <r-ravikumar@ti.com>
Cc:     linux-phy@lists.infradead.org, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        p.yadav@ti.com, tomi.valkeinen@ideasonboard.com,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        sjakhade@cadence.com, mparab@cadence.com,
        devicetree@vger.kernel.org, vigneshr@ti.com, lee.jones@linaro.org
Subject: Re: [PATCH v2 1/3] phy: dt-bindings: cdns,dphy: Add compatible for
 dphy on j721e
Message-ID: <YrLMi+nWZA/HM+U+@pendragon.ideasonboard.com>
References: <20220622075340.16915-1-r-ravikumar@ti.com>
 <20220622075340.16915-2-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622075340.16915-2-r-ravikumar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

Thank you for the patch.

On Wed, Jun 22, 2022 at 01:23:38PM +0530, Rahul T R wrote:
> Add compatible to support dphy tx on j721e
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> index c50629bd1b51..f0e9ca8427bb 100644
> --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> @@ -11,8 +11,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> -      - const: cdns,dphy
> +    enum:
> +      - cdns,dphy
> +      - ti,j721e-dphy
>  
>    reg:
>      maxItems: 1

-- 
Regards,

Laurent Pinchart
