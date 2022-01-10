Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BAA4896C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbiAJKwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbiAJKw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:52:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9946FC061751
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:52:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4191B61262
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0559C36AE3;
        Mon, 10 Jan 2022 10:52:22 +0000 (UTC)
Date:   Mon, 10 Jan 2022 10:52:19 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Generalize ARCH_HAS_FILTER_PGPROT
Message-ID: <YdwP40C8Zu8s2Az0@arm.com>
References: <1641796896-16960-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641796896-16960-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:11:36PM +0530, Anshuman Khandual wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5c2ccb85f2ef..d9594e05fddb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -328,9 +328,6 @@ config GENERIC_CALIBRATE_DELAY
>  config ARCH_HAS_CPU_RELAX
>  	def_bool y
>  
> -config ARCH_HAS_FILTER_PGPROT
> -	def_bool y

Aren't you missing a select for x86?

-- 
Catalin
