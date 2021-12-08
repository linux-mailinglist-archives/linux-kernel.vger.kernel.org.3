Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B246DB00
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbhLHS2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:28:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46914 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhLHS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:28:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1034DB82268
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 18:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F844C00446;
        Wed,  8 Dec 2021 18:25:12 +0000 (UTC)
Date:   Wed, 8 Dec 2021 18:25:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     will@kernel.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wuxu.wu@huawei.com, Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH v2 1/2] arm64: mm: Rename asid2idx() to ctxid2asid()
Message-ID: <YbD4hcSWKEXSL1hg@arm.com>
References: <506863a9-b934-3af3-c70d-3284e14478de@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <506863a9-b934-3af3-c70d-3284e14478de@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:16:45PM +0800, Yunfeng Ye wrote:
> The commit 0c8ea531b774 ("arm64: mm: Allocate ASIDs in pairs") introduce
> the asid2idx and idx2asid macro, but these macros are not really useful
> after the commit f88f42f853a8 ("arm64: context: Free up kernel ASIDs if
> KPTI is not in use").
> 
> The code "(asid & ~ASID_MASK)" can be instead by a macro, which is the
> same code with asid2idx(). So rename it to ctxid2asid() for a better
> understanding.
> 
> Also we add asid2ctxid() macro, the contextid can be generated based on
> the asid and generation through this macro.

The changes look fine to me but please repost with your Signed-off-by.

Thanks.

-- 
Catalin
