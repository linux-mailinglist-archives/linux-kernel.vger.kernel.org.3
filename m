Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF56517F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiECIH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiECIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:07:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 926E91837A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:04:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4946C143D;
        Tue,  3 May 2022 01:04:23 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5488D3F774;
        Tue,  3 May 2022 01:04:22 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3] firmware: arm_scmi: support optee shared memory in optee transport
Date:   Tue,  3 May 2022 09:04:20 +0100
Message-Id: <165156489186.2921185.10737383487390026057.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220425085127.2009-1-etienne.carriere@linaro.org>
References: <20220425085127.2009-1-etienne.carriere@linaro.org>
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

On Mon, 25 Apr 2022 10:51:27 +0200, Etienne Carriere wrote:
> Adds support for tee shared memory in optee scmi transport. When using
> tee shared memory, scmi optee transport manages SCMI messages using
> msg protocol (from msg.c) in shared memory, whereas smt (from shmem.c)
> protocol is used with static IOMEM shared buffers.
> 
> 

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: support optee shared memory in optee transport
      https://git.kernel.org/sudeep.holla/c/5e114ad984

--
Regards,
Sudeep

