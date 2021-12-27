Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE05480513
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 23:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhL0WWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 17:22:45 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:38451
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhL0WWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 17:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640643763; bh=PMjSN1kNjApqigGpTMB1er2Q4CVeitA18g8sxu27rQE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=n3sAE44LADOHn5Rg/ifAQchsg3uPPFUDTrtuKLVTmLb4Vhoc5IOr9pNfWr2Z/95v69slKO4aRzK6XPpQzBG4J0++TxzHM6mnG8PlzuwMHDZ9ExkM8Buio2An7wyoXmoT50HTIvIpThtH1cYXxgC+JVXCyj5XA+YOjgoRrOHPsA9i4EkM/7tITq+DKCYf74KElQUsZ7H5MGxymW67LXq3mqwYNe/PmHnI1aT34VZ4VkifOk1IgQ+Eo8G0RVoXzblKc2lDN6iZgks/skEHzQjU4P+VSoyxsFjWHMF+mxJWrt3KshEcjOVeofi372OldW6eZdjJo17Q1Gj6xLSRt6dFGw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640643763; bh=xgudXLyxfDm/H+HFw/Bif2Yq9OYXldm3JxMKwH45RA1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=F7Ya1mWk0c8utUOuHk83jn/fu+e4YtWFEiuJ+vXbGXLDjMjmW/eXu4GQ8W5NRqy+FanmKX505Zh7j13KYhBEXeTtZj59rGsBeHP0OSD7neReNI1SOt9DzKRElCE/2pCdRAirOzIQxkrpT64pGGaJifec/1L1CCwAwvZiBepQHEdzeKoYPa3mGbj/Dha+edG0WjXz1KCL/VAb8DqcTq1rgmrMCiqqj2eGmItYlhC+yro5DXlhfZcz6WCsgXLqiExkQU69NQgOxbtvWd4mNZpwG85Zd2IUb4SwZOKrMjN1oIPo0YntezjfIJhds2EFHIX3mHf4aT7+CvaKDpcaYEZ4+A==
X-YMail-OSG: 3XWJ_rUVM1mtAkshZwSoDmesgFtcASWMM.iBpVF9JVIs7Z0f5_tXxwO0lUII2s4
 llNuqydT5oLxUG98SBeZiSKNxHnseLcU2ZgMpbklciCGgpI6NENIpTbhmVP.KSORR7B4RyF7S69E
 GYUTjcKai5_jBuGYawR1JJEGmdC5pB_Sn5RtKR.40p0t7J26yN_9K8tYgdUpFjUXH0aoL0USveG9
 vbhqHm8cm_m.qmzctYMqnvoE_C8oS8dNzed7sgoLhWatiWorNqgT51ePb4dLmKziPg_VtX.bvyc8
 vGhoiNCZqP8Sw27QWen5szCUg4M7NTgxVFJMQUPCUM3_SsnpJikosCriwSBpN8TBC6wgrIZd.RpT
 HRSH9Hh37XFL66YDTcsdPCGep0h9FhL6XeLUdD8rlkLiPUGRCuCxhG98WE4cP.mX8sz0MhDsBRoo
 Kol0NiKTA71n1iZbALvZksaPW_jUQx3mpL4aR9ewd5OanXM3gp0otS_1C3vhZ6CigUFgfJRt_jlz
 _8y2Vjx4dQwAVjwa9aU5kHvRU45U168iz6KYT9fudrikWkW4sNOJjDR4mlMuFQzM7tEPtrO5ONdJ
 OOs3nAc7yFbbQAt8DOsOta2cMV2Dj1.l4erFumzZan8cQiQuWk0LxUn1iBc4PIwmeJ2ef_xrbIvw
 P.JX4W4VQVc6gs6GD5tFjMiJfgOQ.NlRkVtiPTbvPuwTnUJ1F7SyUJgqqTTwTOJG4nsLzh55.4WQ
 DbhG9GnL0TbB3qXdvUiDNIOv35_PvGbF3OTFRvxkyEdxiNWWqspZhDRJnHJv_mpZFBf8Rajxpk4U
 jtl.E4O.FQLhsaG8HOH8QTVcZBjP_kLr169fjP2dosRmL.gwg8dCqGHOlRbXSrZvdfEDfVoGY6cO
 t2g.SrsJHg_2ub_ZEzB8YAl__gXf0hyhIzhBC87O.Z_QYT_wUuCgwEe2aeQMV9UNJPoS7WEAZ2.N
 W0cKmbhTnpl7S8HIwppHqyP.tFw8AZMvUxOMUEprzz3mLU5_1mJ0COv1k08TNjeZzahpOK0GBDlq
 IoM9lim0ezylkf7n8JyLbWL._k3TKdkDby3CNmemHhtMm3TrYQbSDexqSwjymVUV_.NnpZddr0JW
 hSHUs3lcW4OWZYUDH5X.F28Q5OA7YspEYR7.eJiinIy.5YQtdKra8CpWuFZg8_5mLlfnoSytNWxh
 3B2Gg.proFr4skvBU_Hxt__4khtplzMS2KiW_B1Jx_ex66LZ771wLjC4JeSbWwPw_d9_t3h14NNF
 34KLeGY6LOwBSPLkoPsGAfYzY62puYu29amKAA6TixUg9AmI1Q86wv95UYQes.O1zFj9FOeKWdP0
 Frp7PZ4B9AlWe8ckfHLukwyZKQ82Sr77GYsKLnO0whDLhSsVpDSFKZOhGiyiFzywfkJ8WJjSF2iG
 Cx.iKx.1slfbp2cFBocMqoJHQi365uezF5VHW5q.T17.waICRQbEDesdzvJk7wPI6m0FKWLtyq7B
 YuoFyMqv8Y28RNaUoHBPtvHCVeWMHeQebiBE0x0GTJ2CcdBTn7FOIcoVHjUG6E0lTIzzlH7bo5Jm
 g_S3u_QFJb8rP7lyxUCXIu0vi9xNCeLNzvX8DKFBQI0FrHQbS74hGSnE.DWtIHkJKpcHEe0K11v2
 f2NtzN7gUAp8JGSiU.l.AW9QxLT97_vd3UV5Fx7RJQeFvtAzLG9HuBMB5G.XTfw_expd6Eluj5VG
 fzHdnzMaMDFC2Ere_PO4jTgsa0HG0i0DcWj_P14n3O5yOKR4OsRmTMLw5._6gzjOlQYiC4v4CKsR
 lgH1BfDzcvJ5F4EHtU0LEEqh2h8BxjbNo7O4suBIBAIBxtEeeqCE5LOYQspEx6rIPJgzRFHChQw_
 cPEeJNtK71lT4JnfLD47bj2_r.c9jUZ7P60.j5T6wp5dNzpMiwWcErcHvUNFclBTAXGvo_SRlctP
 jngQYYHrGaPpoBpbKlXY0IZXnENhH.kdUIg4DLTzGy..c3dEkQ_iNC0avXSAdkeXvZitjE0.iEis
 EDgctsE4dKTDL8pFkeQ1CSS4pmJ9NzQvi06WU0bG.DUkQPCF.0RmRP4Hs3PUp5Lu4WqO2RCShRSs
 YwaUi8Lhe_TirfPdb8hfhim2jyZ0pbEf4HenMoTtcTS9e0nHnVZcw9gNlkqGSWwQBMjTQvggx.YG
 SZdzsZXhtOz96QQNxoreFA9eGDktTugdIOb52oSvdoLrNbHFKKt0Mws20_T1.G0QAkz_gFJtmmiH
 6haK_9EF00P140FSAyQ0jfTDnB3HRoM0JzXaGDgJ.0P6djlDxEDDcsP3M5LQS
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Dec 2021 22:22:43 +0000
Received: by kubenode534.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ea8660f447881654084117e7f2494ed4;
          Mon, 27 Dec 2021 22:22:42 +0000 (UTC)
Message-ID: <7d1d7682-dd19-1b8a-ee5a-50fe6479589b@schaufler-ca.com>
Date:   Mon, 27 Dec 2021 14:22:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v1 0/2] Add capabilities file to sysfs
Content-Language: en-US
To:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211227205500.214777-1-flaniel@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211227205500.214777-1-flaniel@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19498 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/2021 12:54 PM, Francis Laniel wrote:
> Hi.
>
>
> First, I hope you are fine and the same for your relatives.
>
> Capabilities are used to check if a thread has the right to perform a given
> action [1].
> For example, a thread with CAP_BPF set can use the bpf() syscall.
>
> Capabilities are used in the container world.
> In terms of code, several projects related to container maintain code where the
> capabilities are written alike include/uapi/linux/capability.h [2][3][4][5].
> For these projects, their codebase should be updated when a new capability is
> added to the kernel.
> Some other projects rely on <sys/capability.h> [6].
> In this case, this header file should reflect the capabilities offered by the
> kernel.
>
> So, in this series, I added a new file to sysfs: /sys/kernel/capabilities.

This should be /sys/kernel/security/capabilities.

> The goal of this file is to be used by "container world" software to know kernel
> capabilities at run time instead of compile time.
>
> The underlying kernel attribute is read-only and its content is the capability
> number associated with the capability name:
> root@vm-amd64:~# cat /sys/kernel/capabilities
> 0       CAP_CHOWN
> 1       CAP_DAC_OVERRIDE
> ...
> 39      CAP_BPF
>
> The kernel already exposes the last capability number under:
> /proc/sys/kernel/cap_last_cap
> So, I think there should not be any issue exposing all the capabilities it
> offers.
> If there is any, please share it as I do not want to introduce issue with this
> series.
>
> Also, if you see any way to improve this series please share it as it would
> increase this contribution quality.
>
> Francis Laniel (2):
>    capability: Add cap_strings.
>    kernel/ksysfs.c: Add capabilities attribute.
>
>   include/uapi/linux/capability.h |  1 +
>   kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
>   kernel/ksysfs.c                 | 18 +++++++++++++
>   3 files changed, 64 insertions(+)
>
>
> Best regards and thank you in advance for your reviews.
> ---
> [1] man capabilities
> [2] https://github.com/containerd/containerd/blob/1a078e6893d07fec10a4940a5664fab21d6f7d1e/pkg/cap/cap_linux.go#L135
> [3] https://github.com/moby/moby/commit/485cf38d48e7111b3d1f584d5e9eab46a902aabc#diff-2e04625b209932e74c617de96682ed72fbd1bb0d0cb9fb7c709cf47a86b6f9c1
> moby relies on containerd code.
> [4] https://github.com/syndtr/gocapability/blob/42c35b4376354fd554efc7ad35e0b7f94e3a0ffb/capability/enum.go#L47
> [5] https://github.com/opencontainers/runc/blob/00f56786bb220b55b41748231880ba0e6380519a/libcontainer/capabilities/capabilities.go#L12
> runc relies on syndtr package.
> [6] https://github.com/containers/crun/blob/fafb556f09e6ffd4690c452ff51856b880c089f1/src/libcrun/linux.c#L35
>
