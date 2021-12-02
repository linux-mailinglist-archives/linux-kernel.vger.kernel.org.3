Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B964A4661DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357120AbhLBLDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357101AbhLBLC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:02:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF8FC061757;
        Thu,  2 Dec 2021 02:59:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C51A4B82298;
        Thu,  2 Dec 2021 10:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFD0C00446;
        Thu,  2 Dec 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638442772;
        bh=jfJ+kzNVnJ1CTqytb0LMULYzG8eo4xvWqb8+ZuhmIbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSoR8ZLGUZRvLgk4QuK02OG5qkshTYKJ0vjIPsSe0WgHkDiqX4UwRL9IC95D8VDRl
         qMaFwvXSpzedLDw+YHJEymEE3CKHhiI5ec3wp8XXz8DDRfaDoDKMAU0dj7xR14NMJm
         tQgGxbfOmWN/oAQ+QyDWGEneGt5Na3zACyV+s7BaeyENWwkVJ6QNuaPT00QriZ0gqy
         e4Ke/6hW9/EGr77hoO7C0u6A2Z3q5EbAbJ/8W82h8RnH3iezOI9ZB17fZnBVPxVWNT
         n/+pgQtB4O1gW9P10VhFjPzYNZhF46ESWbnaUJQqGFSAJyaQOONvOnBN1QsKkPxTB+
         UBJOhnDIgLsvg==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        nicholas.tang@mediatek.com, linux-kernel@vger.kernel.org,
        chinwen.chang@mediatek.com, james.hsu@mediatek.com,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] arm64: update PAC description for kernel
Date:   Thu,  2 Dec 2021 10:59:24 +0000
Message-Id: <163844001555.25175.12332583693685528592.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211201034014.20048-1-Kuan-Ying.Lee@mediatek.com>
References: <20211201034014.20048-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 11:40:10 +0800, Kuan-Ying Lee wrote:
> Remove the paragraph which has nothing to do with the kernel and
> add PAC description related to kernel.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: update PAC description for kernel
      https://git.kernel.org/arm64/c/ce39d473d1ed

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
