Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C77F46E74C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhLILNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbhLILNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:13:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01667C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:09:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC875B8243C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E3FC004DD;
        Thu,  9 Dec 2021 11:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639048176;
        bh=VP6MRp/SOq7XOhf3FZQo/PNQmsVcRMAIn1+Uf+bBfs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uo1FZGUEHBNoxenzO8hUgEHTwU9ArYp4ZEjisLJDdO55swq8JpFB7qUNaICQdqh6a
         8S2bVDYrLtrS+t3qLYI4ut6IoVJAzUeaEDo+jIo1jgsIo/58Ocj+26BtQz1yOzHF43
         jGfiO0rmu7O7lJdQH6q6zaQpjg2PT2kvf70C1GqzUzbovI8YDszICqGGacfH1ONfra
         fZhJm9/ZkEWiOAUM+WK3lqKPFFqh0iKiDJF11LVf/4tDsZ8JcLzXT6xX4Lk/WNrC+5
         d+fSAbJkZdjNcPdu4R7V+ltg1COBunKbwn7W+vFtTrhLsHuU92cLfe+sIlQEwvcdxS
         ZvW/z6e/nPq7g==
Date:   Thu, 9 Dec 2021 11:09:31 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 04/15] KVM: arm64: Fixup hyp stage-1 refcount
Message-ID: <20211209110930.GA1912@willie-the-truck>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-5-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201170411.1561936-5-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:03:58PM +0000, Quentin Perret wrote:
> In nVHE-protected mode, the hyp stage-1 page-table refcount is broken
> due to the lack of refcount support in the early allocator. Fix-up the
> refcount in the finalize walker, once the 'hyp_vmemmap' is up and running.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/setup.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
