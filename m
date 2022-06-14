Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C554AE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiFNKOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiFNKOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:14:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C75646157;
        Tue, 14 Jun 2022 03:14:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6A4323A;
        Tue, 14 Jun 2022 03:14:06 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 753483F792;
        Tue, 14 Jun 2022 03:14:05 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: arm/fvp-base-revc: Remove 'panel-dpi' compatible
Date:   Tue, 14 Jun 2022 11:14:03 +0100
Message-Id: <165520087950.1030128.13080682792301957052.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610204057.2203419-1-robh@kernel.org>
References: <20220610204057.2203419-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 14:40:57 -0600, Rob Herring wrote:
> The rtsm-display panel timing node was removed in commit 928faf5e3e8d
> ("arm64: dts: fvp: Remove panel timings"). Without the node, 'panel-dpi'
> is not needed either.
>

Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/1] arm64: dts: arm/fvp-base-revc: Remove 'panel-dpi' compatible
      https://git.kernel.org/sudeep.holla/c/7fc96d7162

--
Regards,
Sudeep

