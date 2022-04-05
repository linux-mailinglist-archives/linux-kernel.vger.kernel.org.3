Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A514F402F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448979AbiDEUKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449023AbiDEPtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:49:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A24151AAA77
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:32:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 006D523A;
        Tue,  5 Apr 2022 07:32:46 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE7453F5A1;
        Tue,  5 Apr 2022 07:32:44 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     cgel.zte@gmail.com
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, cristian.marussi@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: Replace zero-length array with flexible-array member
Date:   Tue,  5 Apr 2022 15:32:37 +0100
Message-Id: <164916896263.1245964.9249363820319711355.b4-ty@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401075537.2407376-1-lv.ruyi@zte.com.cn>
References: <20220401075537.2407376-1-lv.ruyi@zte.com.cn>
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

On Fri, 1 Apr 2022 07:55:37 +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [...]

Applied to sudeep.holla/linux (fixes/scmi), thanks!

[1/1] firmware: arm_scmi: Replace zero-length array with flexible-array member
      https://git.kernel.org/sudeep.holla/c/f1ad601d1f

--
Regards,
Sudeep

