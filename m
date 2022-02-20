Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686BF4BD06D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244447AbiBTRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:40:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbiBTRkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:40:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF84A933
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 09:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=EckknzTJPePJ7AVQbgzij600jcq6Ev9RgRVrMRsi0t0=; b=KdFVsLjkGsu/dKZjdWAftVo7kP
        ik1Rf85xr2LpzjrazMEjVQ25cmaos0JrdM3DAh/PGdA8GsIPt0M8TKMaYo0gCYLPmpjrCpf0bocI2
        TGTIIdnp9Yl7MOB7mSzAWTeVpvPjvGomXxExuYb90XwZEq5vcUJHhs3s1wVWUFR+IFFw58T4dirt6
        NjbHfCHqzwLJ9GBhaxHATUTBcU+acLuPkNbQZA6I1VCw1htUTbeIrLU1oC1ZhIYt02UuY3blbOZcV
        2wS8wWbF9dJqB4i8YCOviGewt+ba5Sga6QKahWHkzyl51hMzdzer4vHYK1Aa84DdsWncRTHfFycee
        AwOahKUA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLqBU-00BQcy-GX; Sun, 20 Feb 2022 17:39:44 +0000
Message-ID: <c9e1ffad-443d-dda2-293d-3ef61bda3f99@infradead.org>
Date:   Sun, 20 Feb 2022 09:39:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/3] patch : first example not showing umask field from
 Table 1-2
Content-Language: en-US
To:     Hans Weber <hwe.kernel@gmail.com>, linux-kernel@vger.kernel.org
References: <20220220163047.117864-1-hwe.kernel@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220220163047.117864-1-hwe.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/22 08:30, Hans Weber wrote:
> Signe-off-by: Hans Weber <hwe.kernel@gmail.com>
> ---
>  Documentation/filesystems/proc.rst | 105 ++++++++++++++++-------------
>  1 file changed, 58 insertions(+), 47 deletions(-)


Warning: trailing whitespace in line 228 of Documentation/filesystems/proc.rst

also:

> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index b9d1c6764266..40ca0f9087db 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -138,7 +138,7 @@ usually fail with ESRCH.
>             /proc (as of 5.10.0) 
>  
>   ======================================================================================
> - Name   	      T  Content
> + Name		      T  Content
>   ======================================================================================
>   arch_status          f Task architecture specific information
>   attr                 d API for security modules
> @@ -213,52 +213,63 @@ usually fail with ESRCH.
>  For example, to get the status information of a process, all you have to do is
>  read the file /proc/PID/status::
>  

Why make all of these changes? Is the only difference the
indentation?  If you are adding some missing fields, then
say so. And the Subject: line says "unmask", but I don't see
anything here about "unmask".


> -  >cat /proc/self/status
> -  Name:   cat
> -  State:  R (running)
> -  Tgid:   5452
> -  Pid:    5452
> -  PPid:   743
> -  TracerPid:      0						(2.4)
> -  Uid:    501     501     501     501
> -  Gid:    100     100     100     100
> -  FDSize: 256
> -  Groups: 100 14 16
> -  VmPeak:     5004 kB
> -  VmSize:     5004 kB
> -  VmLck:         0 kB
> -  VmHWM:       476 kB
> -  VmRSS:       476 kB
> -  RssAnon:             352 kB
> -  RssFile:             120 kB
> -  RssShmem:              4 kB
> -  VmData:      156 kB
> -  VmStk:        88 kB
> -  VmExe:        68 kB
> -  VmLib:      1412 kB
> -  VmPTE:        20 kb
> -  VmSwap:        0 kB
> -  HugetlbPages:          0 kB
> -  CoreDumping:    0
> -  THP_enabled:	  1
> -  Threads:        1
> -  SigQ:   0/28578
> -  SigPnd: 0000000000000000
> -  ShdPnd: 0000000000000000
> -  SigBlk: 0000000000000000
> -  SigIgn: 0000000000000000
> -  SigCgt: 0000000000000000
> -  CapInh: 00000000fffffeff
> -  CapPrm: 0000000000000000
> -  CapEff: 0000000000000000
> -  CapBnd: ffffffffffffffff
> -  CapAmb: 0000000000000000
> -  NoNewPrivs:     0
> -  Seccomp:        0
> -  Speculation_Store_Bypass:       thread vulnerable
> -  SpeculationIndirectBranch:      conditional enabled
> -  voluntary_ctxt_switches:        0
> -  nonvoluntary_ctxt_switches:     1
> +>cat /proc/self/status
> +Name:	cat
> +Umask:	0022
> +State:	R (running)
> +Tgid:	19633
> +Ngid:	0
> +Pid:	19633
> +PPid:	13898
> +TracerPid:	0
> +Uid:	1000	1000	1000	1000
> +Gid:	1000	1000	1000	1000
> +FDSize:	256
> +Groups:	24 25 27 29 30 44 46 108 113 114 119 1000 
> +NStgid:	19633
> +NSpid:	19633
> +NSpgid:	19633
> +NSsid:	13898
> +VmPeak:	    5440 kB
> +VmSize:	    5440 kB
> +VmLck:	       0 kB
> +VmPin:	       0 kB
> +VmHWM:	     520 kB
> +VmRSS:	     520 kB
> +RssAnon:	      68 kB
> +RssFile:	     452 kB
> +RssShmem:	       0 kB
> +VmData:	     316 kB
> +VmStk:	     132 kB
> +VmExe:	      20 kB
> +VmLib:	    1460 kB
> +VmPTE:	      44 kB
> +VmSwap:	       0 kB
> +HugetlbPages:	       0 kB
> +CoreDumping:	0
> +THP_enabled:	1
> +Threads:	1
> +SigQ:	0/47433
> +SigPnd:	0000000000000000
> +ShdPnd:	0000000000000000
> +SigBlk:	0000000000000000
> +SigIgn:	0000000000000000
> +SigCgt:	0000000000000000
> +CapInh:	0000000000000000
> +CapPrm:	0000000000000000
> +CapEff:	0000000000000000
> +CapBnd:	000001ffffffffff
> +CapAmb:	0000000000000000
> +NoNewPrivs:	0
> +Seccomp:	0
> +Seccomp_filters:	0
> +Speculation_Store_Bypass:	vulnerable
> +Cpus_allowed:	ff
> +Cpus_allowed_list:	0-7
> +Mems_allowed:	00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
> +Mems_allowed_list:	0
> +voluntary_ctxt_switches:	0
> +nonvoluntary_ctxt_switches:	0
>  
>  This shows you nearly the same information you would get if you viewed it with
>  the ps  command.  In  fact,  ps  uses  the  proc  file  system  to  obtain its

-- 
~Randy
