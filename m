Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A0E49C71F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbiAZKJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:09:09 -0500
Received: from foss.arm.com ([217.140.110.172]:56834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232002AbiAZKJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:09:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 725C81FB;
        Wed, 26 Jan 2022 02:09:07 -0800 (PST)
Received: from bogus (unknown [10.57.39.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3864E3F766;
        Wed, 26 Jan 2022 02:09:06 -0800 (PST)
Date:   Wed, 26 Jan 2022 10:08:31 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Chao Liu <liuchao173@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hewenliang4@huawei.com, zhoukang7@huawei.com
Subject: Re: [PATCH v2] add cpu frequency to cpuinfo in arm64
Message-ID: <20220126100831.vrjid6c6k5qafd6a@bogus>
References: <20220126092349.285642-1-liuchao173@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126092349.285642-1-liuchao173@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:23:49AM +0000, Chao Liu wrote:
> There is cpu frequency in /proc/cpuinfo in x86 but not in arm64
>

This has been repeatedly rejected in the past for valid reasons. I
could find this link[1] quickly, but I am sure you can find a handful of
such attempts in the past.

-- 
Regards,
Sudeep

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/1386924222-23169-1-git-send-email-vkale@apm.com/
