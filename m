Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EC74771D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhLPMaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:30:21 -0500
Received: from mx24.baidu.com ([111.206.215.185]:37490 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229452AbhLPMaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:30:20 -0500
Received: from BJHW-Mail-Ex14.internal.baidu.com (unknown [10.127.64.37])
        by Forcepoint Email with ESMTPS id 5235F69EC4227F8F1B95;
        Thu, 16 Dec 2021 20:30:15 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex14.internal.baidu.com (10.127.64.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 16 Dec 2021 20:30:15 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Thu, 16
 Dec 2021 20:30:14 +0800
Date:   Thu, 16 Dec 2021 20:30:14 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-spdx@vger.kernel.org>
Subject: Re: [PATCH v3] LICENSES/LGPL-2.1: Add LGPL-2.1-or-later as valid
 identifiers
Message-ID: <20211216123014.GA286@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <12f38ebde4dcd8b1ecbd37df1b6ce2018426f6dd.1639657049.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12f38ebde4dcd8b1ecbd37df1b6ce2018426f6dd.1639657049.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex12.internal.baidu.com (10.127.64.35) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex14_2021-12-16 20:30:15:262
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 12月 21 13:17:35, Mauro Carvalho Chehab wrote:
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
> index 27bb4342a3e8..b73f9b6230f5 100644
> --- a/LICENSES/preferred/LGPL-2.1
> +++ b/LICENSES/preferred/LGPL-2.1
> @@ -1,5 +1,7 @@
>  Valid-License-Identifier: LGPL-2.1
> +Valid-License-Identifier: LGPL-2.1-only
>  Valid-License-Identifier: LGPL-2.1+
> +Valid-License-Identifier: LGPL-2.1-or-later
>  SPDX-URL: https://spdx.org/licenses/LGPL-2.1.html
The URL is deprecated, do we need to update it together.
The same, GPL-2.0, LGPL-2.0
>  Usage-Guide:
>    To use this license in source code, put one of the following SPDX
> -- 
> 2.33.1
> 
