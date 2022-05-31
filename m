Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB3539997
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbiEaWfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348491AbiEaWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:35:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8389E9DD;
        Tue, 31 May 2022 15:35:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (lmontsouris-659-1-41-236.w92-154.abo.wanadoo.fr [92.154.76.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A2B06F0;
        Wed,  1 Jun 2022 00:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654036503;
        bh=5wGWNsYpV/rqdoGt8KcWqJ6na3ftVpXTTaFU84KJud4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZMOsUcvBCXrCDZqZ5Vk1HZDEdCWQw5wJ6lkzg1wtZYwojhkvHDDKh/qS7rn6/Zqg
         zlK9FjcoON8eLj0Uwfs8G9mHHrgs3/uKt3QaUV2tRqTY3GkWu+gbxn0bAHaDWWs8dM
         bKm4Bwkbv6eWBtO1b5YwCZPZRLs6WPlTAJMlM/8k=
Date:   Wed, 1 Jun 2022 01:34:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robherring2@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the devicetree-fixes
 tree
Message-ID: <YpaYEtWSEyD7WKCU@pendragon.ideasonboard.com>
References: <20220601082959.2fefa1e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601082959.2fefa1e7@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 08:29:59AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   adb97f9f8442 ("dt-bindings: soc: imx8mp-media-blk-ctrl: Fix DT example")
> 
> Fixes tag
> 
>   Fixes: 584d6dd668e2 ("dt-bindings: soc: Add i.MX8MP media block control DT bindings")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 8b3dd27bfe47 ("dt-bindings: soc: Add i.MX8MP media block control DT bindings")

My bad, that's the correct SHA1.

-- 
Regards,

Laurent Pinchart
