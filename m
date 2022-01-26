Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7F49C010
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiAZARx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiAZARw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:17:52 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F49C06161C;
        Tue, 25 Jan 2022 16:17:52 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 13C46383;
        Wed, 26 Jan 2022 00:17:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 13C46383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643156272; bh=kA7Bg7qvtmrUfbRb06aZ4u5fw96B24wNIHY5jnOQq18=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SWBvYG1w7DJQlYE4025Ke6QV3o3HLZrDpY2wxl2IGvdguJfCgvVQ1DJ62k3hSCaL/
         fiAhcKX0jDiC4uXLCwhLrkBwMq/bKVsIRcqAYWtIEWbvh/F4bEiJm074SxvTRKeQsK
         mILjVJX0WIpmgwDuS9RNNQLG5T/s2RHVrMbbXWDI0PGeyvmzawmaYmknhvtKCQyeyx
         ZaNEgaGqGFe2+oDID8qakfPnmJoNf356u+vEP5+zys2simKMU/SDiGd60QAX2QS0GI
         +qktAK/4S4y83RLD/9Bol7l5G2xm52tAkCjPASIGfoH2gYf2TF6NC/gTiQVa4jpl2r
         9x2zdTKiwifJQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/vm: Fix typo in *harden*
In-Reply-To: <20220117111338.115455-1-pmenzel@molgen.mpg.de>
References: <20220117111338.115455-1-pmenzel@molgen.mpg.de>
Date:   Tue, 25 Jan 2022 17:18:20 -0700
Message-ID: <87bkzzwdrn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menzel <pmenzel@molgen.mpg.de> writes:

> Fixes: df4e817b7108 ("mm: page table check")
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  Documentation/vm/page_table_check.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/vm/page_table_check.rst b/Documentation/vm/page_table_check.rst
> index 81f521ff7ea7..1a09472f10a3 100644
> --- a/Documentation/vm/page_table_check.rst
> +++ b/Documentation/vm/page_table_check.rst
> @@ -9,7 +9,7 @@ Page Table Check
>  Introduction
>  ============
>  
> -Page table check allows to hardern the kernel by ensuring that some types of
> +Page table check allows to harden the kernel by ensuring that some types of
>  the memory corruptions are prevented.

Applied, thanks.

jon
