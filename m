Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC44F50E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843841AbiDFBmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449039AbiDEPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:49:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25A371AAFE8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:32:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784AE23A;
        Tue,  5 Apr 2022 07:32:51 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3CC33F5A1;
        Tue,  5 Apr 2022 07:32:50 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix sorting of retrieved clock rates
Date:   Tue,  5 Apr 2022 15:32:48 +0100
Message-Id: <164916896262.1245964.759396458179093789.b4-ty@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318092813.49283-1-cristian.marussi@arm.com>
References: <20220318092813.49283-1-cristian.marussi@arm.com>
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

On Fri, 18 Mar 2022 09:28:13 +0000, Cristian Marussi wrote:
> During SCMI Clock protocol initialization, after having retrieved from the
> SCMI platform all the available discrete rates for a specific clock, the
> clock rates array is sorted, unfortunately using a pointer to its end as
> a base instead of its start, so that sorting does not work.
> 
> Fix invocation of sort() passing as base a pointer to the start of the
> retrieved clock rates array.
> 
> [...]

Applied to sudeep.holla/linux (fixes/scmi), thanks!

[1/1] firmware: arm_scmi: Fix sorting of retrieved clock rates
      https://git.kernel.org/sudeep.holla/c/23274739a5

--
Regards,
Sudeep

