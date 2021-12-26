Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0053947F66F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhLZKk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 05:40:27 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:56548
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231689AbhLZKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 05:40:26 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AioyOGKOEZHwESC3vrR1GlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQa5hWgi0GYCyWBKD2zUMvvbYTfze4siPd6zp0oD68PVm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM9n9BDpC79SMljPvSGOKlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFCtq?=
 =?us-ascii?q?piLf2dCXmQJaCYE7Q2jwPAfHk20cZzsAx+v9T2P40a1pTijzPm9luwdFJnZ22U?=
 =?us-ascii?q?wYgeKPW8AgYe0AASHkuZ/IuFLjvZCLXXdao51LPdXT1wvNhJF83I4pe8eFyaUl?=
 =?us-ascii?q?I9PcfLDkWKAiKg+Om6LO+Q+YqiN5LBMLsN4gekmpx1i3UCPtgRZHbHePE/7dw2?=
 =?us-ascii?q?DY2m9ALHvvEYccdQSRgYQ6GYBBVPFoTTpUkk4+VatPXG9FDgAvK/uxuuTGVklw?=
 =?us-ascii?q?3gOWrKtfLPMeEX4NTk1rwm44PxEyhajlyCTBV4WPtHqqQu9Ly?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Agl1q9a0/H57IXdiBvtS9jwqjBLUkLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynApp8mPHPP4gr5HUtApTniAtjkfZq/z/5ICOAqVN+ftUvdyQ?=
 =?us-ascii?q?iVxepZg7cKrQeNJ8SzzJ8+6Y5QN5k7MtH2AFRg5PyW3CCzGb8br+W6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,237,1635199200"; 
   d="scan'208";a="1030827"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 11:40:25 +0100
Date:   Sun, 26 Dec 2021 11:40:24 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Qing Wang <wangqing@vivo.com>
cc:     Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: adjust the confidence of fen.cocci
In-Reply-To: <1639484373-76061-1-git-send-email-wangqing@vivo.com>
Message-ID: <alpine.DEB.2.22.394.2112261139500.3217@hadrien>
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
>
> So, lower its confidence to low.

I have made a patch to delete this.

julia

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
