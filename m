Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA0C478465
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 06:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhLQFOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 00:14:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58060 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232847AbhLQFOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 00:14:31 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my5ZZ-0007Au-DN; Fri, 17 Dec 2021 16:14:26 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 16:14:25 +1100
Date:   Fri, 17 Dec 2021 16:14:25 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v3] crypto: hisilicon - replace 'smp_processor_id' with
 the raw version of the macro
Message-ID: <20211217051425.GA20625@gondor.apana.org.au>
References: <20211206105109.21847-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206105109.21847-1-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 06:51:09PM +0800, Kai Ye wrote:
> smp_processor_id() is unsafe if it's used in a preemption-on critical
> section. It will cause the call trace when the preemption-on and sets the
> CONFIG_DEBUG_PREEMPT. So replace 'smp_processor_id' with the raw version of
> the marco in preemptible to avoid the following call trace:

What you wrote here makes zero sense.  If smp_processor_id is
unsafe then the raw version is even more unsafe.

Please provide the actual justification as to why it is *safe*.

Even better, put the justification in the patch as a comment
instead of the changelog.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
