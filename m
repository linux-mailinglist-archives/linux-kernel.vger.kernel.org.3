Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B49A48574B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbiAERbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:31:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50142 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiAERbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:31:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D84B61843;
        Wed,  5 Jan 2022 17:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44026C36AE0;
        Wed,  5 Jan 2022 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641403905;
        bh=7y9Ztfyk/wsCxvSSy7rXBwr0Esh7XJzwinR6rTfAGbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezr/YSqT8M+w5ckBJEsDg1XbGQqZKVqTS2yk0YEZA/KzzPuCPQJ5nH3d28w2Jn2CP
         RoJhRvIGwaDFh2qpavtjgRsWKcvpSShdgD4DfzYFH8UzV0jtUCxRGn/LlMH+RL5eR2
         5lyGAna7mT8UJBtXbUkXbhXh5rF8zZahwDfIJVO0ngmgyHe1jk08PPcyJOjDGkxn/6
         0/Pc0eLQd+h5f1v+CmGLBZp3k0ApKliUvVVVGwWNg2O2xdXwb7KahJITqARf6Um39A
         4aE5I+1aQE8tyG/rkfptQqEuXjso0dXTGrw8VYhzEq84PDsAEmOHlzYU6cS3IUnbuQ
         ltSvwUkpmoeuQ==
From:   Will Deacon <will@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: perf: marvell_cn10k: fix an IS_ERR() vs NULL check
Date:   Wed,  5 Jan 2022 17:31:38 +0000
Message-Id: <164130469774.128143.15567596913293745739.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211217145907.GA16611@kili>
References: <20211217145907.GA16611@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 17:59:08 +0300, Dan Carpenter wrote:
> The devm_ioremap() function does not return error pointers.  It returns
> NULL.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] drivers: perf: marvell_cn10k: fix an IS_ERR() vs NULL check
      https://git.kernel.org/will/c/2da56881a7f8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
