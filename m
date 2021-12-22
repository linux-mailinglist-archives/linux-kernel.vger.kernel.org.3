Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83C47D65B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbhLVSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:15:16 -0500
Received: from foss.arm.com ([217.140.110.172]:51650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233546AbhLVSPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:15:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A613D1FB;
        Wed, 22 Dec 2021 10:15:15 -0800 (PST)
Received: from bogus (unknown [10.57.36.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64F953F5A1;
        Wed, 22 Dec 2021 10:15:14 -0800 (PST)
Date:   Wed, 22 Dec 2021 18:15:11 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     trix@redhat.com
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: replace resevered identifiers in
 macros
Message-ID: <20211222181511.n262joky3gw7h2gr@bogus>
References: <20211222172519.3209478-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222172519.3209478-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:25:19AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Identifiers starting with __ are resevered.  Replace __X with X.
> 
> The arguments to these macros are pointers.  The macros only reads
> values.  There is no need to make copies of the pointers, use them
> directly.
>

Agreed and thanks for the patch.

However the original patch was modified and these macros were moved
to inline functions[0] after the initial build warnings from the
build bot[1]. Sorry my reply to the bot seems to have got lost and didn't
make it to the list.

-- 
Regards,
Sudeep

[0] https://git.kernel.org/sudeep.holla/c/a690b7e6e7
[1] https://lore.kernel.org/lkml/202112211457.TlWRYcoq-lkp@intel.com/
