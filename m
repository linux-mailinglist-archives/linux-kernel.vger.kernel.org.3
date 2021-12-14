Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B235C47463F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhLNPSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbhLNPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:18:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560DC061401
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:18:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A6456156E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16C6C3460C;
        Tue, 14 Dec 2021 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639495114;
        bh=qLyDBf/yZu2sUd5XQDi3WQtlq6e8hakIqUYW8hv6gEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6Q8s2AclEXu0keGIgST108zGqrQoEZvIpEZoaTWn/FMkJjGKQrwNlaYBDo+8bO5W
         7eIf9xDgGwIBY3lIRoRKrzDKBJ34dK0u+rXlbuJcW2IFSn9ncc7feU1cIFXjN3ab87
         i76ZTfDR9FSHut40Zvq8fT8r9BgfSLQYqPfwRcxeoUIv8F0ad1PmvLCx52c2Cub/+e
         i6pILAQ3tGmua0HQrZOr3TOdm08dOjKv4+7Szyv8dq9uT3N9hdws28yMfH/L7AfP0L
         idy2L2NPaAek3b66fY7XMywUhxXmfKo7BskzHe1qwcvvomra31LIh+TXD1ITclaHFe
         yMiXgFpx6BYXw==
From:   Will Deacon <will@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops
Date:   Tue, 14 Dec 2021 15:18:14 +0000
Message-Id: <163949306261.2865560.10724988553513582084.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211204223301.100649-1-rikard.falkeborn@gmail.com>
References: <20211204223301.100649-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 23:33:01 +0100, Rikard Falkeborn wrote:
> The only usage of arm_smmu_mmu_notifier_ops is to assign its address to
> the ops field in the mmu_notifier struct, which is a pointer to const
> struct mmu_notifier_ops. Make it const to allow the compiler to put it
> in read-only memory.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops
      https://git.kernel.org/will/c/17d9a4b43b28

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
