Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD51C4DDB43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiCROJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbiCROJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA80A15E8AF;
        Fri, 18 Mar 2022 07:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF80261A4D;
        Fri, 18 Mar 2022 14:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF8CC340E8;
        Fri, 18 Mar 2022 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647612466;
        bh=6/qgX4VsYNnji//fdZoQeDNIf2p1YkUCR7TjkqdZtpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0CYtkxiIyiTg/I8iNxQYQS0pKjEug7xKQ0rPiFckKyyMbBkXqUKGykOLnfz/cnw6
         GrEGfEiTa6lyTHRE/IkKM/eouuIj3V2BnZCWBUpmzbMNraXHF6yDrwQa0FOGGwhQ9c
         FKhxYxQKTZ79+Qjk/dfX5k4kuUSQL2JUMJC4vj0u8fsCV6bdjEu6SEtc0pDgIX6tC1
         5vA0LWfLvqsoUJGyw0cJw8hxmCY95/zorirvuRBgxP88WhPrfNhf5FBlgo5ZhNwnK1
         Sc0/xZkf+VQQs5c7x2952lsZRPom7eqPZ4cFlnlGgXjF3SaCq+Rt5bMRDyy4XWD+V1
         dElewf3DmAXRw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nVDGa-00FSU4-5V; Fri, 18 Mar 2022 14:07:44 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] KVM: arm64: fix typos in comments
Date:   Fri, 18 Mar 2022 14:07:37 +0000
Message-Id: <164761240231.2295955.754353604300597232.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318103729.157574-24-Julia.Lawall@inria.fr>
References: <20220318103729.157574-24-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: Julia.Lawall@inria.fr, james.morse@arm.com, will@kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 11:37:19 +0100, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.

Applied to next, thanks!

[1/1] KVM: arm64: fix typos in comments
      commit: 21ea457842759a236eefed2cfaa8cc7e5dc967a0

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


