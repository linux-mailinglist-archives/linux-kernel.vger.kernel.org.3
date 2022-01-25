Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B149AB66
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbiAYEug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S252182AbiAYE0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:26:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D297C036BD6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:01:15 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d10so26955248eje.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Cf7HaBEW8ZShSggL6tkumxi9Mw0DTtg8YdgRM/NCJ4=;
        b=qH+SaFIlivJarF0Hk+Y1uD0uJ6o8VVf/6A6TljK3Wf/aT1RSc0qz12Ul8rbpNOSIaN
         CFBTLvJb5/oudP2kwX0FPcRlgjNiErQX2PlDJGY/gEjXLUIm7TbFUZbGzuscDTHi5m5T
         bK2werne4qU1oOtBm5x8LK0xJ9dNNK7gA0fAxvoLs6A/O27YqQSKzCMrEfT4uh+F7Rv4
         zi8l4rsuyVwSfbTqN3eWuLJ0npYuff5lAFWVWXecjRD8wkHwm47qPTVvXwc2Q16tUNJH
         pfrRbX9enPGE1+4ZlQyb29VC/CzhvhshFhqos0wtB3WjCy4H26M0o/TYQ0kynJbCDo7C
         EIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Cf7HaBEW8ZShSggL6tkumxi9Mw0DTtg8YdgRM/NCJ4=;
        b=vYbUx7ZS/RsmWamMLHzWG7CLc5IXJk6v8O/XKhdzpP384EiiDOtNySWYakL965zXn4
         Lf4rGTJsemebnazGwcqIy5s8xkBw6OQ0UYbF32oLWjERmFPsLBMC8VsRWfGbwDGiSTcJ
         YIbZTpwwdvPhSWsorjk7wGaMzgL8RcQR/LvpoZgr7urqDlxav3+NFLm7UnJWF758KBUB
         dum9evgxyqgsv2ju814JceSJEbyG4DoOCHnJ7MgV1AtvFD7x0eirVFL3tmexQ1MezgDR
         xkr/Don8brT9vDgplbkgqP3NYotXr2wgIaD+k4DkHzc09ymoDp8KoxlHwT/rnK5NWZ5X
         w8pw==
X-Gm-Message-State: AOAM532TrNeFpad2T92dATHd24Fa1PRnJtBYuKeQ/JpOGY6/U3a8s+ku
        B4JcS60nKatrEIjtHuYQbuwXcCsVhPXyw+zSbubf+CvyLfg=
X-Google-Smtp-Source: ABdhPJyTujZnq+T75BYqttnf3SUDnVn8mtV198uU7sQYAkf1W21q46hvvVttf6378o3YrQmcq1LWVg4U/7cKWYBGRQE=
X-Received: by 2002:a17:906:2715:: with SMTP id z21mr14573052ejc.393.1643079674133;
 Mon, 24 Jan 2022 19:01:14 -0800 (PST)
MIME-Version: 1.0
References: <202201250941.1xbLnDRA-lkp@intel.com>
In-Reply-To: <202201250941.1xbLnDRA-lkp@intel.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Tue, 25 Jan 2022 11:01:02 +0800
Message-ID: <CA+PpKP=5RKwLf0TG9yArbvWQupL8_5YQ5dUvrro+gYkKKk2=Qg@mail.gmail.com>
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

On Tue, Jan 25, 2022 at 10:36 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220123-215907/Hao-Lee/proc-use-kmalloc-instead-of-__get_free_page-to-alloc-path-buffer/20220123-181005
> head:   98106e76de95ae9aefa914ec056448a5571155dc
> commit: 98106e76de95ae9aefa914ec056448a5571155dc proc: alloc PATH_MAX bytes for /proc/${pid}/fd/ symlinks
> date:   35 hours ago
> config: i386-randconfig-c001-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250941.1xbLnDRA-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> cocci warnings: (new ones prefixed by >>)
> >> fs/proc/base.c:1767:14-18: WARNING: casting value returned by memory allocation function to (char *) is useless.

Hello, Alexey,

This patch has been added to the -mm tree, how do we deal with this problem...
Thanks.

>
> Please review and possibly fold the followup patch.
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
