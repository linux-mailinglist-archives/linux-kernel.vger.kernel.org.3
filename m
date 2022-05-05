Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6341B51B960
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbiEEHrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiEEHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F678488A0;
        Thu,  5 May 2022 00:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85B861D27;
        Thu,  5 May 2022 07:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A510C385A8;
        Thu,  5 May 2022 07:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651736606;
        bh=65e0k0/tBnHDd217HaOOR58aHTSWAo7J+jduc+rHQoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhcRkZwp05PMIzkZixYnWXPHiJiF6dkvHvGP9sGpL7uABgoSnVNITpSHTzgfwyuUM
         eKgpmKhu/bL186tS6GUa1S0RmEwAZ9EZxmInesSlT/vsx+nOmrOYCtJySam58sthjK
         uwcAP9VMq/1+JZd35WtxI3f6ulb5Ta6hrqTnMTLZf31XyCp80ezoIV5ojpX+h5qiCb
         nZ9XoOseqGpdRzHoWQzYDoufwe2TkFgDWSW8IfSTTSoTavzo32FbMZoIzKTK2XGc3G
         /P1a+iBIu8KTLYI4H8TNUy8mKPpFJmsuzzZehdnA/c9NqYKB3vdRnIbHOcE4vbqq6P
         g64VuuKaE8sFA==
Date:   Thu, 5 May 2022 15:43:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7901: remove unnecessary cpu
 temp override
Message-ID: <20220505074313.GC14615@dragon>
References: <20220429162030.9636-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429162030.9636-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 09:20:30AM -0700, Tim Harvey wrote:
> Remove the unnecessary cpu_alert0 and cpu_crit0 TMU node overrides as
> these are added dynamically by boot firmware based on CPU temperature
> grade.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
