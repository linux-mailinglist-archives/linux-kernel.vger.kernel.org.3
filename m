Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B353C511E89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbiD0Pwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbiD0Pwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:52:37 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com (sonic309-26.consmr.mail.ne1.yahoo.com [66.163.184.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9575541A6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1651074562; bh=Y7LuXCXCj4prJ+BaAZCbNYn2yB8vuw8uDwfrZ9Al/T0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WEFQxOsjgK9Qr14KQqgE6/iuLTN1c2D2302f3Gv+ox2DJgmFt0saZfjwL6YaMtDEBTUpYN+Z3v0akLllc2F8bvsVN/+xqG+dlW/CrKv7Gl4LXOZxwSkEinoG+u1TaoxWuCAmoVfWvBwDvp/aRwDNf8s6j8juz33zlortve0DN0utgvk4GmVD8MKdxP/9fZ2aqOn1ARFAmKsYTZ+aTVauXlNrctaHNiO33GVFxo6vvo6/FQB/olk4QdARTIf+J+IHvmNeRft5NM8EtX/tkkx9QrX1mQMHgccqxuu2loH5/vomxDNdveVLiqonBN1Qosdt7oOVcr1VSsgz7JBl5RXAlw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1651074562; bh=LfNP/Qkgqg3VwuBXkXlNnSryf6SR+YNHoc/bHqszSMM=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Sy2nm+635RtR5FvBR827xVAINX1dZZSvjeNSZaQUlNVKvCMvhLoTx3Hnc22GHhDEbr1xblZ8Fbi47lX/lmuA3VUUio7IvLIIVq3o6pl74ai+vsRkzY6lD6NIqe+lNumVRDQGqGgORTJM7m/NyF4q0HcUXQi+y8xvXgSa+qD559/iLb4lS70of46HZ+GDJmUgh0xJZk42/I0cddU3d6w6kwv+dmqlrerieUdbsNigpNy46cGsyvSUoT7+P4jNpi0nUS6xnFPKCIEoZ8t/E7FM03IPtznfo0r1rnTCHETEmhwtbZhdUwTxAhfvi7iBaMOgMbkQ/pJ3w7rsUguJnaZSuw==
X-YMail-OSG: 3dg1ND0VM1lM2wC7bNxPXYC6bl1XvCfyaPuiZoCDcoEu3t05QQC5tWYYX2.6sQd
 _1jmOW3URwaaw81TqpYX1yThXM80pQYkEvyTF1dGOkAtp06ZHKlupz.b_x1gLfBNlRNEMjRZEEOF
 U5qwOqXf5I1SpZAYSitxke8U1OHt.kGvSqO8kVff..7BKLlQsuib5zAystgPszQBeCpvv9aG.FrE
 SDmxTfQWPTbgTUDiquTQIyB4BdGLd3jN6ngksIUnxf.hlYRQ4Gj.LEC4psHBNxfCcsiqkPeqW4Wn
 SOrmmLq7M0Uei28h1P660d.64uOnBKEtubr1vLPFjdfJn3tJF.y82s6zwnFe.4JjMe32QXI.Z7c4
 EF.Em_M.Dgohzm9.V12d0ip.0g8amSVO04HMBCYDgAlEBgqxX2JdcWXmgBXg1qBL0Y1anu8jcdoq
 KXKziUwlre0ZbNxWbR4sv16Z7JYJrSFyd52UW6NXwbF3FjW38jCTnmOL8kjyWb1j70SihnmO6SMQ
 OBc0XBuX3AGwh2FEEeeYMtS_mQVJGdgOPC62o01GQR2GYmmKd3Ojmx.JmHrLpLaK.HeWaBiR88wK
 oqH5KvJ.l0aRoldDuq_wuSk4EDUSA60aZR1U6h5Qy6VpQ3lSTHU00Hhu3zJMWmEy769NB0dt_Dnx
 XkM7a56AjuUi7hH.sdk6pIWpU7yfPGCdj0fjLKoeYzTJWmwVP4OE1nyIxSTU3fkqBaiUFmzZ24WL
 oPPtlx3vhkAQqxSsGtlLtPXeNkJ9mfEVJkbtU0xNwyNqV4TOBYQ6W4xwbkOkNUrcGyvWu3SKqVqW
 hVreoBql0SARG4xQr8rOum4e5nblzEGWP2xi2cvZL.e5bGsweqrSJWyfHc8c_tN_k5z5sJi9KbN8
 bwVnvoXdE2B02KcAIgYYjjrvLsJ7S6XilSHkohBOegy.5TQF4Iz5.P_qxJ9wp9Oklx4Kqh8g8kCT
 RyDYtvKGuRTjbCmdzhgJl7u0z9kleJZ3ZX2zbC6HNE64loLZNaITJj.TBWD6mc0OfT6bQiPwGptQ
 hGkILVRPx3knAcO_FSRR.KmbTy90IaUpvVMAU4F.bPiZMGFJuOjBy28cQS9BUGWtlEBb5LKVXgba
 Be3pJnESr6KF5oNjaJsOrJ0UD.afeugUX6F2q5l7MLWykwhtXRi7aWEkZzXebWrKzFMkfTMekItn
 EokAjDKkCCs98Nm4cUOCMQL8Uny3cymn.0ROwU6XhselhFGGciZOskS4g1KINKXAYOGjg3jvHHK5
 A55lF5yDm00AE1ov.tIYUP0DzL28U6CQx4Fcf1S2H4sL7Yre7Ch4LjaqyjxmowBiZY.Q.6EIUEfl
 6Cw4dMrm6NyOxCXp5.Y0Xb1APwf6KSm60fSeryUfGeGgeqP43QNVKMJ19y5tyBC.8.SQT8Zula7V
 VZyjnKlI7ZnJ3Gf_4Nr4_nH7Hg8qMk6ieiASg7OUAfunifrj097x0JrE65v4zJ28TbyDsMDvdkQi
 JgILc3NHiJ9kX6ewIZ9MM7XMDN6n8Ko_.A8LnLu4Q1j_GPrFqdV.dwGqxu5o373ZG1VGCNzwIJIZ
 _RGl5EpkeJgOUC4ZDqn1OFNiuEfr2DK.Y656DnfxEiJWK2A2KDRtDjMwnEXftJ_HkUNNcUSeS5AV
 xDIa47PrQAOqPMfJjYB.aoHPZn4qIXM0Lr5q.ba8KPhNU54kZEaMsE3sgoBYZESKfPdeexD3lqcQ
 Ga0n98zVfngQSvqZkL_i6fuGWkoCzuJuoJML_TSbZlTJkfDjHlrJD36U_WGnYnw2uNvB14LNSCdz
 04lUsGRfJiXFmno1t5Owyqkc6wgzlUqtAE7VoYl3nxg.iTn2Yi10moeXYHhsA5vLk6gs5z6g7CPL
 9r82BGBdplrsEhD2c4K33qXxbzYKCcTi.MbfvM.hfyMYvvX.b3PNw_.PT2wK4K63SyyiHZVy1PJC
 kl_9OOXZvGkEWPf_e8ielxDNzRLMntDOfI5EDEDb2Xaewdcaq2SEAhojoWTcJRpRUw8KXLY34TeB
 Kbx56.ptUCw5QVFZ93FYxa_3yCdG77veQ15VcsrdJ6_gteEalxzu3Y.BTRpLK_mgxO3qtZpUH0_D
 D.nwAfL_FaVHntmx2q3mZEhV18UVVixFYTUuHNbgul6S_Q9Lx4.2cWdqE4DTCZxDLdWBqhn1d_K4
 UoB9EtNIpfcKBX5nIFAsLYrJZKTWkuOF3z3TfijCAxrFA6DPzdAKAlI1ql8D5BY27XsLUbbg7wG6
 0iJEKPOygevOuMfxuNmcunOxMP8PikDVmiDzF6ioLfK.1ZmRi_cuxRgouKbBS_vGST06EuRLnRDh
 8TRBbmWdcCwjExzPnrhoRLl8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Apr 2022 15:49:22 +0000
Received: by hermes--canary-production-ne1-75b69fcf97-h6f5j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5cf646cccb8d779f95f2cd60c8c8f25d;
          Wed, 27 Apr 2022 15:49:17 +0000 (UTC)
Message-ID: <4ec176c6-1f66-3951-f40f-1eb0d5b66a09@schaufler-ca.com>
Date:   Wed, 27 Apr 2022 08:49:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v35 23/29] Audit: Create audit_stamp structure
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-audit@redhat.com,
        keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-24-casey@schaufler-ca.com>
 <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
 <CAHC9VhRzJKAARW1rnUMu0Y6RVo_uq=i=Jzh4LmA9grtQ1W2C1Q@mail.gmail.com>
 <26eca0aa-111a-9473-8925-e4b12cadbd79@canonical.com>
 <CAHC9VhQQysL8aEt8w5G-nemJzapY-Q4pYKn0TCdnVjpuiTKqhw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQQysL8aEt8w5G-nemJzapY-Q4pYKn0TCdnVjpuiTKqhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20118 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/2022 12:18 PM, Paul Moore wrote:
> On Tue, Apr 26, 2022 at 2:58 PM John Johansen
> <john.johansen@canonical.com> wrote:
>> On 4/26/22 11:03, Paul Moore wrote:
>>> On Mon, Apr 25, 2022 at 7:31 PM John Johansen
>>> <john.johansen@canonical.com> wrote:
>>>> On 4/18/22 07:59, Casey Schaufler wrote:
>>>>> Replace the timestamp and serial number pair used in audit records
>>>>> with a structure containing the two elements.
>>>>>
>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>>>> ---
>>>>>   kernel/audit.c   | 17 +++++++++--------
>>>>>   kernel/audit.h   | 12 +++++++++---
>>>>>   kernel/auditsc.c | 22 +++++++++-------------
>>>>>   3 files changed, 27 insertions(+), 24 deletions(-)
>>> ...
>>>
>>>>> diff --git a/kernel/audit.h b/kernel/audit.h
>>>>> index 4af63e7dde17..260dab6e0e15 100644
>>>>> --- a/kernel/audit.h
>>>>> +++ b/kernel/audit.h
>>>>> @@ -108,10 +114,10 @@ struct audit_context {
>>>>>                AUDIT_CTX_URING,        /* in use by io_uring */
>>>>>        } context;
>>>>>        enum audit_state    state, current_state;
>>>>> +     struct audit_stamp  stamp;      /* event identifier */
>>>>>        unsigned int        serial;     /* serial number for record */
>>>> shouldn't we be dropping serial from the audit_context, since we have
>>>> moved it into the audit_stamp?
>>> Unless we make some significant changes to audit_log_start() we still
>>> need to preserve a timestamp in the audit_context so that regularly
>>> associated audit records can share a common timestamp (which is what
>>> groups multiple records into a single "event").
>>>
>> sure, but the patch changes things to use ctx->stamp.serial instead of
>> ctx->serial ...
> My apologies, I read your original comment wrong; I was thinking you
> were suggesting removing the timestamp info from audit_context in
> favor of using the timestamp info contained in the audit_buffer.
>
> Yes, audit_context:serial is no longer needed with audit_context:stamp.

Thank you for catching that. Easy (I expect) fix.
BTW, I'm not supposed to be working the next few weeks,
but I should be able to sneak v36 in before the next merge
window.

