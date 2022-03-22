Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735924E39BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiCVHl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiCVHj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:39:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDAA27B05;
        Tue, 22 Mar 2022 00:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647934476;
        bh=Hs+LekFd6E4SGdt8i1Ad3ZnN5tN6xqp8p83T7REJkQ8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XA5MZZ4kQSCE87s3wgnN1UAGqNRezIP2Vg1OHovMqT83iImAh0MhTTVDkq1tKgqr1
         5AlgRgS30XebDTfhY9TIar5O388PTza26gcDrKcfAFO99cPZE86LYw71KQ0OCV0eqx
         d8GvppfUALbR6fa7KMRT/Q2/ufmZ3ylwZj8IFZQk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.132]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mulm5-1oNhzL23ut-00rrDh; Tue, 22
 Mar 2022 08:34:36 +0100
Message-ID: <8ce9d045-c3c9-c839-7b82-9f5ccdae2d52@gmx.de>
Date:   Tue, 22 Mar 2022 08:34:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: linux-next: manual merge of the parisc-hd tree with the
 asm-generic tree
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220228114523.03b2f921@canb.auug.org.au>
 <20220322110925.7b295e54@canb.auug.org.au>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220322110925.7b295e54@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e5hbO80bo1ozr4PzUgKbhkXQcCIXaFuDpSIEMhxhGqA/g2UhW9O
 MIb4dwSCoEZBHoHdlZ8eXZR+rRVHCaOtCi21Mpbj6F1n8XqB3IlO9UjtIpg5nDv9AvtSA4M
 b/gVyECMaJL8gSEzDdeCIJVYvgLCw2UPHIv5Tj7IxpgcIPzoYk506pLllldzYl9cKY2M45i
 bzkmknm1UxO/mqiZxOeEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kd1MJCl/xh4=:d+hPN41aPGL8S+OXZAiPTL
 X5JMLqvPw7shoytLMFV+mBxt7QNhU3fOVYTtd71MRfe560TuoNXR4MkyAHE56aaSqyjjBNz35
 Tf65vglLRUz9gmFYa4bmKwOS+6LbtZTTorOeBPnvKYtyfnU7kLnz/AuJW8tsE5ITZJRvXn467
 0sRovYl2XPm0DojucscYhrHoG3MHCaf173ffPr6ORpEVjZrpO5kNp6vOSoX4isix2jIGE5omA
 1Q5DahOcOQOOMTQQShe+N7BhM127OLyDhgXgaxpXhldAIf9NKH7Bz8NUPKVtN8umlw/JMkiYk
 UNC42JCckxEinK3srYEwaqBBnFap3Qb985v5UGdOhXmxrv9j3LrOOmBlUjepkYs0KqJNvcYK/
 8xOZAQ4Ij26YQh4eAsvR4iU6WF4iP9FIvz4k3lDRXrK3H+bcQ+WN4rzF194xS3Bn+denpb1ZA
 NAtE+jXZErV9tPma2hDUfZmXF8hOq/8b+sBekTuG6U2m5aLLbqlYQ+BRD0pMHkpVHUWGymP2c
 9383GMnz9Yf+yLgiJQV9ibYizThfJIDmZ2e4/0ovjqUDHOhDE8P8vOVCeABF6+BQHVodqV/fx
 HcqI/HYp5WDT4wsE8DC5/ssuZUxrGWO0PEcl6slPaI2T7deQDCCsJGWBQDMMe8HPppB2ifLT6
 HQgTAYWz2q7615JWSGKEGjFC57HDgvlcNt2TRZnzWoarerM/+xYxTD1B5/2RtHCDtMejpKwOP
 RIVCtAV/71e8XuSR38ZWQbIWapmZNtX3grC8+1O2yzbX19MkpFQTuEdPEZLvt18aTOKMPxg5x
 AOrpmu0KyaXl4fSu7BiJRKxMheicSwlQlMyzrVBjrgYHB63xA1n8DCJIiICw/2fNbVMOfZfv9
 j32CLiIyoMoy07ewBrtoQpQ5P5mYfl3Aw7bFLJHgWPYjexTnJ4zgaK0jI2W7IX6SHCCj/XgJU
 LHeHbMJ8cT4SLYNBBtRHbBKpOnlCeU0OGys6D9e5jAPPFA0RvmhxhV7nrIxeU0CZRqGUZl9uR
 UVkN+wRYdLRDdUCnit/VXBEIcNdPIUbxtFt9jeeKeV5ldq5xuxLYTmeOVRtVeeVAJYkEaFP/7
 WcsLfgp3ionQcs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 01:09, Stephen Rothwell wrote:
> Hi all,
>
> On Mon, 28 Feb 2022 11:45:23 +1100 Stephen Rothwell <sfr@canb.auug.org.a=
u> wrote:
>>
>> Today's linux-next merge of the parisc-hd tree got a conflict in:
>>
>>   arch/parisc/lib/memcpy.c
>>
>> between commit:
>>
>>   967747bbc084 ("uaccess: remove CONFIG_SET_FS")
>>
>> from the asm-generic tree and commit:
>>
>>   d4a767ea8b0e ("parisc: Use constants to encode the space registers li=
ke SR_KERNEL")
>>
>> from the parisc-hd tree.
>
> This is now a conflict between the asm-generic tree and commit
>
>   360bd6c65807 ("parisc: Use constants to encode the space registers lik=
e SR_KERNEL")
>
> in Linus' tree.


Arnd,
can you please drop the changes in your asm-generic tree for
arch/parisc/lib/memcpy.c
They are not needed any more.

Helge

diff --git a/arch/parisc/lib/memcpy.c b/arch/parisc/lib/memcpy.c
index 468704ce8a1c..ea70a0e08321 100644
=2D-- a/arch/parisc/lib/memcpy.c
+++ b/arch/parisc/lib/memcpy.c
@@ -13,7 +13,7 @@
 #include <linux/compiler.h>
 #include <linux/uaccess.h>

-#define get_user_space() (mfsp(3))
+#define get_user_space() (uaccess_kernel() ? 0 : mfsp(3))




