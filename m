Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE544F7C85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiDGKSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbiDGKRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:17:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C6B276E09
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:15:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE66423A;
        Thu,  7 Apr 2022 03:15:30 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D3903F5A1;
        Thu,  7 Apr 2022 03:15:29 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] ARM: vexpress/spc: Fix doxygen comments
Date:   Thu,  7 Apr 2022 11:15:28 +0100
Message-Id: <164932629049.1424947.11132398032208153251.b4-ty@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404130207.1162445-1-sudeep.holla@arm.com>
References: <20220404130207.1162445-1-sudeep.holla@arm.com>
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

On Mon, 4 Apr 2022 14:02:06 +0100, Sudeep Holla wrote:
> Kbuild bot reported the following doxygen build warning:
> 
>   |  arch/arm/mach-versatile/spc.c:231: warning: This comment starts with
>   |		'/**', but isn't a kernel-doc comment.
>   |		Refer Documentation/doc-guide/kernel-doc.rst
>   |  		* ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)
> 
> [...]


Applied to sudeep.holla/linux (fixes/vexpress) with
s/doxygen/kernel-doc/ as suggested by Randy

[1/2] ARM: vexpress/spc: Fix kernel-doc build warning for ve_spc_cpu_in_wfi
      https://git.kernel.org/sudeep.holla/c/5063b7a80e
[2/2] ARM: vexpress/spc: Fix all the kernel-doc build warnings
      https://git.kernel.org/sudeep.holla/c/42a997f0bd

--
Regards,
Sudeep

