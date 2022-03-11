Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD72A4D5B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346739AbiCKGEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347397AbiCKGEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:04:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307CD120184
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:03:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFFjH53D7z4xMW;
        Fri, 11 Mar 2022 17:03:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1646978595;
        bh=l8rfE/4he409H4tnIdMHNxvTLyIXMhcrObPfkOpkI5A=;
        h=From:To:Cc:Subject:Date:From;
        b=TlXNk45ZElB+oSHUVOD+1i3ACy5nIrj73xl4zWQlm2mcBAu5Pai+jgXRATSLnfQH+
         MRKFwsm6GT4rXJX+sAcQS0gYHOAbPoBgmL41u9SFyHJx1YeBFM6Q/D1GgGMU4KqZaD
         JvlHifjm8CqtjzHnZA65ivoHsRCT8Ajw6MQv6Ip2N9io5X/ENpm+zXrIfQlu6g8naa
         3w8OUaQiub766YK7FYi2slEMhk/of9n6lKupbNDv+N5rDmBxyHLfPRrqUWk12ZhV6V
         NGWhaGRmyGzdZmizvytrvtqcMFpkEByALffVKVQ/2QKJzxljdPDtclUJfp0S9a/zjS
         Xx6+oXlHtrAEg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-6 tag
Date:   Fri, 11 Mar 2022 17:03:15 +1100
Message-ID: <874k45m3fg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull one more powerpc fix for 5.17:

The following changes since commit 58dbe9b373df2828d873b1c0e5afc77485b2f376:

  powerpc/64s: Fix build failure when CONFIG_PPC_64S_HASH_MMU is not set (2022-03-05 20:42:21 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-6

for you to fetch changes up to 48015b632f770c401f3816f144499a39f2884677:

  powerpc: Fix STACKTRACE=n build (2022-03-07 10:26:20 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.17 #6

Fix STACKTRACE=n build, in particular for skiroot_defconfig.

- ------------------------------------------------------------------
Michael Ellerman (1):
      powerpc: Fix STACKTRACE=n build


 arch/powerpc/include/asm/nmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmIq5cAACgkQUevqPMjh
pYAJhw//WqcG+Qv+W5YD9KMiH78CTDm9bsLejRJOy3x/Rbn5Fs2/KKdcYPcpe5gE
nJ87W2w2li2YpEBe3ClbAXFQCNswH8cnj3++HLaGFp4bmM3F96JCEuh1GghlvQ4v
e6EUD0qYEmlFRAvey7bfu5MsNLGadpXob4f+xMoffRHr9rhzsShV4b7pAblUggIi
/ajO+GEvIk7kSB7DCGEq8swfoT0mWb0bD2wAhNoz4nbOENaGp7O26Va6vt/l+qHn
aXFESbaYKKBxYTicuLywQWKqL5j/XaHDz19KkKOljYElsLTZ78i4y1mvIHLRJtHA
NxSAPXBZgOyw7/mQJEYP+ABr0ki+QIpykTLeDxL+XSOtOVYEJW8eQiBHbzxrqSCs
7UEyunNG9Y2WfLPpE+lo4QEEeOp+QiJsla3iJjQAMJjI2M8x6QtWkDJlZ+LSfUa0
mNPnHDt8mlAj1R7zpXLNt0gokgPub4lSBb1V2tEu816gEUVJVgqq63GGynB+ET9K
O/3UlU7jFaQzASw4TUgq1HBE8Zs3NC09GbkUzDoo2cqeZDOPDbb0ieJcy+VzDNiq
bAcRwjXB7LKir59G38Mdo2lMALJUXr+jtz10a+zTnA48KAVbf5ZgEwXHejR0Y/nv
af8B1MyWLjeUWAY2CDSSoOres2qE1phjBVZ4eBSk9VLqd+KtXf8=
=KPHf
-----END PGP SIGNATURE-----
