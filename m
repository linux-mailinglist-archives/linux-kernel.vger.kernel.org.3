Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14F1517F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiECIIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiECIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:08:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F04541837A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:04:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A38AC12FC;
        Tue,  3 May 2022 01:04:17 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AEEB3F774;
        Tue,  3 May 2022 01:04:16 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, etienne.carriere@linaro.org,
        james.quinlan@broadcom.com, souvik.chakravarty@arm.com,
        Jonathan.Cameron@Huawei.com, vincent.guittot@linaro.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH 00/22] SCMIv3.1 Miscellaneous changes
Date:   Tue,  3 May 2022 09:03:54 +0100
Message-Id: <165156489185.2921185.2337902735706863789.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
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

On Wed, 30 Mar 2022 16:05:29 +0100, Cristian Marussi wrote:
> this series introduces a bunch of SCMIv3.1 miscellaneous changes to support
> basically all the SCMIv3.1 specification [1] addition with the exclusion of
> the Powercap protocol and driver which will be introduced later on in
> another series.
> 
> Most notably the series adds:
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[02/22] firmware: arm_scmi: Make protocols init fail on basic errors
        https://git.kernel.org/sudeep.holla/c/4de1b36fae
[03/22] firmware: arm_scmi: Fix Base list protocols enumeration
        https://git.kernel.org/sudeep.holla/c/8009120e03
[04/22] firmware: arm_scmi: Validate BASE_DISCOVER_LIST_PROTOCOLS reply
        https://git.kernel.org/sudeep.holla/c/3b0041f6e1
[05/22] firmware: arm_scmi: Dynamically allocate protocols array
        https://git.kernel.org/sudeep.holla/c/776b6c8a25
[06/22] firmware: arm_scmi: Make name_get operations return a const
        https://git.kernel.org/sudeep.holla/c/992be5d3c8
[07/22] firmware: arm_scmi: Check CLOCK_RATE_SET_COMPLETE async reply
        https://git.kernel.org/sudeep.holla/c/c7e223f5c7
[08/22] firmware: arm_scmi: Remove unneeded NULL termination of clk name
        https://git.kernel.org/sudeep.holla/c/91ebc56cbc
[09/22] firmware: arm_scmi: Split protocol specific definitions in a dedicated header
        https://git.kernel.org/sudeep.holla/c/23136bff80
[10/22] firmware: arm_scmi: Introduce a common SCMIv3.1 .extended_name_get helper
        https://git.kernel.org/sudeep.holla/c/5c873d120d
[11/22] firmware: arm_scmi: Add SCMIv3.1 extended names protocols support
        https://git.kernel.org/sudeep.holla/c/b260fccaeb
[12/22] firmware: arm_scmi: Parse clock_enable_latency conditionally
        https://git.kernel.org/sudeep.holla/c/df3576d14a
[13/22] firmware: arm_scmi: Add iterators for multi-part commands
        https://git.kernel.org/sudeep.holla/c/36b6ea0fc6
[14/22] firmware: arm_scmi: Use common iterators in Sensor protocol
        https://git.kernel.org/sudeep.holla/c/7cab537704
[15/22] firmware: arm_scmi: Add SCMIv3.1 SENSOR_AXIS_NAME_GET support
        https://git.kernel.org/sudeep.holla/c/802b0bed01
[16/22] firmware: arm_scmi: Use common iterators in Clock protocol
        https://git.kernel.org/sudeep.holla/c/7bc7caafe6
[17/22] firmware: arm_scmi: Use common iterators in Voltage protocol
        https://git.kernel.org/sudeep.holla/c/d8d7e91316
[18/22] firmware: arm_scmi: Use common iterators in Perf protocol
        https://git.kernel.org/sudeep.holla/c/79d2ea9244
[19/22] firmware: arm_scmi: Add SCMIv3.1 Clock notifications
        https://git.kernel.org/sudeep.holla/c/7aa75496ea
[20/22] firmware: arm_scmi: Add SCMIv3.1 VOLTAGE_LEVEL_SET_COMPLETE
        https://git.kernel.org/sudeep.holla/c/4c74701b1e
[21/22] firmware: arm_scmi: Add SCMI v3.1 Perf power-cost in microwatts
        https://git.kernel.org/sudeep.holla/c/3630cd8130
[22/22] firmware: arm_scmi: Add SCMIv3.1 PERFORMANCE_LIMITS_SET checks
        https://git.kernel.org/sudeep.holla/c/71bea05797

--
Regards,
Sudeep

