Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E41E4A8AFF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiBCRym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:54:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34938 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiBCRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:54:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7FB7B81C86;
        Thu,  3 Feb 2022 17:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B758C340E8;
        Thu,  3 Feb 2022 17:54:31 +0000 (UTC)
Date:   Thu, 3 Feb 2022 17:54:27 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, christophe.leroy@csgroup.eu,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: Merge pte_mkhuge() call into arch_make_huge_pte()
Message-ID: <YfwW07zuY6T+vjlK@arm.com>
References: <1643860669-26307-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643860669-26307-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:27:49AM +0530, Anshuman Khandual wrote:
> Each call into pte_mkhuge() is invariably followed by arch_make_huge_pte().
> Instead arch_make_huge_pte() can accommodate pte_mkhuge() at the beginning.
> This updates generic fallback stub for arch_make_huge_pte() and available
> platforms definitions. This makes huge pte creation much cleaner and easier
> to follow.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acking v2 as well:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
