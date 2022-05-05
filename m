Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044AB51B4E9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiEEBDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiEEBDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:03:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EEE222B6;
        Wed,  4 May 2022 17:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1DE661D68;
        Thu,  5 May 2022 00:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFFFC385A4;
        Thu,  5 May 2022 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651712377;
        bh=RzoqizGBgBFxtC+JAKRWKJz/etia4XZv5igTPS9RyEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/o4pfKUV4uJrdUg4XXr8/DJ1dyyQ3RLWI0QdHi5M/aKcI7HzNnQp0h7IXvgzTmMY
         VDQgHJuFIUrlEFRf6tD1JcV3h4xEBuJl925gEUTEJferocDB/1gc/Vo5G3YZDZsp2v
         cepfMhX4Cay0kYFdb50emUzsBXwYyGCvvN0iC3KAm6kc0qNYF9SIGWZ1fFwcv29EeJ
         8thA+gBfM+kF5uyDk2hAZCfrIK2I1akIMWtSRFvBmA09qZJCAo12lwCU9cQIW2hO8A
         CGWnBmoo5ypXBYbUol5zvw8DEiePoaNMV2l96SFZExCSyDOQ1rxFKGCacnSgdHAlxJ
         CZDqW9GjxpY5Q==
Date:   Thu, 5 May 2022 08:59:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Plus EDIMM2.2 Starter Kit
Message-ID: <20220505005918.GD14615@dragon>
References: <20220418144907.327511-2-abbaraju.manojsai@amarulasolutions.com>
 <20220425134224.368908-1-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425134224.368908-1-abbaraju.manojsai@amarulasolutions.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 07:12:22PM +0530, Manoj Sai wrote:
> i.Core MX8M Plus is an EDIMM SoM based on NXP i.MX8M Plus from Engicam.
> 
> EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive Evaluation
> Board from Engicam.
> 
> i.Core MX8M Plus needs to mount on top of this Evaluation board for
> creating complete i.Core MX8M Plus EDIMM2.2 Starter Kit.
> 
> Add bindings for it.
> 
> Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

Applied all, thanks!
