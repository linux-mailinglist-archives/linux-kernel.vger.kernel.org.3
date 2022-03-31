Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C004EDF45
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiCaRBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbiCaRBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:01:11 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887AF5EDDD
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:59:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648745960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhGsRCUFCEYULPL/omreK/3n0ZicJpzKa59O2/FBKhU=;
        b=Bk7hlmTlyQb1whvg1ngnlc1ZCMtSU8R4ZbIEDeeyxkBqnvXEGMRr+jU3RzyehyCKyCP5p4
        HjOACtAyBR3kYT0mJ2V4MSYbwItBz59DeW0Xr+gMO3kR9ZQ6BJcFDibO8PcaSzViOR/yN/
        6wbI0RsWvjbrsD0EeoOo+FbxUENmGYs=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10 4036/5872] WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <YkXSv8exRRUbT/oM@dev-arch.thelio-3990X>
Date:   Thu, 31 Mar 2022 09:59:17 -0700
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        kernel test robot <lkp@intel.com>,
        Roman Gushchin <guro@fb.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Minchan Kim <minchan@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Message-Id: <7A4F3379-CC71-4F44-94C0-E47115C14917@linux.dev>
References: <YkXSv8exRRUbT/oM@dev-arch.thelio-3990X>
To:     Nathan Chancellor <nathan@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 31, 2022, at 9:11 AM, Nathan Chancellor <nathan@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Mar 31, 2022 at 12:42:04PM +0300, Mike Rapoport wrote:
>> (added llvm folks)
>>=20
>> Hi,
>>=20
>>> On Wed, Mar 30, 2022 at 02:47:43PM -0700, Roman Gushchin wrote:
>>> On Wed, Mar 30, 2022 at 02:53:14PM +0800, kbuild test robot wrote:
>>>> Hi Roman,
>>>>=20
>>>> FYI, the error/warning still remains.
>>>>=20
>>>> tree:   https://github.com/ammarfaizi2/linux-block google/android/kerne=
l/common/android12-trusty-5.10
>>>> head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
>>>> commit: 0e0bfc41fdf4d79d39ebe929844cdee44f97366d [4036/5872] UPSTREAM: m=
m: cma: allocate cma areas bottom-up
>>>> config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive=
/20220330/202203301412.MZ7wQvQz-lkp@intel.com/config)
>>>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f=
6d9501cf49ce02937099350d08f20c4af86f3d)
>>>> reproduce (this is a W=3D1 build):
>>>>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>>>>        chmod +x ~/bin/make.cross
>>>>        # https://github.com/ammarfaizi2/linux-block/commit/0e0bfc41fdf4=
d79d39ebe929844cdee44f97366d
>>>>        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/=
linux-block
>>>>        git fetch --no-tags ammarfaizi2-block google/android/kernel/comm=
on/android12-trusty-5.10
>>>>        git checkout 0e0bfc41fdf4d79d39ebe929844cdee44f97366d
>>>>        # save the config file to linux build tree
>>>>        mkdir build_dir
>>>>        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
>>>>=20
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>=20
>>>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>>>=20
>>>>>> WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in refe=
rence from the function memblock_bottom_up() to the variable .meminit.data:m=
emblock
>>>> The function memblock_bottom_up() references
>>>> the variable __meminitdata memblock.
>>>> This is often because memblock_bottom_up lacks a __meminitdata
>>>> annotation or the annotation of memblock is wrong.
>>>=20
>>> I guess this patch should fix it, however I fail to reproduce the origin=
al issue.
>>> Maybe it's up to the specific compiler version.
>>>=20
>>> --
>>>=20
>>> =46rom b55a8dd19f4156d7e24ec39b18ede06965ce1c4f Mon Sep 17 00:00:00 2001=

>>> From: Roman Gushchin <roman.gushchin@linux.dev>
>>> Date: Wed, 30 Mar 2022 14:42:12 -0700
>>> Subject: [PATCH] memblock: fix memblock_bottom_up() and
>>> memblock_set_bottom_up() annotations
>>>=20
>>> memblock_bottom_up() and memblock_set_bottom_up() lack __meminitdata
>>> annotations causing compiler warnings like:
>>>  WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in refere=
nce from the function memblock_bottom_up() to the
>>>  variable .meminit.data:memblock
>>>=20
>>> Fix it by adding the missing annotation and removing the wrong
>>> __meminit annotation.
>>>=20
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>>> ---
>>> include/linux/memblock.h | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>> index 50ad19662a32..536bc2fc31e6 100644
>>> --- a/include/linux/memblock.h
>>> +++ b/include/linux/memblock.h
>>> @@ -460,7 +460,7 @@ static inline void *memblock_alloc_node(phys_addr_t s=
ize,
>>> /*
>>>  * Set the allocation direction to bottom-up or top-down.
>>>  */
>>> -static inline __init_memblock void memblock_set_bottom_up(bool enable)
>>> +static inline __initdata_memblock void memblock_set_bottom_up(bool enab=
le)
>>=20
>> I think putting __initdata_memlock won't help here, because there should b=
e
>> nothing wrong with __meminit function accessing __meminitdata data.
>>=20
>> My guesstimate would be that the compiler decided not to inline this and
>> still dropped section attribute because of 'inline'.
>>=20
>> If this is the case we I think we should=20
>>=20
>>    s/inline __init_memblock/__always_inline/
>>=20
>>> {
>>>    memblock.bottom_up =3D enable;
>>> }
>>> @@ -470,7 +470,7 @@ static inline __init_memblock void memblock_set_bott=
om_up(bool enable)
>>>  * if this is true, that said, memblock will allocate memory
>>>  * in bottom-up direction.
>>>  */
>>> -static inline __init_memblock bool memblock_bottom_up(void)
>>> +static inline __initdata_memblock bool memblock_bottom_up(void)
>>> {
>>>    return memblock.bottom_up;
>>> }
>>> --=20
>>> 2.30.2
>>>=20
>>=20
>=20
> For the record, I cannot reproduce this on mainline, which has commits
> 34dc2efb39a2 ("memblock: fix section mismatch warning") and a024b7c2850d
> ("mm: memblock: fix section mismatch warning again"). That first commit
> has the same exact warning as this report, which is against an Android
> tree (android12-trusty-5.10).
>=20
> While I do not see the commit that 34dc2efb39a2 claims to fix in
> android12-trusty-5.10, I do see the three commits in android12-5.10:
>=20
> a46e3fa13968 ("UPSTREAM: mm: memblock: drop __init from memblock functions=
 to make it inline")
> 5f7ec0f4c383 ("UPSTREAM: memblock: fix section mismatch warning")
> 8cf5bb6946a2 ("UPSTREAM: mm: memblock: fix section mismatch warning again"=
)
>=20
> I think we can just discard this report for now, unless someone from
> Google's trusty team wants to address it in that branch.

I agree. Or at least help us with the testing of the proposed fixes.

Thanks!=
