Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70694D37C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiCIQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbiCIQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:53:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDC71A06FF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:45:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F06D6B82220
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBE0C340EC;
        Wed,  9 Mar 2022 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646844302;
        bh=83IGyBqVydE6YEKGx37m7oauqMwS0tW82l+P4o7tTyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDyh63jIl4VGG121WLpp6aX1WRZXcTpmSTWrhIXpANQJGqeorP7ah9vmg0y+Ba0hg
         NexX7EZpQ2NFSMVWswe4eGuz0Z817XuYsb/eop1+ZfDgxd4oaiqyL93MfYXS95tHP2
         dFQASo3Fkr4arCp0yGbF0Rto85BDJvtLGgAhIt47bG66ZwP4Guy32EQQD/w+ZrO/AE
         QHbtGtrwXO/XTySqwQjt4f42t3zjvUREpDpT6CMzmT5eM8QDDIZsmV426B2Qhri8q/
         CN4pKBeSRZsiX0+T2lCukwa0J27477yEOWLe+Wte9U6VwTh9UxOmbZfmnlr/O1Gu1a
         7YOIL1njUrCyA==
Date:   Wed, 9 Mar 2022 16:44:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernelci-results@groups.io, bot@kernelci.org,
        linux-kernel@vger.kernel.org, gtucker@collabora.com
Subject: Re: next/master bisection: baseline.login on qemu_i386
Message-ID: <YijZiapwew8Gnilg@sirena.org.uk>
References: <6228a7a7.1c69fb81.85abc.005f@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pb8q8t+3bAhTPP2n"
Content-Disposition: inline
In-Reply-To: <6228a7a7.1c69fb81.85abc.005f@mx.google.com>
X-Cookie: You will inherit millions of dollars.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pb8q8t+3bAhTPP2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2022 at 05:12:07AM -0800, KernelCI bot wrote:

The KernelCI bisection bot found that commit dc6e0818bc9a0336d9a
("sched/cpuacct: Optimize away RCU read lock") has been causing boot
failures for i386 qemu systems running a defconfig with debug options
added in -next.  The system comes up to userspace but the shell is
unresponsive, most other architectures and configs (including i386
without debug options) seem fine.

I've left the full bisection report including links to logs below, you
can also see a full overview of the baseline tests for -next today at:

    https://linux.kernelci.org/test/job/next/branch/master/kernel/next-2022=
0309/plan/baseline/

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>=20
> next/master bisection: baseline.login on qemu_i386
>=20
> Summary:
>   Start:      cb153b68ff91 Add linux-next specific files for 20220308
>   Plain log:  https://storage.kernelci.org/next/master/next-20220308/i386=
/i386_defconfig+debug/gcc-10/lab-baylibre/baseline-qemu_i386.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20220308/i386=
/i386_defconfig+debug/gcc-10/lab-baylibre/baseline-qemu_i386.html
>   Result:     dc6e0818bc9a sched/cpuacct: Optimize away RCU read lock
>=20
> Checks:
>   revert:     PASS
>   verify:     PASS
>=20
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
>   Branch:     master
>   Target:     qemu_i386
>   CPU arch:   i386
>   Lab:        lab-baylibre
>   Compiler:   gcc-10
>   Config:     i386_defconfig+debug
>   Test case:  baseline.login
>=20
> Breaking commit found:
>=20
> -------------------------------------------------------------------------=
------
> commit dc6e0818bc9a0336d9accf3ea35d146d72aa7a18
> Author: Chengming Zhou <zhouchengming@bytedance.com>
> Date:   Sun Feb 20 13:14:25 2022 +0800
>=20
>     sched/cpuacct: Optimize away RCU read lock
>    =20
>     Since cpuacct_charge() is called from the scheduler update_curr(),
>     we must already have rq lock held, then the RCU read lock can
>     be optimized away.
>    =20
>     And do the same thing in it's wrapper cgroup_account_cputime(),
>     but we can't use lockdep_assert_rq_held() there, which defined
>     in kernel/sched/sched.h.
>    =20
>     Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Link: https://lore.kernel.org/r/20220220051426.5274-2-zhouchengming@b=
ytedance.com
>=20
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 75c151413fda..9a109c6ac0e0 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -791,11 +791,9 @@ static inline void cgroup_account_cputime(struct tas=
k_struct *task,
> =20
>  	cpuacct_charge(task, delta_exec);
> =20
> -	rcu_read_lock();
>  	cgrp =3D task_dfl_cgroup(task);
>  	if (cgroup_parent(cgrp))
>  		__cgroup_account_cputime(cgrp, delta_exec);
> -	rcu_read_unlock();
>  }
> =20
>  static inline void cgroup_account_cputime_field(struct task_struct *task,
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index 307800586ac8..f79f88456d72 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -337,12 +337,10 @@ void cpuacct_charge(struct task_struct *tsk, u64 cp=
utime)
>  	unsigned int cpu =3D task_cpu(tsk);
>  	struct cpuacct *ca;
> =20
> -	rcu_read_lock();
> +	lockdep_assert_rq_held(cpu_rq(cpu));
> =20
>  	for (ca =3D task_ca(tsk); ca; ca =3D parent_ca(ca))
>  		*per_cpu_ptr(ca->cpuusage, cpu) +=3D cputime;
> -
> -	rcu_read_unlock();
>  }
> =20
>  /*
> -------------------------------------------------------------------------=
------
>=20
>=20
> Git bisection log:
>=20
> -------------------------------------------------------------------------=
------
> git bisect start
> # good: [ea4424be16887a37735d6550cfd0611528dbe5d9] Merge tag 'mtd/fixes-f=
or-5.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> git bisect good ea4424be16887a37735d6550cfd0611528dbe5d9
> # bad: [cb153b68ff91cbc434f3de70ac549e110543e1bb] Add linux-next specific=
 files for 20220308
> git bisect bad cb153b68ff91cbc434f3de70ac549e110543e1bb
> # good: [1ce7aac49a7b73abbd691c6e6a1577a449d90bad] Merge branch 'master' =
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect good 1ce7aac49a7b73abbd691c6e6a1577a449d90bad
> # bad: [08688e100b1b07ce178c1d3c6b9983e00cd85413] Merge branch 'for-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> git bisect bad 08688e100b1b07ce178c1d3c6b9983e00cd85413
> # good: [3255b3a262be263864fcc5d5a239aebd1d0b2bb4] Merge branch 'drm-next=
' of https://gitlab.freedesktop.org/agd5f/linux
> git bisect good 3255b3a262be263864fcc5d5a239aebd1d0b2bb4
> # good: [983377cbb2ba7038a34b68f43788e78b34cb01d6] Merge branch 'pcmcia-n=
ext' of git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git
> git bisect good 983377cbb2ba7038a34b68f43788e78b34cb01d6
> # good: [71e306ad46cd73f05b9ba151161b4a3c1bd25e5d] Merge branch 'for-next=
' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> git bisect good 71e306ad46cd73f05b9ba151161b4a3c1bd25e5d
> # bad: [a66320f041601309f1885bcb52e27e0c2f72079b] Merge branch into tip/m=
aster: 'core/core'
> git bisect bad a66320f041601309f1885bcb52e27e0c2f72079b
> # good: [9eb0c9821cf7efd5d18e2707caa01691c6d4fbf6] Merge branch into tip/=
master: 'x86/build'
> git bisect good 9eb0c9821cf7efd5d18e2707caa01691c6d4fbf6
> # bad: [49bef33e4b87b743495627a529029156c6e09530] sched/rt: Plug rt_mutex=
_setprio() vs push_rt_task() race
> git bisect bad 49bef33e4b87b743495627a529029156c6e09530
> # good: [2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a] sched/fair: Improve co=
nsistency of allowed NUMA balance calculations
> git bisect good 2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a
> # good: [65e53f869e9f92a23593c66214b88e54fb190a13] sched/isolation: Fix h=
ousekeeping_mask memory leak
> git bisect good 65e53f869e9f92a23593c66214b88e54fb190a13
> # good: [99cf983cc8bca4adb461b519664c939a565cfd4d] sched/preempt: Add PRE=
EMPT_DYNAMIC using static keys
> git bisect good 99cf983cc8bca4adb461b519664c939a565cfd4d
> # good: [6255b48aebfd4dff375e97fc8b075a235848db0b] Merge tag 'v5.17-rc5' =
into sched/core, to resolve conflicts
> git bisect good 6255b48aebfd4dff375e97fc8b075a235848db0b
> # bad: [dc6e0818bc9a0336d9accf3ea35d146d72aa7a18] sched/cpuacct: Optimize=
 away RCU read lock
> git bisect bad dc6e0818bc9a0336d9accf3ea35d146d72aa7a18
> # good: [248cc9993d1cc12b8e9ed716cc3fc09f6c3517dd] sched/cpuacct: Fix cha=
rge percpu cpuusage
> git bisect good 248cc9993d1cc12b8e9ed716cc3fc09f6c3517dd
> # first bad commit: [dc6e0818bc9a0336d9accf3ea35d146d72aa7a18] sched/cpua=
cct: Optimize away RCU read lock
> -------------------------------------------------------------------------=
------

--Pb8q8t+3bAhTPP2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIo2YkACgkQJNaLcl1U
h9DvVQf/Vd1ufYF6iDMnUzsSoGBYJTSWVQWezb+liEqn0Q23AD3sAU452jaEEFJL
zAcLSN1Mx3F6gMauhXBC6VnZs/Ic6l+cJZR1KTlhl7n3CPWuMuy1RLapG9Stn546
uOY9brDDmrRVfzqMazaGUo9/AnKT9faOD+/0H6A9x5jNwyyLZBNH7jfIo/+x/s9e
YSgAtKNxKkZcO2CWsolTBwuVzF1v3eetoNZAjQFaO/Fla6+zy2luNHZBIMdGUm30
EJudiICG6lJbQAiEo3TuMmJrbs/fQgEMvNrqcu9UN9ormS6mnYYEbrMjfTyrY6Kz
Ox3qutt/+9HiBeXHqluDmO66EcXvIA==
=8Wg5
-----END PGP SIGNATURE-----

--Pb8q8t+3bAhTPP2n--
