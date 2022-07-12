Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF13B5728E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiGLV6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiGLV6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:58:41 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A6A182
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657663118; bh=kxbYYDVzkDm+0qKaNjdrPV1fsG7Mixqy9QIqgCOhzxw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ovuiV7212TVTZZj+mJFRHqEbIloIuWJQG9L7MRvJe78jMqwW+o0yCvbkwvM1gClnu/hCdUqAlJ+4OIcD60XX3RSOZL0U1dUOQO5V3eQrKXE2rrIIsZ26ZbDJzG5w4luCoTxODC0CkrnT0ActQ/ZZwpxTrW8Jzfr5TuExU9vh1PJWu8XDFs91YoHXYESnngM5ufKJD1yDk8wJlwEDXAJmIv6XaPYzJFcUvNQT38ILBFogvTmKIUkaUVPYaG6YuBpvbmaHkOq8FjHeumaQ9I4/3e10TOsRfv3YkT0G4JFDJOboOFojBZVzIYv7TGNsVjA7zGbqSEdWk4bYDAHUo8mdEw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657663118; bh=vMtm3knwl8FuSNtV8coCan4p4lnRSBW/SGD6OIDuNQM=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iVm957K1acjI1jubbeR/Mrf+yVlRF+OnfZuUrVGx0KecKd+g6aOsEoYfaCAjBsPIa/RTZ9ztFYO5qFVfzx90gblpNskS1OKuVBLJhrafZY6McdzExKZG9FRvafQaHubzsexVezrr3WrAoYAEUlj/xe+7QmtR91G4Tz8AKZnUFAXQFO4F4hfcseKn1DsW58H+lXxDu+RQaQ2ASlgs/VGsVQVHiBMKWt2aNpKjwffbVvQZHVCOnLtRNW+Lsb5R6koQsYledLyFzj+MX+Wx8j1X4wj71wp8soqJLeI4p1wkxAZBLjXlZ6YiScN+PRgPSVDm/VOasFoxuGWA/SpLkOn5QA==
X-YMail-OSG: Oi.EETMVM1m5phQ7qVKWgCZ5oxFF975C7ntLaVE5DOebGnXBED9ZYsNTLi84dwb
 8ETv3wwruoDTSO1G5E4LWCQpr6Hh0pTKjBzZH8yEFVxJ0ZlvoYQjVyqidWEQcGlD7oqMBA3B6V3X
 jpO8ttGlFSqyPj03CTK.WJPlWoC3V7mekqjXabI3rh8Xy2z1EogqpGn.jkJ__wlQ9mhSyXiP2nI1
 _nxvghME57setAQZICcC6Qj9gze4hPCBsulQ2OI8Bzgap2cl_xJWM7QRp0pCGjniFmRl53bKmi7d
 LoltQ1s9hk84m4Nqjmu23PJtU13yj7vzOjyRegXDeig_NTDdfrQIOApQ5b4BwpqFHlVmj4Jc6M9N
 4JCsZEf74BJJ2foJ6GQ0gORmbc5nsv_ZBC_qHrmCpof7w4maof.rWT41g5rLfts0fu8kcNjlOeUB
 O8P3nJxGPHHkjAUK1ai6XfzdyGgR9eOVSOsVL3C537mVmj_9AOLF.SlcgHT7aFKnLh1rahG9_DGS
 tG3rPTdWTdG4_a678FBJOM6yu87ZW7AZcQDB50HiNz6HVSzU.Y1gVM.Y5ZfiXxlawwL5IKV2Yze9
 oxBQhnpskog9Ckoj0G0OkRarNMw5Rzt57By6wW0m0L_OAT6HeX8shEDsdg4VplpxAbaInHtPREax
 Ilm90DgtzWgtAtkEBJpurlVFdUpV3zJmhmU7AG55BsKT0a4MQq_VAhTRda6msg9a5WwipN2zKhMG
 _A5ul01x99w0jcvF7ktz6_i9XdXkpHkz9nPY88Wr2VRm.cmaYfqi0IibWobxC_lUEmFJzJrqjq4W
 KRwn8tKG9dtHXYlGLo1OrDbUdvX29IF5a2014b.9WM97cZhVjpN0XUmmEFU6xT3dwNidtdqb8qav
 Fh5J1Ou9td8RT5DDYw1H19JByEMyEUQXaERmL2LpwtWzPgbT8KKy_aTRxDFHVGguAWZgrcKjkEAw
 T6ftNRbhnI25u3qw71KdFJWW3KabJrrwC6bWtxmzrDqVDit1E3HREp3B5O_zmO9uAPTW5p7nV3w1
 AHypka7RDxZ_xEfUl4MXbKRjtBQLDaRi5erbm9jUcqHmQjwFfP4x5JmwfTCNeAR2hE1OMcyrRXqA
 5LfKTsfeSmbFeYaqAjuYOduZvyuytbyj1EkEnBnjvr6TEYlPey2_PILJXOwb84sKpZLLTYhqxI_1
 X6vfboAdAJ6zQrcAnnYPIoFDNS5za_mJ_DIL.21nW9jygn8duBUyyD_lFFom8BIBMqtfFHLNcR8Q
 d39Vyt9pFp28QCEX6pi9OAWQ2HwXV7s3u82Z4McZNLaPzIxc0JIOS1AOWPZLwXSsEq5bHe_TC4ZT
 8Rm06vsFJrzTpGdIE0zBiayCxqlNyg3TjGgAcNGCNOgE1GFyFbQBG_IL.XHcghO1fqphvsvvG_Yg
 nu.obAVHyRLUHcf_30YMw9XcU4TS7VvrlyfUBSb.b.wAkx9vq5JL5t0JQ340Ykd_QuuYIMWEre.k
 6eK.OalNlTNJMPbMM1pWG5uOrH9ZJJrfntIi6GyQXZcLZDbQs1BpiOKL3yD_Pi3gQaBLqC8WBBGl
 mIXz7I1j2bP5SEqfXoa0sA6PYwn_thRFDyqWy6NcWODrjEF.WdU_eZO9p4IDBi4E37UPwOn0wUao
 gj_.T3kXWsh9wOanL.1akr9RkFxdHaQgpR6ihwpD0fyobe83MhwrjGQFyxVuXD5G18uxI3QbQON.
 F3_LH391cJBJcaqd3fBk.vqEU_pbpY0vl8xPku.Ln2zj1Hn7ItFelVKPHc52OX.9MAdRO9DFTaY3
 rMF7VgMJbKc7uYOthn3DXwDtWj3Ef9e6AaXLpi.HRnlKx8kTDdLs1bGOQqqpGIsu.s8uEVKQWqEk
 I_aeuwqRI.iM_oKDnuOWAgOJCI_.b8wHP0_nf1RW4Gn8ZK0IEy3FtyWPaMq1WlrhOgoRQEO2DksX
 LYyyPvguc.HjGmcKZtNpc7yszM.tudoXIwygs.Mz54uDstffqDIozIh7ypwoR7_MoQVI9l8U32pu
 HIe1.n0o.d1b.zZ419ZbH4WOP6d121yn.RUMv_IbfNsNgpAM0R0L9q0DAd1P9ibBdWkai.OtI9Cn
 nGkDW2tJkWKUjnOo4EYI0OVLa1O5CME5Q0fpBlwgkg7TdQDE14LNOOczOfzPyElWzY2svkFXQ.pv
 UB.2r5I2fbeEb3F4KToOranoFtuMKpqPgH7jBb7nCi8ON4LOe5Ss9IXhtWY9Z2fklqDthrdYgvpQ
 9hAyzYfZA_svd_gOie_EZGlQtctApA8I6Vm65WuZ9TEgVAEXSkylR31Tym3HodHOVaiQtIokkXMS
 MeWeUtALRLszLzyQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Jul 2022 21:58:38 +0000
Received: by hermes--production-gq1-56bb98dbc7-b6h6x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f4844076e4ed28c5f9c2d52b5baf81cd;
          Tue, 12 Jul 2022 21:58:32 +0000 (UTC)
Message-ID: <aff6b556-7cc9-be2d-e1d2-ddfaae665210@schaufler-ca.com>
Date:   Tue, 12 Jul 2022 14:58:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v37 00/33] LSM: Module stacking for AppArmor
Content-Language: en-US
To:     John Johansen <john.johansen@canonical.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <20220628005611.13106-1-casey.ref@schaufler-ca.com>
 <20220628005611.13106-1-casey@schaufler-ca.com>
 <92d0f7cb-f565-38ad-37e8-54e04189f558@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <92d0f7cb-f565-38ad-37e8-54e04189f558@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2022 2:42 PM, John Johansen wrote:
> On 6/27/22 17:55, Casey Schaufler wrote:
>> This patchset provides the changes required for
>> the AppArmor security module to stack safely with any other.
>> There are additional changes required for SELinux and Smack
>> to coexist. These are primarily in the networking code and
>> will be addressed after these changes are upstream.
>>
>> v37: Rebase to 5.19-rc3
>>       - Audit changes should be complete, all comments have been
>>         addressed.
>>       - Address indexing an empty array for the case where no
>>         built in security modules require data in struct lsmblob.
>>       - Fix a few checkpatch complaints.
>> v36: Rebase to 5.19-rc1
>>       - Yet another rework of the audit changes. Rearranging how the
>>         timestamp is managed allows auxiliary records to be generated
>>         correctly with a minimum of fuss.
>>       - In the end no LSM interface scaffolding remains. Secids have
>>         been replaced with lsmblob structures in all cases, including
>>         IMA and NetLabel.
>
> <<snip>>
>
>> https://github.com/cschaufler/lsm-stacking.git#stack-5.19-rc3-v37
>>
>
> hey Casey,
>
> I am not finding v37 in your public github tree, the newest I see is v36
> and v36-a both based on 5.19-rc1. Can you make sure v37 is pushed?

Whoops. v37 hadn't gotten pushed. It has been now. Thanks for
your interest! And subsequent reviews, of course.


>
> thanks
> john
>
