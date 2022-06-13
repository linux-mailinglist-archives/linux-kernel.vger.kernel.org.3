Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACF5549BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245726AbiFMSkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245581AbiFMSjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:39:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F449D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:34:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a29so9488891lfk.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUVrD5sZvhy5pi929qRyfNG0F+b3Zc/EW53D0+fY2uU=;
        b=cLxqLvD7xD6X5YtMkj/pR8TW/akQrGK2QTo+Z1G9xksqo9jEnqRMdQ8SY9AYMmckFC
         HJ5AvqMRnxQcVPbXzVQ3v3A/WZS/ADypsHxDbf4m1r/LAEVoUoP8iO4W8YpKtVoM9tfa
         Okp/StB9ZLXVpPjEduqgrhG+Qpnh9Ixp/7Abm3G1wPEAB1OdV3aLNRUnPYP5LV1vUti6
         aLDebyyBICArtB06SLl29jLYmJSNf8wcnasQ3r2C+vAGJ9q7aAg8AJCkt1g9mOwtHr+Y
         o4ETYLGJJTtlRm86g3IkVOBdTxr3UOSvG0Ify/sX7MvZKfSy6eM21P9ehvhrxhCk6Je4
         a64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUVrD5sZvhy5pi929qRyfNG0F+b3Zc/EW53D0+fY2uU=;
        b=5RJbb11Igf5U4SToglPsXZMXI4VumYYjiNwnhjQm8V5q8AyJFwxIvq7brklne+CzeR
         hG3CAQti2Aop9tBfDAs7m1jcMmJoiWhiZYjOLXYFYYCFQToNtJQFqzt/GrPuRKG1gePK
         RA1ay6rraxZBgwIzVbdcqQiGI6y44kp0ZvJNehOM131CvBSBzXA1ERdnPuOT2njFI4+x
         uvrR90sQsZQ8w1hPSyXXwlFxTTJxj7Fu5jmS3xq0ZO2zhezpCNgs0lX9j+iIWfosc9v4
         jN552MPhEtiF6epm8aVj+w+hDsKFdHnT4WtfZANGrj8nZ8q6BuWfhD+cOk6PV7va+8os
         9qPQ==
X-Gm-Message-State: AJIora/YxLLSgDsZ8W6yoQ4UAguveJplUQVWrwEDlA8pvT8TUH2tz02n
        uoxUC/pt0WJxhl/BZqG5JXnomH2KC5H00/M7RxuaEQ==
X-Google-Smtp-Source: AGRyM1sivSKtZ2HgEKJkMKPlx6MiLhcJIawAYX5/5JBtlgrK15mqjiclGttnbibu0eAnQ9GvJo6wuuGvSpufL7YXxw0=
X-Received: by 2002:a05:6512:3c8b:b0:479:324c:dfd9 with SMTP id
 h11-20020a0565123c8b00b00479324cdfd9mr258533lfv.644.1655134467556; Mon, 13
 Jun 2022 08:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <202206131853.x4KJwC5Q-lkp@intel.com>
In-Reply-To: <202206131853.x4KJwC5Q-lkp@intel.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 13 Jun 2022 09:34:15 -0600
Message-ID: <CAMkAt6oxQqRCMt54ZRsx_TGd2banbwAy4Hq+A6GHokpMsoo-AA@mail.gmail.com>
Subject: Re: arch/x86/kvm/svm/sev.c:1605:30: warning: parameter 'role' set but
 not used
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 5:03 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Peter,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> commit: 0c2c7c069285374fc8feacddc0498f8ab7627117 KVM: SEV: Mark nested locking of vcpu->lock
> date:   5 weeks ago
> config: x86_64-buildonly-randconfig-r005-20220613 (https://download.01.org/0day-ci/archive/20220613/202206131853.x4KJwC5Q-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c2c7c069285374fc8feacddc0498f8ab7627117
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 0c2c7c069285374fc8feacddc0498f8ab7627117
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/ drivers/media/platform/qcom/camss/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/x86/kvm/svm/sev.c:1605:30: warning: parameter 'role' set but not used [-Wunused-but-set-parameter]
>                                            enum sev_migration_role role)
>                                                                    ^
>    1 warning generated.
>
>
> vim +/role +1605 arch/x86/kvm/svm/sev.c
>
>   1603
>   1604  static int sev_lock_vcpus_for_migration(struct kvm *kvm,
> > 1605                                          enum sev_migration_role role)
>   1606  {
>   1607          struct kvm_vcpu *vcpu;
>   1608          unsigned long i, j;
>   1609          bool first = true;
>   1610
>   1611          kvm_for_each_vcpu(i, vcpu, kvm) {
>   1612                  if (mutex_lock_killable_nested(&vcpu->mutex, role))
>   1613                          goto out_unlock;
>   1614
>

I am confused about this warning. |role| is used on this line above.
Is this because CONFIG_DEBUG_LOCK_ALLOC the subclass argument is
dropped in the macro?
