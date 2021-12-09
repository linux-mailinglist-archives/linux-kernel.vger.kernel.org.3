Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E2946E66B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhLIKQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:16:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44710 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbhLIKQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:16:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2DB08CE2558
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 10:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84348C004DD;
        Thu,  9 Dec 2021 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639044752;
        bh=5CVuyzSpwPK5TmWLQ6fBTGjSuL2lka26uX4aq31y1Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThThVIeoFPj3DMZpyWlvdzqY+FnkqnUfV5IvxLRr4hbTmRLTbsc6wLmL/p0Hh/rHV
         rMuMUq0lRg9KHKaJgJQIp1GQn3YxlUJvToDgw7MiufeocpGwfUYrNebta1o5g6L+Pm
         AXfOmtuB8m75iquG2rVJX0cZN03fvzPTBz6ZTEE2cgFdOEWgrwiz9XOA9xQcUoVYNX
         iP325P9UhQ7HdcPVCtQa/slAvxHWWBJeF4jhO0XLD/nIIkPOR1VMdehp1GVT3Nuw2w
         pCZEQfjxBp0mYuWkdPSefQuonUsfnhs8X3fRL0JoaWFeKO2AA3Nk7+VasMnJsFSSLV
         Rh6H90IoEEVYw==
Date:   Thu, 9 Dec 2021 10:12:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 02/15] KVM: arm64: Provide {get,put}_page() stubs for
 early hyp allocator
Message-ID: <20211209101226.GB1833@willie-the-truck>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201170411.1561936-3-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:03:56PM +0000, Quentin Perret wrote:
> In nVHE protected mode, the EL2 code uses a temporary allocator during
> boot while re-creating its stage-1 page-table. Unfortunately, the
> hyp_vmmemap is not ready to use at this stage, so refcounting pages
> is not possible. That is not currently a problem because hyp stage-1
> mappings are never removed, which implies refcounting of page-table
> pages is unnecessary.
> 
> In preparation for allowing hypervisor stage-1 mappings to be removed,
> provide stub implementations for {get,put}_page() in the early allocator.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/early_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
