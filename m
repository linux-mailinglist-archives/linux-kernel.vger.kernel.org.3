Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158E6519C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347893AbiEDJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347832AbiEDJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:54:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21BCC27B34
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:51:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADE3ED1;
        Wed,  4 May 2022 02:51:04 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 005013FA50;
        Wed,  4 May 2022 02:51:03 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix late checks on pointer dereference
Date:   Wed,  4 May 2022 10:50:49 +0100
Message-Id: <165165782039.3475411.4505052280143077810.b4-ty@arm.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503121047.3590340-1-cristian.marussi@arm.com>
References: <20220503121047.3590340-1-cristian.marussi@arm.com>
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

On Tue, 3 May 2022 13:10:47 +0100, Cristian Marussi wrote:
> A few dereferences could happen before the iterator pointer argument was
> checked for NULL, causing the following smatch warnings:
> 
> drivers/firmware/arm_scmi/driver.c:1214 scmi_iterator_run() warn: variable
> dereferenced before check 'i' (see line 1210)
> 
> Fix by moving the checks early and dropping some unneeded local references.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Fix late checks on pointer dereference
      https://git.kernel.org/sudeep.holla/c/c7f8852d42

--
Regards,
Sudeep

