Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC84B456B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbiBNJSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:18:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiBNJSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:18:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1CD606D7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644830274;
        bh=776fbTkW3rx8NUz5JG3E7EEwkmT22DR668tj/3CzOxs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CKcdrwVdfDW1zvQn72NaGA511HNw0JPy0ZxfiJCd+4L0rVNKiIHTY+U4BMRkpjDy7
         60MmB6QebVF/6usV0dqnkxlX5eAy62EAYyjih02VoDMo/x5uvuH/nrq39J01QjC0oG
         aU21V3kmy7gw4uRnW0wv7I6uIC0lYRUk+elXrvwA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm2D-1nUGsb0InL-00GGT3; Mon, 14
 Feb 2022 10:17:54 +0100
Message-ID: <bf9d7f0d-b77f-6cc2-96df-bb9f2aebeae1@gmx.de>
Date:   Mon, 14 Feb 2022 10:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [kbuild-all] Re: gcc: error: unrecognized command-line option
 '-mno-space-regs'
Content-Language: en-US
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202202131837.mZeWy9J4-lkp@intel.com>
 <a7181772-ff49-fd35-2e9d-cfc2c2ce653e@gmx.de>
 <5a693363-521b-3d9e-7ce7-6844a5eee7c3@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <5a693363-521b-3d9e-7ce7-6844a5eee7c3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HpcdRJXxpzdis+NAnWO6U6SsEf1XxIpBHepTd48dFNaLUcIlI4B
 QfQ/duKysnkEVgEnsuqPN46m3QUcX+VS9ffOEFjYYnA8SxLD4d5w4wzQGXoFSV9TnsEP6ha
 5leDDGjscGlfUERPwneTT0dmJjRNo1tkpAn2FVl5XAirLEEoG6OXHO8hM1SNVu3kaUmvtH4
 3jTIqMv1XmkQhERhj+Lrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2C85wzxWwNc=:fVoOFkpURgR9Ec8oI0qRvv
 zOlPx0UPNxoKn7dOMDiq/W3WUQnigWkH6Q7FURvX2xGpXE2mOmQelJTkX/dfcqxzylYoMzo9w
 U85v1CtyIKWWi3q0Q/NaS1WYgLbBIRjg/V3xxRztvhsoZEcIeCWdOce5jnTJN0N/QKhtakavS
 1ECbjh8G+JP5Xib1xxzVf2JvJ3Yt/c9JGec6aJJ3XlmVRE30RzoKGaGvU+ANRO4gCQmuIB/lW
 62ztQ5HCXTCo0mLYKAn/PvlGGuYUfGxFvlKZvPdxBwQ7XN4WN1EeHVtEJZMIXWQwooRsILAX8
 1vnVuJUX1SA4gb7aElyU8lz8UlLcA6brbwskkIRMStKs9kiar0VZXFoq2obNVqXNYuqgO8Eb4
 l1yrhN3/F45qFssiXL06NASrSHTsszUMvFvX1w2SN1eGZiCldID2OYjI5bu8gxGFoA/HSJBPC
 i2oKPMQYzwOR0K+PHf1C9hEp/zu8n8OgZt7T/ElbHhez41rY7InnE6LRkq2ghXPvc4HqNihSb
 i04WUpshq8mHOWrCku3f6aKUNlPj3pwU+Pzj9JBbHuWRCxMLzY/vv8s8i0JswALYmzdYn61fr
 0V8CZ0QyxkIBOawlccjDPbjTmgEldVS9/8R/wJZifzm9mTtcKpyeFTPB8ytmz3icNahVDZHSX
 Zp2gtnGSpaLS56NJsJrZgGNKWa7KVm70pafUeSPURr9xPRBoT7lKtH5AymNT2vTzPlrJYOX03
 cCmASroDMGnwokrUBvHbWdF4dJMY3HxDbXW6KW0G3Uu73aYwAmc2d0P0IAkqJykiWkB2yqysl
 AtL2I+4lmX4OK8MTEb63GldfGOsjNbNq/PoUobXeiwNayEitESpecmKd/wC0GBx2VWlfV2D/Q
 iu9X+PQg1pLqcmZNEeR8NhvlmHKjJyEgMuHwaVR4O/DOu5IyWh5ZGyvYlES7S0OjTK5kVtY4/
 U6iPqlN4jqTPxOUVikpafm1MCo+paGwX/hn9XAU+eXoITLTRUFIxWihUMlk3Hf+nitNH61dEs
 FZ8+Tbpx7DUT2sm/YTIAN2MbTfVP/t0clWi6m3ZfNgWP9U0wk9rV6F+x1aZlbI1+TMeXPmycU
 mO/BP3xLKFf6OQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 10:15, Chen, Rong A wrote:
>
>
> On 2/14/2022 6:26 AM, Helge Deller wrote:
>> On 2/13/22 11:39, kernel test robot wrote:
>>> tree:=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/torv=
alds/linux.git master
>>> head:=C2=A0=C2=A0 b81b1829e7e39f6cebdf6e4d5484eacbceda8554
>>> commit: 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e parisc: Fix compile f=
ailure when building 64-bit kernel natively
>>> date:=C2=A0=C2=A0 6 months ago
>>> config: parisc64-randconfig-r035-20220213 (https://download.01.org/0da=
y-ci/archive/20220213/202202131837.mZeWy9J4-lkp@intel.com/config)
>>> compiler: hppa-linux-gcc (GCC) 11.2.0
>>> reproduce (this is a W=3D1 build):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wget https://raw.gith=
ubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cro=
ss
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chmod +x ~/bin/make.c=
ross
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # https://git.kernel.=
org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D5f6e0fe01b6b3=
3894cf6f61b359ab5a6d2b7674e
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git remote add linus =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git fetch --no-tags l=
inus master
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git checkout 5f6e0fe0=
1b6b33894cf6f61b359ab5a6d2b7674e
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # save the config fil=
e to linux build tree
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir build_dir
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 COMPILER_INSTALL_PATH=
=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cross O=3Dbuild_dir ARCH=3Dparisc=
64 prepare
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>> =C2=A0=C2=A0=C2=A0 scripts/genksyms/parse.y: warning: 9 shift/reduce c=
onflicts [-Wconflicts-sr]
>>> =C2=A0=C2=A0=C2=A0 scripts/genksyms/parse.y: warning: 5 reduce/reduce =
conflicts [-Wconflicts-rr]
>>>>> gcc: error: unrecognized command-line option '-mno-space-regs'
>>>>> gcc: error: unrecognized command-line option '-mno-space-regs'
>>>>> gcc: error: unrecognized command-line option '-mfast-indirect-calls'=
; did you mean '-mforce-indirect-call'?
>>>>> gcc: error: unrecognized command-line option '-mfast-indirect-calls'=
; did you mean '-mforce-indirect-call'?
>>>>> gcc: error: unrecognized command-line option '-mdisable-fpregs'
>>>>> gcc: error: unrecognized command-line option '-mschedule=3D7200'
>>
>> Same issue as the other error.
>> Here a 64bit compiler was used to build a 32-bit kernel...
>
> Hi Helge,
>
> Thanks for the explanation, it seems kernel still can be 32-bit if using
> make ARCH=3Dparisc64 randconfig, we'll check CONFIG_64BIT config directl=
y
> to decide the ARCH value.

Yes, that's the best approach!
Thanks,
Helge


> Best Regards,
> Rong Chen
>
>
>>
>> I've queued up a patch in for-next which should give a better error mes=
sage if
>> someone uses such a wrong combination:
>> https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git=
/commit/?h=3Dfor-next&id=3Db160628e9ebcdc85d0db9d7f423c26b3c7c179d0
>>
>> Helge
>>
>>> =C2=A0=C2=A0=C2=A0 make[2]: *** [scripts/Makefile.build:117: scripts/m=
od/devicetable-offsets.s] Error 1
>>
>>>>> gcc: error: unrecognized command-line option '-mdisable-fpregs'
>>>>> gcc: error: unrecognized command-line option '-mschedule=3D7200'
>>> =C2=A0=C2=A0=C2=A0 make[2]: *** [scripts/Makefile.build:271: scripts/m=
od/empty.o] Error 1
>>> =C2=A0=C2=A0=C2=A0 make[2]: Target '__build' not remade because of err=
ors.
>>> =C2=A0=C2=A0=C2=A0 make[1]: *** [Makefile:1216: prepare0] Error 2
>>> =C2=A0=C2=A0=C2=A0 make[1]: Target 'prepare' not remade because of err=
ors.
>>> =C2=A0=C2=A0=C2=A0 make: *** [Makefile:220: __sub-make] Error 2
>>> =C2=A0=C2=A0=C2=A0 make: Target 'prepare' not remade because of errors=
.
>>>
>>> ---
>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>>
>> _______________________________________________
>> kbuild-all mailing list -- kbuild-all@lists.01.org
>> To unsubscribe send an email to kbuild-all-leave@lists.01.org
>>

