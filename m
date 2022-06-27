Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627AF55C7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbiF0Okg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiF0Oke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:40:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228DCBE3F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:40:32 -0700 (PDT)
Received: from zn.tnic (p200300ea9746579d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:579d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A6221EC0324;
        Mon, 27 Jun 2022 16:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656340826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5Uw0AJzcz+NaVP9+fmQVzmmgxZlLX/u7bhWmR6+QNVg=;
        b=nxhiv/7MWD6J1g1BiymOqQXKB7/6tilsS8SNk+8wU2gCWigCHqKQmasQKoDIWh0WcnXIkH
        xt2cqZGeto8MWLFG1G2PT9wT41ppg7TWMXQCG4rDEwSzI3YFRyVaDFPd5Y2WhBfY4EBuv4
        pwKz876sFyXzxCeUzWaYFvzGT4EJTP8=
Date:   Mon, 27 Jun 2022 16:40:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] RAS/CEC: Reduce default threshold to offline a page to
 "2"
Message-ID: <YrnBWjkX82OhXAtL@zn.tnic>
References: <20220607212015.175591-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607212015.175591-1-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 02:20:15PM -0700, Tony Luck wrote:
> A large scale study of memory errors in data centers showed that it is
> best to aggressively take pages with corrected errors offline. This is
> the best strategy of using corrected errors as a predictor of future
> uncorrected errors.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> Here's the link to the study. I thought of putting into the code
> comment, or the commit comment. But these links are sometimes changed
> as website is re-organised, making the link stale.
> 
> https://www.intel.com/content/dam/www/public/us/en/documents/intel-and-samsung-mrt-improving-memory-reliability-at-data-centers.pdf
> 
> The paper has two recommendations:
> 1) Change threshold to "2".

Kinda unconditional that... we haven't talked to other vendors even.

> 2) Do very smart platform dependent things

If you mean AI, that probably won't happen in the kernel.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
