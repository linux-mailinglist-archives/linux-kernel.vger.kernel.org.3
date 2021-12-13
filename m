Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC91A473341
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbhLMRxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:53:20 -0500
Received: from foss.arm.com ([217.140.110.172]:33250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234108AbhLMRxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:53:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 745746D;
        Mon, 13 Dec 2021 09:53:18 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8408F3F793;
        Mon, 13 Dec 2021 09:53:17 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: optee: Drop the support for the OPTEE shared dynamic buffer
Date:   Mon, 13 Dec 2021 17:53:15 +0000
Message-Id: <163941758947.730610.17873657952964419577.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125150730.188487-1-sudeep.holla@arm.com>
References: <20211125150730.188487-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 15:07:30 +0000, Sudeep Holla wrote:
> The shared memory buffer allocated by the optee driver is normal cached
> memory and can't be used with IOMEM APIs used in shmem_*.
> 
> We currently support only IO memory for shared memory and supporting
> normal cached memory needs more changes and needs to be thought through
> properly. So for now, let us drop the support for this OPTEE shared buffer.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: optee: Drop the support for the OPTEE shared dynamic buffer
      https://git.kernel.org/sudeep.holla/c/afc9c1e26b

--
Regards,
Sudeep

