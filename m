Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C27C51D575
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390844AbiEFKUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245457AbiEFKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:20:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E25A5A5
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D440BB834B0
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 10:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4A7C385AA;
        Fri,  6 May 2022 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651832179;
        bh=eNp+UUNZui7u6coUNS7PNxrxe2tkL04eKOUXm9fKysc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aG2fTzMLcidijec70O3RMF7AS8kQV2M3M/Ncl+vS0Of2b+6zzOrHH/lHZshuQPpaw
         yHiHvpJaR15aodDq0leNa4Eb37VQ8zcrg1Em3n5ZeZilprPRTX8x2Uq0z0z2wlmITb
         4gX1lTugGTY0oOdgfmS6JwPfe0fN5cN9pjMZF0YX6czmtLC1DM3MexqYlJmXdxfqRj
         xD5hGbrK2o1IFDk+0Qwsz56xLWLGQ8B+i4YBIBGwv80RcXpDyz1LAEaOPjQONWaz8t
         +CF3qbKaOx9StUbG7amB8MhLytSzvo98I6DdUHp+Ho8LfIuoWBCGxaRmNoSUcNfc34
         pdpZZqMw/KRiA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nmv0T-009Qtg-5m; Fri, 06 May 2022 11:16:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     kvmarm@lists.cs.columbia.edu,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        David Brazdil <dbrazdil@google.com>,
        Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH] KVM: arm64: nvhe: eliminate kernel-doc warnings
Date:   Fri,  6 May 2022 11:16:14 +0100
Message-Id: <165183215982.192247.17735807567998554164.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430050123.2844-1-rdunlap@infradead.org>
References: <20220430050123.2844-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, rdunlap@infradead.org, kvmarm@lists.cs.columbia.edu, alexandru.elisei@arm.com, suzuki.poulose@arm.com, james.morse@arm.com, lkp@intel.com, linux-arm-kernel@lists.infradead.org, dbrazdil@google.com, tabba@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 22:01:23 -0700, Randy Dunlap wrote:
> Don't use begin-kernel-doc notation (/**) for comments that are not in
> kernel-doc format.
> 
> This prevents these kernel-doc warnings:
> 
> arch/arm64/kvm/hyp/nvhe/switch.c:126: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Disable host events, enable guest events
> arch/arm64/kvm/hyp/nvhe/switch.c:146: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Disable guest events, enable host events
> arch/arm64/kvm/hyp/nvhe/switch.c:164: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Handler for protected VM restricted exceptions.
> arch/arm64/kvm/hyp/nvhe/switch.c:176: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Handler for protected VM MSR, MRS or System instruction execution in AArch64.
> arch/arm64/kvm/hyp/nvhe/switch.c:196: warning: Function parameter or member 'vcpu' not described in 'kvm_handle_pvm_fpsimd'
> arch/arm64/kvm/hyp/nvhe/switch.c:196: warning: Function parameter or member 'exit_code' not described in 'kvm_handle_pvm_fpsimd'
> arch/arm64/kvm/hyp/nvhe/switch.c:196: warning: expecting prototype for Handler for protected floating(). Prototype was for kvm_handle_pvm_fpsimd() instead

Applied to next, thanks!

[1/1] KVM: arm64: nvhe: eliminate kernel-doc warnings
      commit: bd61395ae8393f28f4b084702acd6f5f02b1f7c0

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


