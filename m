Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3FE5B1B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiIHLY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiIHLYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:24:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8017E26FF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:24:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 109BC14BF;
        Thu,  8 Sep 2022 04:24:30 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C34F3F71A;
        Thu,  8 Sep 2022 04:24:22 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     sudeep.holla@arm.com, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jens.wiklander@linaro.org, marc.bonnici@arm.com,
        coboy.chen@mediatek.com, valentin.laurent@trustonic.com,
        lukas.hanel@trustonic.com, achin.gupta@arm.com
Subject: Re: [PATCH v3 00/10] firmware: arm_ffa: Refactoring and initial/minor v1.1 update
Date:   Thu,  8 Sep 2022 12:24:16 +0100
Message-Id: <166263613429.1889754.11330926190281757716.b4-ty@arm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907145240.1683088-1-sudeep.holla@arm.com>
References: <20220907145240.1683088-1-sudeep.holla@arm.com>
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

On Wed, 7 Sep 2022 15:52:30 +0100, Sudeep Holla wrote:
> This series is just some refactoring in preparation to add FF-A v1.1
> support. It doesn't have any memory layout or notification changes
> supported in v1.1 yet.
> 
> Regards,
> Sudeep
> 
> [...]

Applied to sudeep.holla/linux (for-next/ffa), thanks!

[01/10] firmware: arm_ffa: Add pointer to the ffa_dev_ops in struct ffa_dev
        https://git.kernel.org/sudeep.holla/c/d01387fc1642
[02/10] tee: optee: Drop ffa_ops in optee_ffa structure using ffa_dev->ops directly
        https://git.kernel.org/sudeep.holla/c/320c3fa38c51
[03/10] firmware: arm_ffa: Remove ffa_dev_ops_get()
        https://git.kernel.org/sudeep.holla/c/55bf84fd0a76
[04/10] firmware: arm_ffa: Add support for querying FF-A features
        https://git.kernel.org/sudeep.holla/c/cb1f4c2c15bb
[05/10] firmware: arm_ffa: Use FFA_FEATURES to detect if native versions are supported
        https://git.kernel.org/sudeep.holla/c/e57fba9105fa
[06/10] firmware: arm_ffa: Make memory apis ffa_device independent
        https://git.kernel.org/sudeep.holla/c/8c3812c8f74f
[07/10] firmware: arm_ffa: Rename ffa_dev_ops as ffa_ops
        https://git.kernel.org/sudeep.holla/c/7aa7a9798955
[08/10] firmware: arm_ffa: Add v1.1 get_partition_info support
        https://git.kernel.org/sudeep.holla/c/bb1be7498500
[09/10] firmware: arm_ffa: Set up 32bit execution mode flag using partiion property
	(with the additional version check as discussed on the list)
        https://git.kernel.org/sudeep.holla/c/106b11b1ccd5
[10/10] firmware: arm_ffa: Split up ffa_ops into info, message and memory operations
        https://git.kernel.org/sudeep.holla/c/5b0c6328e47d

--
Regards,
Sudeep

