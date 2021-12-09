Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C6B46E7FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhLIMHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhLIMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:07:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19244C061746;
        Thu,  9 Dec 2021 04:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9E686CE24D7;
        Thu,  9 Dec 2021 12:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48231C341C6;
        Thu,  9 Dec 2021 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639051457;
        bh=pguoaYTdAlZwqo3FoVAuUSGuWCNb7rD363z+iOENWZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOQtgDpIrlwJhsubJAJjaf3rbV38BDe3GuCNQmnoI0AY64eatGbEf5DJ8UYsot+db
         9s8VQq1JCIoUS1RilfbnzFWdzdM2vScomQtuodoeGkb2KIjL7obKV4oIRoo25TC7sj
         ojCJKKuEEYEIt3A/z63Aagcv7psXAGus9/to0QR5gndZNz3og8TxRYVINCTJkWIGLw
         LW937LQd5YD8GNOiqSmZQOxplsLVmLerHZUOlXu6QNIfsOOBUXahrLXlGmQnorFuac
         dJHVR4PqEsjU693twUyQIODL4gLrm6Lgz1HTCgXFCQ9lqn7LipberAKxB9h5thqjTT
         RmYU28zQ5beow==
Date:   Thu, 9 Dec 2021 17:34:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: qcom: Add clocks for SM8450 SoC
Message-ID: <YbHwvQFtg992DlgL@matsya>
References: <20211207114003.100693-1-vkoul@kernel.org>
 <20211209081946.4B3D8C004DD@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209081946.4B3D8C004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-21, 00:19, Stephen Boyd wrote:
> Quoting Vinod Koul (2021-12-07 03:40:01)
> > This series adds the GCC clock support required for SM8450 SoC
> > along with devicetree binding for these clocks.
> > 
> > Please note that the GCC driver patch depends on new alpha LUCID_EVO
> > introduced by Vamsi in [1]. That would be required to be picked before this
> > patch can be applied.
> > 
> > [1]: https://lore.kernel.org/all/a0b04869a20a0afef99dd457ebb6474f50591210.1637302009.git.quic_vamslank@quicinc.com/
> 
> Can you use --base with format-patch please so that kbuild robot doesn't
> get angry? I think the robot may be able to find the patches and apply
> them now if you tell it what to base it on.

Aha, it would be interesting if bot is able to pick a patch using
--base, let me try that for next rev and see if it is happy

-- 
~Vinod
