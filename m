Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2C5683E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiGFJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiGFJlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:41:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDE5624BF7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:39:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 900741042;
        Wed,  6 Jul 2022 02:39:38 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10ACD3F66F;
        Wed,  6 Jul 2022 02:39:36 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH v2 0/2] Add SCMI full message tracing
Date:   Wed,  6 Jul 2022 10:39:33 +0100
Message-Id: <165710015322.2263892.9997974312132058494.b4-ty@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220630173135.2086631-1-cristian.marussi@arm.com>
References: <20220630173135.2086631-1-cristian.marussi@arm.com>
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

On Thu, 30 Jun 2022 18:31:33 +0100, Cristian Marussi wrote:
> after a few recent troubles handling too strictly out-of-spec replies from
> SCMI servers deployed in the wild, I though it could have been useful to
> have a basic way to dump at will the effective full payloads of
> successfully transmitted/received SCMI messages.
> 
> The existing SCMI traces already collect a bunch of information about SCMI
> message exchanges but they do NOT keep any payload information: this is
> certainly preferable most of the time since dumping full SCMI messages to
> the trace buffer involves a full copy of the payload.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/2] include: trace: Add SCMI full message tracing
      https://git.kernel.org/sudeep.holla/c/2bd0467074
[2/2] firmware: arm_scmi: Use new SCMI full message tracing
      https://git.kernel.org/sudeep.holla/c/b60e088682

--
Regards,
Sudeep

