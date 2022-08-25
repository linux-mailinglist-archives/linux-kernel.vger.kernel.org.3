Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA35A0DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbiHYKbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbiHYKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:31:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4AA491F8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:31:06 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P9VCVZ007511;
        Thu, 25 Aug 2022 10:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JYz6yE+IBR3ZxjEeajtj3nlaitgP+ytBhZUlKrF/UKo=;
 b=iS3QrL0tZWDc6uYpYPViW5WlG2UzsQ99/HUCpuBBxBjzfOn0xNu0n+ZXwzYQenMuxEMh
 RXkvZbCAjuHKeWy6kil9YSZPcg+qivr/B4IJ1sr6V3RDyFEamckcUbQpojypJDkSk5qn
 qH+hxWA6rgJ2NuKJ3C1ntR9O0l9kVdb7ZmgcFVYw8cTg76ZmyDaFBN65DnsFSp+uhQSx
 iGpUtesQEr3m7YtUj5xCGPlndQ3gfkY/KODi8jACWHBUsgLJH+cITVcUvTsH5jcobr0t
 33lVUk87x7AVVhaAYJ5f3fyzFVIREGOIA+B3FiO2pBvtRQVopmd//o6zthzogyT/5P2K Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j64xjfnwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 10:30:58 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27PAUoQZ020035;
        Thu, 25 Aug 2022 10:30:58 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j64xjfnw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 10:30:58 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27PANPba023805;
        Thu, 25 Aug 2022 10:30:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3j2pvj6a0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 10:30:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27PARpiO43385310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 10:27:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6B3F52050;
        Thu, 25 Aug 2022 10:30:53 +0000 (GMT)
Received: from localhost (unknown [9.43.41.198])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 63E8A5204F;
        Thu, 25 Aug 2022 10:30:53 +0000 (GMT)
Date:   Thu, 25 Aug 2022 16:00:52 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] compiler-gcc.h: Remove ancient workaround for gcc PR
 58670
To:     linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     sv@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <20220624141412.72274-1-ubizjak@gmail.com>
In-Reply-To: <20220624141412.72274-1-ubizjak@gmail.com>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1661422971.cqtahfm22j.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n4nPEr4_DKqV7t7Sbq939YhBxWNh-F8C
X-Proofpoint-ORIG-GUID: dArQoAqUYuj9ZjLsB45xWWI8Z16dfYen
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1011 mlxlogscore=863
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uros Bizjak wrote:
> The workaround for 'asm goto' miscompilation introduces a compiler
> barrier quirk that inhibits many useful compiler optimizations. For
> example, __try_cmpxchg_user compiles to:
>=20
>    11375:	41 8b 4d 00          	mov    0x0(%r13),%ecx
>    11379:	41 8b 02             	mov    (%r10),%eax
>    1137c:	f0 0f b1 0a          	lock cmpxchg %ecx,(%rdx)
>    11380:	0f 94 c2             	sete   %dl
>    11383:	84 d2                	test   %dl,%dl
>    11385:	75 c4                	jne    1134b <...>
>    11387:	41 89 02             	mov    %eax,(%r10)
>=20
> where the barrier inhibits flags propagation from asm when
> compiled with gcc-12.
>=20
> When the mentioned quirk is removed, the following code is generated:
>=20
>    11553:	41 8b 4d 00          	mov    0x0(%r13),%ecx
>    11557:	41 8b 02             	mov    (%r10),%eax
>    1155a:	f0 0f b1 0a          	lock cmpxchg %ecx,(%rdx)
>    1155e:	74 c9                	je     11529 <...>
>    11560:	41 89 02             	mov    %eax,(%r10)
>=20
> The refered compiler bug:
>=20
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D58670
>=20
> was fixed for gcc-4.8.2.
>=20
> Current minimum required version of GCC is version 5.1 which has
> the above 'asm goto' miscompilation fixed, so remove the workaround.
>=20
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/compiler-gcc.h | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index a0c55eeaeaf1..9b157b71036f 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -66,17 +66,6 @@
>  		__builtin_unreachable();	\
>  	} while (0)
>=20=20
> -/*
> - * GCC 'asm goto' miscompiles certain code sequences:
> - *
> - *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D58670
> - *
> - * Work it around via a compiler barrier quirk suggested by Jakub Jeline=
k.
> - *
> - * (asm goto is automatically volatile - the naming reflects this.)
> - */
> -#define asm_volatile_goto(x...)	do { asm goto(x); asm (""); } while (0)
> -
>  #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
>  #define __HAVE_BUILTIN_BSWAP32__
>  #define __HAVE_BUILTIN_BSWAP64__

This is causing a build issue on ppc64le with a new patch replacing use=20
of unreachable() with __builtin_unreachable() in __WARN_FLAGS():
https://lore.kernel.org/linuxppc-dev/20220808114908.240813-2-sv@linux.ibm.c=
om/

during RTL pass: combine
In file included from /linux/kernel/locking/rtmutex_api.c:9:
/linux/kernel/locking/rtmutex.c: In function '__rt_mutex_slowlock.constprop=
':
/linux/kernel/locking/rtmutex.c:1612:1: internal compiler error: in purge_d=
ead_edges, at cfgrtl.c:3369
 1612 | }
      | ^
0x142817c internal_error(char const*, ...)
	???:0
0x5c8a1b fancy_abort(char const*, int, char const*)
	???:0
0x72017f purge_all_dead_edges()
	???:0
Please submit a full bug report,
with preprocessed source if appropriate.
Please include the complete backtrace with any bug report.
See <file:///usr/share/doc/gcc-11/README.Bugs> for instructions.


So, it looks like gcc still has issues with certain uses of asm goto.


- Naveen

