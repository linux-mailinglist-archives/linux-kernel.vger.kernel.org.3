Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C299546A6E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349719AbhLFUfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:35:44 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37238 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhLFUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:35:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6293CCE180B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 20:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6CFC341C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 20:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638822731;
        bh=PpbneIl9UbCtnJCrGClHEOavMhFrhAMlJPtwupxH8ss=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z9R6nTEvhCxJCyLShRLgQUGW9QTRQC/0pjE4wBdCppP8jzL0q3CjU1JHS2vvLrWX1
         jtVLfYOfVePMWAcNDMODh8FZOTCfq9G82mzgiNUAeucvxzRUduPvK56PeD9Bovc2Qm
         CSYcEIThHWkTn2LF+bTRZzGYNoLFenR7Y0bkadMdkT3At96OZMnJ6kOetQDzakSMGv
         wbE0szS0Cc3u+Va/ubckZgd7/HdAWvJVe7YkGo2pRf+C2mylCPQcoNidWdfEy4gJQ2
         5PMRBijj4HGPQit1CGrRbMW6fL64Gb89EWBVVb4CMMpgqQBSJ7E8LqWVQ42RWAvIEJ
         VwivM01Cte6fw==
Received: by mail-ed1-f44.google.com with SMTP id l25so47798122eda.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 12:32:11 -0800 (PST)
X-Gm-Message-State: AOAM530hKJ/+AjoIKFo4F+CkQ07NInabTghi1tbbVSs71StuwrnaNrby
        0K2MqhKEpmPjAiYVJkWqETjlf0R5/16L0ct9AA==
X-Google-Smtp-Source: ABdhPJwHHjaGDe+Z5pMSCRWZlbAmPIhxTCvuANX+k49kHNk3+pxODqBMVcGuMcdtcqNWs13V/5izM69x62MHG6PS54Y=
X-Received: by 2002:a05:6402:4251:: with SMTP id g17mr2007287edb.89.1638822729777;
 Mon, 06 Dec 2021 12:32:09 -0800 (PST)
MIME-Version: 1.0
References: <202111280304.FL2314qf-lkp@intel.com>
In-Reply-To: <202111280304.FL2314qf-lkp@intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 6 Dec 2021 14:31:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzsCvS2QKUo7x4eJ2s6p4=3_d38hyMvsVt7RySjHoGgw@mail.gmail.com>
Message-ID: <CAL_JsqKzsCvS2QKUo7x4eJ2s6p4=3_d38hyMvsVt7RySjHoGgw@mail.gmail.com>
Subject: Re: arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments()
 warn: missing error code 'ret'
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 5:47 AM Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
> commit: ac10be5cdbfa852139658d52c2f1c608782ce992 arm64: Use common of_kex=
ec_alloc_and_setup_fdt()
> config: arm64-randconfig-m031-20211127 (https://download.01.org/0day-ci/a=
rchive/20211128/202111280304.FL2314qf-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments() warn: mi=
ssing error code 'ret'

Lakshmi, Can you please prepare a fix for this. It's been reported since Ju=
ly.

>
> vim +/ret +152 arch/arm64/kernel/machine_kexec_file.c
>
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   81  int load_other_se=
gments(struct kimage *image,
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   82                   =
       unsigned long kernel_load_addr,
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   83                   =
       unsigned long kernel_size,
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   84                   =
       char *initrd, unsigned long initrd_len,
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   85                   =
       char *cmdline)
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   86  {
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   87          struct ke=
xec_buf kbuf;
> 3751e728cef290 AKASHI Takahiro         2019-12-16   88          void *hea=
ders, *dtb =3D NULL;
> 108aa503657ee2 Benjamin Gwin           2020-11-03   89          unsigned =
long headers_sz, initrd_load_addr =3D 0, dtb_len,
> 108aa503657ee2 Benjamin Gwin           2020-11-03   90                   =
     orig_segments =3D image->nr_segments;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   91          int ret =
=3D 0;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   92
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   93          kbuf.imag=
e =3D image;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   94          /* not al=
locate anything below the kernel */
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   95          kbuf.buf_=
min =3D kernel_load_addr + kernel_size;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15   96
> 3751e728cef290 AKASHI Takahiro         2019-12-16   97          /* load e=
lf core header */
> 3751e728cef290 AKASHI Takahiro         2019-12-16   98          if (image=
->type =3D=3D KEXEC_TYPE_CRASH) {
> 3751e728cef290 AKASHI Takahiro         2019-12-16   99                  r=
et =3D prepare_elf_headers(&headers, &headers_sz);
> 3751e728cef290 AKASHI Takahiro         2019-12-16  100                  i=
f (ret) {
> 3751e728cef290 AKASHI Takahiro         2019-12-16  101                   =
       pr_err("Preparing elf core header failed\n");
> 3751e728cef290 AKASHI Takahiro         2019-12-16  102                   =
       goto out_err;
> 3751e728cef290 AKASHI Takahiro         2019-12-16  103                  }
> 3751e728cef290 AKASHI Takahiro         2019-12-16  104
> 3751e728cef290 AKASHI Takahiro         2019-12-16  105                  k=
buf.buffer =3D headers;
> 3751e728cef290 AKASHI Takahiro         2019-12-16  106                  k=
buf.bufsz =3D headers_sz;
> 3751e728cef290 AKASHI Takahiro         2019-12-16  107                  k=
buf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> 3751e728cef290 AKASHI Takahiro         2019-12-16  108                  k=
buf.memsz =3D headers_sz;
> 3751e728cef290 AKASHI Takahiro         2019-12-16  109                  k=
buf.buf_align =3D SZ_64K; /* largest supported page size */
> 3751e728cef290 AKASHI Takahiro         2019-12-16  110                  k=
buf.buf_max =3D ULONG_MAX;
> 3751e728cef290 AKASHI Takahiro         2019-12-16  111                  k=
buf.top_down =3D true;
> 3751e728cef290 AKASHI Takahiro         2019-12-16  112
> 3751e728cef290 AKASHI Takahiro         2019-12-16  113                  r=
et =3D kexec_add_buffer(&kbuf);
> 3751e728cef290 AKASHI Takahiro         2019-12-16  114                  i=
f (ret) {
> 3751e728cef290 AKASHI Takahiro         2019-12-16  115                   =
       vfree(headers);
> 3751e728cef290 AKASHI Takahiro         2019-12-16  116                   =
       goto out_err;
> 3751e728cef290 AKASHI Takahiro         2019-12-16  117                  }
> 7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  118                  i=
mage->elf_headers =3D headers;
> 7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  119                  i=
mage->elf_load_addr =3D kbuf.mem;
> 7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  120                  i=
mage->elf_headers_sz =3D headers_sz;
> 3751e728cef290 AKASHI Takahiro         2019-12-16  121
> 3751e728cef290 AKASHI Takahiro         2019-12-16  122                  p=
r_debug("Loaded elf core header at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\n",
> 7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  123                   =
        image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> 3751e728cef290 AKASHI Takahiro         2019-12-16  124          }
> 3751e728cef290 AKASHI Takahiro         2019-12-16  125
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  126          /* load i=
nitrd */
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  127          if (initr=
d) {
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  128                  k=
buf.buffer =3D initrd;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  129                  k=
buf.bufsz =3D initrd_len;
> c19d050f808812 Bhupesh Sharma          2019-07-11  130                  k=
buf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  131                  k=
buf.memsz =3D initrd_len;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  132                  k=
buf.buf_align =3D 0;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  133                  /=
* within 1GB-aligned window of up to 32GB in size */
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  134                  k=
buf.buf_max =3D round_down(kernel_load_addr, SZ_1G)
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  135                   =
                               + (unsigned long)SZ_1G * 32;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  136                  k=
buf.top_down =3D false;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  137
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  138                  r=
et =3D kexec_add_buffer(&kbuf);
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  139                  i=
f (ret)
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  140                   =
       goto out_err;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  141                  i=
nitrd_load_addr =3D kbuf.mem;
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  142
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  143                  p=
r_debug("Loaded initrd at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\n",
> 51075e0cb759a7 =C5=81ukasz Stelmach         2020-04-30  144              =
                    initrd_load_addr, kbuf.bufsz, kbuf.memsz);
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  145          }
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  146
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  147          /* load d=
tb */
> ac10be5cdbfa85 Rob Herring             2021-02-21  148          dtb =3D o=
f_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
> ac10be5cdbfa85 Rob Herring             2021-02-21  149                   =
                          initrd_len, cmdline, 0);
> ac10be5cdbfa85 Rob Herring             2021-02-21  150          if (!dtb)=
 {
> 52b2a8af743604 AKASHI Takahiro         2018-11-15  151                  p=
r_err("Preparing for new dtb failed\n");
> 52b2a8af743604 AKASHI Takahiro         2018-11-15 @152                  g=
oto out_err;
>                                                                         ^=
^^^^^^^^^^^^
> This needs an error code.
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
