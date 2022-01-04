Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F9484302
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiADOF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:05:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60856 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiADOF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:05:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46AEBB8160D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F2BC36AE9;
        Tue,  4 Jan 2022 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641305126;
        bh=bhl5UyJyteuv6QbsNSocnsvA1DaSc46ypy3s1vY6NFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDBJE1ochkvUckxJi/f4xkX89R0d6oE+kmNu/v+9+qzOcv0gmZt5tXts7x3xsujoW
         ED9cm29Iww8YZxAuJCRvDFZsjGu+e2dYwg0XzfYlvlPTRdRmbuVdTIdE/CVmPg7cvL
         xCbvMaMXMoTRutSqSs/DBuK433vqo85CZUtfekAl7af7d1TlaHG4HhvZQZeiSOwfhV
         PfFcnFpgdEMnxXa0aDW71xtwYD28qHc/vBY/elsbYvdSfCh4Kgv2WpewcAcfjxdCSF
         4ivPQL3ilUfaiXu1hzG+kmmozmJ3YCfdpZdQS8EYd92o0AvhpBinpT/WcAbA9kx60Z
         BOQJt2rkvj6Ww==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1n4kRI-00FvXP-5q; Tue, 04 Jan 2022 14:05:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>
Cc:     kernel.yuz@gmail.com, suzuki.poulose@arm.com, james.morse@arm.com,
        alexandru.elisei@arm.com, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] KVM: arm64: Fix comment typo in kvm_vcpu_finalize_sve()
Date:   Tue,  4 Jan 2022 14:05:19 +0000
Message-Id: <164130511055.3362481.10306211546953262745.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211230141535.1389-1-yuzenghui@huawei.com>
References: <20211230141535.1389-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, yuzenghui@huawei.com, kernel.yuz@gmail.com, suzuki.poulose@arm.com, james.morse@arm.com, alexandru.elisei@arm.com, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 22:15:35 +0800, Zenghui Yu wrote:
> kvm_arm_init_arch_resources() was renamed to kvm_arm_init_sve() in
> commit a3be836df7cb ("KVM: arm/arm64: Demote
> kvm_arm_init_arch_resources() to just set up SVE"). Fix the function
> name in comment of kvm_vcpu_finalize_sve().

Applied to next, thanks!

[1/1] KVM: arm64: Fix comment typo in kvm_vcpu_finalize_sve()
      commit: e938eddbeb85f4c0c47e56cd9e09ee196ea1bc1a

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


