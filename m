Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B75A7EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiHaNZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiHaNZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:25:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF1B87D7B3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:25:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17939ED1;
        Wed, 31 Aug 2022 06:25:51 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 404323F766;
        Wed, 31 Aug 2022 06:25:44 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cristian.marussi@arm.com
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/6] Misc fixes for v5.20
Date:   Wed, 31 Aug 2022 14:25:41 +0100
Message-Id: <166195221577.495172.1725940194540410334.b4-ty@arm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220817172731.1185305-1-cristian.marussi@arm.com>
References: <20220817172731.1185305-1-cristian.marussi@arm.com>
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

On Wed, 17 Aug 2022 18:27:25 +0100, Cristian Marussi wrote:
> just a bunch of small unrelated fixes for v5.20.
> Last one is marked as RFC since as explained it could be controversial.
> 
> Thanks,
> Cristian
> 
> Cristian Marussi (6):
>   firmware: arm_scmi: Fix missing kernel-doc in optee
>   firmware: arm_scmi: Improve checks on .info_get operations
>   firmware: arm_scmi: Harden accesses to Sensor domains
>   firmware: arm_scmi: Harden accesses to Reset domains
>   firmware: arm_scmi: Fix asynchronous reset requests
>   [RFC] firmware: arm_scmi: Add SCMI PM driver remove routine
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/6] firmware: arm_scmi: Fix missing kernel-doc in optee
      https://git.kernel.org/sudeep.holla/c/2e42b1652df0
[2/6] firmware: arm_scmi: Improve checks on .info_get operations
      https://git.kernel.org/sudeep.holla/c/1ecb7d27b1af
[3/6] firmware: arm_scmi: Harden accesses to Sensor domains
      https://git.kernel.org/sudeep.holla/c/76f89c954788
[4/6] firmware: arm_scmi: Harden accesses to Reset domains
      https://git.kernel.org/sudeep.holla/c/e9076ffbcaed
[5/6] firmware: arm_scmi: Fix asynchronous reset requests
      https://git.kernel.org/sudeep.holla/c/b75c83d9b961
[6/6] firmware: arm_scmi: Add SCMI PM driver remove routine
      https://git.kernel.org/sudeep.holla/c/dea796fcab0a

--
Regards,
Sudeep

