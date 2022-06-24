Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68299559F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiFXROP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiFXRON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F94E1CFF7;
        Fri, 24 Jun 2022 10:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C07A56235A;
        Fri, 24 Jun 2022 17:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885E9C341C0;
        Fri, 24 Jun 2022 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656090851;
        bh=FVmOf9t4q7VPO1xCVXboLfTEVU2n7pCqLGdcaM8W1yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHDvc+8fRQBUAJguetOwh5hG6sN+dPhQ9zPzPoN0krDmLMzla3QSUGdkWa8qRm4I5
         hN59QD9XZSVC/PVQkl07/nRFWoThi+t96Y+nuBT4v2evBJZf/O2Nz7wPAzVptiqUXT
         XOYP0kw8jdaSsjawk0XY/61c+VyherJQQ1nMpWcgpASEitY5NQ5o0Ys948eKI9WGwo
         P7CPbpif19z3lbQqXNsduitz1+FgRcCk9sRUlK5E+4Q6llaYMxLwf+vhuGCRnYNU+x
         V/yMaC1VD+KXOoSa//IuB3AWwrRX7hMdn8qUs7sfOKdLJ620QYWZeCaeqHR9P2mSa2
         2SbYBbbtq8+eA==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/marvell_cn10k: Remove useless license text when SPDX-License-Identifier is already used
Date:   Fri, 24 Jun 2022 18:13:59 +0100
Message-Id: <165607318443.2894038.5154531205807916686.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <4a8016a6da9cc6815cfa0f97ae8d3dd862797bda.1654936653.git.christophe.jaillet@wanadoo.fr>
References: <4a8016a6da9cc6815cfa0f97ae8d3dd862797bda.1654936653.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2022 10:37:40 +0200, Christophe JAILLET wrote:
> An SPDX-License-Identifier is already in place. There is no need to
> duplicate part of the corresponding license.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/marvell_cn10k: Remove useless license text when SPDX-License-Identifier is already used
      https://git.kernel.org/will/c/8e28e53f1356

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
