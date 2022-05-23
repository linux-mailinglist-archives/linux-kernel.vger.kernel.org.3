Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7BA53172C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiEWTbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiEWTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:30:52 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4421C111B90
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653333143; bh=0r/nfafogot5XMVQwRUvUeOafN0fuSbPENhCVxJYeUg=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=lZ/nwJMH623xoqactQQ4jH0Rc3WDfKVioTsME2h71hmt92mL7Ix0kGN+QPpSVisJolf77dRvNSg6KkIXnQfeA4iPS1S1o2ZpM8F8G8cOWb0OUDqXBTNKcbH6LMELBZDVmjN0Mv1LdOn/v0VCLBrJg4fc2nPLNEayJ7YF3wY3mrlAvcLsC+6ELrBwaclAS99CrnK7SAZ520my1pJ1Z4uxKczCzwpGk7lLBxeKC6Y9Oen/Sow/gPPdSxdiAPr4WAz+ZbzwMecfN7pcMthKZCsEFZj/lIbUr6JMK7+M9G3T/FdhgpiEmvaQ+GD1UZouVkk5ZuZnC7mZPvgK7tdOSxmSPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653333143; bh=TwUZZzdKrq2Hn/qKQvQnkuNBG9vN/wUikcPVY31NZlQ=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=nNT/XcpW+MXSVM0UJ6kf3XPxdKvkyKcW5TOTUZk3uwuGP797u3fZXqHrc2X0A8uk/UB2qcM1cCOT0h9D+aXPlXq3Ya/WswGAev7YfVi6HakXP1tKx/RPTDhtQWbpfBFfy2JbRB2xyCaSSgAbIx/Wj3NpiNdQHSHrQ6twhCqmXLTE2jxHq7EC6O8d1nuYDkwR0NymoqrnHSqeo/Z4g6fDTrwctyZHAAsI1i8g1d3fHI2L4JhWyA21vZ4iRc26pzYoZZS2TB73cvNJwusXFy69FLXJJct1UTjFADypBE3AmWZtrUauXReS9h4ITyUsaP13FhM8ipVB8Xg1Llb/M8IN4Q==
X-YMail-OSG: 4l6kipQVM1mD1hc2_cW6VhyZZddctPgpn9SZypmcVb0zG4VDrPd7YLiN5_o1bkm
 uNKyEIC60o4wjk_WomgwMjMTX9ICI.fIV1E5aOe98KaR_eTyOZoCKrBk0km8V4CQUHjK.6hZ7UQP
 B5smLWJKwKWsMBWcwRwLoT0vr3KzwIusta62G4kfTqFgjEhJVIyFkBPY7CwqIExFlQw6BQsWq6Vm
 EEpGyUWPIULUF.JEi7xEhbAYAU6DLUbyxg98_svAralVPPs7hFij_idvPg3zlCs9L60cw4OPjhWm
 7gS8.Ny_.4Q.oM0ugxJE99Lf3dIPDi7eez2ArNebG7bGJlYwlCUh3z3EqSSiLpAy.pAGmJx.zjHr
 XrSbBZllzf4kvw0bTZXiw5vPkwElOl3_0mgPECw1kjbW7xYA6O7Rpvmp3E1P45nJwNt5M8Fx49CK
 mREbn_Q9809xmFNGxhSWzkIcsIOjZ6oiI7SVSVzHShh3HGmluM4hRrTkpF_obvcyFK6oCuA1Mq0P
 TWnL6JRfveFLu1APQV4_jsg5keFni.mDJS_uVmllWT.I9.Z8IF.dWLALFja9huRlpEZTwLZkrPs4
 38ALgVP726.UceqWdV7nPGyDVTfX7W0zmy8ZGL1Dltxc67GJk6g5ZAy_Kx0HGh8e79fYEQpPi4vt
 uq3JP2WWY8iRLmsGvtvnlwgqyBVTiFltjk7SrHHcySWSlD_wKbJkEwBOy3425EVfVFZZMwKlYGfV
 b1GmEG6biTq7bgFOhKwEt8.QAzXGNadTRYweACYNzoPTuQXFk4Ik9w7djWOR4cLa2JlSXj.9YCaO
 am4wGKuGOaj7Y3w4ahAtK.u.inqXIYQfbzOp0XwQX3i26iGCeN8GW4ByMSmPlxubOVNuymRp4gd5
 CRfbUemsde_jAcV_5rdhIrpWxKhG3ScMCHoxAsn3pI288W23rH3SPin41S.kx2cZwPgrSnRcSuDD
 GX4hjfwk87ahdaW07bB_0Wf07obg_J4Xs2LwhfamY3n5RqmHzleDWRHyjYOuEWcOxjsUfYd0ME_D
 SsB6hVEBpwVKFOR27vwq2cLHTiY915DOGY8cj1u1bTWnF_NFlJbhtPdNRJHFhjsfHbNOtMK4oYM5
 rkvIMefEapaNbBGXXyv8ZrkZjIR6TSxpjJ3sb04WkF.7I1X7gZo7bbKtGluCBlUiCn_njT2Wl8Kq
 fgWpF6m0TtxKrf2YUL9PN_6.STWZG4V6ufYAP8jGNpGYWk5Naba7VG4jhGDOPoQr98hhebnALF.d
 wpuJ.nMHzlFOunVbl441kDwGDJceVqNxldNfRDOnCXoV3xqPNgegupetmHdu5I4P40DUkYSpc17T
 8RYD8RZllsYqu82icO.aln22AxkCAC8TRrp_kvfwKSzcadsVKRfwBxS_hsEE25VbAIo65kIXpBlS
 n_i229Y9XMB0dc3TPuVE7opvEoyVbZwd586Hl632pRI62km3zzUrGSyqXC.cREUcjudTttfRgaB7
 UPouA4nAD8Y4j7KCHaquBnlVQxryDXY2vj6WmlZxEEVvTQJmDsbLBPccz6t8QnbXiAHHi2DOreT0
 F0bZv0Sggi4.GkyZNjRM6mZ.OLg4M6j_PuL1IzL1LcKu7uuwa3FLIUNDsC.xHtB._HVv4DI4YRex
 IAEEo47zzRzWMXiagbhacyUeA5oKGJjpwG2QLf_jKerAlEOq55o9sqMgAerQikDzY2teD4R.j52F
 pPrFFmsmuUKSq.JoEPypO3i06Z8MVGDkETZBZDHgt9sF3OyAGK33OH0.IpKLWdlBEjBy2VbIRhGX
 OlGUu8jYdARGX4xfOrs9k61I3iqEYjGgUOE6Kx1DTLcTJzWyyvUTkYvMeeDld_Zf889a0xHu6X.G
 2iZojzBBHWwDqOpHfZCtx9jheCFYiTkLqdlqOvnHL2IFhXDNgo23a1z7U9WSuY5J4nqDaTqooXwc
 mIQukZZR6x755ztb0q9YTrMSRy7xqUauIqXfMKnKcnV_lQRIKlxnQRXSUcRoASZPff6YAetDDiKx
 qLsHN3JMqJ.K2EL8KOdJ3VnJfZvBNXPX_s1kAQqyFP9nnf_d3iOveyOPJ0w39FGB2S6FBw6osQL_
 bww08RBkCIvNN5RdGbFWlHfbzPUaDdfEeRhv81745voHN9wRNlTMleeYmVvOfnhJ9rM60Spabgms
 DR7NFZQp3hoOklVWfkzWyJY3xEHPVxwtenxEi32vhZ_H_.sE3awSVrZUInK6JrPPd.bRhyzk8atw
 Fi12oAFdH6Z6KVNDz9BhIrZPG7pA5RBIFVT1KYnZVpXfiBCtuQmhZJqA_gmjo1unT5SeN_MDOzFp
 S640GHbQFWcVbNmzBF2A-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 May 2022 19:12:23 +0000
Received: by hermes--canary-production-bf1-5d4b57496-lhzp8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 08ea89ddc253c345cd6d029d7f01b725;
          Mon, 23 May 2022 19:12:21 +0000 (UTC)
Message-ID: <52db2436-fe75-0810-aa82-382aa4ffd0b5@schaufler-ca.com>
Date:   Mon, 23 May 2022 12:12:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.19
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <52db2436-fe75-0810-aa82-382aa4ffd0b5.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the Smack pull request for v5.19.

There is a single change to remove a pointless assignment.
It's been in next and passes all tests.
Thank you.

The following changes since commit 4b0986a3613c92f4ec1bdc7f60ec66fea135991f:

   Linux 5.18 (2022-05-22 09:52:31 -1000)

are available in the Git repository at:

   https://github.com/cschaufler/smack-next tags/Smack-for-5.19

for you to fetch changes up to eaff451d4b7c86e3db3c03611426f5ce1d3826fd:

   smack: Remove redundant assignments (2022-05-23 11:12:08 -0700)

----------------------------------------------------------------
Smack update for 5.19
	Remove unnecessary assignment

----------------------------------------------------------------
Michal Orzel (1):
       smack: Remove redundant assignments

  security/smack/smackfs.c | 1 -
  1 file changed, 1 deletion(-)

