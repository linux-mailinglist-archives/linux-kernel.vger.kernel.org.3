Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BE149AD40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443088AbiAYHM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442600AbiAYHJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:09:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05765C061747
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:05:25 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w14so7773816edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abBK9VVUqL6UXjuLUzWwVweR3OtIvZP20Nia7ymSDqE=;
        b=m8brp/KA6L4kEtPy7NYPdztwrNSthgERntr1drcocg6YTINq/qeRvhzDEHxQ6tnhCJ
         FLuAtoTIKUjRLU6O7dVBAewX/90a7jDupC77e7YK1TRAuKpkYve2SUWLUSiMAFxG/uxF
         r7VuB5TSBUGkPK7P44njHJNjstoo6Vu6Cifwr1F/LFau7ckMsijIYypqeh/EWQ/qhvJX
         CXtDrw4/sv+ntsT+6TLBAGpaM5JEPnlwCoGHCfLppNLnYjQXsA/oM3M1xbu+bWdZ16/+
         CytXv5huuxwJxFf+lLDZpc845kYOEWp2VYS2oO9KH1eFvRNKDcMDtn6vxFpowJaxsWyJ
         7osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abBK9VVUqL6UXjuLUzWwVweR3OtIvZP20Nia7ymSDqE=;
        b=mh2ApQGgYkCReFJUNSZaBv+OpamZOtd2lh1CQqvN7/hSUY/n+LEIt71iIO8orcGlMI
         FAAl0tvYb89FdqU8Yj0mbGYP5+93zWkNpfyJ0N0reF0aAjGjfJsKQaX7KPwLr5GsTYXR
         CpWVqVwwM/9ZBIZwGKC6HDtN/slJcdZldbAAOTZ37ncFW4+615ckZKEekkbLZWw9t9Aw
         PcGz3lUGdqlanAPbKdVj2tG7QJrbfXM9jro7ZmXEUm1ghn0DteX5m4Yd8ewCttIAmRTv
         owIP7zv3JqmXwBXVX08QjhMyLucwFFqUXwukShFagcWhbslCCnG9wpEivw+xFWiBvxEF
         f+pw==
X-Gm-Message-State: AOAM53336v3AB7T2N8gUNJnaulsgasewrbNExkuG/xoW7NSkjFGRSUip
        IqJiY3riTpJbnZOSmXZYFMGY9oRg53Up9B1IXyM=
X-Google-Smtp-Source: ABdhPJz3opqJwT2dQuTyCeDjkfvvCqRb7uCqVNzAkTfNe/xl0dc90gK0RUvHWBYwj6QKtN5oeeYPCt2ynzIs2CJ1S0Q=
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr11526651edd.35.1643090723501;
 Mon, 24 Jan 2022 22:05:23 -0800 (PST)
MIME-Version: 1.0
References: <202201250941.1xbLnDRA-lkp@intel.com> <CA+PpKP=5RKwLf0TG9yArbvWQupL8_5YQ5dUvrro+gYkKKk2=Qg@mail.gmail.com>
In-Reply-To: <CA+PpKP=5RKwLf0TG9yArbvWQupL8_5YQ5dUvrro+gYkKKk2=Qg@mail.gmail.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Tue, 25 Jan 2022 14:05:12 +0800
Message-ID: <CA+PpKP==M8gYygZJW7nTYBryj7EB6-7go7EikNVx4OoOH1dLGg@mail.gmail.com>
Subject: Re: fs/proc/base.c:1767:14-18: WARNING: casting value returned by
 memory allocation function to (char *) is useless.
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:01 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
>
> On Tue, Jan 25, 2022 at 10:36 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220123-215907/Hao-Lee/proc-use-kmalloc-instead-of-__get_free_page-to-alloc-path-buffer/20220123-181005
> > head:   98106e76de95ae9aefa914ec056448a5571155dc
> > commit: 98106e76de95ae9aefa914ec056448a5571155dc proc: alloc PATH_MAX bytes for /proc/${pid}/fd/ symlinks
> > date:   35 hours ago
> > config: i386-randconfig-c001-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250941.1xbLnDRA-lkp@intel.com/config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > cocci warnings: (new ones prefixed by >>)
> > >> fs/proc/base.c:1767:14-18: WARNING: casting value returned by memory allocation function to (char *) is useless.
>
> Hello, Alexey,
>
> This patch has been added to the -mm tree, how do we deal with this problem...
> Thanks.

Andrew has handled it. Thanks.

>
> >
> > Please review and possibly fold the followup patch.
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
