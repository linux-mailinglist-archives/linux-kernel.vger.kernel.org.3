Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2F47333F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbhLMRwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:52:22 -0500
Received: from foss.arm.com ([217.140.110.172]:33218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235008AbhLMRwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:52:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 014616D;
        Mon, 13 Dec 2021 09:52:20 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A39B43F793;
        Mon, 13 Dec 2021 09:52:18 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, Jonathan.Cameron@Huawei.com,
        souvik.chakravarty@arm.com, f.fainelli@gmail.com,
        james.quinlan@broadcom.com
Subject: Re: [PATCH v7 00/16] (subset) Introduce atomic support for SCMI transports
Date:   Mon, 13 Dec 2021 17:52:11 +0000
Message-Id: <163941764494.730640.10200745909627088229.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129191156.29322-1-cristian.marussi@arm.com>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 19:11:40 +0000, Cristian Marussi wrote:
> This series mainly aims to introduce atomic support for SCMI transports
> that can support it.
> 
> After a bit of refactoring in the first 5 patches of the series, in
> [06/16], as a closely related addition, it is introduced a common way for a
> transport to signal to the SCMI core that it does not offer completion
> interrupts, so that the usual polling behaviour will be required: this can
> be done enabling statically a global polling behaviour for the whole
> transport with flag scmi_desc.force_polling OR dynamically enabling at
> runtime such polling behaviour on a per-channel basis using the flag
> scmi_chan_info.no_completion_irq, typically during .chan_setup().
> The usual per-command polling selection behaviour based on
> hdr.poll_completion is preserved as before.
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[01/16] firmware: arm_scmi: Perform earlier cinfo lookup call in do_xfer
        https://git.kernel.org/sudeep.holla/c/d211ddeb51
[02/16] firmware: arm_scmi: Set polling timeout to max_rx_timeout_ms
        https://git.kernel.org/sudeep.holla/c/582730b9cb
[03/16] firmware: arm_scmi: Refactor message response path
        https://git.kernel.org/sudeep.holla/c/5a731aebd3
[04/16] include: trace: Add new scmi_xfer_response_wait event
        https://git.kernel.org/sudeep.holla/c/8b276b59cc
[05/16] firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
        https://git.kernel.org/sudeep.holla/c/f872af0909

--
Regards,
Sudeep

