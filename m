Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F24847446B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhLNOEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:04:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42236 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhLNOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:04:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDC4D6150C;
        Tue, 14 Dec 2021 14:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24487C34601;
        Tue, 14 Dec 2021 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639490681;
        bh=88fh/EYw6Nm9NultqYdorTEVZ3dFC4vacY+2dZLYB7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=am2C6nmOBes1GCqiev3sF25zvXCRmBC8aAQZw8sefjK/amqS5FcIvaTioKxC0+uzZ
         3fOKx4PY+EYReAbBKzHytIYRUekvXAFCxgl5a5DYuk7SZ4b0kkLHxLXC93xo4iRIp2
         UMGnG3z+gdm/PTz9lk7rglRMyySQ9ThREI2+E45hMI4Yq8V+hzmja8mSrdIAN00YDo
         kXyehpPoXbmzgmOkrL5LjXly+pcQ3crGtG0tGK0eHIH3b2GJbXth97B+Wci2ia2ODn
         +UrQhOgZ91JBDVQng1+hRnmDIPh60MI0x2Z9rGEm5zga9OnACJcGVeD0BJErd3UJMP
         hUT7bMazKAv1w==
From:   Will Deacon <will@kernel.org>
To:     sgoutham@marvell.com, bbhushan2@marvell.com,
        Bhaskara Budiredla <bbudiredla@marvell.com>,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu driver
Date:   Tue, 14 Dec 2021 14:04:32 +0000
Message-Id: <163948458175.3584506.7943620757309501715.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211115043506.6679-1-bbudiredla@marvell.com>
References: <20211115043506.6679-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 10:05:04 +0530, Bhaskara Budiredla wrote:
> This series introduces performance monitor driver to Last-level-cache
> tag-and-data (LLC-TAD) PMU which is an integral part of Marvell CN10K SoCs.
> The configuration and functionality of the TAD PMU is covered in patch 1.
> The device tree bindings are dealt in patch 2.
> 
> v7:
>  - use braces around a multi-line conditional statement (Will Deacon)
>  - remove mask doesn't do anything (Will Deacon)
>  - restrict compile test dependency to aarch64
> 
> [...]

Applied to arm64 (for-next/perf-cn10k), thanks!

[1/2] drivers: perf: Add LLC-TAD perf counter support
      https://git.kernel.org/arm64/c/036a7584bede
[2/2] dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD pmu bindings
      https://git.kernel.org/arm64/c/4cbf47728f8d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
