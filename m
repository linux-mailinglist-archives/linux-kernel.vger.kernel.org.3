Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ED647AAFF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhLTOFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhLTOE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:04:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5BC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:04:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFB1C60FE8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25919C36AE7;
        Mon, 20 Dec 2021 14:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640009096;
        bh=9sjxJskFKOgRv8n2zjhy59WxR1jSNxtcTPKmdV6yNzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OC9MU0mGitl2VV1ixIxFSFHUy1Yd4fP+bmESV1rlYodkFfpgUPtHLHjBEsoTKKy4e
         s1ujSv+2l2xbmSoNWGAVPojXl2I2Xr7gyL7lyzcw5XTvZDViImNDnqSUS+9zJBnQJQ
         rz5bWxXkCYxDRqNgOg+4XAXf/ahKQa3k2qy70V/yWE5bRD90e0X24cz1MIH6vjsLt/
         9y2PG6fFzt37WOf/7+gBiDNkiL/sDN3tCNIWcfNAY0szfB97Nix/gFBsojwv9Edv2N
         8+3VMJCxuGtbQqwwm1u6A8haY3uTnBH5s41JKlUW+fujKtcY4TEyyUiJbpgSmIhvGe
         dbCYrbGe3sSIQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mzJHa-00DIca-7c; Mon, 20 Dec 2021 14:04:54 +0000
MIME-Version: 1.0
Date:   Mon, 20 Dec 2021 14:04:54 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>, tglx@linutronix.de,
        irqchip-bot for Marc Zyngier <tip-bot2@linutronix.de>
Subject: Re: [irqchip: irq/irqchip-next] KVM: arm64: Add minimal handling for
 the ARMv8.7 PMU
In-Reply-To: <164000884963.23020.18240369465894812989.tip-bot2@tip-bot2>
References: <20211126115533.217903-1-maz@kernel.org>
 <164000884963.23020.18240369465894812989.tip-bot2@tip-bot2>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <cade0e7233db41e5e32d0420239967ce@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, alexandru.elisei@arm.com, tglx@linutronix.de, tip-bot2@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-20 14:00, irqchip-bot for Marc Zyngier wrote:
> The following commit has been merged into the irq/irqchip-next branch
> of irqchip:
> 
> Commit-ID:     00e228b31596c6bf5f08b5ef76f80cb26e620f02
> Gitweb:
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/00e228b31596c6bf5f08b5ef76f80cb26e620f02
> Author:        Marc Zyngier <maz@kernel.org>
> AuthorDate:    Fri, 26 Nov 2021 11:36:43
> Committer:     Marc Zyngier <maz@kernel.org>
> CommitterDate: Wed, 01 Dec 2021 13:11:22
> 
> KVM: arm64: Add minimal handling for the ARMv8.7 PMU

Dang... I merged the kvm-arm64/misc-5.17 branch in the irqchip tree
instead of the irq/misc-5.17 branch. I guess holidays are in order...

Now fixed.

         M.
-- 
Jazz is not dead. It just smells funny...
