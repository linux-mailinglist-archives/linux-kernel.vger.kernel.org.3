Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80389517F5B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiECIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiECIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:08:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB5C618381;
        Tue,  3 May 2022 01:04:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73BDA1516;
        Tue,  3 May 2022 01:04:29 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A6D03F774;
        Tue,  3 May 2022 01:04:27 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ray Jui <rjui@broadcom.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 4/9] arm64: dts: juno: drop useless 'dma-channels/requests' properties
Date:   Tue,  3 May 2022 09:04:24 +0100
Message-Id: <165156475719.2920732.8758785469502064309.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220430121902.59895-5-krzysztof.kozlowski@linaro.org>
References: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org> <20220430121902.59895-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2022 14:18:57 +0200, Krzysztof Kozlowski wrote:
> The pl330 DMA controller provides number of DMA channels and requests
> through its registers, so duplicating this information (with a chance of
> mistakes) in DTS is pointless.  Additionally the DTS used always wrong
> property names which causes DT schema check failures - the bindings
> documented 'dma-channels' and 'dma-requests' properties without leading
> hash sign.
> 
> [...]

Applied to sudeep.holla/linux (for-next/juno), thanks!

[4/9] arm64: dts: juno: drop useless 'dma-channels/requests' properties
      https://git.kernel.org/sudeep.holla/c/b30ae5638d

--
Regards,
Sudeep

