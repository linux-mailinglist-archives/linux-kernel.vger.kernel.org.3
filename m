Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A755683D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiGFJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiGFJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:41:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EABDF2528C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:40:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46B9415DB;
        Wed,  6 Jul 2022 02:40:03 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42A673F66F;
        Wed,  6 Jul 2022 02:40:00 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, wbartczak@marvell.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        souvik.chakravarty@arm.com, adrian.slatineanu@arm.com,
        wleavitt@marvell.com, james.quinlan@broadcom.com,
        etienne.carriere@linaro.org, daniel.lezcano@linaro.org,
        tarek.el-sherbiny@arm.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v4 0/7] SCMIv3.1 Powercap protocol and driver
Date:   Wed,  6 Jul 2022 10:39:57 +0100
Message-Id: <165710015322.2263892.5289020414237680742.b4-ty@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220704102241.2988447-1-cristian.marussi@arm.com>
References: <20220704102241.2988447-1-cristian.marussi@arm.com>
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

On Mon, 4 Jul 2022 11:22:34 +0100, Cristian Marussi wrote:
> this short series introduces the last missing bit of SCMIv3.1, Powercap
> protocol. Along the series, there is a small refactoring around the SCMI
> FastChannels handling routines so as to reuse as much as possible the
> pre-existent (and tested) FastChannel code from the Perf protocol.
> 
> New SCMI FC tracing support is added too along the way.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/7] dt-bindings: firmware: arm,scmi: Add powercap protocol
      https://git.kernel.org/sudeep.holla/c/451d8457bc
[2/7] firmware: arm_scmi: Add SCMIv3.1 Powercap protocol basic support
      https://git.kernel.org/sudeep.holla/c/0316f99c47
[3/7] firmware: arm_scmi: Generalize FastChannel support
      https://git.kernel.org/sudeep.holla/c/6f9ea4dabd
[4/7] firmware: arm_scmi: Add SCMIv3.1 Powercap FastChannels support
      https://git.kernel.org/sudeep.holla/c/855aa26e5f
[5/7] include: trace: Add SCMI FastChannel tracing
      https://git.kernel.org/sudeep.holla/c/e699eb9b4f
[6/7] firmware: arm_scmi: Use FastChannel tracing
      https://git.kernel.org/sudeep.holla/c/b27d04d5a5

--
Regards,
Sudeep

