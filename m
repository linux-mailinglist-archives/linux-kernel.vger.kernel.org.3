Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0881473211
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbhLMQm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbhLMQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:42:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC09C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:42:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 694BA61192
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 16:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6F3C34606;
        Mon, 13 Dec 2021 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639413775;
        bh=tTwpCy/mh6p93YlMDgTwXSg738FhRzNnkLBAJnaP0sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5r8pn0iBcHZK2HdKwCWkSMnNRT76j58d+sHdH2rSCs/+A5TAY0xKBqpa3u4c99yV
         IeMwCbidE7U0IB07SOLm4tdJXGdO4DBV8OKP976b4HDK0CyrHMnNiCZ0oNUZk2fzD6
         ye2SsEJqDm9jmkudZqep2PH6VqnO6zAgLE8ko2kkEURcyPjrVoqpijxXUbpiNHhOcp
         AND72B0Hb4wwdBNC3vCOoTp8rBSRuJ1BnRLazFUVA7lCLRonZcsFSuhWKzZj+vTiqh
         X+C4mtJLk/o0xe2fq57ZWrFleHdHLzZxloCrcILGigJSrPoDNDtHlySN9MN8L3anVH
         hAl0tifryXuOg==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        robh@kernel.org, dan.carpenter@oracle.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bauerman@linux.ibm.com,
        qiuguorui1@huawei.com, kbuild@lists.01.org, lkp@intel.com
Subject: Re: [PATCH] arm64: kexec: Fix missing error code 'ret' warning in load_other_segments()
Date:   Mon, 13 Dec 2021 16:42:45 +0000
Message-Id: <163941287805.4004441.18442960905908913119.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211210010121.101823-1-nramas@linux.microsoft.com>
References: <20211210010121.101823-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 17:01:21 -0800, Lakshmi Ramasubramanian wrote:
> Since commit ac10be5cdbfa ("arm64: Use common
> of_kexec_alloc_and_setup_fdt()"), smatch reports the following warning:
> 
>   arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments()
>   warn: missing error code 'ret'
> 
> Return code is not set to an error code in load_other_segments() when
> of_kexec_alloc_and_setup_fdt() call returns a NULL dtb. This results
> in status success (return code set to 0) being returned from
> load_other_segments().
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: kexec: Fix missing error code 'ret' warning in load_other_segments()
      https://git.kernel.org/arm64/c/4bfe24b6beb3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
