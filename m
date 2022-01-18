Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B9C492FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbiARUsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:48:24 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:44018 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiARUsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:48:22 -0500
Received: by mail-pl1-f181.google.com with SMTP id d1so58173plh.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOM/9d3vaIxaBIA0cMlgEqEwisRxVhoT7BelUSgFdDM=;
        b=sbitvUQ4OgXxrW47VqivgQ9xGCd0/HKPVbwpG3s5C14nE2Hgewnq8ySgiN5fsU7k8H
         lpwKel0U6r2orP1VkZe8N5lVsm1H7zKxOthA1a/4RDh8V7uQxXD3xe2nTctDVfRvjuvC
         i8rgcNmESDqllRp4BoXHPVNM3TdmIYopsaWhVilxhdtXVoHsCN6FGjf2KyhDgSpyu6rE
         zU9KXIrmQNsozzMeDqYWXc69yMAYdowBIPNiALs+dwN2USJAEQQ6cF1F5y9LW4WpGnt8
         NGOl7u4CNlBsJzC6GzP6/Xp9gIDzcyQkAwK3jp9fIrnCrNBqzkSaHWJZ52V2Tw+aMeSn
         nqjg==
X-Gm-Message-State: AOAM532E7oD2vki203thqyppxMznCavLo5aRlCGAxAlj3PFfxKdXK58M
        LnwS2VsrVvMOup2rge9aVxUhWzv9MFCfqFhsJ41Si1ip
X-Google-Smtp-Source: ABdhPJxUJ63/JOV+VtzhkuxkOAPuTWf3ZW6Ud5tX3NDbFvZdFix5DDlqcPEPVLZu6wgytwx9SaASnmJ/8DTcWrc8Dzg=
X-Received: by 2002:a17:902:ab12:b0:149:c5a5:5323 with SMTP id
 ik18-20020a170902ab1200b00149c5a55323mr29698203plb.97.1642538901604; Tue, 18
 Jan 2022 12:48:21 -0800 (PST)
MIME-Version: 1.0
References: <202201190351.34Nj9vc7-lkp@intel.com>
In-Reply-To: <202201190351.34Nj9vc7-lkp@intel.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 18 Jan 2022 21:48:10 +0100
Message-ID: <CANBLGcy9Ka8cvgZkXC8ei1gr8V3EN0qiOKATfhyXm9nmjfQ6RA@mail.gmail.com>
Subject: Re: [esmil:visionfive-5.16.y 61/80] drivers/net/phy/motorcomm.c:163:5:
 warning: no previous prototype for 'genphy_config_init'
To:     kernel test robot <lkp@intel.com>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 at 20:13, kernel test robot <lkp@intel.com> wrote:
> tree:   https://github.com/esmil/linux visionfive-5.16.y
> head:   eeeb46a916e77aecbe1699537a5592746f3130f6
> commit: d4993dd33c50b5ea0db8f5a8cdcd0dee5458b299 [61/80] net: phy: motorcomm: Support the YT8521 gigabit PHY
> config: ia64-randconfig-r021-20220116 (https://download.01.org/0day-ci/archive/20220119/202201190351.34Nj9vc7-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/esmil/linux/commit/d4993dd33c50b5ea0db8f5a8cdcd0dee5458b299
>         git remote add esmil https://github.com/esmil/linux
>         git fetch --no-tags esmil visionfive-5.16.y
>         git checkout d4993dd33c50b5ea0db8f5a8cdcd0dee5458b299
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/phy/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Hi,

Thanks for the report and thanks for pointing the robot at this tree!

In the future it would be great if you could point it at the
visionfive branch instead since that where new development should land
first. Right now the visionfive-5.16.y branch is only "ahead" because
5.16.1 came out before 5.17-rc1.

Thanks,
/Emil
