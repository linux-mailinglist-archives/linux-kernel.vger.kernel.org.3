Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276F04953E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiATSJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:09:57 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:40038
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232336AbiATSJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1642702196; bh=RpKbOUBqPqoxbnyP6odJcyOj3qk0N00ED3xegLWnZdU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=kzlgmVLO0lstwmpyT2DvzvHdrgO1/BfKW0uzJz+XN1UU7FI+X4MgA8YuMGccHFiaJMDWMovqK3ZVSKuS0KDIA6fd1tKUGMJFfgZTA5rUs47gvtI0GnqygHV09n2Yja5WBPw0Ax0aPNgUIKikRXBtCws0jOmhmfkHP46+Vl1TqaLk3onngCdJj1Yop+Q/kU4f0WXhj/PdLmwpPJSQggd07NpqYerxWQE0Gre3BmjmBkiz6XQH9LRGp4dnmz+4pBqeCBuBvrxySyaQW1SDPK12b4J8WwOFovsC8XGFm5Nkhv82Ro4f3hWFR6yzRbDPZMxyiW3QqojrpgLpL+K+4xsfmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1642702196; bh=pdHftM5rh9oWaQ9zhW9zp8LXboWN3V+OqB2MJnDG4Vc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=eq+Hq2/uZbYTVzyVG3dPDzfUba24sSY8kKCjpK99fOIbh1K7gdtorpm3zWE8J6MEvh6SQ0pON7Zzc/TRKC0sNoW0pZXzaqt73H/wdOa9id/Kd19xPO3Xb9NH8P+ww0Ps3AK9cgTqKQb7c9bi+tExdf7+myahrENCvFVglU+6o7RyGSihbklgChWpoXFeC7epVwpF6dqZDIfdceIRZ4sH02jPyVEothNU4dVABwzBLpx7PHU4rTrZ1Iz1SAYLWC+rl47rwBpYUWc41T8VP2YGf4Qi/+pRkAqk8T0dQSIeKpKuCMIej11TRpk9DhgcQBNJW1sD6DGn11SSIb8XYvDRpg==
X-YMail-OSG: .0.4HVAVM1k5R_YvpAT_6BUd_UVfts7qd5yFtYtGqYIl2Hn.8iityHCDImbpenI
 r5eTzVbiQZvgKHr2U0PBjZRBiYUJtZPSAISvxorNK0RDACugCWdoKV4AayTzFHs50mff1GTptLWA
 3PED95FRrxsxzhf.P.171kkn8Tekz.ev3OSD1LfI8cET1xsn8TK3cYgCYdHz4SSQZ7NJTEEb7R_1
 LGO0f03lSUwPUbxVkninMsayZPXEjMdDdEsRYGcVaN0avp4J.4ViGLcnRO9j_eVL7DS7tldJ073g
 sduryN8tT.GLtlUykwb3m2L854Hl4BwOutUqsgrAUgZTDWPZzxbmfzx6wnEmXU_Gee.IFdoVTSX9
 5Mjkw1X2BUlxd.2RNL60C.Me7T6zCNH5YNuakkQHyT5oReLggcIPlYD_KbAYshFxtMDmuen8zh3f
 aVY6mlL7Rik0r5YJDwJUD4TYYw_vHY4OGZYJNcxJ26CUQiw3ab3YNcO6Z_Y2wK21XIZ.K.Q6_z.7
 S3Alj2YiX3.uSd18QVGCxg.Y8ZNbWrUTQTdL6yHKQrpaApdNNhdmcH_edt.U_PqL.c0LQ_E1uwGV
 98779qtLaeOfG9up5514dok4Q.l6z.LeON59_F5.kb9Sr27hm81C652IyrAPhzvh6zW8EuSuB9vw
 etoP7DmaEZKM.WhbolrYH9pTjBKvUVtm5CGztr9sNUtVlpSz4gljMmUl6hOMjPS26yqEWuXmHxkv
 d2E0yo79ko0Cl8O5aZTfUFzWMEgAM4n0NW4a3TSDwQHb9bnoWYOVSTDagvZ98OBOTnWTbVHwetK6
 JoZEY.25K7KV4XYUvCL6oT2875pQcPY9pXWaVsR042Amkl0WmHcPRV3Ptjtw8eJwx_rfm_MAARTP
 YTDpB26jiqKFHOJEbxyQaFjOypv85dZHDqR_p5xJk5lWHyVuQPSCaIrRuj3V9KLpTefHqsHKFJtw
 JqOUIOC3v63ls7Kzb_Tl2_8qP_gTmwFlRYK3C0cbKP9ssWjkurkOj9hP51DnvCGrCsMDQiNVBHv4
 5ODWUYLZcPV6v94uWzjGFo1zgPYPzGH0URbPcggqdhP17Ks72.NeTvnn6smDaAssheQDMsgbwJpr
 kjXhKhuAZsIMW4jV0yljPkFCTnvgsP.5fqrmfuflN25fBc8hpmZzRDAFHxma9JjZVH20_5OLVRiP
 qwIi.UPE810kK7NZl2PUjXEO9AOx3pm22W8p70O1Us9LfGv077jRtv_P4ZTJfxFjWRfwc1XPnbSY
 PUxNjS4lQksT4yOkQkUQZSw5wr9vG9uhz9AGW3PfpRfMTvh1FAfTS3P8WvSjClExY9Gi2Dx_kLNk
 bf2an1mH7nOgWpYa3hN3Po0GDi5JrOZExo0YCLl5gnVxxTlbiw7U8Jlx_DCwcVl2APoiNX9Ier3K
 rnFGGFjC1f7Qf7ffCHW2WkML4.6U1LI.DJKNq.tsrC2BggmfQvysAsQyETSNQLiil4zye2ApJ530
 lMcYV0fOX7xYt65ZzAqR3qpur.WF9lOkhQFdxQsw7BfRG2HQQv_SYHI16qsZnay.XqYH5Xx8tJ13
 LWoxl7gTrUpy6P0hYYxybWWHaakpk8neyotpbfIPgPOP9T.8jLrh6LOGeIBu6UBs8di9KOfXSwr3
 yRmwOmhBO.VcEZmxj6cb6uGzdZoBcubOzcmjlCeDgSe._.GzLIGlx7DOEeqMdeVrpY3oWPcrOvZm
 0Qwa2GoNioUBFOG0JEaX8qGhz74kv97nqNZ3KtuwqXSh6DndaqDwrzjTptcXOpDn0U2iZMkCNyQI
 V4Nkp9NeEJpVf.yDfDZQoHxyDaNrmF5BdOfBt8JKeh0pY.z7U4TWPOpxLr5GNTJZWAoZyC.70.vj
 57oErWVMZFC4kdZNI24.Wwwt07a3j94MefBkz6LViQu.fpz5KMt.6yS2V.SB8OHcgkQnteIJYJ94
 rZWz8zy._3kIT9h3EyUj7LaOlNyebvXuFoAgFIVsyJJ0g1h6z1OxRuXTf4.PBHMDMKtJ1SsEZU4k
 dx1XDinH0PK7PdBTiKMBDaZGkJCmPFZJwyrKItEwxiO_BFoYTl0oQQkljWf_CQ39B6ou7K5znEDA
 rxs7vaEGl1nC.Zu_eGkzpUlwQYPrEJT4Fl2VfIWsIjpwwEf2GjKuSMUESvEx1NPeesxkuFiiF3vJ
 u2ZClwBiB3xrTr6pY.HLPKv2rOc8z1G9m_9znQVHI4bI9qFKkFm5ojhF6mib0ObpMURzRttRUNo7
 ch8fa6LpF69RcC1HrdDEzWg5FEZy8pvBrdWVbtG.vmN5bBvklEFi0UtNLnQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Jan 2022 18:09:56 +0000
Received: by kubenode506.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b5e679d038464819c66d7c1668eb00a6;
          Thu, 20 Jan 2022 18:09:55 +0000 (UTC)
Message-ID: <0c3b5f66-1550-3b67-c5a7-c452ff463b30@schaufler-ca.com>
Date:   Thu, 20 Jan 2022 10:09:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v3 0/2] Add capabilities file to sysfs
Content-Language: en-US
To:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220120180116.167702-1-flaniel@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220120180116.167702-1-flaniel@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/2022 10:01 AM, Francis Laniel wrote:
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
> So, in this series, I added a new file to sysfs:
> /sys/kernel/security/capabilities.
> The goal of this file is to be used by "container world" software to know kernel
> capabilities at run time instead of compile time.
>
> The "file" is read-only and its content is the capability number associated with
> the capability name:
> root@vm-amd64:~# cat /sys/kernel/security/capabilities
> 0       CAP_CHOWN
> 1       CAP_DAC_OVERRIDE
> ...
> 40      CAP_CHECKPOINT_RESTORE
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
> Change since v2:
> * Use a char * for cap_string instead of an array, each line of this char *
> contains the capability number and its name.
> * Move the file under /sys/kernel/security instead of /sys/kernel.
>
> Francis Laniel (2):
>    capability: Add cap_string.
>    security/inode.c: Add capabilities file.
>
>   include/uapi/linux/capability.h |  1 +
>   kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
>   security/inode.c                | 16 ++++++++++++
>   3 files changed, 62 insertions(+)

For the series:

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

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
