Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A54902E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiAQHVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:21:21 -0500
Received: from mout.gmx.net ([212.227.17.20]:39569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234961AbiAQHVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642404066;
        bh=5A44tv5RQl70N1VW//8mOPYezXRUVBJ6cE+c2TN+/sM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UmtSmI4awEpb/8dO5oKFyEbRZSwKn6IB7TIzhmwdgFM5VuC+C6Yq1P/fAg9qWW6qG
         GRGoVdLKCdMNf9CE+Fr+uHsem3aqI28Bv9X9JNcqXUOfqepo3ZkTRv56NNYgE8rlMi
         s+rXbo0k2s0wGN2AOyXfqrydfS12G7l5qbqn3L9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.167.237]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1mIlfe2sb2-00r1lM; Mon, 17
 Jan 2022 08:21:06 +0100
Message-ID: <74ac7cb1-0c04-8eca-679e-5c58cc7c8d3d@gmx.de>
Date:   Mon, 17 Jan 2022 08:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: arch/parisc/kernel/toc.c:61:32: warning: no previous prototype
 for 'toc_intr'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Sven Schnelle <svens@stackframe.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202201171401.TSfnAVql-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202201171401.TSfnAVql-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fgDbrS2lOCOI80PTI//B9rVE4GoedJX0O4zAdZPKuJGgP1yIGJ9
 ZpReiPDB+sms6uVzG+3jTeZ9B1y84VKrwU03StFZCQqjapT2sGg4662k1YHRuzNK/S7+8G6
 m60aKqqPPPk2DGy8v7P5JHwB6nHEk7cQAIQngzDnsY2eogM1h/9GAKtdb5SsNYdHQ1zKpOd
 uMg+WKI5gKOuk+An7nbXA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d9ucwE9PQds=:3UNeD5IdlEWHt4m2k8bQQw
 u58W4Vzxy9cDMvvQ0sOf/JvqCcH1JV6YinkNY8bllwWAELQsYKxOycmnVEtnGKnEzQdqbv1Ly
 lNl9uBbcPMiFYA9ds6lnWo3XQYrJyyk45cAZXrfN9sKjRwFanRNhPdRgDcRiwLB3fOfu1QuMN
 cD7H7UeUUpnGFgB6iM2GHLi5l17BEVHybUAeFqebt0oexylwyucr52tBFTbio654hzut+Me9G
 zYFOkOH9D5vbfXqsB5Gy7KYj8QsInivGezULaFMFoeD2a7YJVrq6RFZRIeS/IXptS+qLrZD4e
 H0FNt81yznJnjTF0pbnX01JpDfmtKZaa3QUq6LPK2+vi495E8MscX41L5kdiP1Izw9ztU2Ffc
 tHQFC45wZX8/24xD3Ct1JeRXEf+B+m0ZFm9qIo3JEQNm3Yerjqbh15J2lg1eCgTS/mxH0joY6
 5XmCvOMg45Trm43OmOMbU2TEPu5FW2gj9d/vL0tyWx4AJMxPZRciyeItnIXK+EvJwZXfF8urm
 wK+2Qw+Omeu8UdNmEGFz1vcZHrMGS1dhnh096kDRILfXiCNIdB4+YEEHjCPM5pHqzRjrGWtKX
 aX9dONffs3qEb3sCMkTy+7Nxu4FYWT658an0Osmjwxcm0k8wKDodtQsbwqT2vGTJHccPhnppJ
 uUSmyM8QCOnOysS4fekucBfGPEckUxw7XhZR7lNFqedAhW1v321jQFJN7VN4NzJIT3yWdBBCN
 y+HQbjr5DI/9uJK0pekpoEjcrd9ObIR6D6Mm/ssezE6nClPR9yp70vw8MUNV3w+6HBkjaDVP5
 iBq9PZPOWvt4u9frRkPzlOxiYEYiWBRIW5/ydnPvEebIeooTUnLAtGM70oyZPUFzbqlIfVmFK
 UCsFiiGhipcPFsMq1lggRHQqZTBNsda57t+gNAuXSwnMSRX6qOE0WmCjBVuYizYOlEBW1Msqg
 GDYrsTWdCGybuRLiUmBuPguh1PiICG4rkl1rbpuuvGFoG9STANupBA7fPAzHjIpoA/7xI6YSd
 //DiffDklZVdoXT5ztqtP+k5BZraVwgcX4FP68kT5lhSpJp5AaKy3Ej0Oney/GCpie/6l++RX
 B5oAMoFd1rvkUg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 07:57, kernel test robot wrote:
> Hi Sven,
>
> FYI, the error/warning still remains.

I'll fix this.

Helge


> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
> head:   35ce8ae9ae2e471f92759f9d6880eab42cc1c3b6
> commit: bc294838cc3443a2fbec58f8936ad4bd0a0b3055 parisc: add support for=
 TOC (transfer of control)
> date:   3 months ago
> config: parisc-randconfig-r022-20220116 (https://download.01.org/0day-ci=
/archive/20220117/202201171401.TSfnAVql-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/commit/?id=3Dbc294838cc3443a2fbec58f8936ad4bd0a0b3055
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel=
/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout bc294838cc3443a2fbec58f8936ad4bd0a0b3055
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash arch/parisc/kernel/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> arch/parisc/kernel/toc.c:61:32: warning: no previous prototype for 'to=
c_intr' [-Wmissing-prototypes]
>       61 | void notrace __noreturn __cold toc_intr(struct pt_regs *regs)
>          |                                ^~~~~~~~
>
>
> vim +/toc_intr +61 arch/parisc/kernel/toc.c
>
>     60
>   > 61	void notrace __noreturn __cold toc_intr(struct pt_regs *regs)
>     62	{
>     63		struct pdc_toc_pim_20 pim_data20;
>     64		struct pdc_toc_pim_11 pim_data11;
>     65
>     66		nmi_enter();
>     67
>     68		if (boot_cpu_data.cpu_type >=3D pcxu) {
>     69			if (pdc_pim_toc20(&pim_data20))
>     70				panic("Failed to get PIM data");
>     71			toc20_to_pt_regs(regs, &pim_data20);
>     72		} else {
>     73			if (pdc_pim_toc11(&pim_data11))
>     74				panic("Failed to get PIM data");
>     75			toc11_to_pt_regs(regs, &pim_data11);
>     76		}
>     77
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

