Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28AB474637
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhLNPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbhLNPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:18:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F90C061574;
        Tue, 14 Dec 2021 07:18:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 068C861570;
        Tue, 14 Dec 2021 15:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDC7C34608;
        Tue, 14 Dec 2021 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639495106;
        bh=t/ioqHHdb/Ss2Yo/QWbW8oF8j/7s1fB4C/FeJDG9SlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8ZsejB9aBcTlt03eyImEu3Q1qg23EcB85+Y5+380PQHuHkcOySIUzqYn9zunAtVr
         aBy08BL2lbqv5EFot4ykRIjNxlNvdDtOwf6RR55hHjgClCaTpYAxTWt6qRU5cctPiJ
         pdJU6sYIbqWkpAsB/dVTcQ3vLA39q+ACKeOe47hf61n3e2xNXxK9ioj7A1bevFte2W
         9CCKVePmBquGgZuOmTijgQqjvfPcg4D/2mtyPHk8TFS/N25hiBIDtnyHic4Yol/m6P
         59d+FWX3lT/XqSwZLFRxi002dNBVb7h1aqlgmxDXQhRVtaZBDHumHuY927E9G+Nnc2
         hEXtIe702jktQ==
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        David Heidelberg <david@ixit.cz>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, ~okias/devicetree@lists.sr.ht,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: Add compatible for the SDX55 SoC
Date:   Tue, 14 Dec 2021 15:18:11 +0000
Message-Id: <163949295158.2865133.9086863880936702882.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211020231701.278846-1-david@ixit.cz>
References: <20211020231701.278846-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 01:17:00 +0200, David Heidelberg wrote:
> Add missing compatible for the SDX55 SoC.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] dt-bindings: arm-smmu: Add compatible for the SDX55 SoC
      https://git.kernel.org/will/c/ae377d342006

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
