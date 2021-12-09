Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCCD46E827
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbhLIMLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:11:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48908 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233676AbhLIMLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:11:48 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EFB41EC04D3;
        Thu,  9 Dec 2021 13:08:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639051689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dMxp/gGeAoEUpCT2uqegcuVBMsanPN/e8GbMQ6Bh64s=;
        b=VL92LyaeWAhSUNBriozC7zdOYcTYSsP4lck2rgTJwnI6oRHAWxayYBJnajv3sWKP6qST88
        lvDkL5wT+G7MYKy5IHzG1qIxEeN8Z2aMe3B2rq84GeZBBodrvPEyNaJJ80s7joTIXhPaGf
        dx8koIQ+ULNOC5oA1qfVbZ5uiUwpcUo=
Date:   Thu, 9 Dec 2021 13:08:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH v13 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
Message-ID: <YbHxq9oGAdY09gVb@zn.tnic>
References: <20211116162116.93081-1-jarkko@kernel.org>
 <20211116162116.93081-2-jarkko@kernel.org>
 <f25d95e6-e129-597b-5d93-d7264feae8b8@intel.com>
 <YbCEl9kqhTz2iOY2@zn.tnic>
 <32abd0a7-bc3c-f7a7-3330-8287ef05131c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32abd0a7-bc3c-f7a7-3330-8287ef05131c@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:38:11AM -0800, Dave Hansen wrote:
> I reworked the changelog quite a bit, addressing some of Borislav's
> questions.  No code changes, though.
> 
> The result is below.  I've retained Greg's ack.  I'll stick this in
> tip/x86/sgx if this looks OK to everyone.

It does, thanks for taking the time!

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
