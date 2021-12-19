Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE1479F07
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 05:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhLSDyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 22:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhLSDyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 22:54:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C56C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 19:54:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JGpk33SVZz4xdH;
        Sun, 19 Dec 2021 14:54:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1639886044;
        bh=pAkMD3y3xdyYad2d6OyF9TkGhGy0BlhiCG/o/UdESVY=;
        h=From:To:Cc:Subject:Date:From;
        b=ksR4Er10zc6tmvX+PoM3BeHAKGWC/Uji4/OcemntI3c276SZTvCDrAunLVpV/qUfl
         fakO+jjt6bmrHZkFjX47PyDYAdUXnsCtnqFF0BZhGJuZp+EpWXsprd9HxMrJ+YHpjO
         DoaCrpD3m/lPjl6v7TSmodIXAs6nR6iXK2+YVkqiBBV4edef1MVRfpFXImxgJwrsJM
         3KErdytiC1U6T8+TzNJNelBvKfaTjjZ8LK8i3+HjgU73RFw5XnKfpfrxJpresvKdfq
         mkBqv53RuLl1xceCxH8TS89G7DWXNUBrMn3saAnCPu+PwFrgnh/4TQyvddP6A2awFS
         1rKHrkQ9YAE8w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nixiaoming@huawei.com, ruscur@russell.cc
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.16-4 tag
Date:   Sun, 19 Dec 2021 14:53:59 +1100
Message-ID: <87lf0hl06g.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.16:

The following changes since commit 5bb60ea611db1e04814426ed4bd1c95d1487678e:

  powerpc/32: Fix hardlockup on vmap stack overflow (2021-11-24 21:00:51 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-4

for you to fetch changes up to 8734b41b3efe0fc6082c1937b0e88556c396dc96:

  powerpc/module_64: Fix livepatching for RO modules (2021-12-14 23:13:03 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.16 #4

Fix a recently introduced oops at boot on 85xx in some configurations.

Fix crashes when loading some livepatch modules with STRICT_MODULE_RWX.

Thanks to: Joe Lawrence, Russell Currey, Xiaoming Ni.

- ------------------------------------------------------------------
Russell Currey (1):
      powerpc/module_64: Fix livepatching for RO modules

Xiaoming Ni (1):
      powerpc/85xx: Fix oops when CONFIG_FSL_PMC=n


 arch/powerpc/kernel/module_64.c   | 42 ++++++++++++++++----
 arch/powerpc/platforms/85xx/smp.c |  4 +-
 2 files changed, 36 insertions(+), 10 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmG+rMQACgkQUevqPMjh
pYBLNQ/8DdqJFMgeVNV+RBinTdrtXl4RmMGvNE0ogmZ215GPiwjbjt2WYlMEg0Ol
4WrWSZwThKJdDXvR05HTU9QncNEXi1KIISfppNkNJQkRzRzs7HjDgFMjinNBsLzg
q3Q8LeGhj2eL3VNbavAr5UBsXgxJriGjrQQQj6NR2jyLZnITd+Wdn4/SWUgxdlmn
+aSKvoOWAUM3/+SrrhDmCsCKhM24bwoQ339uOp81j63oP6UVtr4dFVvDcVZyL+ea
tYSIQ5UeO8/zoaEMudZwFRifXmPk6+KiYzlzY+bx/6b5xXTv+B1oAT0RX+nvdv2g
aQIRI0EKsEf2OLD8ttlGKkF8NyXQBJjsDZ6VBklXTcSlIxMtSAJxz80USHk2FyHx
ojgi51Axdp031gA7bhq6jDvSO1izYR4S7si3Hqfzm4IxYMr5UnQSA5IJfsfMlASt
3qZBFpkN3rwFOERMa9IiLarnLzMiionvw7Vf2nESx+Uv/0sYS38528Z2xjBgagdd
OUA5h8XsC3NLUpbZtQy9R0+7jkDYXbe0r5BoPjmonkS90bR3/LhsO8eCWANqsaWO
2Jtu6V33PgAKZbR02V2o76t0WSzf3z72kOq7vsvcmc4tD6Lv4ph3d2ynjQ9oHizu
7FQqoFdHAA/Cbq/AiZqIVwE1pUpJIKesjr/JcNkagUsExLTnXQk=
=Xy0P
-----END PGP SIGNATURE-----
