Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9428C477153
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhLPMGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbhLPMGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:06:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D283C061574;
        Thu, 16 Dec 2021 04:06:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0FB661D55;
        Thu, 16 Dec 2021 12:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9565BC36AE3;
        Thu, 16 Dec 2021 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639656389;
        bh=5q3maKmBNtBFHFRE5qIwOGTWJO8+mChbksY8wKDAGiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gM6KkgAWNq+zfBq+1OthpdJl0t71Rm6bnXNex5UXttvvchJ+hQALClKcJ6nBjVi/4
         8yU0RLkXGbP1qOLurLEaWPwXzEJR7Joe15wIRonDHzieF2iyXPBx97bzBcM547jJ0j
         WpRcpZ0YC0c1Gs2STb9rEKzaLQ689wIUG6lv1pfc=
Date:   Thu, 16 Dec 2021 13:06:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH v2] LICENSES/LGPL-2.1: Add LGPL-2.1-or-later as valid
 identifiers
Message-ID: <YbsrwkfDb19cnHXT@kroah.com>
References: <4f45e733caaa08b8b13f8cfd95848cc5ea89bfba.1639654324.git.mchehab+huawei@kernel.org>
 <0af6460832237cbec13ff403695cf90e75488e96.1639654402.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af6460832237cbec13ff403695cf90e75488e96.1639654402.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 12:33:33PM +0100, Mauro Carvalho Chehab wrote:
> Some files have been flagged with the new LGPL-2.1-or-later
> identifier which replace the original LGPL-2.1+ in the SPDX license
> identifier specification, but the identifiers are not mentioned as
> valid in the LGPL-2.1 license file.
> 
> Add it, together with the LGPL-2.1-only at the the license file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  LICENSES/preferred/LGPL-2.1 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/LICENSES/preferred/LGPL-2.1 b/LICENSES/preferred/LGPL-2.1
> index 27bb4342a3e8..5feb8a6dbf15 100644
> --- a/LICENSES/preferred/LGPL-2.1
> +++ b/LICENSES/preferred/LGPL-2.1
> @@ -1,5 +1,7 @@
>  Valid-License-Identifier: LGPL-2.1
>  Valid-License-Identifier: LGPL-2.1+
> +Valid-License-Identifier: LGPL-2.1-only
> +Valid-License-Identifier: LGPL-2.1-or-later

Can you sort it like we did in the GPL-2.0 file instead which clumps it
by functionality, not in alphabetical order?

thanks,

greg k-h
