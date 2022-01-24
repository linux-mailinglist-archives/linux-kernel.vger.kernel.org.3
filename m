Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98A4977FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbiAXEGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:06:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51520 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiAXEGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:06:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87BF5B80E46;
        Mon, 24 Jan 2022 04:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568A4C340E1;
        Mon, 24 Jan 2022 04:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642997173;
        bh=o/3MvP+MSzWAXqDRstGBMIXdR3ZkDk/is947+21Zhf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6YWa9G3joPJJSEjdIQA2VXNUiozi+bIGQ8ONoKEE6/AGP5zkavFqEYBfE1opTJWq
         7V335VX+MiDkHPHi0ht2UWO+cxXe05FnGVug0MblLNng28S/9mOwHlk/Pe6mq390Uc
         zkfJv3njkfQg9rxxqXAAVbFLIZDL943NTl6B4BamIvt/nT5Vz6+bzOB8C/EJxJ0Cuz
         bmvYE2IRTZH2Z5Z8cOTqMj0um62erobG021i+JcPHd+F5VMySBYVq91nNjpf3q5mcC
         X/YTCHmslvJmraVdV3iKkqVBo8K5qmaWO3XxX+TIlLGbrGLC9n9XW5sgptvdeRK2zp
         5lEPh7YGAfR0g==
Date:   Mon, 24 Jan 2022 09:36:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the phy tree
Message-ID: <Ye4lsTsDaYHvTeNs@matsya>
References: <20220124072422.3cf483a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124072422.3cf483a1@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-01-22, 07:24, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   760e61025158 ("phy: ti: Fix "BUG: KASAN: global-out-of-bounds in _get_maxdiv" issue")
> 
> Fixes tag
> 
>   Fixes: 091876cc35 ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")

Updated the sha1 now, thanks for reporting

> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed in the future by setting core.abbrev to 12 (or more) or
>     (for git v2.11 or later) just making sure it is not set (or set to
>     "auto").
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
~Vinod
