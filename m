Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF352B434
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiERH7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiERH6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:58:17 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E81207CE
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652860694;
        bh=hoX39PemcSFYcIE/U6fMYNXcF/lSXAXQ7ENdEkgZSZ0=;
        h=X-UI-Sender-Class:Date:From:Subject:To;
        b=Bw5ELnsckKQ1mt88xZZ1DxTfrCExNpUYHshrxt6g9g06V/nbAzOJECFfWCb1N1JAS
         70TAkLLSofmBi3YHrx6pRu6UrECR0YpL88hbyBeZd3EJCoYZbSnOYpUpbbuFk9C99X
         kHARDQiw5GnGUOHSm9n/ARgzC5nGm+bwZjWT9r4I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.15.110.18] ([143.244.38.17]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDnC-1o1eRP2VNm-00CeJ9 for
 <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:58:13 +0200
Message-ID: <877bc1ca-e72b-1a48-25de-61250df601ad@gmx.com>
Date:   Wed, 18 May 2022 07:58:12 +0000
MIME-Version: 1.0
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Cannot build Linux 5.17 on Fedora 36
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JnbqlO50qYhUdp2d6lc7+ou6782U+x5qYqfJc4f4pAiK/kXtSRD
 0bO0CKZxlVZQvYIf0MUfzupd8rj19wIVRPTGz/win443EERaAbdqXovtOsa0Pd0wvd3oia0
 I+CmcUqeKUL9ndRS0X4JZrEk7VHKulfDMC2sEB8FKxfY38ezDuImNXrQGZZs5ZA5zMDwuyC
 tUa2YwOT6JlzBcDH7yEKw==
X-UI-Out-Filterresults: junk:10;V03:K0:yaOUZKOtfyY=:5UmBM6rZY4CVDLpf94WlJ7aU
 Etk+sFASPLBunuwSUH6zgVoA79OCe+zHeIgdmPONG/Tgv6qVlXypYDZQpBXdUsvodXNVJMGZS
 +kxsHJqWZRB19NErroB92R4OuoZWgRJapJRYzZzOAKqfAk8OL7U4Q1UxHL2/BaDdzqz31kJ1L
 DHRY3FcZ+NV+SaklajplDOMO0x6n5HWpReb+WbFTFe6OrdqzqYQV98z3XZ0pCJjp6q4dpiFkO
 i3mnRVrwQUQt3bJxL2UPMhB5b6Bs/1aTkZhDvrU+5b2AnUTsqShv0obbN1LD7PGbkrf+Yezis
 70XX8h4YLI8sEvFhnK5uvN+Z3CAFRD9NqnGp3SEWo946HvgnXPRnEDfekFBKzDbeO6ZuoeQYQ
 0ehkDjq94ao3BTnigc6WXN+UmRoiCSMbMG9sqSAuFSxbvuCW1KlYGGm18JPw4yLiMblynNbwt
 2dRBEKTzDIm/DJvD5DXDyifvG2msviZegxiZIKMbGQ9rV96+yXQNzWIz1JBYLb07BttuaxuUK
 laGOQl3WLw6gNOTqXk6GZKQnBb6TS6ygPnfFZJNu1JOEf63SlIRgI0mZNhFw3QBtoK375D+vP
 ygWQdYXKNQf71HQlb9rlDvWqVeIRFanIR4q6u5OBu6i+VmBhg6SS0S2FnPOCoELUrBm0at483
 osM52WRaddsA5C5c6HAkZQrlDsJD/Wi2LxJGl47vx7hJbvIhGpvi7ax2nuLpTe3IKTBSGhsyv
 YftBjlbtiXYek2uN7vmz1WsLg7KsKpy5/5ZB6cS98aQDs18VehH0AO5I7CiIyYYkoysZjX9Mi
 wAmb+RdH/dTd7zSM+leMucdgpOc/f0OckdQgqPd5eokDpb4KGILnvbYdgzLlJfQ9wOGtLNEm0
 6rJWhVl4pdtrVO9b9WI8Dm78itLlJxW4o8bVYuR8EYqLL8fsl0e9f20q0X+BKuZunfxOmvpNx
 Qj4rds6Zegz3wS8ZmneT4UPA8T4Qc6jX+o1T2Be69NtFzCRYGS5f8aRSlIALgXKJfrX4y0O8E
 kAaj0VzxRAx/RgpdjHyavF3rEVGi+IFzUFxbWgkLSRD0GYvCrjS/w4v9p0UXeXqRPmvn+ToQ6
 VcsRAw3M+l+LmXqC0N2D6scUUOHar8cf12pB3qSAPrrHNYHVrsTBPZeoMUDziJLiGdekAQUFP
 Or8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I cannot build vanilla Linux 5.17:

# make defconfig
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/kconfig/conf.o
   HOSTCC  scripts/kconfig/confdata.o
   HOSTCC  scripts/kconfig/expr.o
   LEX     scripts/kconfig/lexer.lex.c
   YACC    scripts/kconfig/parser.tab.[ch]
   HOSTCC  scripts/kconfig/lexer.lex.o
   HOSTCC  scripts/kconfig/menu.o
   HOSTCC  scripts/kconfig/parser.tab.o
   HOSTCC  scripts/kconfig/preprocess.o
   HOSTCC  scripts/kconfig/symbol.o
   HOSTCC  scripts/kconfig/util.o
   HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'x86_64_defconfig'
gold linker is not supported as it is not capable of linking the kernel
proper.
scripts/Kconfig.include:56: Sorry, this linker is not supported.
make[1]: *** [scripts/kconfig/Makefile:87: defconfig] Error 1
make: *** [Makefile:619: defconfig] Error 2

No idea what's going on. I've recently updated gcc and binutils packages.

# dnf update
Dependencies resolved.
Nothing to do.
Complete!

binutils-2.37-27.fc36.x86_64
gcc-12.1.1-1.fc36.x86_64

ls -la /etc/alternatives/ld
lrwxrwxrwx. 1 root root 15 Oct  7  2020 /etc/alternatives/ld ->
/usr/bin/ld.bfd

So, the symbolic link hasn't been changed in more than a year.

No idea what's going on. What am I missing?

Best regards,
Artem
