Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975DD55B27B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiFZOlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 10:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFZOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 10:41:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C96EBC10;
        Sun, 26 Jun 2022 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656254465;
        bh=O+20x6Ln82NyZwC0tlbjDZszW4v87ztjQKwidZpougI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=dLE1hs0f5G7x2mMeT6R4/jOV8mvvRmVxYwdmn733EglW84w1+aZdA8BO82/6IAQrr
         8IXnkSDQCZh0Z6ybHF0NTc464Ae7QOhlK2l4edMRbraKlTEAXtTG+uGvVdzT/jwWLm
         wWaVfPW0RgR507lAWcSQxo4ZnMGMIA5ZJtlPuPUQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.135.166]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPog5-1oJPpi231P-00MscU; Sun, 26
 Jun 2022 16:41:05 +0200
Date:   Sun, 26 Jun 2022 16:41:01 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for v5.19-rc4
Message-ID: <Yrhv/Z0vCzSX/kK3@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:15CGdLZHdPI1zWwYycjOAiqPey0NrhsmDHYX62NP8FKXaT0GUMk
 G2gzTlOJjeZGDmTss3Hi0erXQSJGB6UpGDtgY4/ll9bIPdDTl9YM6P8QkE5PHs9w+D+iwSL
 0GAB3+yQ8fGKLQlmLR/VjFSsKikQpqJgohkC1FCTgV1RS9SJE7JdyS7ayjCuKXAffga3lDA
 KsFCV9MlC7efXqF7ITpaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1bE+uueP5Yw=:OROI8y8p8QuFeMl6gIBsl9
 SeVcBGXup3USaD+AihXBvc8PhXAI64yE8rzd9M4zSSnmNgBJuGSwxZLefOtxECZni6wPs/SkW
 rSaQZU53NPM3IR7ihNKPZtpoeUKjGAv+tPJfoYFWK/g8cIxJnLSvhRUO/Slm/04jMoYKBd/ur
 BuXiYMajDwMPrmdo5GweLw5yZSoBvwltfmlKbUTnXIhauyBPbqQ8nymL87Hbff0ZGfC9o6T5g
 rYzmd7806KvArvr4EXP/Lk9i2i3beObZgPvVqv+yVD4eA/fiPBX0k/Abnh+Kd/FGn44999JJO
 Yqyvv11W6bdiVwlvWAOUUXX79O+IvCR3rK4Tm2b36IeHKWpECMzqCsQryz6Z9asDaL+oonllg
 PSurL8x66iaIR5csa06dsDjlnBtaxbrWYo9H4ifu6WpmOYQy+qpd+uKskuPNhcpfHgM1Ram+S
 gFJTYRxJht5VeJEe+0zKCW+2s1RbNClGBIwC8Jebfbei/wqnkt9F3Mg23Nfeg+ZrsEvMCT7Ev
 RUA0z+YVJe9PdNlZbfosm7lw5XzrY0h1r6duucbeKb2YKlLe9l1d407qKIgowj3fAJfKXbQVx
 aVOjz3AD/wA8gXp6zuCZqkC7RL7jvIMLkF8F9GDSdMWXuqXrHpniiTv9gilpkrqEiwPA/LAK7
 qSzFLviQQ1uEBH2nRd/jp8PJtKcHAC+hDir5ULjFnwxLL4mervSWP4P2A7nUK4ywLkc+yv7vR
 rZjFVw2nrbEygiQoM3Js6tRWtR4m/tuPaO7oG169TIP7dvzi+BSRO3FuALGGWO4Yypf29etl8
 qSWRbQAJrOsPMlREAHbJVHcr1Cw2ISO6zQLj8EKhuPxdfinrWtfVw2HHJIPc/PgPKyT/sMNWh
 fm8DY5PJnoP+DnXedU8Sa8Wl1ofu7i3PB8GxpY38eV0CXfXvZ4eAI0Yl9++GZCpbT4AWPyRph
 KIqTgwKmMeEyjLN8Q2PzhQ6bx4rrbCoHVpGUdeC2CpzhXlvadDIdSKGdo+yNkU16od8Vat0wY
 orMnS9pAGlfJw1fEMa3NxaAKmo/40L3z/JwCQ1I5Ac6gpkEarWxXltvnTlBbilb/HYf3I8j7d
 rvi6VjXQBfJzMzj/jmLA2uBLFBC2ALnk2ktTykeJE7zRI5KzVNCc+bfeA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three important parisc architecture fixes for kernel v5.19-rc4:

- enable ARCH_HAS_STRICT_MODULE_RWX to prevent a boot crash on c8000 machines

- flush all mappings of a shared anonymous page on PA8800/8900 machines via
  flushing the whole data cache.  This may slow down such machines but
  makes sure that the cache is consistent

- Fix duplicate definition build error regarding fb_is_primary_device()

All of them are tagged for backporting.

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-3

for you to fetch changes up to 0a1355db36718178becd2bfe728a023933d73123:

  parisc: Enable ARCH_HAS_STRICT_MODULE_RWX (2022-06-26 12:23:15 +0200)

----------------------------------------------------------------
parisc architecture fixes & updates for kernel v5.19-rc4:

Three important fixes:
- enable ARCH_HAS_STRICT_MODULE_RWX to prevent a boot crash on c8000 machines

- flush all mappings of a shared anonymous page on PA8800/8900 machines via
  flushing the whole data cache.  This may slow down such machines but
  makes sure that the cache is consistent

- Fix duplicate definition build error regarding fb_is_primary_device()

----------------------------------------------------------------
Helge Deller (2):
      parisc/stifb: Fix fb_is_primary_device() only available with CONFIG_FB_STI
      parisc: Enable ARCH_HAS_STRICT_MODULE_RWX

Jiang Jian (1):
      parisc: align '*' in comment in math-emu code

John David Anglin (1):
      parisc: Fix flush_anon_page on PA8800/PA8900

 arch/parisc/Kconfig               | 1 +
 arch/parisc/include/asm/fb.h      | 2 +-
 arch/parisc/kernel/cache.c        | 5 ++++-
 arch/parisc/math-emu/decode_exc.c | 2 +-
 drivers/video/console/sticore.c   | 2 ++
 5 files changed, 9 insertions(+), 3 deletions(-)
