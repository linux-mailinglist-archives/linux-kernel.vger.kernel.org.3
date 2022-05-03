Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E90B517F6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbiECIIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiECIIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:08:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D83241EAFA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:04:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5BD11516;
        Tue,  3 May 2022 01:04:47 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E55EE3F774;
        Tue,  3 May 2022 01:04:46 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: Set clock latency to U32_MAX if it is not supported
Date:   Tue,  3 May 2022 09:04:45 +0100
Message-Id: <165156489185.2921185.14872526406815086549.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220428122913.1654821-1-sudeep.holla@arm.com>
References: <20220428122913.1654821-1-sudeep.holla@arm.com>
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

On Thu, 28 Apr 2022 13:29:13 +0100, Sudeep Holla wrote:
> As per the spec, the clock_enable_delay is the worst case latency
> incurred by the platform to enable the clock. The value of 0 indicates
> that the platform doesn't support the same and must be considered as
> maximum latency for practical purposes.
> 
> Currently the value of 0 is assigned as is and is propogated to the clock
> framework which can assume that the clock can support atomic enable operation.
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Set clock latency to U32_MAX if it is not supported
      https://git.kernel.org/sudeep.holla/c/7ad6b6ccba

--
Regards,
Sudeep

