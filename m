Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34514F4941
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392080AbiDEWJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449128AbiDEPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:49:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A83371AD1D3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:33:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B809923A;
        Tue,  5 Apr 2022 07:33:02 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE2D73F5A1;
        Tue,  5 Apr 2022 07:33:01 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix sparse warnings in OPTEE transport driver
Date:   Tue,  5 Apr 2022 15:33:00 +0100
Message-Id: <164916896263.1245964.4982099650010775310.b4-ty@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404102419.1159705-1-sudeep.holla@arm.com>
References: <20220404102419.1159705-1-sudeep.holla@arm.com>
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

On Mon, 4 Apr 2022 11:24:19 +0100, Sudeep Holla wrote:
> The sparse checker complains about converting pointers between address
> spaces.  We correctly stored an __iomem pointer in struct scmi_optee_channel,
> but discarded the __iomem when returning it from get_channel_shm, causing one
> warning. Then we passed the non-__iomem pointer return from get_channel_shm
> at tow other places, where an __iomem pointer is expected, causing couple of
> other warnings
> 
> [...]

Applied to sudeep.holla/linux (fixes/scmi), thanks!

[1/1] firmware: arm_scmi: Fix sparse warnings in OPTEE transport driver
      https://git.kernel.org/sudeep.holla/c/bf36619a54

--
Regards,
Sudeep

