Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C0749CEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbiAZPiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiAZPiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:38:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3ECC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:38:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d18so10071228plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ro5pH9vIpkOFLnJg2Q47tpqXtWuHwH7MahTsVAJomkE=;
        b=de752mf3ztrZpRPGpoGMqFHIHfB/wtWnXWQ1WtrL9Cl1Up+oyieGhM3VGkdRlq8gZx
         UzBgn77zr17htZUyaRQeUwbRi3E7oV6zCn5+H1sa1541iRFTEKnXzSREKHwaL57vzGlg
         /MKTestN1mecRyIevbXMI9wFnwGyM3qFQHTSF0so51mUqX7Gi9k7XWCAqmAjSmt/wxTj
         YQqqfuN5RdoiVmT7QhEoG9zB043tqm0ytaCPbBvFGt4LQ96DYp2OK1icVqIepv3F3oLL
         UvzSa/78WNhVMY9WoHTklxcgXtJGYe6o82DhNZB2JcOWThITmEdtzj66PcWo+7+Vi7fp
         QcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ro5pH9vIpkOFLnJg2Q47tpqXtWuHwH7MahTsVAJomkE=;
        b=PGGqfGzyiSV1NQ92OewnNT/rNyehYI9ZY6aUTvpilriCwtL01CwQl286uSzcN91R4D
         BKGlCM1BDDgJEeGUFD609Q2SRBukTMgMHx5Xv77p/MHyKmCnZqH/gLfNf/aeG6ccN3xp
         MQAzKIoTq1a+qhbZq7WxcKxgT0NmxSjFaTpRVvXuIlUJCNyCfqXyHJjHOMZw3K6dr5UN
         qY6ZdG3XCy4PkCj6erCwARYFSMt1RQFPk2Cyl1i9wNmhX1hpiuDj53TlAy226BFbZPFw
         ImFPIjhN6p1QV+jbGbaytWm9utlkE6ACW634Mz+6sWNlUg0Kf4uqQLC+kqLO7tw8Y5FU
         oPAg==
X-Gm-Message-State: AOAM531hntzmJGUGOyNZaDLCvF+KTr5EqYyfkSSFuw5uOUyCZj0vLHZQ
        //cfsOSSVgeXDVIh5NNUrS6SQzbBAMLGku64lza5Bg==
X-Google-Smtp-Source: ABdhPJzEEGeg4rGOdkO9X2q18hUxteEKmNYUi6ccIY2PKHTbND7OSVYkwmld6Ar5fLOaA9UOMpwyHscEZH2AEQXL9VA=
X-Received: by 2002:a17:90a:640e:: with SMTP id g14mr9266859pjj.8.1643211495352;
 Wed, 26 Jan 2022 07:38:15 -0800 (PST)
MIME-Version: 1.0
References: <202201250055.R82EBqL1-lkp@intel.com>
In-Reply-To: <202201250055.R82EBqL1-lkp@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Jan 2022 07:38:04 -0800
Message-ID: <CAPcyv4iRMYx4kQci2Um=NvsizqVhHTNZiCVbfL18U=ZMX5xm3w@mail.gmail.com>
Subject: Re: [cxl:preview 30/54] drivers/cxl/core/port.c:527
 decoder_populate_targets() warn: inconsistent returns '&cxld->target_lock.lock'.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:09 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
> head:   d0687472d5b56e2018b833723082c2717e96c074
> commit: a5d24e660f35f16cfe30031dcbd7356f7a002398 [30/54] cxl/core/port: Use dedicated lock for decoder target list
> config: s390-randconfig-m031-20220120 (https://download.01.org/0day-ci/archive/20220125/202201250055.R82EBqL1-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.2.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/cxl/core/port.c:527 decoder_populate_targets() warn: inconsistent returns '&cxld->target_lock.lock'.

This report is too late. The branch was posted on the 22nd. The bug
was already found and fixed manually:

https://lore.kernel.org/r/164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com
