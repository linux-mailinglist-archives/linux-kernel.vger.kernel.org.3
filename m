Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEFF48CB29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356409AbiALSmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:42:24 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:39497 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356384AbiALSmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:42:14 -0500
Received: by mail-qk1-f173.google.com with SMTP id 69so4314732qkd.6;
        Wed, 12 Jan 2022 10:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmfYPB11Ou5DTZdDH8mTQHFm0SLlZ8h38q0aVdDysic=;
        b=G+qh8T4jsQjlJuj0Anf1C4YzujKeYu/78+AGu8kEsRbelwScb/x82HXY3/QPAW1KL6
         NKttT1g5NJCES1rF6MPBx3PvOmWTCoMJuDnm4U63mWo4qMlWNs+bi77HuHB1/exo+8wm
         y4KSw2983JmeHr5fchvqP/nyhUDW+WZEyPohH0GVQkCny66uhoXoYnlIvfYJn1UoaZ6b
         dMvWICfzIh+fvQB0/hByZ3W+YiUVz0+wH1glkiwNU4fGsBYsKHhrriVctedDbq/YhxtX
         lbpQ2cB6vv7+MOz+3CLT9aTIQpKLvRAi9JO+gjHpOyznIJGoFek8VxZ83TrehIoO6SVY
         De4g==
X-Gm-Message-State: AOAM533Vexwr8JK9ONNRpG95RYPg4+32CrJ13LvjkG4BtM1VG7TnqxZu
        Fve9UZ1TAl/imBdX7hWCOzyaPBf2oNfWKVqvGTfO9xgw
X-Google-Smtp-Source: ABdhPJx3uptLFabDUOylc68jm5c+2NFmXEkPVdtXcBIzVMWhVjtUe9ctWyrfGxVMTHX82SzVfpT6yMQykXXMYzjjyj4=
X-Received: by 2002:a37:dc45:: with SMTP id v66mr799997qki.516.1642012933392;
 Wed, 12 Jan 2022 10:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20220103155838.616580-1-sudeep.holla@arm.com> <20220105174554.GA29945@1e936cf764ba>
 <20220106141230.qddcwyycefxlbrma@bogus>
In-Reply-To: <20220106141230.qddcwyycefxlbrma@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Jan 2022 19:42:02 +0100
Message-ID: <CAJZ5v0iG0-O1m2hS62yXMNW4p1JhWhxXZCDQc=mxKc50mU7GZw@mail.gmail.com>
Subject: Re: [RFC PATCH] ACPI: PCC: pcc_ctx can be static
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     kernel test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, kbuild-all@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 3:12 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi,
>
> On Thu, Jan 06, 2022 at 01:45:56AM +0800, kernel test robot wrote:
> > drivers/acpi/acpi_pcc.c:34:22: warning: symbol 'pcc_ctx' was not declared. Should it be static?
> >
> > Reported-by: kernel test robot <lkp@intel.com>
>
> Thanks for the fix and sorry for not noticing this before it was merged.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Applied, thanks!
