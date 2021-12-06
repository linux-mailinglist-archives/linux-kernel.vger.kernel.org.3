Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071664691AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbhLFIp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:45:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49190 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbhLFIp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:45:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9A92611F1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56370C341C1;
        Mon,  6 Dec 2021 08:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638780117;
        bh=4wWOVe2lwPaaXoppKsoOmUrakURNFayKUJcMUbva6IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E505Cjk/H9JyXpn8eSTt0M7VxC9n2ELL9SuTlBogzn7URcEyR2MmwrOz42w09QquA
         tQlTtLyH2/0D79pdvuwpep4oIjcgzBMz/x+nM89DHtCWXNkxPlMWw17clnKlVxv6/1
         BHd04Whjmp1YMA4wEP36ocwSkB7dYEhrJ8jax875Sp3jrrjcDDSQnWvoRFlS3iVMTi
         NwfHyBU4QFPeU2tpSz20ogc7P0X4QRxZ7r/Kx12hHJn8GvLRcTCD6zGwCj0prMBpbv
         9JNfwsFydYUFJwOkMNda02byobWWsth3LQoRl6/jTW7pj7qjEzTp1kdnaQy0g8WjqS
         dSJPixHPhpRwg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mu9ZL-00A7wb-Am; Mon, 06 Dec 2021 08:41:55 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Will Deacon <will@kernel.org>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] KVM: arm64: Constify kvm_io_gic_ops
Date:   Mon,  6 Dec 2021 08:41:52 +0000
Message-Id: <163878010586.1389753.7080973991720885525.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211204213518.83642-1-rikard.falkeborn@gmail.com>
References: <20211204213518.83642-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rikard.falkeborn@gmail.com, suzuki.poulose@arm.com, james.morse@arm.com, alexandru.elisei@arm.com, eric.auger@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 22:35:18 +0100, Rikard Falkeborn wrote:
> The only usage of kvm_io_gic_ops is to make a comparison with its
> address and to pass its address to kvm_iodevice_init() which takes a
> pointer to const kvm_io_device_ops as input. Make it const to allow the
> compiler to put it in read-only memory.

Applied to next, thanks!

[1/1] KVM: arm64: Constify kvm_io_gic_ops
      commit: 636dcd0204599f94680f8f87b46cef7c66034ac0

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


