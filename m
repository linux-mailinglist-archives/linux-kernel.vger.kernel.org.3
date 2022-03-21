Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627E34E2E22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351186AbiCUQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243126AbiCUQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:36:34 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB6D41323
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1647880507; bh=vJPepEl0zqrXUFx266WI0WDEhUIpWwDNqvBodY4bDvo=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=dywuA94DmdpwVbeksnNjCSCVDoCA/OYp8PP2CzndcyhEmBBHkhj5XUXQTQ77GwoQVMxsOHwVo6is2NEljoHGx7bM4FnWqJUdMMppapD4ymgo4J/yZVydqL4DXiYmR8WbJVJMbMkL4GuB/dIKYnQN1UhL1+Rkd/Ss64cVDG4Lu5WgB6pj4ys6yvfp3cELEGm4ja8Vp58c8HiAGm9TMvS/O1PB20I2QKrOt1EQflK/H+8Oe/Y+Felztkrtzak/MgKWeKmnNwQU4p5Nb8K5qjVA46/1qP46fYKNuDaaPKi1tQfzzJEiGlmWbShNs3rgWkia6sLrDThAzNqT6uWyYQhHyA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1647880507; bh=esLTU+d/0kpFfBCGLE097jy6JeFjv+af4y9e94COAh/=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=WILfKBzAIbLI2xqEgUgs6SkswYONHMI38+lFDeHYHoRmdmvYZGRL5a16HMy/pKGYU7CIyzTUdPW3q2hcRzrRFE/XH+W+lb8J5HyZu1eWbVLHOT2M1wfQolLSm7FbqyJyQmhPpOjWyZtGthBFYcq7e2WJQLt2rrBJUYhzC98u9bHcjf5+sA91IGqGtjPgEAm2joDSa0m5jwIX0HDUsXdPaKbYQTl2QCbzZXF6yK4UuFyF23ck9Qi+yN9KlqRU+qHhSP3fMG0FgHNrc8lNQKlxi04GwNZbrfcjTafCKLnyXpHQNBfpfAg9v8Kq5yskmY5VPs7a/nOG0T733RMdAtcHOg==
X-YMail-OSG: JZbLgjwVM1ktQnL5.kK5LtqANuiT2MKngRATnS9OgmCqougGrMhdbICKS_3Yg11
 J9nW5H.NoGQq6pNyFtLuP3fIBDr.xdI4QgfJrx89qnzm6JTjjjuDhMNbkyOC3Hj5WloicmKr262L
 Qiwp0ZtJhA0AUW9ouJgUBpo_uxjZrldCCxL7fZsuAmiKqsML7fbw338bRjIbzQZD0DM9OuNKi2Cw
 m1jqCVXfXvomyUdn7TuDQWbt8Z815hUbCilHCEOpHk73XlCvEMYZ.6HqfPYcHYOhCiQOjbxfk0S1
 7njoJPhfoWrWXHFvGzD2Usax1gFr1IV5kgSTUaxnKjV9wbFJg5.EEHh3JqocgiSaAw.smNiLiyoG
 0cKmes7sDcKO5XvqDI3sQbS4xpKiXY3y0otl4yLy9UKO0hz1bo8VKVicjCt2rYGbx.tRWtobXp4h
 tX2NOwALloI4DSOqwAphqPwecMQ83Nl1cI2hdGeSozCs81hBAmiPqGU.uxs6aKg8hGV5OwBshrQ2
 65eqksNzQX5JcTE0Gy90cz5Kry7veU7QO33PGfKSkd6SEoEDcbEOvBfDjigpf.4wkX_muJiEFhE_
 fmQ6u6azDGfhJtmCmho9IBOBnR2iQT4jmLdDEzo.UYiiuG6wYTIen.KBLeS.34Iwn8hXNjb1GgNA
 6ko9rZtoWoV_EY2n8BzLEi8I8nGroKdLVhhQE0LVgb82M2.1_3oXrPNDGxMsI4chiCY7M_9qJB3P
 ePL7piHZYzS.D6hzfCbzoHbaZaatyFP2LY.8ekSN3uFufQW8ksFssj2IhSQuWUCLDrNxBZ1kK80s
 f3ZY5NOvToZm1qyGUW3HtHCZR1zSKajRwzN1wp4lyYiEuCluW276TJin4hjyOWDvlwJvCVjXJqwk
 OBT5z_V1kCu9B2MrfUfdEFcMhg6de14Yrbu7dYGL461A6LO4nsjJK7aoeN8hQEcXZjhm0mEG4itw
 e4lsPglpr8UyVer0TWmrIuFKPJodzF8MKUqqEfJioGgeWl22S8BlHzndIYyjhFCLpHACpG.VctTJ
 TWtsVZ9MS1P7v1NRkJL1eGtbSONiiuQDJs2ko7JHaKKmmEYVVRx_ZjI492dmmLG.2Rp3W6ZVZbda
 lJShbkhBteI0spJlB4UaxcDAmRhaHoI06UUmC_qgyrFjd39fd1ICf9G1BscsPH211.0B_aBymS07
 uQJ6G1KZCvYVUTw.wpPcltzqAcw8oIyPHWcZrKhpt7glPQvChtfCyGOU9BoT1BFvZh2yJ7XNO_qg
 4.YGU0eywWbmXLYUpOhP5myuZJbUzUZUZqMdxmJKTHzJiiVmOiPLVBlq0tzag3L7ENAFZNxCgM.A
 ndk_gdzJ1LRLtRCuBhkxD4JqfabGe0l.BkxPYtu.ec2SRHjwSjUkR4fBAHHAki4QPJSFTBE8erh5
 YZrwxtjBwdySn.IPmGJPmaCOOi.ltQ8bq0fVbS0XccbHU1qVSbrn3IWrtNFkWW5NPHF7CmZbHh5V
 XfIvuIutewYQbXX65kvLAOahF7iLdG.yGo3LnXuzJCJAVh6Ui5yHTjQjuQqmmQj3M9jVf5aHN92s
 UXP2LHnPacLd9Uto9XxjoRMdnjk80S2YkWf2YmXkr8Fg2Mub5fWXv2IUdkgx9jl9AiMW.rGnIEGa
 _xhFPYYKaaMesOXGDDI78prYir2Jue3R32T6CKCpgGczz5mp7vJP.JTgPb82K3IPDcC9JU59ElbJ
 gexSMKlgU_agalcAR2rYZY3ue0PhQECkap5zd_qtyVytHAhLGB4muCLE6M.37yvFcnddct80rjHS
 Z.XwoehLPJ6O1bc_zf4wgWZ.4Ga9RK4AbbsYYhqZkk6r7jPFzi0LI862DJbN5lHCWXuUh6qB8lCd
 RLmA.NLRDbqC2MucC6Mq1IqjCFl7SUtubi7NChExO9_JjQavRjOyUQmpPEhKrVIiJYtRxHweuM.k
 DuvKzoLrfyZce8CcE.Fsf9t6tvKz3IyJ5Ib0GmgepLwj0x83epbHhpEi6Nq8JBBeW11n1w0V8OrW
 q9tf_pWVvvBWHFBKslxSIh_dErSht6giVlHuOCa.nVEGNELB21XIXGpk3.uIRNw8PnaEXuBWUXYZ
 vpOTMJnQlhCt2nniYZEKevefRFVFLsBokHIXyD1lO.zFNYj3Y6cRcwwp2brc0IATMyIvDaeEYvmD
 F7tg3Dri77ivvTKZOD7ojw.oAqOKSLAFCRXrIDzQHRe8QifQcmnfpvt.b61AefBA2NTvyLz4GUgZ
 wA27YgeG.Zd0QPx0BCT1jiMEYVne0o1rObG6CwjvkUJi6RTtV35UcYV.KEahHjnalgunQnIiiG8Q
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 21 Mar 2022 16:35:07 +0000
Received: by kubenode522.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d57b9854834ae6071659616f4d6eb4ff;
          Mon, 21 Mar 2022 16:35:01 +0000 (UTC)
Message-ID: <bf678bae-821c-02ab-042a-004c03d9c334@schaufler-ca.com>
Date:   Mon, 21 Mar 2022 09:34:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     torvalds@linux-foundation.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <bf678bae-821c-02ab-042a-004c03d9c334.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.19894 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the Smack pull request for v5.18.

There is a single change to repair an incorrect use of
ntohs() in IPv6 audit code. It's very minor and went unnoticed
until lkp found it. It's been in next and passes all tests.
Thank you.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-5.18

for you to fetch changes up to a5cd1ab7ab679d252a6d2f483eee7d45ebf2040c:

  Fix incorrect type in assignment of ipv6 port for audit (2022-02-28 15:45:32 -0800)

----------------------------------------------------------------
Smack updates for 5.18
    Fix incorrect type in assignment of ipv6 port for audit

----------------------------------------------------------------
Casey Schaufler (1):
      Fix incorrect type in assignment of ipv6 port for audit

 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

