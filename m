Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3068057398D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiGMPDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiGMPDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:03:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949683E75F;
        Wed, 13 Jul 2022 08:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39E03B82025;
        Wed, 13 Jul 2022 15:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB238C34114;
        Wed, 13 Jul 2022 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657724585;
        bh=wsIdfHIG7F2tnroKm1i5VUPbK8CQs4fRT2cEONpz1T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/rJW8Pfre4Q9JN0Jnqo33d4lqnajvsL6J8Pni/Hux2OPtNt+YiEqpigBdqi5UYG4
         3BV0vEExnz1iTWzkgHxS5UenP5DLkbbABNJ9mrGlgup6K1Qlsae1Xow4ibzIbpDK5H
         j0mDspbQ5j205vjJiAjHlYzU7A96Rn9tQB2edRsnKRb9VlomGluaE11F3OpYS1lw9E
         mSZxHB5+dJouGYT00bmK51zf11pH7/a3hyihMqjDAX8QeqGn/8Lp0YUmJ81/TZH6vx
         dAAtOtTpA8NIHl1G7ZxFarhOJag9ms48K4Hsa9VK3QjFqHTThlDpT2IfupjcaNgWGN
         6qap4R7lMiGhA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBdtN-0001SX-GJ; Wed, 13 Jul 2022 17:03:09 +0200
Date:   Wed, 13 Jul 2022 17:03:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sc8280xp: fix USB interrupts
Message-ID: <Ys7erer+lLaHqLqe@hovoldconsulting.com>
References: <20220713131340.29401-1-johan+linaro@kernel.org>
 <20220713131340.29401-6-johan+linaro@kernel.org>
 <20220713141228.5z5rmgepj6mepjyp@halaneylaptop>
 <Ys7YKkRAAI0Vbseh@hovoldconsulting.com>
 <20220713144310.kehfuqvfhsjb36ri@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713144310.kehfuqvfhsjb36ri@halaneylaptop>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:43:10AM -0500, Andrew Halaney wrote:
> On Wed, Jul 13, 2022 at 04:35:22PM +0200, Johan Hovold wrote:

> > Do you mind if I fold a fix for that into a v2 of this patch?

> Sounds good, feel free to add my R-B with that change as well!

Done. I'll wait a bit for any further comments before reposting.

Thanks again.

Johan
