Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85922540159
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245473AbiFGO2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiFGO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:28:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F38A336
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 461A6B82028
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D33C385A5;
        Tue,  7 Jun 2022 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654612103;
        bh=aPLYd3KgtEjQHeA9cBl3JPZVGNS5SWH0+fVtRGJZ+VE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCBoApsn3vKD2DmhSQk6kJ8oEXtmEpDRV7Ad08bX2Vuq6UBt7nJqu4FW54iTsoaC/
         L8VZ3o5MoeoTrFFtLzihSp9a2Z5FOscnwbp0NmomH5srjeB9NyRfF/RiRP7wSmtcjK
         1ltVwCUW29kRXcVqaqZ8pmujAXBYh6a/8xigk9KCyy5e2tViQGzM3C99N9GWhLXv7d
         b4q6Wh+c8k5B+0nH/m0ccvFOWLeNJ/gsq9iL+Nsh06dGPPnLidHYUcfBrXXnte8mTc
         VXWTxWW7afmsTjhG8M6xMhIGAs6n3uJh688WG91zQgML5Gb7ozZVc1IUZ+63uHlSSB
         MW2q/zjhKaG1g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nyaBx-00GCvF-EX; Tue, 07 Jun 2022 15:28:21 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     james.morse@arm.com, julien.grall@arm.com, catalin.marinas@arm.com,
        sunliming <sunliming@kylinos.cn>, will@kernel.org,
        suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] KVM: arm64: fix the inconsistent indenting
Date:   Tue,  7 Jun 2022 15:28:10 +0100
Message-Id: <165461208429.127112.9553887915528964109.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220602024805.511457-1-sunliming@kylinos.cn>
References: <20220602024805.511457-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.morse@arm.com, julien.grall@arm.com, catalin.marinas@arm.com, sunliming@kylinos.cn, will@kernel.org, suzuki.poulose@arm.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, kelulanainsley@gmail.com, lkp@intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 10:48:05 +0800, sunliming wrote:
> Fix the inconsistent indenting in function flush_context.
> 
> Fix the following smatch warnings:
> 
> arch/arm64/kvm/vmid.c:62 flush_context() warn: inconsistent indenting

Applied to fixes, thanks!

[1/1] KVM: arm64: fix the inconsistent indenting
      commit: e3fe65e0d3671ee5ae8a2723e429ee4830a7c89c

Cheers,

	M.
-- 
Marc Zyngier <maz@kernel.org>

