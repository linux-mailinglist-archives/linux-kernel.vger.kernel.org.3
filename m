Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7DA47F673
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 11:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhLZKpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 05:45:20 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:35642
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhLZKpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 05:45:18 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Ax9blH6NnC5TFsKfvrR04lcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdVK/1Dgq0zcGnGcZD26GOP6OMGOge9x/b4zj/UJX7cTUm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM9n9BDpC79SMljPvSGOKlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFCtq?=
 =?us-ascii?q?piLf2dCXmQJaCYE7Q2jwPAfHk20cZzsAx+v9T2P40a1pTijzPm9luwdFJnZ22U?=
 =?us-ascii?q?wYgeKPW8AgYe0AASHgmZP0uFLjvZCLXXdao51LPdXT1wvNhJF83I4pe8eFyaUl?=
 =?us-ascii?q?B8OEcLD0XRgKCguisyfS6TPNtj4ItNqHDOoIUvXVp1nfBBPInUbjCRqzFo9FCt?=
 =?us-ascii?q?B81h8tOFPKYY8kcbRJqZQ7DZANOfFEaFPoWl+CjjXjXaCxDtF+QqOwz4nCNigJ?=
 =?us-ascii?q?ruJDpMdzIapmJSN9Tk0KwuG3L5SL6DwscOdjZziCKmk9ALMencTjTAd1JUuTir?=
 =?us-ascii?q?7g00BvDmyoJBQNQTlWh5/+0liaDtxtkAxR80kITQWIarSRHluXAYiA=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALhloWaxXwTDrPaSbWBZUKrPwK71zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfq+V98jzuSWftN9VYhAdcLO7Scy9qBHnlaKdiLN5VYtKHjOW21?=
 =?us-ascii?q?dAR7sN0WKN+VHd8mHFh4xg/JYlQuxFBNr8AUMSt6vHyQOzeuxO/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,237,1635199200"; 
   d="scan'208";a="1031018"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 11:45:18 +0100
Date:   Sun, 26 Dec 2021 11:45:16 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Qing Wang <wangqing@vivo.com>
cc:     Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: adjust the confidence of
 uninitialized_var.cocci
In-Reply-To: <1639484387-76107-1-git-send-email-wangqing@vivo.com>
Message-ID: <alpine.DEB.2.22.394.2112261141070.3217@hadrien>
References: <1639484387-76107-1-git-send-email-wangqing@vivo.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2021, Qing Wang wrote:

> From: Wang Qing <wangqing@vivo.com>
>
> Since uninitialized_var() was removed, this cocci should reset its
> confidence to low.

I'm not sure to understand the argument for this one.  The semantic patch
in its current state is looking for declarations that hide an
uninitialized variable.  The part about the uninitialized_var macro is not
there any more.  The problem that is searched for seems reasonable to
address.

julia

>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  scripts/coccinelle/misc/uninitialized_var.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
> index 69bbaae..79e02e3
> --- a/scripts/coccinelle/misc/uninitialized_var.cocci
> +++ b/scripts/coccinelle/misc/uninitialized_var.cocci
> @@ -18,7 +18,7 @@
>  /// this kind were cleaned-up from the kernel. This cocci rule checks that
>  /// the macro is not explicitly or implicitly reintroduced.
>  ///
> -// Confidence: High
> +// Confidence: Low
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
>  // Options: --no-includes --include-headers
>  //
> --
> 2.7.4
>
>
