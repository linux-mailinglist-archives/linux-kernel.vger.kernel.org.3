Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506425523A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbiFTSP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243978AbiFTSPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:15:15 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3801A828
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655748911; bh=h6STTI1UnnL+/N3bGacK6gIQvLl45g+igMgXSobAa6k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XD/2KBFQ1Y/36NnnFX/REkiZDBGikafJXHNS7cO0UsjWZA9uKbik4wwkl5e7EjAeYAy+Et3tr8D82UuxrPAOUGkAo7SNbIykDUUyFO5TceIbcIIYmjCBeZntjOj5ZSBcvfw1ldCjG9H2DQII0FZEnNx7KAfmq58P/DSiu4ziFtJmY1bQosgXSJDfMyUWrFFysGDxqXspSUz0huVlN2p3lES3IolPTOv49npDQDLH329jv5pZJ+gCePc4qNO/LjVByndiq4VCIECat5hm3iEobOJVM6ODUQ5CAvDwd2JXLTsjMPhmk2WcVjJLNXCg7rl320CyLif4pMTp2umhKh4Mtw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655748911; bh=YEF1FrjC7NXSFSdeBmelWh56TfJ25Qfhl3bgWMGiUva=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=J/V5Fj2Q+NfnJ1ib5oE5CxmxWIvd5CM+7jZqZ64y6q4ruHy+6lwNXIhnF469TC4bc/PkyOnh1D/GdPuQG6dxd7aWnDitz3UR4VUS+Qo6YksKJtw9xMQhqoS9sDsmM2Gp2ZDB6D3MO5igGw14i0D/0iYggaKfCtygQL9gDsfzUTwPBjBsZ8L06Eubu9d9djN1Jed3AzOmEhJD5hF/JGyvbu/+NkWd9OMl1X7/UJfQB+AsvHrkLHP39RXJH4t7uvLMjQ1Z4toG8immy5iRuRAkITWAw72RkyWR0I4CIVDKEIGPOMs2r8vIsb8EmTTE+RBBpoi/GbSKQOR3bzXwyiaLFw==
X-YMail-OSG: o8Gq5L8VM1lPUC8VL_bF9qPClxoHXmnPoJUA60LINBZ33qRP8DTLQZlqJsEZpuJ
 CMnbrbw150KXQYJHk41w3tn7D9RIoYgW1GZH3hdhV8dviUfWCWRyoD7wo1aBMOlb3BOLc1FyGbA9
 Ac7jlXRqozjITHXhZu77cs6LBM6kPjeeAnShH10Sr1oddrvbPCnSF_7HG3xnhZwczW7AvgdU6YXD
 gUJe4sRYyAkXb0cHN1wZwSEgQZuE8jF9AtGrUDPuFMwdl61LptZoYr3VYtyf.8i7u4q8rsP7sGyx
 Qlwahhm0GuY_1otpWcjLL2IbqKo53.x9pDtqYWMyzuC4bvYutPRWmWJftuKJXH_.tyZdRe36zwXB
 xjWK5Yv_XEAa8YOKKQj.F58uE7mLDok6_cl8.hoIHptcV0E0gF8OUmAmXlH2zxREZ6hWPdhwf8vu
 sNgna6umT0j2HoPrzGXKlUwfFWtiTe5ITnObc2OjscWr0o15PjxL061lim6UEHzF3VWq6pHTXdHs
 KfmSHf08aaJY30T0anFJ_IAJfyxaafuoO_guKjMIqgp_b1_B.mHKxYTqb3D7_MjDySCCSkQ4_aeH
 fVQwIkRESXi0DDevIJDu1jK157ck6Lga_EPUtkl71vOgKfQ6nYCtNUnjfeQGzg4C71P0Ko1U9a0j
 nmp.qTRmQUzxcI1etsICGKrIvCxYDLkboFwVdd5OPX3KJ_vlb2PhFHiM2diYQSAzE8rGhYJ9g2Yb
 WeQIG0W7tiKYWvv46f43sOyxt6ovOBb07JAhiRvz29.tFEHOy4vyXPiCKGz0kGuC8ueLTGfZnI8P
 ZeKInvW.yy_Xl7NYVlHaqq9Du3aGBc3G2I6X7NLSWZn2mlNjJLnTJizI0oaeCevniKb3adQGNXFT
 ieXedJDrHOoCDqXx7e2p5KEvtGsvw0QSNOYETgxdg9znnRnBC.in5WqSsr.ftqvqBmAnwLK2Saum
 GYwzNR7troI.nWrYyEPr3T9c9gooRSEzuPxAMLBkJKjD2JqfUEBPLprc0RQSnP1tgBWI5fS5DTcD
 s.jH6OifAU7SnZd5AZDSPfFxWKEQfAGFIeRiblRc5PROYP6iuar97ShS3n91wN5Aq7FrlaM6QwfT
 dGrWsukMAwosr8PpCVa.SeZZHWDvqpWqYax5Zvw.7PpBBF_Prb3M4BsNNR0vbCmfjjZyEY473V7l
 98ZvnP7quuudvX_TYQe.AIwfopu8uP4e1BqDfPxNMns_6nZQ6jhWXKbDScYNMxn9foghYaWkdgwv
 bTfKrSrlctRySjxR3qGuoN7.TlvUkTzKKHdykczSgU6kw4o790pxAQ9W1me.mHND3zKGb8vggSX2
 x4qOFBb6cID8n63hYtscDArYzxzZdhBljmOZ8f7HEzTAU9s0JiBi83YfwErqCeYB_YgohW0STY3T
 XnwSMLLONC9aPscnNzn.Z4QHB7k1JDaRwXMu1WcQ2bNiBwLkgByATkW7l0o2N3DA1DhYFxC4YLns
 iX_NTkGqtMyUzk77jJ5tH_jUVx5K65QYs23hZsjY8.mS7f0fYlGho3_VSkQZd7NQkclhwJUXcXmm
 btnSvL.Pk12sfb2ojeE9vBZNOoYFunHW._yin11R6QdZBo17_zuM2q35eeKOg525sLYURqcqJaN0
 0R7SmwVVPOj3ACIMWZrpz6q3yOf__YtDS54gs.A1tT_e9l.k5onHMlicsGyxeF58juVuy32FHEqh
 Z0RsvmOOFA1CwcyfE_JMZXhqOxkyN2sEntn_kdL0FMUFp2w4dOgUmsO4S1_5LdC3M13jz9MdX4Ir
 VqlrCkyV7A1N9SIfw8mGsH8t8nKT03Ta2kTdjQiqamEYcH3xAfe3Hqug.r6mbCOfCEf3dG4y.jzi
 8wc5MC3YundGTIq2D4fJmfHIvagQjlbhrgFW4Cx_sDXqIUzfWlsm.dcA1gwV5PnXbPd6bDB3vNXY
 33lUOfalqAEmZ2uivNTj7KoAvBqFoJgFay.Wl2UdGwLHPyHrgIBUf9hR6oa88Wr4r0UY1OQRblig
 tFjQhIrslPdqgvzXIRvZlJQWJXg_3Q4zLJiJ0saqeFXMl_lJmgFn7Kfv.EkAHsZG8UFnvZBpVaf1
 nLBmRcAX_ZUYQ2QRuO1GJEQRzeK23aUIIRd6ZGbOYCNAZ0zNP89LPm_niaUnphmXTYHUjJokrUkz
 cAK9DQglNGQFXz8MktDVXCaOMwJAkZI7bB7_65srYqXlVMW1deNFLW8bGj03Ds05ddqNVFo9q22P
 tU3.VBMqegTVQAQ4zrJSUmzucIoylhJlRt.Pi076I
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 20 Jun 2022 18:15:11 +0000
Received: by hermes--canary-production-bf1-8bb76d6cf-44t2w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e2a7845c38f5e224c788e30894a53d85;
          Mon, 20 Jun 2022 18:15:08 +0000 (UTC)
Message-ID: <034eb96c-573e-a074-2506-99456ec7f6f7@schaufler-ca.com>
Date:   Mon, 20 Jun 2022 11:15:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] security: Add LSM hook to setgroups() syscall
Content-Language: en-US
To:     Micah Morton <mortonm@chromium.org>,
        linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220616171809.783277-1-mortonm@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220616171809.783277-1-mortonm@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/2022 10:18 AM, Micah Morton wrote:
> Give the LSM framework the ability to filter setgroups() syscalls. There
> are already analagous hooks for the set*uid() and set*gid() syscalls.
> The SafeSetID LSM will use this new hook to ensure setgroups() calls are
> allowed by the installed security policy. Tested by putting print
> statement in security_task_fix_setgroups() hook and confirming that it
> gets hit when userspace does a setgroups() syscall.
>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

I don't see any problems with this.
Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>   include/linux/lsm_hook_defs.h |  1 +
>   include/linux/lsm_hooks.h     |  7 +++++++
>   include/linux/security.h      |  7 +++++++
>   kernel/groups.c               | 13 +++++++++++++
>   security/security.c           |  5 +++++
>   5 files changed, 33 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index eafa1d2489fd..806448173033 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -201,6 +201,7 @@ LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
>   	 int flags)
>   LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
>   	 int flags)
> +LSM_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred * old)
>   LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
>   LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
>   LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 91c8146649f5..84a0d7e02176 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -702,6 +702,13 @@
>    *	@old is the set of credentials that are being replaced.
>    *	@flags contains one of the LSM_SETID_* values.
>    *	Return 0 on success.
> + * @task_fix_setgroups:
> + *	Update the module's state after setting the supplementary group
> + *	identity attributes of the current process.
> + *	@new is the set of credentials that will be installed.  Modifications
> + *	should be made to this rather than to @current->cred.
> + *	@old is the set of credentials that are being replaced.
> + *	Return 0 on success.
>    * @task_setpgid:
>    *	Check permission before setting the process group identifier of the
>    *	process @p to @pgid.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7fc4e9f49f54..1dfd32c49fa3 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -415,6 +415,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
>   			     int flags);
>   int security_task_fix_setgid(struct cred *new, const struct cred *old,
>   			     int flags);
> +int security_task_fix_setgroups(struct cred *new, const struct cred *old);
>   int security_task_setpgid(struct task_struct *p, pid_t pgid);
>   int security_task_getpgid(struct task_struct *p);
>   int security_task_getsid(struct task_struct *p);
> @@ -1098,6 +1099,12 @@ static inline int security_task_fix_setgid(struct cred *new,
>   	return 0;
>   }
>   
> +static inline int security_task_fix_setgroups(struct cred *new,
> +					   const struct cred *old)
> +{
> +	return 0;
> +}
> +
>   static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
>   {
>   	return 0;
> diff --git a/kernel/groups.c b/kernel/groups.c
> index 787b381c7c00..9aaed2a31073 100644
> --- a/kernel/groups.c
> +++ b/kernel/groups.c
> @@ -134,13 +134,26 @@ EXPORT_SYMBOL(set_groups);
>   int set_current_groups(struct group_info *group_info)
>   {
>   	struct cred *new;
> +	const struct cred *old;
> +	int retval;
>   
>   	new = prepare_creds();
>   	if (!new)
>   		return -ENOMEM;
>   
> +	old = current_cred();
> +
>   	set_groups(new, group_info);
> +
> +	retval = security_task_fix_setgroups(new, old);
> +	if (retval < 0)
> +		goto error;
> +
>   	return commit_creds(new);
> +
> +error:
> +	abort_creds(new);
> +	return retval;
>   }
>   
>   EXPORT_SYMBOL(set_current_groups);
> diff --git a/security/security.c b/security/security.c
> index 188b8f782220..15c686145ad6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1803,6 +1803,11 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
>   	return call_int_hook(task_fix_setgid, 0, new, old, flags);
>   }
>   
> +int security_task_fix_setgroups(struct cred *new, const struct cred *old)
> +{
> +	return call_int_hook(task_fix_setgroups, 0, new, old);
> +}
> +
>   int security_task_setpgid(struct task_struct *p, pid_t pgid)
>   {
>   	return call_int_hook(task_setpgid, 0, p, pgid);
