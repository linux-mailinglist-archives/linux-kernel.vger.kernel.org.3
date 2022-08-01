Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5F587230
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiHAUO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiHAUOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:14:31 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12774505A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659384807; bh=E43cQkvn/4/VHiP7B0OPm/B+8rXIwu0R/6PBB0SR798=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=myJ8/rNW54VSib9BxXvanrJTHBimTcsjMoZPawp2E1VFf8ZFB+/pWSk/ABcLvF8444ILaeiJIvyewaTiu48joXXbsgR2vDJgAT8OqFAeF6uEoCjFzvYMHanuF6X76Nzx1tPQJzkIRmmOuvXbB09cVh4PtRfij0H+cvc9UPpoOgoQmMq0cyuSSOyELx7bvm9NlzvjZz/P8genITYsrGyG3MqKDIzEiSKGbG1rLpsQyadi3N7NGHmlMS/ymOjaDAOwPw22xmNf5fi7R2/Vd8UFJMUtSXuBGRXeW4wa21jakxw+v1sEiNL+on8IwPBZJGPcX0Wn0JnDMsyzg9vobliLdg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659384807; bh=qr2qLQWxP80b35yhKXdOd+b5Jw+iwWVz4oScqlLgtj8=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=j5hEGl+CUf3gtGGrj/erI2erszo2145C0k0B9k5yxoq3vXypteJSBshrfArM8tC+pMd8UrlmLZNnpQfI4z/YNTdR+Vnr7Y2v6EdwxMwQg325Sg47yT9rJc5UQY2HFrIlMbHhEgRa/uCOgEIajQHmw+TET02mtsdQTErg471Q4guJhFUzRvCQICbTbenfNpS0FZSjf9twBBGwDI2+bnLtpfSIKxmgOf2q9A1wSut3/3OJuD6IFPXomJPujptqmx1tNuiq8nBGXRFPw3ug8kc4hyW4TiI67ppT/NE7e9dikxp4b7RukJAZzt0aSRqBjbFFXgayOyIc2YhYGDX8H4bCag==
X-YMail-OSG: glwSvgwVM1nDgNhBS8JECVcpJrYn_sSCP7Q8tSCB6TySPVHOUF7kkZwJfv81e.v
 9IGIq.W8K7xVBiv2eVdhm7uAcP_Z8MDoEKaouQnrejbuxsGbknMD47UI9iBJyN6Mw5B0C1RDvmgI
 RjqwswHkkcvC_eVdosZimt4DUzY5YJqBAFtWl5uK3_28NykfoJU7ODdJhBD47LEN5rqWAy0Cbz_.
 mKwcpGnKdIT8h48I2Paw2wjevpEU6WJuFA1Dsxg4JxfzJMBhk6YBM3fuBbCTuLg3eooqsPuGB1pi
 fE8EqL.F7R4dCQ6MDGAaAs3VczPZrK5wYtqy3BzI4Vrwsbumn.qDutdEnYW9LyS49BD22IMaqqwa
 FYc6rWUB2O7Wgesd8mkRVb.sOR0FBG25hs99Jy5FhXMEyoB3rkoYR65QHDpNdHfcf2e_9u2Ig1yL
 PtyOjZkSdxdjLPoAH3W16.T2TbmFTsuX3XrON5dfAGueQGS2qa6GIPGy9fXa6QlwXkFuUaGhyixt
 B.bf7so5zVwgl9zI7AScKpCddD5QBinwql0bkKh5h4VGdKkdt5fr5kLoUwlWO1CQaLk16J93BmL7
 9lCeGGEBmp0XCCYV0_v2KtUBKUNKBRqPPvoS8EQMcauk73ARxxE8Z.6s_Tb4.ko0PX2KN0O3K3l7
 jJXVYIv5JQTW5do1MpLM.0URHnDUEuqz.63vxJ81nQ_9uJ4A8f279B4C07zfoiQCsBP5UVzb9fzm
 YnI8dzAR5b4YNBw5eN2cbUo7d4Z98wDFhxmoHeGzDMrKU1BidbYiAkCScsFlnxvk9mAxhOKsCwlq
 qaW9RhmFbHW6Wk1VO8gOVkjzJw8rB2r5Ea6K412byPUoqXYWMICJwlE7NtcGu2tDGLQDyCe9ymOc
 gdAWW_UCv_hO9Dh9iTHUKTIemOzt0jUMbX9tjAHO0AMQSvCExUVIHSfzavxroVmwIsKYGn.dN8uX
 .koNd9boutCs44qw4btQ1.pEFBMR3ii5pmAkprY96QF97auDmsUzsrDdN6ljZuUsbtuQDN2FZO_9
 8_weyURNFIQHEN79jO982C.VO6IyNiBKkZBgWwZisjakJGbo9ZkJWFy4pzFROGRAd16aFat19nDP
 jDpDJi8Lia2VX4w0jC9f6iG89pJrg99hTvKBMUgzj7ryFHAAi3l8un_jG9ydfodDekCMWrJ0z1zU
 9sjPXZ32KR.Igb4wyBe0N5KN84MvUmJVP1P4DALLR1_s_PBxaqZ3xL3N9tpZuFf6o3NGYMAIeBOg
 f8Br1ybZPz9Dxgc6iemfn5qawhyMKvpUG4LuB7BdDHH.FK36f1n4VyYjGMh3XDg8SrWTEIOWIGve
 WqdRTQPDeKmgyvLImZOOZqvSYR1LuJ3Ok3Hrz4q1lrS6a5N68I0R6hak8CQfxihq.MTWwQGshDIw
 zdRily32TbudyOBp03s7lFAv3dnJ0XIcEzg5yjBwNThbBo2_JvcxWsRz7NrDM4JW3KPKqRrd4LTZ
 dvfvD2iA2wBM_eMkhNj0OcIw_oyPIcFM46bj.LRXAl0fWvWUV4rZakzarahNBkv4oVrt56cydYG9
 LDEaIeBT7gNJDBy40CB32ZeY5hzBLKNJ0bi6uHlzyY6XyEYe8qSTqV.DqmWJI8dR86xwCEtYlO1E
 i2Xaw9beVT2yDx.EP3FkrS.agz_qAlPswi6Kq6zAYp.MpeLfNqZos170eqReH5CMGVT6CPaSg5ho
 eve1.I7obnqOUmTLq1SQ7NcIvIG4EKaBUzKyfvSU35gy9HidikqD3APyGPbyUZKHstCdepkpzFd9
 gNM4ntLKHOG.U_rK067v95fIxQGYo0YHbASqwQM3cPufNkWB8oLAEFbccntaJv_KX3r42Mo_ytMm
 NLgrTzorU56rMPvXnr16bveKtt2ZyUewiMmW13Ba0Y710o1xAqDckwz8w38Oa0H3pInKKzq0dnv_
 FOlgTf308RImUfCFNfRAZZsiF_QoH0q63PLv_gy7H6Q1M9oRi7JIv1ZDl6KkHLxUP_77fnr.tyut
 W_qxCJxTa9C4HKwEvDq_LDNUeb0R9WeCWxErkq3BqxJkAocZrs4XPztx.v0KA5z7syvYqOzLi64Y
 rcTaT.dBYo0y55vwFca0y7xX1GaEYJTkVAK9PRkEl93RwubgG5F1Xkf_AZOIoFgMlmfMlCBiPq6N
 sRmksc_U.YLAaxzBz57Ryw_QdivpUOoIrrLAZzQhWe56dtJI4Fq2Sp7aWq_PoNDV1Sxf5GFNMfY2
 twIrYfiC5tiAMT1Bwxv0xKc2xO_RQva8DfRW0UHmxjl3Q
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 1 Aug 2022 20:13:27 +0000
Received: by hermes--production-bf1-99ddd9c9c-mpxmp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c13a2b16efdf9bc73ba23e617461e1ba;
          Mon, 01 Aug 2022 20:13:23 +0000 (UTC)
Message-ID: <827a0fe0-03a3-b5ca-db34-daff17095b8f@schaufler-ca.com>
Date:   Mon, 1 Aug 2022 13:13:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     torvalds@linux-foundation.org
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v6.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <827a0fe0-03a3-b5ca-db34-daff17095b8f.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.20447 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the Smack pull request for v6.0.

There are two minor code clean-ups. One removes a touch of
dead code and the other replaces an instance of kzalloc + strncpy
with kstrndup. The changes have been in next and pass all tests.
Thank you.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.0

for you to fetch changes up to aa16fb4b9e7e1057008d999138e7ae68a40bf167:

  smack: Remove the redundant lsm_inode_alloc (2022-08-01 11:26:09 -0700)

----------------------------------------------------------------
Two minor code clean-ups for Smack.

----------------------------------------------------------------
GONG, Ruiqi (1):
      smack: Replace kzalloc + strncpy with kstrndup

Xiu Jianfeng (1):
      smack: Remove the redundant lsm_inode_alloc

 security/smack/smack_access.c | 7 ++-----
 security/smack/smack_lsm.c    | 7 -------
 2 files changed, 2 insertions(+), 12 deletions(-)

