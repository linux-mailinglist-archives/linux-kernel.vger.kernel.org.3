Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9365930A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbiHOOYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbiHOOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:24:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AB2323BCA;
        Mon, 15 Aug 2022 07:24:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8039623A;
        Mon, 15 Aug 2022 07:24:34 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A78E63F66F;
        Mon, 15 Aug 2022 07:24:32 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        jassisinghbrar@gmail.com
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jaswinder.singh@linaro.org
Subject: Re: [PATCH] arm64: dts: juno: Add missing MHU secure-irq
Date:   Mon, 15 Aug 2022 15:24:30 +0100
Message-Id: <166057213112.3029001.4648914666752068588.b4-ty@arm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220801141005.599258-1-jassisinghbrar@gmail.com>
References: <20220801141005.599258-1-jassisinghbrar@gmail.com>
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

On Mon, 1 Aug 2022 09:10:05 -0500, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> The MHU secure interrupt exists physically but is missing in the DT node.
> 
> Specify the interrupt in DT node to fix a warning on Arm Juno board:
>    mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short
> 
> [...]

Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/1] arm64: dts: juno: Add missing MHU secure-irq
      https://git.kernel.org/sudeep.holla/c/422ab8fe15

--
Regards,
Sudeep

