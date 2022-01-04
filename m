Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C114846DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiADRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiADRSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:18:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C204AC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 09:18:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77623B8179D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 17:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F5CC36AED;
        Tue,  4 Jan 2022 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641316713;
        bh=UkZFEDb4tbKzvcbyZHYlvNAxkPyB5nrD6sI05Eqzrxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8nCcaZoMJpJjkAnP/295K453uXOowW5+h53HDseFaAudgqbpdgEDDf/VZ/qRPM5u
         xM/gEswIQSU5d7mW6S6XrKt7xMY8QTg7B7Lbyuy/JepqtGbW+3NUY30O7+ZBVHj3sU
         X5GsgO/3sQqcmj+FSpW9yiUrY86Cdd98bO3XJAO8EQutZEx71sOYtFuQg3lOUm3I38
         vVTlV9kBo/BYG8V1hvaAbGoMlspamoDRebRMygF4uug87QdXl+EpBnrdJ2A9Kxkx6B
         +VT2RZ+e8x6L8+D/LT21Gk2DXMd41HKH1MczRkQNgz19+k0fqina6zFbBAmoh/+BZX
         u8amhnVle7Jyw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1n4nSB-00Fy9A-2X; Tue, 04 Jan 2022 17:18:31 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 1/1] KVM: arm64: vgic: Replace kernel.h with the necessary inclusions
Date:   Tue,  4 Jan 2022 17:18:23 +0000
Message-Id: <164131669019.3722270.11121664995774113019.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104151940.55399-1-andriy.shevchenko@linux.intel.com>
References: <20220104151940.55399-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com, alexandru.elisei@arm.com, james.morse@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 17:19:40 +0200, Andy Shevchenko wrote:
> The arm_vgic.h does not require all the stuff the kernel.h provides.
> Replace kernel.h inclusion with the list of what is really being used.

Applied to next, thanks!

[1/1] KVM: arm64: vgic: Replace kernel.h with the necessary inclusions
      commit: 6c9eeb5f4a9bb2b11a40fd0f15efde7bd33ee908

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


