Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0867C47D399
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhLVOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:23:18 -0500
Received: from foss.arm.com ([217.140.110.172]:46620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233186AbhLVOXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:23:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F343D6E;
        Wed, 22 Dec 2021 06:23:16 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C9D23F774;
        Wed, 22 Dec 2021 06:23:15 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, etienne.carriere@linaro.org,
        souvik.chakravarty@arm.com, Jonathan.Cameron@Huawei.com,
        vincent.guittot@linaro.org, james.quinlan@broadcom.com,
        f.fainelli@gmail.com
Subject: Re: [PATCH v8 00/11] (subset) Introduce atomic support for SCMI transports
Date:   Wed, 22 Dec 2021 14:23:09 +0000
Message-Id: <164018266575.56571.7239723529749989056.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211220195646.44498-1-cristian.marussi@arm.com>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 19:56:35 +0000, Cristian Marussi wrote:
> This series mainly aims to introduce atomic support for SCMI transports
> that can support it.
> 
> In [01/11], as a closely related addition, it is introduced a common way
> for a transport to signal to the SCMI core that it does not offer
> completion interrupts, so that the usual polling behaviour will be
> required: this can be done enabling statically a global polling behaviour
> for the whole transport with flag scmi_desc.force_polling OR dynamically
> enabling at runtime such polling behaviour on a per-channel basis using
> the flag scmi_chan_info.no_completion_irq, typically during .chan_setup().
> The usual per-command polling selection behaviour based on
> hdr.poll_completion is preserved as before.
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[01/11] firmware: arm_scmi: Add configurable polling mode for transports
        https://git.kernel.org/sudeep.holla/c/a690b7e6e7
[02/11] firmware: arm_scmi: Make smc transport use common completions
        https://git.kernel.org/sudeep.holla/c/f716cbd33f
[03/11] firmware: arm_scmi: Add sync_cmds_completed_on_ret transport flag
        https://git.kernel.org/sudeep.holla/c/31d2f803c1
[04/11] firmware: arm_scmi: Make smc support sync_cmds_completed_on_ret
        https://git.kernel.org/sudeep.holla/c/117542b81f
[05/11] firmware: arm_scmi: Make optee support sync_cmds_completed_on_ret
        https://git.kernel.org/sudeep.holla/c/bf322084fe
[06/11] firmware: arm_scmi: Add support for atomic transports
        https://git.kernel.org/sudeep.holla/c/69255e7468
[07/11] firmware: arm_scmi: Add atomic mode support to smc transport
        https://git.kernel.org/sudeep.holla/c/0bfdca8a86
[08/11] firmware: arm_scmi: Add new parameter to mark_txdone
        https://git.kernel.org/sudeep.holla/c/94d0cd1da1


Deferring the last 3 for next release. We can see if we can include
latest spec change for clock atomic support 🤞.

--
Regards,
Sudeep

