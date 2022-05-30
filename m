Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA6F537494
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiE3HDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiE3HDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:03:34 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38129703F7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653894208;
        bh=jESFkxCn1y9t+0yhV/nWIM43we5orHhIHFoWHUhDPwU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=FnB41CnKRnJKeyXTwVEU5UOMNePiadt0tnkj7cSzkxZdv+bEwvzV6Y2fXGFWqTTvA
         KPnMzZd50HCLB7xnlcmMWvOVikkCYpl0x1bnsZH6bLLryZi0lL8Ym3YRcqmiafdznT
         d35yIEkO6vArTRcoW9DJeWcaFyWkFgoOl0YhE6lU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [100.120.193.22] ([84.17.52.175]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9G2-1nQLEU1cXe-00oD2L for
 <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 09:03:28 +0200
Message-ID: <dcff1b34-8cd0-9369-69a2-13fedd7e96fc@gmx.fr>
Date:   Mon, 30 May 2022 09:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: PROBLEM: with daemon.c after y2038 on 32-bits Kernel
Content-Language: en-US
From:   =?UTF-8?Q?Arnaud_Pana=c3=afotis?= <arnaud.panaiotis@gmx.fr>
To:     linux-kernel@vger.kernel.org
References: <trinity-3d43505a-735f-402f-8b14-90a32b289a0c-1652773898430@3c-app-mailcom-bs07>
In-Reply-To: <trinity-3d43505a-735f-402f-8b14-90a32b289a0c-1652773898430@3c-app-mailcom-bs07>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Antivirus: Avast (VPS 220530-0, 30/5/2022), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:I4MD62Xj+QoAn+8/Rui4w0eBAMosP7q5KthNpuj27HRyx9fmN4N
 y4ilEtWmoTfcM8ldvZBN2TzcaCwG0NsdDGNZizKFTWbofTEK7z/AuMrLSp9+4KC1KBgVixJ
 foNMZ2+So6XC3PXU2ysMXf/EOrIbq6yeI1X8n8x4J4HFDCE2VVhl9EI3C+wT2uLiB9HqC7s
 WkQGrhPo/0YPkqrg8SgKA==
X-UI-Out-Filterresults: junk:10;V03:K0:mOfarJtH5zs=:eTrNp4+YbQZnbB4Gei+mSJb7
 KV3ppse44jlan25xZxcoB41AynsGrICS805mIdhDScxJ3Ix8qtupEuPGVgMjVdgMtxQCuYvZc
 lAi9aSXkrGTJqWbzL+948YqlEEQomE6aaq86WnuY6ruWgK/nzpRtAQpAZ0/TxlTbiiLYRDczb
 rcB1sycvhn75xO8iX5tdEP3STRyq9BZDV2gkblWi6Zu1eXOSl1l2f2nw5QpoqEL6fiuTOHAr/
 20dpwbIFrc+LPzPV17YzY40t6jYmYCDg6WqUld38TrYzRYkUJp2VXXoDBd1D7X1VC2/I889Ht
 WmAFIiF2gLTcezaIHUo3SYCKy/lzjMOqk1fbtcbQvCmEBT7wYuwokhSMO8QdF9L1hzZAU6tF5
 pCpPO0aXHgRksAYqRhmxHNsSiJmwfHIgR0jmm1fXmPcXO86B48xyQRY/sbhwfXOuhHCmBs1Hj
 drhftMvW1ke2Gi7Rv2vi+fEchIYTN5UFHLOV0kpLguz4iUOsIIRTuAO/t2/LYi51GuPyr29Ob
 4SieQ/zfV2SzN9TaDVqa4rIjeCZX4bVYdgomz+CsGtVzQw+4mofCySM07OhBt59ZLB+wH9tJ8
 RpxMuPuv8cAEbiQiaYTZ2xpuAYOW0nZ4AzgeH/THxefIVa2SIv6ncP4fMqg9T2lJmmswiAWKx
 U3alCbqpTvbecd30KVvCR2NeLXivnj5WCV7uwHu9N8AqZiLO7LWQSevPvp7EE6503BIjEb92j
 2mwxgcNH4Osyx5HfP4lmOyu/+VekgtHSb2C4QPJzw+KrrtVvOTNxy6ZvqKy3QaqJzuA69xb5X
 wfwjCXBFMb8EivssgZznHYil/x+CwNr1waUo3aBpY4ah8xkRxqhs0b9Vhr/DnkTSj99yfsT9e
 ypQn73w9XzZcZybDHvknxZ4hN4jqgDuwjLceDIq6y+X7t3pEsVfVovvLjA1P5129LKGjr7jFB
 giaF2MImWQ1qoxWV+/zxvb5B7BxqTyWs/NY4I7KFH10Uy4WH8zR+3tNUerkn56UjVLmTRyi6m
 8CDF9OwgZO6pjcSlqhhkDOfcF/jW/K5hDN3CHUA/42VuLRAzDppMRKWOYji2CwSVWkd8nSOkS
 Br2GZPVUJnapTz1DU0XVFSQvmxBYJIwXg9CbWi2wDdOneZiTUFitq4w/XdgZJlURbfpL0E3DI
 /dI29tSzmyBqk3W+sejeK+Fj
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_CSS_A autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I send a mail for this two weeks ago but didn't get any answer, I'm not
sure you received it or if a ticket has been open.

Could you provide me a feedback?

Let me know if you need more information.

Regards,

On 17/05/2022 09:51, Arnaud Pana=C3=AFotis wrote:
> Hello,
>
> I'm working for a client to generate embedded 32-bits Linux Kernel worki=
ng after y2038 issue.
>
> I generated a 5.15 Kernel thought Buildroot with Coreutils 9.0, GCC 11.2=
.0, Binutils 2.37, Glibc 2.34-9 and CFLAGS  -D_LARGEFILE_SOURCE -D_FILE_OF=
FSET_BITS=3D64  -D_TIME_BITS=3D64.
>
> I encounter an issue while working with OpenSSH (I initially contacted t=
hem before).
>
> After 2038, /usr/sbin/sshd does not create an error but it child does ge=
nerate this one:
> daemon() failed: Value too large for defined data type
>
> This happend here in sshd.c:
>
> 2019         /*
> 2020          * If not in debugging mode, not started from inetd and not=
 already
> 2021          * daemonized (eg re-exec via SIGHUP), disconnect from the =
controlling
> 2022          * terminal, and fork.  The original process exits.
> 2023          */
> 2024         already_daemon =3D daemonized();
> 2025         if (!(debug_flag || inetd_flag || no_daemon_flag || already=
_daemon)) {
> 2026
> 2027                 if (daemon(0, 0) =3D=3D -1)
> 2028                         fatal("daemon() failed: %.200s", strerror(e=
rrno));
>
> To reproduce:
>
> # date -s "2040-05-12"
> # hwclock --systohc
> # reboot
> # /usr/sbin/sshd
>
> Note this error occurs only after the reboot, and setting a date before =
2038 also require a reboot to remove the error.
>
> strace and gdb trace linked.
>
> Let me know if you need additional information.
>
> Best regards,
>
> PS: I had a similar issue with binutils cp
> Discussion : debbugs.gnu.org/cgi/bugreport.cgi?bug=3D55023
> Fix : sourceware.org/bugzilla/show_bug.cgi?id=3D29097
>
> --
> Arnaud PANA=C3=8FOTIS | Lead Developer Freelance
> +33 6 34 82 12 62 | arnaud.panaiotis@gmx.fr
>
> 18 place Jean Moulin - 38000 Grenoble
> APsudo - www.panaiotis.fr
=2D-

*Arnaud PANA=C3=8FOTIS* | Lead Developer Freelance
+33 6 34 82 12 62 | arnaud.panaiotis@gmx.fr <mailto:Arnaud Pana=C3=AFotis
<arnaud.panaiotis@gmx.fr>>

18 place Jean Moulin - 38000 Grenoble
APsudo - www.panaiotis.fr <https://www.panaiotis.fr>

=2D-
L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=C3=
=A9rifi=C3=A9e par le logiciel antivirus Avast.
https://www.avast.com/antivirus

