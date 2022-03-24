Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829AE4E6901
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352818AbiCXTFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346892AbiCXTF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:05:29 -0400
Received: from sonic315-55.consmr.mail.gq1.yahoo.com (sonic315-55.consmr.mail.gq1.yahoo.com [98.137.65.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261F0344CD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1648148636; bh=UNNMV8/CFSa205arhP+OW27CLzMCkhU8HDwxmydKjxg=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=fGUS6SIePFYcpVzee0eEzmCQYX9ACOsVVxM/Syx2EN5ezLAcxahhVUrDt04NVfB46Vq5SgXUmCedck8icb4XRI9on4qWiJGCMWIpX/5EJqODBucEV+mYu+oUBvCrqTjZAnoNqDjD+xVq6LrOCGlCIoWEebpcuRP0Zp1UIfyQ+AW6ZxATaVjF11Lv5Z4DT1sQIWTaczj1uWthRL0TewYLtLkbD132lrpYk7hGOaBH4nCQszxHkgqosyOoPtDGnh5zmySkXZrITUJbeESe72gsgLsZiY5npK5FF4HX3xf976wECtSa+h2dKVOFpBt5zDbfFX6MK0CPQZSTHnDI3tLfiQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648148636; bh=LztHCICx+CyyMKi/YOfmF66g4ljK9RySnwMZ1AdE964=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=Q2Nz4GkpiTTcblpjWoC+Pp4hFkseBQjaIp6bULCXu7neZ5yzjoFZXwSZvs4O3w0CXeg3S2Zm3VKFxUCvvvzQc4Rg5RDLdhudqP3mxg90zmoSXlDl5nmxT9OL1TurHg6Y+beQPHa1jgWcoiaXA8D+FKa0lbk+oaQUI+dCOtTxmVbeZ/XKdrjN5my8b/4yMi+VmwUG24tG/xTmx18pVz7vQU6COBxuoKAQ/A3am76OqHToO2GK6EI8E1FZepFdA32eV6DQ7tzIF4cjXsWjnj0qXsk4NaTLOtkAB97/9DNSDr0Y1plg77ejWS9wP0EDLbuwqsOhfXhIFKsjgXnTW7y2cQ==
X-YMail-OSG: KJ3afmwVM1ndxaRE7RsdKv.0.WD7OfGMIlbAuSC3M3Eu31.iJQZ0_rZ7n7EGQnG
 KmRDlSRTE_QbVHIU3x6qXat6qyLxH0plrHJVOCALKuD0kHfY_4PnHzupApX7uUNjJjSyHpwK.DnD
 tWzVRRIr0Ws9.UUXS1HAxqVzyKhzYhDFARjpx2XhIryYYkUqB3WtznnXyiEBxSj24n_SJyvq8wV1
 _sFbIwcKNTYBNSnBnYsvp3fMYHC50FouiWaoSHKMZYu_h_rNYrvBQM_riGFHagPu.6H2F8gViy6v
 XGM9g3w3J7iS20D6xNf83oxpvjI0iRBgWEsK0KxQjwXEPVMxb6MYP9lWQ0CAJ817C_24ZP00Z9WG
 qw1ighp1y.yenPCoKTWq1RVshpeYak0b9zSwbGJeE_jMPJWn1INqNqMPcHVWl0yxZzaYUPJ7FZHr
 UydVVa43atnybWpgfWTNssL1j3FvykNCtIORgxvMnGU0jfZSUznE6V3RyW.9BJYnDM0G4lmHj0K5
 gMBgSysq0jAgqVVqUPVt8J_Vs8XvzECeY1STS8aRXzHicXL7qGBJ1HozB9ebWOgwMYVWJn177MeE
 T.DXmtuY_mWaYWQUcm2Zhx5m1ScHrHflpqiXImZpHHIUNH4DP7be37RVDcDj8p2_fX3YzunKx4ld
 f3iu8iO34WJleAw1As1RiIlMwzgFA425Kt0Sgv20LtnaLmAgQMo9ABhV3rSnOyPdUHo0YLU.yYdj
 reR_b_q2EpfdDnjPyd4CH7sx81ROkjo5ft1ILk50M3yeDRZScdd7GS.v3KSD4N6qSpH8X0sD2U7P
 iUirzy1VWLC8WZE8qc9N5CJk85LG5HDOHxtEvWQQxb3zIIemzOyMhHM6RlYTGqoTpXvwqfNqAzeV
 BW1cARmgmVgF6oU31JOXbjXcvkLjF1HE_RM9qo19tLmGAHy7h2ZHkQ3IeteHFKCMmnKcVL2fyeEn
 9gnZrC1RwdH.7jUpJGC9umaL_VuatkGYxSDHDF6Eb4MWpdLX71Lw6K62Ok_KSUs5UzeRRuCb8uI5
 rgoLCLZ.J_R9B16xAKp7HQV_SfCqs4nqacsIjRXN.KCDhJbo5rfWEjmmfAXyVYRAxNZ1FIhac2nY
 AOdprl71gN0LimICHdaXjqOMqQJjYH2PWJ0d3fQstoIcA.wMxxVV1AFrpCm2QyYpz8x8K6U10Ma0
 CHu37mOOG3FMnx3AsxjSooV1HHeWTEzE8juMkwgBsUpARyW5wvtHic3gDPaFZNhmwnt8FY_MtVZG
 aY9Who5eVXVC6kIEbKIBoOae3KLozyWK6uc521JfsHwOUk8PfvglQJkz7OI0BPqFjAv8NO5CLmG9
 1ttHM9vcShVnzndoH.6xhBqmtVwvsrhrWXZPaqn.sPmpfpIOSzUYD3B2bTR_Y2GJ5t.DURNM7fOO
 EB.Lp8nW0DCRArLlFJeWNa2Ri8EEFtWv_5th1P9aP5ROxU646svesrcHeXw4uxpb4UJoRATfrzeS
 GqhyvlUCJYmUXPnW9fFSCCD5wBokPP1E3icFUhzh0YR1jGY2CDGZWxQNX6T1bslJdXA9YaD12v5M
 szMUTnajqFtu7lS5J2bOySXOR8ZTxhZ5AmRCewsjj6WXxam5g_fMwsaY5c5z3KXpBqK1CLxUe0Fe
 3dLUumhXZKZ1DBnScOsVyttRz0.uFYGWoGzxARCAtJ6u_qNhAhhnvRvGp2Z_aNDL_sGdmi1d.hLq
 4VyL8q7NK33088Qm0gDuScRzS.5cF_EWDpgnL9OfxtCplsqkO78wbCgc.ZxrrkTCr3myT9bNseHN
 qwDUmy_aVDTn16tWFc5COZpWXvEO_1ObBY6KPnnuc5yi3fFbbGJC9csJbAIrCh2J4td9_hrKbZVT
 l3A2CKFkwF230CK98sVnW00jTY8tNH_qikgq5k56GCVhctM.BQwEzrkicSCrIyCesaU1JdPUAnGb
 vf4QxBQiB7aFKLtXM1ZiYtMIHm5CAO0IdZ6X.rOMlQfOFbpuxsJ3GmtxUmu9n9iMArzAkebTeUE7
 KRaEMAOGbMxcJdxNSX0z3YY_qGcgAzV5GNsuntgFoFrAtOklV21sCNS3glBZ.Tpj4qdb_sDCR9jq
 H1QO1J04_PzUfcSY1b1ms6bS1cMatX9FKOdYLYKQ4R7CPdPzE9G8oN5z4nYFWf5QX62JRfqhXth6
 sbriy.njyPBpDZswg09sqLUcAxlhlanGattVJS_gS2B9CgyvZ_iSxWfb9SGlXN8aJUVmaeB9i3Ha
 GunP8_dpCCH5xGEQHVSC6KUTMdpqa07ojwX4iRMalJIxho0ZcRxT40y39eF_gy_CgPTnrRb66FUo
 hI2plEplECQ--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 24 Mar 2022 19:03:56 +0000
Received: by hermes--canary-production-bf1-665cdb9985-6hz22 (VZM Hermes SMTP Server) with ESMTPA ID 183683c88045089ba67b9b130d79d949;
          Thu, 24 Mar 2022 19:03:54 +0000 (UTC)
Date:   Thu, 24 Mar 2022 15:03:50 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jann Horn <jannh@google.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>
References: <20220322191436.110963-1-Jason@zx2c4.com>
        <1648009787.fah6dos6ya.none@localhost>
        <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
        <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com>
        <1648138746.2zrnsqdlu7.none@localhost> <YjyoaEZLb+GzxJFT@zx2c4.com>
In-Reply-To: <YjyoaEZLb+GzxJFT@zx2c4.com>
MIME-Version: 1.0
Message-Id: <1648148400.ytc07g7pbi.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.19894 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Jason A. Donenfeld's message of March 24, 2022 1:20 pm:
> Hi Alex,
>=20
> On Thu, Mar 24, 2022 at 10:29 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> w=
rote:
>> The issue, in systemd developers' opinion, is that counting seed file
>> towards entropy initialization potentially causes repeated RNG output if
>> a system is cloned without resetting the seed file. This is discussed at
>> length in https://github.com/systemd/systemd/pull/4513. A few years ago,
>> I wrote most of a program to check machine ID, disk ID, DMI ID, and some
>> other things in order to avoid this issue. Since then, systemd decided
>> to store the random seed in EFI variables, I assume on the basis that
>> machine cloning typically does not clone the EFI variables? In my
>> opinion, since the same argument applies to machine ID, ssh keys, and
>> any other persistent cryptographic (or even non-cryptographic) material,
>> this falls outside the scope of random seeding and into a general
>> machine cloning "sysprep"-like utility.
>=20
> systemd's seed utility will credit a seed file if the seed file was
> generated properly (e.g. after the RNG was initialized). For that they
> use the user.random-seed-creditable xattr, which is a reasonable way of
> deciding. If that attribute is present, it's credited; if it's not, it's
> not. Here's their source:
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If we got this random seed data from getra=
ndom() the data is suitable for crediting
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* entropy later on. Let's keep that in =
mind by setting an extended attribute. on the file */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (getrandom_worked)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fsetxattr(see=
d_fd, "user.random-seed-creditable", "1", 1, 0) < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 log_full_errno(ERRNO_IS_NOT_SUPPORTED(errno) ? LOG_DEBUG : LOG_W=
ARNING, errno,
> =C2=A0  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Failed to ma=
rk seed file as creditable, ignoring: %m");
>=20
> Since my seedrng.c is designed for more minimal systems (running
> buildroot or openrc or whatever), which might not have xattrs available,
> it distinguishes just based on the filename:
>=20
> 	if (new_seed_creditable && rename(NON_CREDITABLE_SEED, CREDITABLE_SEED) =
< 0) {
> 		fprintf(stderr, "ERROR: Unable to make new seed creditable: %s\n", stre=
rror(errno));
> 		program_ret |=3D 1 << 6;
> 	}
>=20
> It's no surprise that these are very similar; I've read systemd's
> seeding logic and contributed a fix to it.
>=20
> By the way, if you think something is different or wrong or whatever in
> seedrng.c, please feel free to send me a patch for it. It already
> received its first contribution this morning (from the buildroot
> maintainer). Hopefully the code will reach a good settling point soon,
> and then various projects that want it can just copy and paste it
> verbatim into their environment, and tweak idiomatic things as needed.
>=20
> Jason
>=20

Right, but I'm saying that even if the seed file is good when you wrote=20
it, it becomes bad if you copy it to multiple machines (e.g. by VM=20
cloning). For various reasons, I think this is outside the scope of the=20
random seed services to handle, but I think it's good to keep in mind.

Cheers,
Alex.
