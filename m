Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446165303C5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347788AbiEVPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiEVPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:12:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA2237D5
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 08:12:44 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.95]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MTiHd-1oILX11I8z-00U1ez; Sun, 22 May 2022 17:11:42 +0200
Message-ID: <bfad3d08-3268-5528-17c1-c17ef3949d96@i2se.com>
Date:   Sun, 22 May 2022 17:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: vchiq: Performance regression since 5.18-rc1
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>,
        regressions@lists.linux.dev, riel@surriel.com,
        viro@zeniv.linux.org.uk
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
 <20220521234616.GO1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220521234616.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Q7W4EvkD5FS32nrU71vNeT8z0yPIXNczX4elRQCT4wO9DzrgxY2
 DzjPxqQNr3wRCuCPPCLQr7c3v8cdV/mCI7NlGB5xFmr1sKojnUfP2BH/x8TwfWGX9w68o6F
 yvyq3T/c2BqlBBwANnsMnCu0YEf6Jwoza3iaJEoRrDxGCZ6/3Uc1R3c88r7GIBA23FFIRbm
 2VLhewpNiQEBEvW9Il/Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g8oTkQDDkxY=:uFjwQvTOfgsxKh4vQPj23+
 2SxfvvXiyCfOzDwJieJFCPs8eOZNBycESZwOyusgJ9kpHuVvDM+r7/Un8qiHtHNirx90jag+z
 Gye/6r0mfgrQxQ/7CbImTR8BApjRtqB5ApsgaaBKPZWSrDhyZXj0keIsAZrFamg8QPOkydkJD
 Sv8O69BpsDXcD4uDVVcOHrg/mbC9+RwSNQjBIbiuhzPA4jR4ZNWgIwsMNbc3VvBtoceAh5qMU
 bDQPt9vXHwyFh2AL0hmyWh/IV6bPgQtpcYQvfo3z7ah/uFPs/nnKgUUYdmZABJp9k9eZ7p0P5
 OPhZ67laxa0Z1TY0nRtQU/LoDg/LSmCwMguWT9ipkpZTDa3XIZQN1d+5ILUIH9GgrEH8VJtgL
 UwT29qylhZ+2nBijixXkiOIObiLXApJqhC39CKubvuIG4Dp3oCz374/uV2DF/LoPmbnNtwad8
 4sHWi6K0kY65xIhkO/QULz5KOKfb/I9hxFTiDB6tEgAjRW9JrZLESek4gsCQU1ZrtcHq2WoAG
 dCdBgRlScy2Hy+evD1O9h43PtpeIDmwQatrx46T9YkaWtr/uwIKg4dlLXB3ADhv8/Mg9BlZwK
 o79msgVdgtFL9/y7AOeOLFmRhxbWSWo66SMKwm5uP75vTZ5/xY4dMOUMoVqbEno5uUiz2bkGG
 ZIGyH79RbAaX8S/1ThLA6QB87BU2mb+2DJ17prbGLzQZ5wMujrV0ydIC3NoDI0aK62VY6A5ph
 0WnBdSAhw9jZcqB5VdhHM9F0FqlvMWCHHMu5bX3BisgxUNuOhiVbirNW8PA=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Am 22.05.22 um 01:46 schrieb Paul E. McKenney:
> On Sun, May 22, 2022 at 01:22:00AM +0200, Stefan Wahren wrote:
>> Hi,
>>
>> while testing the staging/vc04_services/interface/vchiq_arm driver with my
>> Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance
>> regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
>> lru_cache_disable: replace work queue synchronization with synchronize_rcu
>>
>> Usually i run "vchiq_test -f 1" to see the driver is still working [1].
>>
>> Before commit:
>>
>> real    0m1,500s
>> user    0m0,068s
>> sys    0m0,846s
>>
>> After commit:
>>
>> real    7m11,449s
>> user    0m2,049s
>> sys    0m0,023s
>>
>> Best regards
>>
>> [1] - https://github.com/raspberrypi/userland
> Please feel free to try the patch shown below.  Or the pair of patches
> from Rik here:
>
> https://lore.kernel.org/lkml/20220218183114.2867528-2-riel@surriel.com/
> https://lore.kernel.org/lkml/20220218183114.2867528-3-riel@surriel.com/

I tried your patch and Rik's patches but in both cases vchiq_test runs 7 
minutes instead of ~ 1 second.

Best regards

>
> There is work ongoing to produce something better, but ongoing slowly.
> Especially my part of that work.
>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
>  From paulmck@kernel.org Mon Feb 14 11:05:49 2022
> Date: Mon, 14 Feb 2022 11:05:49 -0800
> From: "Paul E. McKenney" <paulmck@kernel.org>
> To: clm@fb.com
> Cc: riel@surriel.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
> 	linux-fsdevel@vger.kernel.org, kernel-team@fb.com
> Subject: [PATCH RFC fs/namespace] Make kern_unmount() use
>   synchronize_rcu_expedited()
> Message-ID: <20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1>
> Reply-To: paulmck@kernel.org
> MIME-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Status: RO
> Content-Length: 1036
> Lines: 32
>
> Experimental.  Not for inclusion.  Yet, anyway.
>
> Freeing large numbers of namespaces in quick succession can result in
> a bottleneck on the synchronize_rcu() invoked from kern_unmount().
> This patch applies the synchronize_rcu_expedited() hammer to allow
> further testing and fault isolation.
>
> Hey, at least there was no need to change the comment!  ;-)
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Not-yet-signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> ---
>
>   namespace.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 40b994a29e90d..79c50ad0ade5b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4389,7 +4389,7 @@ void kern_unmount(struct vfsmount *mnt)
>   	/* release long term mount so mount point can be released */
>   	if (!IS_ERR_OR_NULL(mnt)) {
>   		real_mount(mnt)->mnt_ns = NULL;
> -		synchronize_rcu();	/* yecchhh... */
> +		synchronize_rcu_expedited();	/* yecchhh... */
>   		mntput(mnt);
>   	}
>   }
>
