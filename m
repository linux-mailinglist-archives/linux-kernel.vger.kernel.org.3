Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE8851242A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbiD0U6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiD0U6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:58:35 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D2288789
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1651092919; bh=xgehmnJSTKW4K8cVQa6/Sg7BveMcVQzT4njiupCv2Kg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=R7DJz0ehmN2JOnLhvDyI9X9vmrGqZ0ltcLeDwmfoc0GshFicotQYh+IAgQriXe28s9Nj4caMQ53kSGWARi9k8XJ6ii+/KlizUcQ5lSoU/8NW/A/ofZtF9k6qIK01RE4s82PO06xLnHVZkOtx9VBZJD2F2hWgJ6DcFG8DAIJwFbtiVMHQf5WHQ2aGRzDg+pTO/kf86dOZNnfVnsICncmWlt675WwjspNU+9+ddlWCt28QoEwQ4JbMiDY/VPr2gEKsVwgubVStb6tyw+UcJvQtddpTSXq7NIT3+t2itaxOhMwlr6Trk1Opq6E+zAuYwS9kCd6nkKMcRfv5aiZFxwJGcQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1651092919; bh=BLC+GALjnwAPvZSHjInQlCIHCjDRqXeFg5bL4P+XEKO=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=apZFWI6CV05AMeaHhsOdcWdNXez30+ffx0e/HGqAuUr6wyXLiL7ol0EmagWHS/JT5PEWmKoS7h9nPHP7g4hFlavhx2Tpi0EtkyzbT32gOKD67qr+ZMVeFOqe0fOCkhUtAqk3c8Ufhwgzln57kWWlFEV5NS8i1GyyTWL/zubHpsnB7YuGOInBINFns1vlga7BdFBBPBLsl06G/UyQYZbY+wqFwyPaDaUozSJeCWJjFLnadCgzNcoqdO9E53K4UCX7btJV84SkfifT1nwg/t+oKqIzW1tBgPGE5AbCQnQdEWwn1p+2m1MazDNmieL9OngDscgmqNnB6yq4BJU9w1QhzA==
X-YMail-OSG: Iyn7OOkVM1nuqIGXdn.HwIb7jJQi70mWTKJHCG4ZHVlwLjeteeNY7pp4.kZHeB_
 j4Zh0cu512PcBjkAzAD5OE7IVzo17qyo5EVTAXSplqaLaT7p5iq6DoAxxqZzqWcGZaJQ0wYCRgbb
 yCdpYheBUr5qNPPoKIGhWE_EzraD9m9qR5HVMAZVV7Osly2fRbcRzgjj9zWa1DE3t5OpEgoVSCFF
 7Ya5Ut2idWzn.5IMu2dOdu24ZDtyIriTYsvPGYi_OjyuGpeXCG39OGM4pOFmplKK2gEVa5BJJZ7Q
 47RvblsPF7t4RnSLZegih24KELUG2NvLqp1NnJHcWtWjV4g257GmE_oIxN1twoYwlz5rsC8fMWS6
 n3rspAyLXKSPOYR2MxDQQpzAL0Mmkq11tT1p3TmZWFzTN0TYiObZBi_By4.GBc8ka9Ue66yBRN2i
 BcvJlhGXJEyEkvCKoziQ.VLJJDk_v2btpA8YKZHJ44iZbKuapVrIr.GKETtLV3Ry8L2FQovUbpL9
 Nc1XCoKAPDIIJ6FPx41.EBdqc4AfAnR6_eC2wf.PRFEGeS59axMKqiDlMDCdSkTT2cNcGnx8OUJN
 QmWWQ2MXL.9nQgDWU__5pJGFtdxpj.UfeR99KvaNbal6vVOwGst_EU9rWDjYcdzybLlibahC6rvL
 eKSBCblePbLuDZ0TtW4l9mgpNdtiGV95B8bm2nFoPdB4mGdYxieQqSDnnmLFe5xlxOiydQVifE7g
 59HJfxBSs8u6NfCjDcVrBlJ9IAyIb81PsoMA3v6jlREOFpIbwqpRcst1g8QPdr6Tr82NK3KVMf.f
 QHmRgFbrbEgFeJmOs2koNSXyOQHPVGwyVxJgujOe3F5Yulf.5cRd6HW1j7PmMPXMFETlp6D.t5HA
 pq4oCZPJuMHwrKaL.MBkg3ZeCMN5RXVXscuno2iq.DiSgeFZd8pIYFce3b83YT8W4bqInyDYjxKk
 gYkr44Eh.ljC6denfZ72cfetrXBkMboqhoMw77tu.9xlWWFhsOVCpI_sTGmmy223lV4f3DsKNmKx
 7NyKjwrQhhmb9qiDpNJN97R1G3UM0ckBfB.H_1yLTmyR95OM8xOr8Hq79Vs8vUlr9tMjMVZrQ925
 Jl2ttp4z3s9mZMXte4aaWMNd7rmp37aQO0hk8evCFx80TaSlGb2OOp1aU.2rtSp_TKw00nfiK2Lu
 Ii_nbziTBRiD2dFFO6wxX.qmiml6wry6TErCtyZ53Xa7zHduVM7Ms2fAYoJAJtryT0Fbw96Nj3ZG
 e_fx5by9M1G6aeaxEGvq_ts2hYsvVnSI397Z0FYrQh6p38yzVpn_yXYDU8LsMIFo62XL4x0iorYD
 W5xD2Lwa1qBf.arvK_r1iSR5_5stufW305FVx.2BHNcZipZ60z0urF9z3hTuCvKO0rbfAWAlzuo9
 ptbY__RcMqpKL0ObcTmyGaga2qHNmY0RIp.wGyRXTygBuizZLWyvNSLh6R2mExZCrGuSiv.NyG9K
 X4GvYSmKd0tC2df6W1LbEk00Lb8pSfF9BJnx715cVZJW8uY9dam.7EtKvvHPK3OuC4fXLiM1QZt0
 eUAjNoF.km0S_Pa9WuB9su.uwo1YEsDaIh7AaSwf7TvEBiPw6Ybid537r9ZzH88tzvk6lZHn_pxe
 BacxxnsArY.E.iiWZeMV6xluUzYbVpYfanevbHImQ6O4xwwMaa1ILXp9DtYffS3oprkT7UoMZKY_
 OjLKtUjmTqM_Jwce0IY7e32JfaHWvlBOUha4J2ffilbsw8GWx9OTih9w9UBAamp6AAI9Yjiyklgf
 LSAdoEl15Pm5wVit.hyLH1Wk2DYT2edqdygv9BK5HwIi47KVwHta3FoT4Z8.5pLAsGbOErIy9YP1
 8_7dW7LVXtidWFrS8qO4tEnq7b8TZtCrij1av5V253uNJdl8AgX4U3A1P82dr74TyytfyPqAuqWX
 uNrHq0oWK8.w._.Isa6VZ6BXzZq9Twu329XP1aUSLJ3z65o6b7GyOx01_OBpVj38NnCZTHzf_aTf
 gDR6yULu8rx7oVPvXNISTy0pwN1d5SIayCNViE7Yk0hbOuTYIlxuGQXrKrabPlx.nikQz7Hf.sAv
 yd.tgsIMcxuOr.nJ8XFMwdmqUVwsVSLLyh_SZKEnThi.8P1VOUte0RQb_ywX84jlwEjNW16_fSTQ
 SJubSWjkac.6TWVirs21aKdXKhvWHJjMItkdgDa0xi9.ZbqNrMZAhKWXMWZMQFiXlLRzq23qjVLJ
 1LRfML.lQMKFvYDLnZAYKlqEOczsjug_53FipBBnsF.JXsKhO40KN
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Apr 2022 20:55:19 +0000
Received: by hermes--canary-production-ne1-75b69fcf97-7lp55 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8d1b4e2d8871487ec86e963c3b1cd982;
          Wed, 27 Apr 2022 20:55:14 +0000 (UTC)
Message-ID: <8bb21e2c-0c09-86ec-13a7-3e316c145ab7@schaufler-ca.com>
Date:   Wed, 27 Apr 2022 13:55:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v35 23/29] Audit: Create audit_stamp structure
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-24-casey@schaufler-ca.com>
 <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
 <CAHC9VhRzJKAARW1rnUMu0Y6RVo_uq=i=Jzh4LmA9grtQ1W2C1Q@mail.gmail.com>
 <26eca0aa-111a-9473-8925-e4b12cadbd79@canonical.com>
 <CAHC9VhQQysL8aEt8w5G-nemJzapY-Q4pYKn0TCdnVjpuiTKqhw@mail.gmail.com>
 <4ec176c6-1f66-3951-f40f-1eb0d5b66a09@schaufler-ca.com>
 <CAHC9VhQow5MaC0O-YJHxXh_=SR5eo3+97pznVyUq4YhkTuBBmg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQow5MaC0O-YJHxXh_=SR5eo3+97pznVyUq4YhkTuBBmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20118 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2022 9:02 AM, Paul Moore wrote:
> On Wed, Apr 27, 2022 at 11:49 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/26/2022 12:18 PM, Paul Moore wrote:
>>> On Tue, Apr 26, 2022 at 2:58 PM John Johansen
>>> <john.johansen@canonical.com> wrote:
>>>> On 4/26/22 11:03, Paul Moore wrote:
>>>>> On Mon, Apr 25, 2022 at 7:31 PM John Johansen
>>>>> <john.johansen@canonical.com> wrote:
>>>>>> On 4/18/22 07:59, Casey Schaufler wrote:
>>>>>>> Replace the timestamp and serial number pair used in audit records
>>>>>>> with a structure containing the two elements.
>>>>>>>
>>>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>>>>>> ---
>>>>>>>    kernel/audit.c   | 17 +++++++++--------
>>>>>>>    kernel/audit.h   | 12 +++++++++---
>>>>>>>    kernel/auditsc.c | 22 +++++++++-------------
>>>>>>>    3 files changed, 27 insertions(+), 24 deletions(-)
>>>>> ...
>>>>>
>>>>>>> diff --git a/kernel/audit.h b/kernel/audit.h
>>>>>>> index 4af63e7dde17..260dab6e0e15 100644
>>>>>>> --- a/kernel/audit.h
>>>>>>> +++ b/kernel/audit.h
>>>>>>> @@ -108,10 +114,10 @@ struct audit_context {
>>>>>>>                 AUDIT_CTX_URING,        /* in use by io_uring */
>>>>>>>         } context;
>>>>>>>         enum audit_state    state, current_state;
>>>>>>> +     struct audit_stamp  stamp;      /* event identifier */
>>>>>>>         unsigned int        serial;     /* serial number for record */
>>>>>> shouldn't we be dropping serial from the audit_context, since we have
>>>>>> moved it into the audit_stamp?
>>>>> Unless we make some significant changes to audit_log_start() we still
>>>>> need to preserve a timestamp in the audit_context so that regularly
>>>>> associated audit records can share a common timestamp (which is what
>>>>> groups multiple records into a single "event").
>>>>>
>>>> sure, but the patch changes things to use ctx->stamp.serial instead of
>>>> ctx->serial ...
>>> My apologies, I read your original comment wrong; I was thinking you
>>> were suggesting removing the timestamp info from audit_context in
>>> favor of using the timestamp info contained in the audit_buffer.
>>>
>>> Yes, audit_context:serial is no longer needed with audit_context:stamp.
>> Thank you for catching that. Easy (I expect) fix.
>> BTW, I'm not supposed to be working the next few weeks,
>> but I should be able to sneak v36 in before the next merge
>> window.
> Enjoy the time away :)
>
> FWIW, this isn't my call to make, but I would strongly prefer if this
> got a *full* run in linux-next before it was merged into Linus' tree
> during the merge window.  For example, get this into the LSM -next
> tree at -rc1 instead of -rc6.

I am in complete agreement. There's too much Murphy to rush it.

