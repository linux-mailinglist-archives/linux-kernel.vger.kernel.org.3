Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569CF48E85A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiANKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:31:06 -0500
Received: from foss.arm.com ([217.140.110.172]:59490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233947AbiANKbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:31:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC8C66D;
        Fri, 14 Jan 2022 02:31:04 -0800 (PST)
Received: from bogus (unknown [10.57.38.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38EFB3F766;
        Fri, 14 Jan 2022 02:31:03 -0800 (PST)
Date:   Fri, 14 Jan 2022 10:30:46 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ACPI: PCC: make pcc_ctx static
Message-ID: <20220114103046.bksotsteooys3ywv@bogus>
References: <20220113161846.1932-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113161846.1932-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 12:18:46AM +0800, Jiapeng Chong wrote:
> This symbol is not used outside of acpi_pcc.c, so marks it static.
> 
> Fix the following sparse warning:
> 
> drivers/acpi/acpi_pcc.c:34:22: warning: symbol 'pcc_ctx' was not
> declared. Should it be static?
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

The fix is now already applied [1]

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/CAJZ5v0iG0-O1m2hS62yXMNW4p1JhWhxXZCDQc=mxKc50mU7GZw@mail.gmail.com
