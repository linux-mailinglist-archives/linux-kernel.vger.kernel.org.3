Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77F34C3FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiBYIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiBYIXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:23:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9EB180D24;
        Fri, 25 Feb 2022 00:22:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EC66B82AB8;
        Fri, 25 Feb 2022 08:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C80C340E7;
        Fri, 25 Feb 2022 08:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645777359;
        bh=h4M7TWzHmz7Q4X/YiAL28HmdTihIVjng7o6LYmmkWNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAEL1AGWbVLcycWd0/6g8QhGPWjYxN/45/iuOlg3/zW78PTzfZK/6D1JU7InhQ31k
         nq6ws4/J1G+p4nla6VE31B74uyD96bSW44jLYvoPFMxy0Mnp4WukWRD4qMYsow77WP
         mBaxTnK27z/JhELuXVDfPsOS1O7c3ySA2yNE8n2bboODB/K15ghThfuYY2lY00FrKi
         jcWJXsR0/tNjeh7Hv3+n/YlUEc7CKM4PkSX/npOKn/pMdzsvvJKNmu+qP2/DuPcT54
         H4wNmSTeK43ZQpGeYfDj1JjSF+YbKx2Ly1TaHcDRoWNstzFqE4GBGhgFOvH6sXrRM/
         g1WN6GyaZrN9g==
Date:   Fri, 25 Feb 2022 13:52:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/4] dt-bindings: phy: Add compatible for D1 USB PHY
Message-ID: <YhiRyq7k5jtSKlni@matsya>
References: <20220203013558.11490-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203013558.11490-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-22, 19:35, Samuel Holland wrote:
> D1 features one OTG port and one host port, like the A64 SoC, so its
> USB PHY supports the same set of properties. Add the new compatible to
> the existing binding.

Rob?

> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
> index 078af52b16ed..0fa4b32b097e 100644
> --- a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
> @@ -15,7 +15,9 @@ properties:
>      const: 1
>  
>    compatible:
> -    const: allwinner,sun50i-a64-usb-phy
> +    enum:
> +      - allwinner,sun20i-d1-usb-phy
> +      - allwinner,sun50i-a64-usb-phy
>  
>    reg:
>      items:
> -- 
> 2.33.1

-- 
~Vinod
