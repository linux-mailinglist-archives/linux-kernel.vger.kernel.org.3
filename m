Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28363550820
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiFSDkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiFSDk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86995EE0A;
        Sat, 18 Jun 2022 20:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C77F60F31;
        Sun, 19 Jun 2022 03:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A747C341C5;
        Sun, 19 Jun 2022 03:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655610027;
        bh=xIBW4zY8o0dIMBDkNL+vL5e593wLZH72rGNycDvq6g0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quIGM6FY6UkXU19LL3wVxd5wenzFHp7sT0yVHQpeIIYKU7jqHpt5kUHpFCMwZuAr4
         3fxK1Uay2polsUlUJQp2V77TrNxL0SchGbEg/p4dstxx6GdyN7NDHmZ5BYWySmF8WI
         gMRN+PVgJqSJl+n5R4BKdBsLwVeulQyUACVyP/WVUEYjb/kKaTmGAy7GVpQBRelX+W
         ClA/30ko6DxZf5AZj0E6AN9A3dPjxw/a0dxLXlm9ZEiPXxQH+vWlZrzMRSJ7GHo9A0
         cuP0MFlaRxY15efHZgIVkAlgnnGYT9o5LsxKCWN95Q+cZS/17FkSTOfltU7699FLzi
         Qzar2hWbwpINw==
Date:   Sun, 19 Jun 2022 11:40:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: imx25: support silicon revision 1.2
Message-ID: <20220619034022.GZ254723@dragon>
References: <20220602080344.208702-1-martin@kaiser.cx>
 <20220602080344.208702-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602080344.208702-2-martin@kaiser.cx>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 10:03:42AM +0200, Martin Kaiser wrote:
> Update the mx25_read_cpu_rev function to recognize silicon revision 1.2
> for imx25 chipsets.
> 
> Silicon revision 1.2 is mentioned in the errata document at
> https://www.nxp.com/docs/en/errata/IMX25CE.pdf. The imx25 chips on my
> test boards show revision 1.2 as well.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied this one, thanks!
