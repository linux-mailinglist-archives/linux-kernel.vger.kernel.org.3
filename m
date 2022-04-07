Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4FB4F750B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 07:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiDGFEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 01:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiDGFEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 01:04:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B5A2274E3;
        Wed,  6 Apr 2022 22:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649307705;
        bh=9b4Md4MYesGBOCKdPFfjC1F90x94GBzNXqnzdUTVZd8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GBHR1ClBeHf+LIalxer3RZT3wCCEvSnqm+KOEefnvUKNWFZg+GZ7WVdiAp4HB1fna
         8xWixhakAklSvEiCMBoD/Dp69XCsBWoFrSF9UJ8dEDmvnv8oKuHjnTgqd387MjT9ns
         Vm6HMaWvbB1U6QN5uRsqolBE2IohofxjCsrkBom0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1o32G80QpV-0108Gw; Thu, 07
 Apr 2022 07:01:45 +0200
Subject: Re: [BUG] hwmon: (adt7470) warning when removing the module
To:     Zheyu Ma <zheyuma97@gmail.com>, jdelvare@suse.com,
        linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMhUBjmTObCwaF=enLNkRSzxqSzK6KdkHf+4cWo5fqOO7B40iw@mail.gmail.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <5f3a3672-6b99-7e24-9003-443c571f2dcc@gmx.de>
Date:   Thu, 7 Apr 2022 07:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMhUBjmTObCwaF=enLNkRSzxqSzK6KdkHf+4cWo5fqOO7B40iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:F3RHcOiHphE4QAbvUpOKlf7XOPwbz+FGcbxA5BdUpH7CWGhES6I
 eSQDih/kvSA8JjEw7KybVOZ2e2H30l59sljCvAYIKoThlHJTwzEwq4pzI7lGn7DeX5HX9DN
 IbRamr9iiLp1VVGCThlrFwGQgGz1HT3WP258BNjXnBoEfGZmUxQXvwacNMAC0/V3eLGZCEn
 E4JfpSKQd41zIsUYXnF5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wFm7vKDxtio=:5DAjUG1UoiliBiTTl8a/dm
 IYuGe0oEW6IahwC5l04DAXpDoOjdkAMQ4EWAj69rWGAJTdlepLziwRcGyT391pn0YbnI9GWrs
 efNOThZHFvrlQIBOLf0keKqkGjeitXW02YOj6BPltJxDJs84cwIyzPDo/0PG55SLkLq0DIfTP
 dmUmzWAGu7Cvg5GoEC0fpMKuZhYmWG8bH/lKF/8qJPbF1QZqiidbIg6QZF9o9ftp7Hl2QmRiX
 UdLS9OAmMjD/qGHdDEmQ32feptZj4vRQhQ/KaJRwaSg9qDnfLcbkjO/ayrMjWwJGxSvu1XMrF
 VbrCod5AvP2h+Y7Wjo+97zMhDwXHg+TRZ4pyGOBer+Z5vxAaBvT0bBH8PiYDRrSPMLYjRDt1u
 AijSw2TKZQ5WyC2/Se1V6mvR3D3HSvN1H6+yW+eYi0gTNIQAM9PIae8/MY6vq0qZl6wh/xYOg
 EDtpQ2DHv4MyPZNdWgoJzMtQJnHXAZTgoXrP5OwmAPgaTgivZZ3F+dZlHlv3pMN9c0xcXFVqm
 xB3VsLz6SFiF/aFP36tn/3EMaS+ffhKuIa94zCy97VOScbCFFXTrmBRKn4syMEtyvcWKOWURI
 XOU5UZbm9AE/Kc9AmraeTnKzqFV+mlKmhw7yApg+p5AedaRCb5Q9wclvPsrAksViX2anKXo0l
 RCWw1/kAZ0itv/QF4N92PzbmiRXhg56+X4PClEfw3bUXXds5gfF+NjpxYFizcVNCLWS5WF4i8
 WxBLkyzAY4JMWTevikrBLgMdkVA/aGohMDNHIvC6yboHIkBqnAZUfGn5+BWjw/VA16JBUmxOv
 CnnKWX1grmaTG0K2MvwLMPO24lNHF7Nk9eH+mWCIMiDr23uby4mzR8RoSvCULggpHdk3JuhHy
 1kCca0oLFPt6QRMAM5GKrEI7q3IMsS99VS7Cp3qwp9+o5DKeWa/yjrEoyCSavs7MpokJsDQlm
 QeBq1jc2Og/pQUoVnqRt09FgBcMzThsryoCT4fWy/xv4guDKF6Pwot4kAyZuuekLSbmMBYYwo
 /sLFWr5rw5JqsB36Q6LdSVXOBW8IHpPrvhA4boWSiVyuxLB2SutC7pDuHLtp+5EEdjLy1NBn+
 jUFH0wCacsTHQc=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.04.22 um 05:17 schrieb Zheyu Ma:

> I found a bug when removing the adt7470 module.
>
> The following log can reveal it:
>
> [   18.459479] ------------[ cut here ]------------
> [   18.459852] do not call blocking ops when !TASK_RUNNING; state=1
> set at [<ffffffffa006052b>] adt7470_update_thread+0x7b/0x130 [adt7470]
> [   18.460857] WARNING: CPU: 7 PID: 365 at kernel/sched/core.c:9660
> __might_sleep+0x96/0xb0
> [   18.461523] Modules linked in: adt7470(-)
> [   18.464568] RIP: 0010:__might_sleep+0x96/0xb0
> [   18.472577] Call Trace:
> [   18.472778]  <TASK>
> [   18.472957]  exit_signals+0x2f/0x3b0
> [   18.473251]  do_exit+0xcd/0x18c0
> [   18.473534]  ? __mutex_unlock_slowpath+0x1b8/0x740
> [   18.473927]  kthread_exit+0x42/0x60
> [   18.474212]  ? adt7470_detect+0x140/0x140 [adt7470]
> [   18.474622]  kthread+0x272/0x2e0
> [   18.474885]  ? adt7470_detect+0x140/0x140 [adt7470]
> [   18.475277]  ? kthread_blkcg+0xa0/0xa0
> [   18.475601]  ret_from_fork+0x22/0x30
> [   18.475901]  </TASK>
>
> Regards,
> Zheyu Ma

Please correct me if i am wrong, but i think the issue lies in adt7470_update_thread()
leaving the kthread in TASK_INTERRUPTIBLE state when the second check for kthread_should_stop()
returns true and causes the kthread to exit. Since kthread_exit() might sleep in exit_signals(),
we get this warning.
Maybe moving set_current_state(TASK_INTERRUPTIBLE) below the second check for kthread_should_stop()
would fix the issue?

Armin Wolf

