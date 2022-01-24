Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6AA498324
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbiAXPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbiAXPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:10:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1619DC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:10:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA7126142A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5ECC340E1;
        Mon, 24 Jan 2022 15:10:11 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Subject: Re: [PATCH V2 0/2] coresight: trbe: Update existing errata for Cortex-X2
Date:   Mon, 24 Jan 2022 15:10:08 +0000
Message-Id: <164303699846.16509.8389008992406508241.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1642994138-25887-1-git-send-email-anshuman.khandual@arm.com>
References: <1642994138-25887-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 08:45:36 +0530, Anshuman Khandual wrote:
> Errata ARM64_ERRATUM_[2119858|2224489] also affect some Cortex-X2 ranges as
> well. This series updates the errata definition and detection as required.
> This series applies on v5.17-rc1.
> 
> Relevant identification document can be found here.
> 
> https://developer.arm.com/documentation/101803/0200/AArch64-system-registers/
> AArch64-identification-register-summary/MIDR-EL1--Main-ID-Register
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64: Add Cortex-X2 CPU part definition
      https://git.kernel.org/arm64/c/72bb9dcb6c33
[2/2] arm64: errata: Update ARM64_ERRATUM_[2119858|2224489] with Cortex-X2 ranges
      https://git.kernel.org/arm64/c/eb30d838a44c

-- 
Catalin

