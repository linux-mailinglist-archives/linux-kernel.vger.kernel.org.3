Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928F948F398
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiAOA6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:58:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:33768 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiAOA6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:58:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61C86CE24C2;
        Sat, 15 Jan 2022 00:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0E5C36AE7;
        Sat, 15 Jan 2022 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642208300;
        bh=McnEXYJd55Dz/0s+UTqoEnDni3cdecySuuj+DIbfTCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rO6sYCB1zx3VR1h4CXXO38hSKfTDq7qJ24l1I7kDdd1AEm7JPYkSK77vewZY7OBf0
         L6FLM/EU7QqAGKFE3Uln4Q8sAtY5ltJRVWQMl+vQm9tGA7UMg6bMvpTfrSYu06+8xp
         CEQGQcgfMLQlLcApW57I509ytFJw25EHtiQ4Tx0IeBM9bTShAcQErnhkeimEd0nQl8
         +ky9f5AZ0l3N8E03R3m1+sSwXrv0uxuXaUDHiQLPYwnrZznI9nqDdWp45Rz2/ZYCId
         HRNUMu1HFS90DCcnb/vRMgDD4g47TIKCwvZY1MDqUpMbIK9eSWmA18BO3SEEHHCJNA
         A/8pzLpWr0l1A==
Date:   Sat, 15 Jan 2022 02:58:08 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/sgx: account backing pages
Message-ID: <YeIcIMNUK/ujMTMQ@iki.fi>
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-3-kristen@linux.intel.com>
 <Ydm2Qk8JFwgdueZa@iki.fi>
 <fda3bb7bd557a37112a4f7c6c205871addda1bd3.camel@linux.intel.com>
 <YeIMqd+o//M3vB6e@iki.fi>
 <3b7e79ea-18f2-afe2-be4e-401524b481f7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7e79ea-18f2-afe2-be4e-401524b481f7@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:55:43PM -0800, Dave Hansen wrote:
> On 1/14/22 3:52 PM, Jarkko Sakkinen wrote:
> >> I can understand your hesitation, but I agree with Dave here that
> >> wrapping the function makes the code more clear. I would prefer to keep
> >> this the way it is.
> > What if sgx_encl_get_backing() was changed as "static inline", if the
> > only motivation is encapsulation?
> 
> What would the purpose be of adding an 'inline' to the function definition?

Agreed, not much sense to do this. I just had troubles to get the way
things were encapsulated before your response.

/Jarkko
