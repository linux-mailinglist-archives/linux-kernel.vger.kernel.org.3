Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A144BF7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiBVMQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiBVMQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:16:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BF9C7E5AE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:16:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 869221063;
        Tue, 22 Feb 2022 04:16:03 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 014B83F5A1;
        Tue, 22 Feb 2022 04:16:01 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, peter.hilber@opensynergy.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com
Subject: Re: [PATCH v5 0/8] Add SCMI Virtio & Clock atomic support
Date:   Tue, 22 Feb 2022 12:15:59 +0000
Message-Id: <164545700514.3239877.12444812805375315945.b4-ty@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217131234.50328-1-cristian.marussi@arm.com>
References: <20220217131234.50328-1-cristian.marussi@arm.com>
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

On Thu, 17 Feb 2022 13:12:26 +0000, Cristian Marussi wrote:
> This small series is the tail-subset of the previous V8 series about atomic
> support in SCMI [1], whose 8-patches head-subset has now been queued on
> [2]; as such, it is based on [2] on top of tag scmi-updates-5.17:
> 
> commit 94d0cd1da14a ("firmware: arm_scmi: Add new parameter to
> 		     mark_txdone")
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/8] firmware: arm_scmi: Add a virtio channel refcount
      https://git.kernel.org/sudeep.holla/c/42e90eb53b
[2/8] firmware: arm_scmi: Review virtio free_list handling
      https://git.kernel.org/sudeep.holla/c/9a1699bda0
[3/8] firmware: arm_scmi: Add atomic mode support to virtio transport
      https://git.kernel.org/sudeep.holla/c/5a3b7185c4
[4/8] dt-bindings: firmware: arm,scmi: Add atomic-threshold-us optional property
      https://git.kernel.org/sudeep.holla/c/0539884ccc
[5/8] firmware: arm_scmi: Support optional system wide atomic-threshold-us
      https://git.kernel.org/sudeep.holla/c/05976c5f3b
[6/8] firmware: arm_scmi: Add atomic support to clock protocol
      https://git.kernel.org/sudeep.holla/c/b7bd36f2e9
[7/8] firmware: arm_scmi: Add support for clock_enable_latency
      https://git.kernel.org/sudeep.holla/c/18f295b758
[8/8] clk: scmi: Support atomic clock enable/disable API
      https://git.kernel.org/sudeep.holla/c/38a0e5b735

--
Regards,
Sudeep

