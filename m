Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121CE475C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244366AbhLOQBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:01:08 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34862 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhLOQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:01:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7BCC3CE1DDE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FD9C340E3;
        Wed, 15 Dec 2021 16:00:36 +0000 (UTC)
Date:   Wed, 15 Dec 2021 16:00:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [GIT PULL] arm64 fixes for -rc6
Message-ID: <YboRETjutObrQTHH@arm.com>
References: <20211215111917.GB16765@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215111917.GB16765@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Dec 15, 2021 at 11:19:18AM +0000, Will Deacon wrote:
> Please pull this pair of arm64 fixes for -rc6. There's a fix for missing
> locking around kernel page-table allocation causing a crash with
> virtio-mem and a fix for a smatch warning in the kexec code where we
> would return 0 on the error path.
[...]
> ----------------------------------------------------------------
> Jianyong Wu (1):
>       arm64/mm: Avoid fixmap race condition when creating pud mappings

I you haven't pulled this yet, please discard the request. I'll revert
the above commit as it causes a regression, reported here:

https://lore.kernel.org/all/Ybn4EfweLqKtyW0+@fixkernel.com/

Will is already on holiday, so I'll retag the branch tomorrow and send a
new pull request.

Thanks and sorry for the trouble.

-- 
Catalin
