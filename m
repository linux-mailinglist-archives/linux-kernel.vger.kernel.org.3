Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3872B4BACE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiBQWuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:50:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiBQWuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:50:51 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D621F1CA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645138232; bh=T6iIX5BaPc7gwjH/n3Sbd0FM25joVDFZqzT9x9ttF1A=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=o0PDKaXSivRXm1uIaeyxwcI0b5GGTlwZW6W5VhE13K57+EXDEItvi6daI6I92FXJ8f+tAopcDSqp6PI7ZoxLkof3gdVsKiuxD3/o2sBcKtmVkZPwNfKIhavbGHiGB4mpwmJIHsSWc3jVKFXNIFudK3N8EKmB55HMTLtJuekERoF3NrPLkxyRm6QaZ8HO9xaD/kG93y+3r2AE43noZnfOOnmYWqJay6yMgkxXCzTagw0fPJajn2KMcDlbp4+HVZp00VksZA6DR0s7p5DiEC1KQDrV4lsJ2JBbTVKG7v61Jtz6MwhQW14mldJ3/1Dy0T1YXcSj4gPNO8uVUFablAG3rA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645138232; bh=udXRKLBL3VoowDWNGoLAdXT0d+BUivcwM4F4nnEYUuk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qIc+AU5ASGYMdt1cEEVjZLMCwiunyHqxjW6yrzw6zvpKlNJyW6R0n7QQg/ywr8hG08DRohPHgoAxzHt0DVgwH+8adfmV8x7zwJdgVEWOYNe5tQ/8pNgzPi0xFzd617tmtcG8wWkyfbDz954bZSd2bOAl/92qayGHmXLRFkQ0Hq83vmhsJ29luPBwdOcxjaeATCYPmoXlGOVUuANMrdV2TcEP1TZW++yO4JTExeR9kp7FBYWBfH5L06p236Cw3DmW6cUwL/XhZtulIFTveKYxntxhDvuhAIHOySnOf5eyrLQ+RkvRBFbl+2Dn6OE8GmB9ff0NmZMkdlzyyHY6HEC5iQ==
X-YMail-OSG: 3bFJBTMVM1ksQUwkRIKxlkVJegxkUYJhhcojlviV55Z6Aj9L7HHtTN2kwAzivmB
 S4kI78bKp9Wzzxcmyz4TUVoLn5gjmphv.BI6jdEEo7jCxdS1kN0np3R_4L0e4qOI75uhXZ5JP7nO
 5.l4IqRsZ0zbO97q6OjDkxPtFHp5OAaMhdfuMyHJVsiNQEMXsn5rxJiTtR5jSXvV7fegKL2G1sA7
 7mpLZ2dZPZx.9pF8Do6UJANCZ3juCEk4e81298bGVDzYU73KpXTfjRJF1I36P8vz9ZH9bF_kP4GB
 l6mBBEf2Oydj2yobqN_56.eHJOwp_uxpHE9MC8CRw08tpvVf3389u_TrLv7g4Y30k7K8WBrn7Qfk
 T9wrmQmN4rphgT4cAhe0ZaDj8YDXNrgSiZCDtTelSXt8gEa1Clk4qe0_ZRjzhqjcjftNkTsQlX08
 1kCgRXiDBMWhshHx4zxdlm1EQ3t0kaonG7UIC46MlmZ5dIh7TW2X8SXAm04JaiTq8_5C5mmRI58R
 ikdNruq7enSeASxkocSLtoz3nlR5YJiwoGY4.s8gKE7ESy901cS66L_1H_yHyVzxHUwZfw8sAVv2
 Bp1GMpV6uRDFy9.j5m6VESB2_ZxdfP6.sd_v6KvjtlbzlnQhxihcL36ltc2PSzdTWCcjhbCbL.KY
 Q5Z.R8SmvuRAogp6m.e4DRdkDyfGRj7gVzNShB0jE5OyJaTT50Yvm.5zzUsfVit3BEbCKRvX9JQB
 CzW13N84btSlc79FdaegHfih9ViaYI1.QP7VMan9pLOplRFJ.7s5FLqQNJacoHUYP3UtDAO.tqB6
 8yrfeGA9IuflGKsO.Y5OkDhTk.11inNyGCpciyWnVcqoJ3vS0ymkH.r3PvDd_E2oxvyq.SD8NuYm
 EqicHJLBot723GRjix6fMfVUiF5mEzxFcVUWr5hu6IauB22sZMPc5esr.oMEsq_sWukd6ur.ZjrW
 Y6NyAj7F8CH3vFh8b7IkumdaoYOQt.Fs9YeUbDGJYQcuLN6AdIMt_rPqlsJ6awek2v8MCfFn0F27
 etSgEZSBSwHaU.VqXTh1CsdT4pxQN5iiOAjwQMJTnV0OOVYsO99jWcj2D1h1103gjmU1KVLzcgF1
 9LxFprBQfS0cjk_cNM5wm4JhZ.SZdyhjU9.b2vx4bBQS4qUUt0twT08ec5Swj4VDiAmKmcmc7puT
 Z5XC_eBy4x4.ofs4Fp.eEvYr1bG1Y5xv7qo4bOKsrroWBcBCX0tGLouQNI8eecnebcoZx71As.As
 jCFRkYew6uNT08nIYEXAmgy0d9FLwTV0sKTImIXXeYGRfruNovKM9mGOOTjRl.4LK3JMSOi9U2v7
 a4C1oZdh18cakEP3RuuX4gEdWFo0I_wyDcr9wokpfZ80Q3rSXHB0Wu9FxbRiCMKCRkuWVNgXUWZ_
 OsDpHCyiTM3yqESXZaypmEYaF7XvC6KsS0lMkkJFoJqYFuCfupCdsA6LgI2mrOoCV9A1Dgd4ERQ.
 Rn6h91G66yVt_bidnVtN3b8J5aC3S6t4UggoUaHEYh1G9V5x3MJzPYuRV16G92eYp2AjMfk.PMcg
 L.ztd.0LPP_5od7nXXAn.t8ioLelnfXzybONSTwKDZtZkXmZuAeh32RkQndLyT4rUeUmDB9RIaUJ
 sUlna_FCLmshZZK_D87JswQYsDRe5yFhTsXghvflOzroRjWYtA8I6JpPhSYR3CaPOzdDp4Nku2Gs
 fCG.HZ7RLpDKWeYGW6Uc2.R_fL.NEtc9bOOstg6IwIcMbFy46j0v_pT_25UU.QpokBokrYsfHfAU
 kBZJ14EKRwyC.fM0uUYXP4PobYH3IHl2N6dn7Qkh_shSmSVDduxvpQfmP_GdcbQsWuT867DpiR5H
 sJGKPM2dSuGIij8K7CbYbbsq4BzGHHZ36wHQV0wHkU11SYn9aB0BY8N4y44qhRlnQNN4CfETFvTL
 k6WEZxk67lnihW7vqYtZyIM66t6dv7sToSOOpWFDnkJisXdMewDlqXyfFuQfGxmwmwbBkKVYFBK1
 7hy2OkAxondz_AZqUxSna0s5gYY57JjAx1g_kNV.HFRSw4sTaL1ai_j0NRkG65bW1E9NHDpFoTCU
 CgVEc9DXnz8dwuCi_QaDLGLMMoRayGToLHapN.JmEbiwarEsAcN6PcIVQXkdDS_AlWhxzSJv2c9t
 D1owhCNtA0wf6D3KGH_5EHfdINHi_SA5MXkfXs_qI6QYv_Gv9COPD0wvymbCiaeRPKbIn.os8j2T
 yJBa.ZSofirfn.8sBex07_yguwLBDiVeDbQc6.tCjuxVRLIkRQUhKWEpCSdCBSNxoCBBIiY1m9Gp
 Ny445
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 17 Feb 2022 22:50:32 +0000
Received: by kubenode518.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6b34b34f702f3dd48a8606ae65e940d1;
          Thu, 17 Feb 2022 22:50:26 +0000 (UTC)
Message-ID: <41224e84-2da7-3f69-0fdb-bb309ad6a3d4@schaufler-ca.com>
Date:   Thu, 17 Feb 2022 14:50:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] security: declare member holding string literal const
Content-Language: en-US
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Todd Kjos <tkjos@google.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220217141858.71281-1-cgzones@googlemail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220217141858.71281-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/2022 6:18 AM, Christian Göttsche wrote:
> The struct security_hook_list member lsm is assigned in
> security_add_hooks() with string literals passed from the individual
> security modules.  Declare the function parameter and the struct member
> const to signal their immutability.
>
> Reported by Clang [-Wwrite-strings]:
>
>      security/selinux/hooks.c:7388:63: error: passing 'const char [8]' to parameter of type 'char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>              security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), selinux);
>                                                                           ^~~~~~~~~
>      ./include/linux/lsm_hooks.h:1629:11: note: passing argument to parameter 'lsm' here
>                                      char *lsm);
>                                            ^
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>   include/linux/lsm_hooks.h | 4 ++--
>   security/security.c       | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 419b5febc3ca..47cdf3fbecef 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1595,7 +1595,7 @@ struct security_hook_list {
>   	struct hlist_node		list;
>   	struct hlist_head		*head;
>   	union security_list_options	hook;
> -	char				*lsm;
> +	const char			*lsm;
>   } __randomize_layout;
>   
>   /*
> @@ -1630,7 +1630,7 @@ extern struct security_hook_heads security_hook_heads;
>   extern char *lsm_names;
>   
>   extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm);
> +				const char *lsm);
>   
>   #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>   #define LSM_FLAG_EXCLUSIVE	BIT(1)
> diff --git a/security/security.c b/security/security.c
> index 9663ffcca4b0..a48eb3badfdd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -478,7 +478,7 @@ static int lsm_append(const char *new, char **result)
>    * Each LSM has to register its hooks with the infrastructure.
>    */
>   void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm)
> +				const char *lsm)
>   {
>   	int i;
>   
