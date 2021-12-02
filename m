Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B416466B98
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349095AbhLBVZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbhLBVZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:25:46 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8AC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 13:22:23 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mstWy-0007ka-Uy; Thu, 02 Dec 2021 22:22:16 +0100
Date:   Thu, 2 Dec 2021 22:22:16 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: r8188eu: odm cleanups
Message-ID: <20211202212216.uev4psqudy3ze2qm@viti.kaiser.cx>
References: <20211202192309.9362-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202192309.9362-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> This series removes unused and some set but never used variables
> from the odm_dm_struct structure.

> Tested on x86_64 with InterTech DMG-02.

> Michael Straube (5):
>   staging: r8188eu: remove unused variables from odm_dm_struct
>   staging: r8188eu: pbNet_closed is set but never used
>   staging: r8188eu: pSecurity is set but never used
>   staging: r8188eu: pNumTxBytesUnicast is set but never used
>   staging: r8188eu: pNumRxBytesUnicast is set but never used

>  drivers/staging/r8188eu/hal/odm.c         | 12 ----
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c |  4 --
>  drivers/staging/r8188eu/include/odm.h     | 73 +----------------------
>  3 files changed, 1 insertion(+), 88 deletions(-)

> -- 
> 2.34.0

Looks good to me. For all patches:

Acked-by: Martin Kaiser <martin@kaiser.cx>
