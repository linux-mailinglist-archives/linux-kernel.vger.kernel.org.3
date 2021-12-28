Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA0B4808C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 12:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhL1LX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 06:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhL1LX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 06:23:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79499C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 03:23:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JNXGy0DNdz4xsZ;
        Tue, 28 Dec 2021 22:23:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1640690634;
        bh=gfpieEPB6YXvTB0I/puABEiM/5ZSyJPFtebl/hR8tI4=;
        h=From:To:Cc:Subject:Date:From;
        b=YiiDsVSlzexsbtgl4hfOH7J/bJMeLMpKgzWFdTHvYoKVOivjr1Svvg86IyWJiBsyI
         8pvxgqkC0zVjQ7QEUjhi+IkGND9UDMJSXQa6E+eG6NIx3wCvt9L3CJEe+jHt9FL6dV
         FiwzMDjA2n5he8BwWXQdsQxsxxJx4JvLuj27UdYfBZXMtznMdqhSQ2KTteuMZfcgBP
         fr09ulpjaqEFJ6Zg2tfVctryInyhQ89r01CNetzRMVSxI1w7sWxu0KTy8+TOA0p8v1
         59IOGx8UwNaTuy2EEseaBVuTvgnoxTDsjNos+3sc0e8IlTubMMW4vSBCm+aF3JBpLp
         fj52v9EBJFBzg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.16-5 tag
Date:   Tue, 28 Dec 2021 22:23:50 +1100
Message-ID: <87v8z90y7t.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull one more powerpc fix for 5.16:

The following changes since commit 8734b41b3efe0fc6082c1937b0e88556c396dc96:

  powerpc/module_64: Fix livepatching for RO modules (2021-12-14 23:13:03 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-5

for you to fetch changes up to 8d84fca4375e3c35dadc16b8c7eee6821b2a575c:

  powerpc/ptdump: Fix DEBUG_WX since generic ptdump conversion (2021-12-21 13:05:59 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.16 #5

Fix DEBUG_WX never reporting any WX mappings, due to use of an incorrect config symbol
since we converted to using generic ptdump.

- ------------------------------------------------------------------
Michael Ellerman (1):
      powerpc/ptdump: Fix DEBUG_WX since generic ptdump conversion


 arch/powerpc/mm/ptdump/ptdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmHK8v8ACgkQUevqPMjh
pYDyKhAAn5YbfZvtti5ST+Xw5Y6+eIQjs96IQ9QS9AU6PgCmQp46ryt6V3CogSb5
bXlTsPRJTre8zu9oc0D643Z+ttAwd0eI02Vov+yohnPH0hphuStr9kznKEgJO07y
oJlQ2BfvE1F4fkfY8sBxod2+M+/g5IczmG+TTd9/r8I/qcLowq74/eYqoo/fg5ma
TbylbPEQBxwBR3mf6PFkKGsjJSQdLhE4gFn9i3NGnofpVjSzv5k9/WnJ05ipYWEd
68iQCLHTWYMx+bktlr2M5m9gpToeWOsQ8cgDs6PxiFHuPPD/3ZnFX9JXSf5k+qDk
EkEq9tg7SsmPaN1gsUcJ8SNxNUuTJRqo+RLrPVjYSu4FmMLM0MXtvYXiTJWg3W0S
b6C3KbJP+yzhYUFc3eN/HOwH+G6mK5AFh7iDRxeki180ZUZgTmMxPyRHH8M1TLEo
YpQJUQyGlWXNSCMA1A77KcEEHxfq6S4UaPm3stBWLrFiM2STBdC5HFXadfcizKYz
qgjhKH0tOVxFcOVqmhTh8S5eAsfl+2a1ZU/7A9PB+IUqcBC2tpaLR2TwvTYIR5mQ
e96SW32NUakuH48YVhEnD+1DHvRzZ8IwSQgF5RxlqFk88Q6RmiK1HVv0cO4ki/Ub
Q1WZVYqBePz5kqxzqeKQfd8bznWOC97yXmF9UAILByQbFADczR8=
=GTbN
-----END PGP SIGNATURE-----
