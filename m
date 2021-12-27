Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFF0480515
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 23:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhL0W0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 17:26:36 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:41048
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231671AbhL0W0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 17:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640643994; bh=7CCPramJaXebVg/EN1lOxho1hU6rhDVryhwAn0+xCi0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gpsVP5snQBHx8OmUzK5aM//dHjWx2SSaTlHWsVwFlkqHHJkQggHYMOhG0RQsXBpTvMQzgVqONHOBuE8OLoY/sU4E41OToskcMQ4AxSLy5KZ39HndYxNhXLO+dCai/or4wyE1tPDbAO6kSUKrqGksyOddq20jeqqkD9pEnZ2VVfdlH2RSCPyC8KL4qfyH82cdBp9gegjL2uFqPcfmkoGcyr1I9K3+9D1/vFrFR2Cvoyeo4O+A9EzcpxqAgdZQQOhGkbutY8tS+xXbIRVoQNTjfuhOJ20b+iqKw1RvRYRS1ZK+VZmfF0bHzruCaTgM9Qg+rMkwZzQyfjgJzB+i1xIhrA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640643994; bh=3ff7sWpwVNpTtcnHZ+3oiNW2zgvkJzYn7nHHZr+dy0E=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jwcHz609BSNbSuGtunJEAyTF4phoRLR46CFNeWLzwfa9BuofhW7wwMICFjr06oFyzTqFKzM2vcpXdkUqJ614hISxmxNiETSrXU2xsAf4/6d2gF6bYnk3dELKCC97GmFIL3ObU8cwchodpZWw70ZZxNCd9DJrvjG0DiFqaP1dCyKFGxHM2TlBP6qs8WxYT8b6VqfVqET7qYNH0gDLOMJRpfUajibjrPs8P8y1jaBTX65yS0jLN/drdwBxLtDD72cHnbI7C4l85Jmjts00dSgJmk0EVdcbfbFwPnPtoZ2yriKztejjTwJgZOLOMxwf6AdZNkHE601BNn/H3FMBdQ/i3Q==
X-YMail-OSG: 7Ooy7E8VM1lzXRRKfvAjr583GeX96V6c5m_SYk6gbZx6PuktOBxsUSIPW5swCDa
 DtFGrPif.SOxAORbbmqm_tytFQnRHmxnf34tzZyltO0BbvrYDjd_8SHBZLSaDGNa1K3zX5Cn6tSG
 perOvPLoyt.zOMVV4gTE7OUKoY8qXMF2mx9KOG9I4YAJXeZNMngV6iOLYeLFCt3B7xdlrxKprrmj
 cTVaMm.1XTC3X_rlipqrU0gHcRGVwrXy0UAiq31ojTr4OGqHDapMmtmGMgFmelOeW2u4v.BW8aal
 N9zNCshUWFQNJSAiijMjzcHvB5JSRvL5oL6hRMSG_PJ7pMxuuqBAV_UL2fvAZzOsUcTSTgksl9xc
 EAVe9ORyAnBce.A65CAyw15n5b7VBj38pogf9dPaYHEiSkIZadiEoxozj0pHIx4XA2yAJaQBl_mw
 aUy1CMHlxxaj1mbgxv78qW4mRsuYgwmOvnsCW6m22Sgya_2YXNUduCo2316IAR1pYgjVf0uHb5Tt
 B8jBIO5qZEnwi0fDn72jAJE3OBMQH_heAr2YfpZwBdLIdh3BWuJv19ISux6giEsXna7LNemCxhQL
 PF57KySwj7fY8VaHqPKvNQS0r4XqX9XmAimA0lrwcKAvGcYDOUMRJ0w4I2Ue5LUgqFe_.pnYFIA7
 b7nV4hY.mj2P4zfHR.fvdq_khk27xSlFv21LY6J3D3xnm252627qEhinRZyxSfBxJSwF2O.Svx2I
 5.mZpGVRdAKZISAJ8zGOUU6csWEb3T54g12zBMZ5gt0xiBp9zhRIjc8Ob9qsNU0AnvKuo_uPH1yS
 vqXj9kZKuzdWDEnRRBhELbKbyI2P7WrO0R_u2jyLV5WTR5QnYpIOQWz1bxZ7xz3Yg85kmM31sPHS
 d7zMMTyZwQldVL7SjVfz0EVSsDM8MDzO_kJelRbqHJUyWw.jSItXOYr1xp.8gSSz2WQI3m1wEYKr
 CWpB6KvjoqVdKwwwG2Xw5FGBCgVKV6.VuKBCa3e7RMOaj7fZ9nlgZcyeEY2s2l6htOqjyXfzlN9e
 xcRdqVhe_w0fnjYwiBSSwgoXaQGkDJR._QuQ82DpVRSw_AnN7tkUXCmun3JEi0_VG5WhHe79pEYK
 4HrQ3dwzuNRMpBEzPt.JuVLepWmws9llqgRdg3bvRNsyNDzagm.2SsHwjZTsjaxm1H_gLVj0aTPO
 Ow9ZEBY7GeTmn6PO4OEAliTSZeVRYzLwAZDpNiM8q7uj6bE4AQUsgoJHKrFOM2Iy5gQgFORoxdU.
 9UMN.zFaie.53ICsAb8iJ3Ub92GvjvmLKXst2JssR2..9CqBUHh.51c82x0nFF1TiN8QeYcBGiiD
 ovKJMv21J2QWkk1EMHhyj7Jg93uU9PzukftTaiJ04uYZRPxdJ6xcpHhV0ksUCeQ5eIYqn_4bo80O
 o2qfBU.dlSjaxHKXSfAlOmX1.NSxivSIk1Ua0sTcO1pzKbR9IsSfdvx2MgxTSBQMUta8nZJ1gGp8
 KzFgQlyCH5WhctqkZHPrmy5LAk.2mLzOJQsllvxdR82vf1pGT0sU_xDAuzZhwB3rq2sW3L_T28Kz
 SStqprlLZoC4J9r0ndt_OqGgr3mATlY.ErCXKBdGhuGMleXrxCCdRKR_YadyuKOnRyNM1jcbGw7y
 UIgP5pzfSXuoVmbwH7C_GZdB40EZ.B4a1WlxVKkqffYyuLaUfnJ7q8hyR75SJDN7.flnpIU4ynsh
 9RsiijUyudFKzswPoiX99eXQwl5vLdzChTdWJHYv59jPdI1VG8xjJ0jlNtlStGGSDxrbz7Si5ZyQ
 f.22ZHqYGHE6l3obOaDSlhvIvAjeBpYpZqmPdfAznvEnUA_yMs6fIg9aCYSKNNXucBQp.F9yMVQr
 t5bea1Om5XDhN4fGOgcoYeHtbqcksuhi8DM36kOouZMm5vjyBaU0avanx6wbe3xYy9mmJ9qB7DyY
 TMz3mKjThjFP6ceBiY7fNLnUiUrI4bmPcUboL.1JeRRF82CpMHN2bmSBaDtnzN1Wn90H9QKOUxRk
 Doc_JuinBk0OYpFL5W8qj6FMqYJz3M40BCLBCu04Hl3_w5eGw2fa_p54LygoDIHvKpvOoOJfAHG_
 1In9kDP2nu1kiBYwaEjlwWFifbmePuIrPbMZI4vrGreK9eOnPBROyW2Yk8EOmmsb2Xu7e_yOnif2
 VTgxXtklokWLZN1l6ejhtMO4csZxHXJMfL2hnBi43kqBzRySMwuCssW.ex54pVZTVIuDcAh3HSxX
 eO0gUDb5jO8Zupg5cFB9gFkEkze3lZiQqKLAW4i70fcRTN71yfbCbNKrK0FjFOsWGuQsV6w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Dec 2021 22:26:34 +0000
Received: by kubenode524.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 50fba0bb209de5a486803f3bf10897e4;
          Mon, 27 Dec 2021 22:26:29 +0000 (UTC)
Message-ID: <289c4134-1ac4-48fc-58ec-cab0bcb63268@schaufler-ca.com>
Date:   Mon, 27 Dec 2021 14:26:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v1 1/2] capability: Add cap_strings.
Content-Language: en-US
To:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211227205500.214777-1-flaniel@linux.microsoft.com>
 <20211227205500.214777-2-flaniel@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211227205500.214777-2-flaniel@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19498 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/2021 12:54 PM, Francis Laniel wrote:
> This array contains the capability names for the given capabilitiy.
> For example, index CAP_BPF contains "CAP_BPF".
>
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> ---
>   include/uapi/linux/capability.h |  1 +
>   kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
>
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 463d1ba2232a..9646654d5111 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -428,5 +428,6 @@ struct vfs_ns_cap_data {
>   #define CAP_TO_INDEX(x)     ((x) >> 5)        /* 1 << 5 == bits in __u32 */
>   #define CAP_TO_MASK(x)      (1 << ((x) & 31)) /* mask for indexed __u32 */
>   
> +extern const char *cap_strings[];
>   
>   #endif /* _UAPI_LINUX_CAPABILITY_H */
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 46a361dde042..5a2e71dcd87b 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -15,6 +15,7 @@
>   #include <linux/mm.h>
>   #include <linux/export.h>
>   #include <linux/security.h>
> +#include <linux/stringify.h>
>   #include <linux/syscalls.h>
>   #include <linux/pid_namespace.h>
>   #include <linux/user_namespace.h>
> @@ -27,6 +28,50 @@
>   const kernel_cap_t __cap_empty_set = CAP_EMPTY_SET;
>   EXPORT_SYMBOL(__cap_empty_set);
>   
> +const char *cap_strings[] = {
> +	[CAP_CHOWN] = __stringify_1(CAP_CHOWN),

I may just be old and slow, but why is this better than

	[CAP_CHOWN] = "CAP_CHOWN",

> +	[CAP_DAC_OVERRIDE] = __stringify_1(CAP_DAC_OVERRIDE),
> +	[CAP_DAC_READ_SEARCH] = __stringify_1(CAP_DAC_READ_SEARCH),
> +	[CAP_FOWNER] = __stringify_1(CAP_FOWNER),
> +	[CAP_FSETID] = __stringify_1(CAP_FSETID),
> +	[CAP_KILL] = __stringify_1(CAP_KILL),
> +	[CAP_SETGID] = __stringify_1(CAP_SETGID),
> +	[CAP_SETUID] = __stringify_1(CAP_SETUID),
> +	[CAP_SETPCAP] = __stringify_1(CAP_SETPCAP),
> +	[CAP_LINUX_IMMUTABLE] = __stringify_1(CAP_LINUX_IMMUTABLE),
> +	[CAP_NET_BIND_SERVICE] = __stringify_1(CAP_NET_BIND_SERVICE),
> +	[CAP_NET_BROADCAST] = __stringify_1(CAP_NET_BROADCAST),
> +	[CAP_NET_ADMIN] = __stringify_1(CAP_NET_ADMIN),
> +	[CAP_NET_RAW] = __stringify_1(CAP_NET_RAW),
> +	[CAP_IPC_LOCK] = __stringify_1(CAP_IPC_LOCK),
> +	[CAP_IPC_OWNER] = __stringify_1(CAP_IPC_OWNER),
> +	[CAP_SYS_MODULE] = __stringify_1(CAP_SYS_MODULE),
> +	[CAP_SYS_RAWIO] = __stringify_1(CAP_SYS_RAWIO),
> +	[CAP_SYS_CHROOT] = __stringify_1(CAP_SYS_CHROOT),
> +	[CAP_SYS_PTRACE] = __stringify_1(CAP_SYS_PTRACE),
> +	[CAP_SYS_PACCT] = __stringify_1(CAP_SYS_PACCT),
> +	[CAP_SYS_ADMIN] = __stringify_1(CAP_SYS_ADMIN),
> +	[CAP_SYS_BOOT] = __stringify_1(CAP_SYS_BOOT),
> +	[CAP_SYS_NICE] = __stringify_1(CAP_SYS_NICE),
> +	[CAP_SYS_RESOURCE] = __stringify_1(CAP_SYS_RESOURCE),
> +	[CAP_SYS_TIME] = __stringify_1(CAP_SYS_TIME),
> +	[CAP_SYS_TTY_CONFIG] = __stringify_1(CAP_SYS_TTY_CONFIG),
> +	[CAP_MKNOD] = __stringify_1(CAP_MKNOD),
> +	[CAP_LEASE] = __stringify_1(CAP_LEASE),
> +	[CAP_AUDIT_WRITE] = __stringify_1(CAP_AUDIT_WRITE),
> +	[CAP_AUDIT_CONTROL] = __stringify_1(CAP_AUDIT_CONTROL),
> +	[CAP_SETFCAP] = __stringify_1(CAP_SETFCAP),
> +	[CAP_MAC_OVERRIDE] = __stringify_1(CAP_MAC_OVERRIDE),
> +	[CAP_MAC_ADMIN] = __stringify_1(CAP_MAC_ADMIN),
> +	[CAP_SYSLOG] = __stringify_1(CAP_SYSLOG),
> +	[CAP_WAKE_ALARM] = __stringify_1(CAP_WAKE_ALARM),
> +	[CAP_BLOCK_SUSPEND] = __stringify_1(CAP_BLOCK_SUSPEND),
> +	[CAP_AUDIT_READ] = __stringify_1(CAP_AUDIT_READ),
> +	[CAP_PERFMON] = __stringify_1(CAP_PERFMON),
> +	[CAP_BPF] = __stringify_1(CAP_BPF),
> +	[CAP_CHECKPOINT_RESTORE] = __stringify_1(CAP_CHECKPOINT_RESTORE),
> +};
> +
>   int file_caps_enabled = 1;
>   
>   static int __init file_caps_disable(char *str)
