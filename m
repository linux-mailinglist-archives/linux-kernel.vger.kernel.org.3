Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F04BF253
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiBVG4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:56:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiBVG4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:56:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B461111BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:55:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B69A96077B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68DBC340E8;
        Tue, 22 Feb 2022 06:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645512937;
        bh=aHbl0umTQOj534Uobo3+upnZJRJmo6o3DEZLEbvbXtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZ29PDc22tFmjuzYTO3QgeB4lUqtyJLYDTpCnaGDeX25+P68RkxfgJrQa8LxL1ZPN
         gOmXS6r24FDEm3P48lt4ZPiFQpir5kebUHI71Leo4R0imqfPLWop5/j9UhFOdCEYm5
         K1LlUA+RnmD9BOrKG6AgOYAMxo1nDuxt+kq3WD4qQVm6REIZIRJ/pnQ2DiRrK4qWfj
         3q4AqmnHu99hLAKRhtrrLiWmjucjs5mRAaeFLtuHeyhFmzABjOMtbl9f6OktPEzzsD
         v2vs0y4WpcufY0kb+sskS/w4oYrpztDtCv/4XLLufDV0+leBoMrcUWFkQpqgifdkVg
         Ez8J/nBOJE53Q==
Date:   Tue, 22 Feb 2022 14:55:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v3] bus: imx-weim: add DT overlay support for WEIM bus
Message-ID: <20220222065531.GY2249@dragon>
References: <20220205055006.23447-1-i.bornyakov@metrotek.ru>
 <20220222052059.23610-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222052059.23610-1-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:20:59AM +0300, Ivan Bornyakov wrote:
> Add OF reconfiguration notifier handler for WEIM bus to setup Chip
> Select timings on runtime creation of child devices.
> 
> However, it is not possible to load another DT overlay with conflicting
> CS timings with previously loaded overlay, even if the first one is
> unloaded. The reason is that there is no acces to CS timing property of
> a device node being removed, thus we can't track which of configured CS
> are available for re-configuration.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
> Changelog:
>   v1 -> v2: minor style fixes
>    * rename "priv" -> weim_priv"
>    * remove excessive newline
>   v2 -> v3: minor style fixes
>    * rename "weim_data *weim_priv" -> "weim_priv *priv"
> 
>  drivers/bus/imx-weim.c | 135 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 126 insertions(+), 9 deletions(-)

Applied, thanks!
