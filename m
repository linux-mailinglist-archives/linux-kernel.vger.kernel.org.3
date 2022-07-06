Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4AE5683F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiGFJlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiGFJlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:41:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE94F26112
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:40:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 503FD15A1;
        Wed,  6 Jul 2022 02:39:49 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE7F13F66F;
        Wed,  6 Jul 2022 02:39:47 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, f.fainelli@gmail.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v2 0/4] Introduce SCMI System Power Control driver
Date:   Wed,  6 Jul 2022 10:39:45 +0100
Message-Id: <165710015322.2263892.15675986780763066533.b4-ty@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220704101933.2981635-1-cristian.marussi@arm.com>
References: <20220704101933.2981635-1-cristian.marussi@arm.com>
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

On Mon, 4 Jul 2022 11:19:29 +0100, Cristian Marussi wrote:
> This series is a respin of an old series[0] parked for a while waiting for
> a required SCMI specification change to be published.
> 
> The series, building on top of the SCMI System Power Protocol, adds a new
> SCMI driver which, registering for SystemPower notifications, takes care to
> satisfy SCMI plaform system-transitions graceful requests like shutdown or
> reboot involving userspace interactions as needed.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/4] firmware: arm_scmi: Support only one single SystemPower device
      https://git.kernel.org/sudeep.holla/c/a0db3962fb
[2/4] firmware: arm_scmi: Add SCMIv3.1 SystemPower extensions
      https://git.kernel.org/sudeep.holla/c/7097f29819
[3/4] firmware: arm_scmi: Add devm_protocol_acquire helper
      https://git.kernel.org/sudeep.holla/c/d91079995f
[4/4] firmware: arm_scmi: Add SCMI System Power Control driver
      https://git.kernel.org/sudeep.holla/c/2c4b97fee9

--
Regards,
Sudeep

