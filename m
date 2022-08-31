Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B415A7EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiHaNZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiHaNZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:25:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0866A43301
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:25:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C21B6ED1;
        Wed, 31 Aug 2022 06:25:39 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72BDE3F766;
        Wed, 31 Aug 2022 06:25:32 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cristian.marussi@arm.com
Cc:     Sudeep Holla <sudeep.holla@arm.com>, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 0/1] Harmonize SCMI traces formats
Date:   Wed, 31 Aug 2022 14:25:28 +0100
Message-Id: <166195221577.495172.12603063310858665227.b4-ty@arm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220818132309.584042-1-cristian.marussi@arm.com>
References: <20220818132309.584042-1-cristian.marussi@arm.com>
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

On Thu, 18 Aug 2022 14:23:08 +0100, Cristian Marussi wrote:
> after having recently added new scmi_msg_dump traces I realized the
> general format of the various other SCMI traces is not consistent.
> 
> As an example the full traces of a simple PERF_LEVEL_SET is now:
> 
>      cpufreq-set-276     [000] .....   139.905639: scmi_xfer_begin: transfer_id=145 msg_id=7 protocol_id=19 seq=145 poll=0
>      cpufreq-set-276     [000] .....   139.905724: scmi_msg_dump: pt=13 t=CMND msg_id=07 seq=0091 s=0 pyld=000000008066ab13
>      cpufreq-set-276     [000] .....   139.905725: scmi_xfer_response_wait: transfer_id=145 msg_id=7 protocol_id=19 seq=145 tmo_ms=5000 poll=0
>           <idle>-0       [000] d.h2.   139.906493: scmi_msg_dump: pt=13 t=RESP msg_id=07 seq=0091 s=0 pyld=
>           <idle>-0       [000] d.h2.   139.906521: scmi_rx_done: transfer_id=145 msg_id=7 protocol_id=19 seq=145 msg_type=0
>      cpufreq-set-276     [000] .....   139.906651: scmi_xfer_end: transfer_id=145 msg_id=7 protocol_id=19 seq=145 status=0
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] include: trace: Harmonize SCMI tracing message format
      https://git.kernel.org/sudeep.holla/c/40d30cf680cb

--
Regards,
Sudeep

