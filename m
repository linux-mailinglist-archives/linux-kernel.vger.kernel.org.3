Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84C9474327
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhLNNDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:03:24 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45606 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232083AbhLNNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:03:23 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A1RWM1qkAwLAMehxzLvADN8no5gxyJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpz0Dm2VOCjyEaP6KZGqjc4x2adizpkgHuZDcndRiTgdt+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x/RGQ6YnSHuClUbS?=
 =?us-ascii?q?dZngrLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTflFPRrfNNAyKzGJfQam5xBlEvC07lKghXBYeQR4N23PYxJYvl5MT6PRcS?=
 =?us-ascii?q?i9wVkHIsOYAVxhRVSV3IqRC/JfGJ2K+uIqd1SUqdlO1m6U+VR5mYuX0/c4yWwm?=
 =?us-ascii?q?i78cwNzkLYQmCge2e3rOlTa9ngcFLBM/qN4Qbs2om1TjdDOYOQJXKTOPE/7dw1?=
 =?us-ascii?q?zA7jcFmBufFe8ccZHxrbQyeJRNVUn8TCZQjjKKri2P5fjlwtl2Yv+w07nLVwQg?=
 =?us-ascii?q?316LiWOc50PTiqd59klrdomvZ9mD9RAkTLt2EjzuD6HOlwOHV9R4Xkbk6TNWQn?=
 =?us-ascii?q?sOGSnXKroDLNCAraA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AhL62Faxv4DaKalkSv6cAKrPwEb1zdoMgy1kn?=
 =?us-ascii?q?xilNoNJuHvBw8Pre+cjztCWE6gr5N0tKpTntAsO9qDbnm6KdgrNhXotKPjOIhI?=
 =?us-ascii?q?LAFugL0WKh+Vzd8kbFltK1oJ0QCpSWf+eAa2SS4/yW3ODBKadG/DDRytHNudvj?=
X-IronPort-AV: E=Sophos;i="5.88,205,1635199200"; 
   d="scan'208";a="10881787"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 14:03:22 +0100
Date:   Tue, 14 Dec 2021 14:03:22 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Qing Wang <wangqing@vivo.com>
cc:     Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: adjust the confidence of fen.cocci
In-Reply-To: <1639484373-76061-1-git-send-email-wangqing@vivo.com>
Message-ID: <alpine.DEB.2.22.394.2112141402240.2623@hadrien>
References: <1639484373-76061-1-git-send-email-wangqing@vivo.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2021, Qing Wang wrote:

> From: Wang Qing <wangqing@vivo.com>
>
> We scan by coccinelle according to the confidence value, then check for
> potential problems. But the accuracy of this cocci is very low,
> the scan results are all wrong.

Can you give some examples of cases where the results are wrong?

thanks,
julia

>
> So, lower its confidence to low.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  scripts/coccinelle/iterators/fen.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/iterators/fen.cocci b/scripts/coccinelle/iterators/fen.cocci
> index b69f966..7b71207
> --- a/scripts/coccinelle/iterators/fen.cocci
> +++ b/scripts/coccinelle/iterators/fen.cocci
> @@ -2,7 +2,7 @@
>  /// These iterators only exit normally when the loop cursor is NULL, so there
>  /// is no point to call of_node_put on the final value.
>  ///
> -// Confidence: High
> +// Confidence: Low
>  // Copyright: (C) 2010-2012 Nicolas Palix.
>  // Copyright: (C) 2010-2012 Julia Lawall, INRIA/LIP6.
>  // Copyright: (C) 2010-2012 Gilles Muller, INRIA/LiP6.
> --
> 2.7.4
>
>
