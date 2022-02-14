Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E344B5429
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355616AbiBNPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:06:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355605AbiBNPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:06:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7940149F9D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644851190;
        bh=XJKDudRxjecHHstAdeydKO87TqgUYqKLrpClo0189hg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=atjrzDzrVd+rtHTzMGl4C904TAWNYEIs1mEDpMmTP6tvuByaXqsFy+pwHGIbFWUmr
         TZzMnOa+UOf/SGaNfl0ZVwFtAYpfMi/+f5+x8nK/CQ2CbTbjBIrrRzNvLf1pRafFKr
         RVMXpkftRtlUQ6zw+IuF6NHIIlIyrgBL/Talo0tA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatRZ-1nqTVu3Z4V-00cP9n; Mon, 14
 Feb 2022 16:06:29 +0100
Message-ID: <e259c202-5473-8406-2577-9e3c0d968385@gmx.de>
Date:   Mon, 14 Feb 2022 16:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [deller-parisc:for-next 5/6]
 arch/parisc/include/asm/bitops.h:20:2: error: #error "Please use
 'ARCH=parisc64' to build the 64-bit kernel."
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202202142139.fHrrv9Oy-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202202142139.fHrrv9Oy-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AMQd1HwBAbw+XhfwZikxGzoW4Mxd95Au1gMMbC1lNpLj+h+pX0Z
 j+zLsvP8q9zaCxE1ZwxOgBXIrGHjIVMUxFPuyGPcGCFtJv37edyNjLrCfSuLNv4LkBg1yMj
 /kPl0OqqmcS3h1Hj89XBQzWUsGdCEm8ofkWEIKAkHDXv6N5MSqBXh2XrUt1WgO470SZ5bsa
 +QOw1JqpC1p8mcocNoeOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RqLYCO8ho6s=:TGZbwiuz54oRHe0o3nHC3F
 SwJ0i3TDMEhqsBWYnvS17DOtqrBRE8kpGTJgIkmYliNh+eVdlCniDjeDbEoo0e1bIsMVAVdJD
 VDjjvKV/ZUc+D/qDdpJUtRuaRGFKd/w3rKbaqQfkNqRr9SY+VGKbGfnoFYUSgobkSxIkXIiWz
 cCQkB4qBnqy/eCbhYP1BtX7Iy6FK1UlzulpiuoNM0vU7uMoyXVDRfngkJA4dSiAxRHZ3hk9Vt
 B5IA5aylR7o1vDS4rfFdMOJtR+ZCEHS0fA2JMe6NlFNDvpOTy6EdtIYPnyJ9ZdddX5bObjKl3
 HPzG3Uty+G7guSTyZWFkxt0JR+vftqUpD6krwEx/uqxHHgfMt+Ad04mncMGrhCY0iEkS+hMVy
 6tx88+2babh7RwWP04trp+EXVyehZs5vVROrohg6/jIDIcbAhKFE6/8XThwdNqmL+t/aty3J5
 AvzImtl5KeSTj3Vgk0cfGVyWso55ZqSk5RzUcANuXU4e7dlE2XazmgmgcmWeBV3l5Ewopf4Xz
 ici078RBOxkmeP+FIQ6ifblFYdMb9BU8YQ7FHCoYdfoWSDf2r19mIVD7K1s1cMnvSqktCHzD+
 aPi4CWKMuYhsZQ5ZdX7whch8BgSBo7vcajiYfEqbKajYvc5/rGdM2zQjy9Gqi7lpi8XvlHgmS
 M2teQP0Q2x23+C+SU3afU76UblIAKcs9dAKD6NnXwwjpRDzOH1PBaFAf5+Ea/ggG1MAo5cwE5
 x8H+ti4bFlRVUptnMTv40xd07Jqoc3/eR082E81USXE5F2ueEMxAi9OwgFW25oYZ7EQ/rf8Kl
 OOuHgzkZpNxk7jXRTOmL62/SkM3qchS/yd359VZkfNLTC6TICBZz0xE/Pt/I7xSB+Mj0pZnXK
 pB9WXOov+wM4b4UWH21Rwyre7cTC7zUtN1dnEGCveQoc/EKA/uW7WqaEF9dkQznW0JRTaOSIU
 NJEKYa9AxcSCL1jvtuajuWkTf45Tcju1dYk01fSsd7YIIKO5rAFP09hW3CvC80o2TmwcKIAh/
 vo7se0kkiBC5AEAOfznhI8vWI5rgmWFptjKqzcpqT2p7OV4ZUQfpJoSsB+zZYLDPAY1Lv59XG
 8Wh9FHRYn/DX70=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 14:25, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-li=
nux.git for-next
> head:   dbd0b42350d5717786cb8257fbe5b528f3af9772
> commit: b160628e9ebcdc85d0db9d7f423c26b3c7c179d0 [5/6] parisc: Show erro=
r if wrong 32/64-bit compiler is being used
> config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci=
/archive/20220214/202202142139.fHrrv9Oy-lkp@intel.com/config)
> compiler: hppa64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-=
linux.git/commit/?id=3Db160628e9ebcdc85d0db9d7f423c26b3c7c179d0
>         git remote add deller-parisc https://git.kernel.org/pub/scm/linu=
x/kernel/git/deller/parisc-linux.git
>         git fetch --no-tags deller-parisc for-next
>         git checkout b160628e9ebcdc85d0db9d7f423c26b3c7c179d0
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dparisc prepare
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/bitops.h:33,
>                     from include/linux/kernel.h:22,
>                     from arch/parisc/include/asm/bug.h:5,
>                     from include/linux/bug.h:5,
>                     from include/linux/page-flags.h:10,
>                     from kernel/bounds.c:10:
>>> arch/parisc/include/asm/bitops.h:20:2: error: #error "Please use 'ARCH=
=3Dparisc64' to build the 64-bit kernel."
>       20 | #error "Please use 'ARCH=3Dparisc64' to build the 64-bit kern=
el."

The newly introduced error message works as intended :-)

#error "Please use 'ARCH=3Dparisc64' to build the 64-bit kernel."

Helge
