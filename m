Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5C5317C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiEWTjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiEWTj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:39:26 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E333365
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:30:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 66D9F3D2F3F;
        Mon, 23 May 2022 15:30:41 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zZSMELB1_qKE; Mon, 23 May 2022 15:30:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DD9E13D3052;
        Mon, 23 May 2022 15:30:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DD9E13D3052
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1653334237;
        bh=bYIxjle3eayijpoTpp2cDmwXc3QPG+ma+cLeqznHpqs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rh17//oVkpDiE2emLdmVCtx5v4pW4vAcdXRcoc2rqNO5sTYI8h/e0DqZaATe0QgXM
         TylPrPSwt7pKgybRGzEmlfr6Mf5/vkWQSdngH5vVbM2qeUCCJTLI7Af1lm/8wGs4Ps
         evOMX6UE62l9DktzZFlOhOCJvM75qb8JBaRlfcMPnIExa8LeSyPKs+g2WWh+UJTSTR
         7oKneQASRg6phouGpBRErpjtQpnRKyA+nE1KE2XLCEJdp1yMf/bznYAC5sg9hACzLF
         XpY2OS+NdusCBbIYKnpyFCHXUgTpYUz04dTwU4hJ7chFU2Lky2Jb8PosEQFo4GcIg2
         e45mBsLutaVyw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RQyvfg6AOMMU; Mon, 23 May 2022 15:30:37 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D358F3D304A;
        Mon, 23 May 2022 15:30:37 -0400 (EDT)
Date:   Mon, 23 May 2022 15:30:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>, 0day robot <lkp@intel.com>
Message-ID: <1454426300.65656.1653334237745.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220523141434.GA17163@xsang-OptiPlex-9020>
References: <20220523141434.GA17163@xsang-OptiPlex-9020>
Subject: Re: [rseq]  3bb11f3f68: kernel-selftests.rseq.make_fail
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4257)
Thread-Topic: 3bb11f3f68: kernel-selftests.rseq.make_fail
Thread-Index: 0Sh53EzkXBVp7zJy4EZOAvI+r5aIEA==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 23, 2022, at 10:14 AM, kernel test robot oliver.sang@intel.com=
 wrote:

> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-11):
>=20
> commit: 3bb11f3f6872a692759f653f90d10674deb330a4 ("rseq: Remove broken ua=
pi
> field layout on 32-bit little endian")
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable-rc.git
> linux-5.15.y
>=20
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-8d3977ef-1_20220520
> with following parameters:
>=20
>=09group: rseq
>=09ucode: 0xec
>=20
> test-description: The kernel contains a set of "self tests" under the
> tools/testing/selftests/ directory. These are intended to be small unit t=
ests
> to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>=20
>=20
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 1=
6G
> memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):

I suspect this is because commit "rseq: Remove broken uapi field layout on =
32-bit little endian"

needs to have this prior commit cherry-picked as well:

commit 5c105d55a9 ("selftests/rseq: introduce own copy of rseq uapi header"=
)

Thanks,

Mathieu

>=20
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
> KERNEL SELFTESTS: linux_headers_dir is
> /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f653=
f90d10674deb330a4
> 2022-05-21 14:37:09 ln -sf /usr/bin/clang
> 2022-05-21 14:37:09 ln -sf /usr/bin/llc
> 2022-05-21 14:37:09 sed -i s/default_timeout=3D45/default_timeout=3D300/
> kselftest/runner.sh
> 2022-05-21 14:37:09 make -C rseq
> make: Entering directory
> '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f6=
53f90d10674deb330a4/tools/testing/selftests/rseq'
> gcc -O2 -Wall -g -I./ -I../../../../usr/include/
> -L/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f=
653f90d10674deb330a4/tools/testing/selftests/rseq
> -Wl,-rpath=3D./  -shared -fPIC rseq.c -lpthread -o
> /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f65=
3f90d10674deb330a4/tools/testing/selftests/rseq/librseq.so
> In file included from rseq.c:30:
> rseq.h: In function =E2=80=98rseq_clear_rseq_cs=E2=80=99:
> rseq.h:143:20: error: request for member =E2=80=98ptr=E2=80=99 in somethi=
ng not a structure or
> union
>  143 |  __rseq_abi.rseq_cs.ptr =3D 0;
>      |                    ^
> make: *** [Makefile:27:
> /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f65=
3f90d10674deb330a4/tools/testing/selftests/rseq/librseq.so]
> Error 1
> make: Leaving directory
> '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f6=
53f90d10674deb330a4/tools/testing/selftests/rseq'
> 2022-05-21 14:37:10 make run_tests -C rseq
> make: Entering directory
> '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f6=
53f90d10674deb330a4/tools/testing/selftests/rseq'
> gcc -O2 -Wall -g -I./ -I../../../../usr/include/
> -L/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f=
653f90d10674deb330a4/tools/testing/selftests/rseq
> -Wl,-rpath=3D./  -shared -fPIC rseq.c -lpthread -o
> /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f65=
3f90d10674deb330a4/tools/testing/selftests/rseq/librseq.so
> In file included from rseq.c:30:
> rseq.h: In function =E2=80=98rseq_clear_rseq_cs=E2=80=99:
> rseq.h:143:20: error: request for member =E2=80=98ptr=E2=80=99 in somethi=
ng not a structure or
> union
>  143 |  __rseq_abi.rseq_cs.ptr =3D 0;
>      |                    ^
> make: *** [Makefile:27:
> /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f65=
3f90d10674deb330a4/tools/testing/selftests/rseq/librseq.so]
> Error 1
> make: Leaving directory
> '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-3bb11f3f6872a692759f6=
53f90d10674deb330a4/tools/testing/selftests/rseq'
>=20
>=20
>=20
> To reproduce:
>=20
>        git clone https://github.com/intel/lkp-tests.git
>        cd lkp-tests
>        sudo bin/lkp install job.yaml           # job file is attached in =
this email
>        bin/lkp split-job --compatible job.yaml # generate the yaml file f=
or lkp run
>        sudo bin/lkp run generated-yaml-file
>=20
>        # if come across any failure that blocks the test,
>        # please remove ~/.lkp and /lkp dir to run from a clean state.
>=20
>=20
>=20
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
