Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757AC525CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378018AbiEMIGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378046AbiEMIGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:06:37 -0400
Received: from hfcrelay.icp-osb-irony-out7.external.iinet.net.au (hfcrelay.icp-osb-irony-out7.external.iinet.net.au [203.59.1.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 450644ECF9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:06:28 -0700 (PDT)
IronPort-SDR: D0mxgqfBkzwthw1rq1YT6+Hvkyo/XBJ20prte7Ulu6WV4HNlD4XUshzSfBtZM4WXmk/xc8KSZn
 YTiB5HJe+pHmCSS5MNzN7KY3ARQNCgjt5jJRFd7vGmPxo1AFp+/IC7rnZr4LVNNtNa5Mcl+saS
 7YoA4YCw8OmFdsjpC4hd6cqt6RSbttsp9ZvrKIX6MLed7LuWD3PDkgPo3S/wrQ0INiu/Ya2jpj
 nQ5O09/oHy+LgR6oxJrTBsf5aZ+3LGKGyLfwf2hdOBPdold6ieZaLeUQ43wj7vOFu1oCapb1pl
 duo=
X-SMTP-MATCH: 0
X-IPAS-Result: =?us-ascii?q?A2DxAgCmEH5i/0gv8TwNTR4BAQsSDEAJhjyETpELA4skh?=
 =?us-ascii?q?HeCB4w+CwEBAQEBAQEBAUsEAQGCDoJ0AoU/JjgTAQIEAQEBAQMCAwEBBwEBA?=
 =?us-ascii?q?QUBAQEBAQEGAwGBHIUvhwgBAQEBAgEjFUEFCwsSBgICJgICSQ4GDQYCAQGCe?=
 =?us-ascii?q?YJ0q2B6gTGBAYgZgWWBECyOYEN9gRCBPAyCdz6EC4QPgmUEgWeTcygEDwMdO?=
 =?us-ascii?q?IEGEoEhcQEKBgMDBwoFMgYCDBgUBAIVEVMeAhMFBwocDhQcJBkMDwMSAxEBB?=
 =?us-ascii?q?wILEggVLAgDAgMIAwIDIwsCAxgJBwoDHQgKHBIQFAIEEx8LCAMaHy0JAgQOA?=
 =?us-ascii?q?0UICwoDEQQDExgLFggQBAYDCS8NKAsDFA8BBgMGAgUFAQMgAxQDBScHAyEHC?=
 =?us-ascii?q?yYNDQQcBx0DAwUmAwICGwcCAgMCBhcGAgJyCigNCAQIBBweJRMFAgcxBQQvA?=
 =?us-ascii?q?h4EBQYRCQIWAgYEBQIEBBYCAhIIAggnGwcWGR0ZAQVeBgsJIxwKIg0GBQYWA?=
 =?us-ascii?q?yc4BiIBGwJSlwp7E0OBGRVaHgsvoVmfDINWn3UGEy2oV5ZmqR2BfjMaCCgIg?=
 =?us-ascii?q?yNRKJ0CYzsCBgsBAQMJikyCSAEB?=
IronPort-Data: A9a23:rJX336qjbTCx4/raZAvpQhUg14JeBmJoZBIvgKrLsJaIsI4StFCzt
 garIBmFbvuMa2b9fN4gYdy28E5SucDWnN42SAI4rSljH3tAp8PIXInJcR6rZXPLcZPKHUg8s
 5tPNYGQIJw+ESPVqkv9buGx/HJx/J/TS+unAoYoGMzRqSyI6csFoUg+8wLsqtcw2bBVO+4M0
 D/Li5W31GWNglaYCUpJrfPawP9TlK6q4mlA4wVlPakjUGL2zhH5MrpOfcldEFOlGuG4LsbiL
 woU5Ojklo9x105F5uKNyt4XQGVTKlLhFVHmZk5tZkSXqkMqShrec0oMHKF0hU9/011llvgtk
 48V7cTYpQ0BZsUgk8xFO/VUO30lZ/UeoNcrLFDn2fF/wXEqfFPR6eh+D2UqbLFH0f1uDGNC8
 PtIGRY0O0Xra+KemNpXS8Ff35V5apC1bMVH/Cs6+Fk1D954GdaZH/yMuYAeg21YasNmRJ4yY
 +IWZCBgRAnLZxxJJ0dRD4gx9AutriKuKGME9A3M+sLb5UDdz1Bu+rTBFeDEc9HQXNx3smSdu
 U3ZqjGR7hYycYb3JSC+2n2hi/XTtSf6Xp8CUbjmpv0sh0ecrkQXCRsLRR6+/6m6okq/QM5Eb
 UgV/Dc+6K1spE/tScPyNzW8oXiZrlsfVsBWHukS9g6A0OzX7hyfC2xCSSROAPQit9ceRDo22
 1vPlNTsbQGDq5XLETfHqu7R8Wz3ZnJTMXcNZGkPSg5D6sSLTJwPsy8jh+1LSMad5uAZ0xmpq
 9xWhEDSX4kusPM=
IronPort-HdrOrdr: A9a23:wqL0Ka3xIsf2jR9rUfpH2wqjBG4kLtp133Aq2lEZdPU1SL3iqy
 nKpp8mPHDP5gr5NEtMpTnCAtjlfZqkz/9ICNAqXYtKPzOW2ldATrsSlbcKqgeIc0fDH4hmpM
 JdmsNFZ+EYY2IXsS+02njeLz+M+qjgzIm4wc3l5zNGSwVybqFp6A10TjycDlZ9SGB9dPkE/d
 6nl7N6mwY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,221,1647273600"; 
   d="scan'208";a="393644717"
Received: from 60-241-47-72.tpgi.com.au (HELO [192.168.0.22]) ([60.241.47.72])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 13 May 2022 16:06:23 +0800
Message-ID: <042eaca3-5007-d1cf-4fc4-ef02d1ecb255@uclinux.org>
Date:   Fri, 13 May 2022 18:06:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] m68k: math-emu: Fix dependencies of math emulation
 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org>
 <CAMuHMdW3BsuJOx6r1TmUJJYhqn_v5iDznTw0gnbayQAjBp2OYA@mail.gmail.com>
 <db869491-142f-4360-0f3c-e4395563088b@uclinux.org>
 <CAMuHMdUb=c5WYviGqJXSVtWe4rob28oOQsPE2V==V3P7hDWwyg@mail.gmail.com>
From:   Greg Ungerer <gerg@uclinux.org>
In-Reply-To: <CAMuHMdUb=c5WYviGqJXSVtWe4rob28oOQsPE2V==V3P7hDWwyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 13/5/22 16:56, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Fri, May 13, 2022 at 1:23 AM Greg Ungerer <gerg@uclinux.org> wrote:
>> On 11/5/22 22:54, Geert Uytterhoeven wrote:
>>> On Wed, May 11, 2022 at 11:48 AM Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> If CONFIG_M54xx=y, CONFIG_MMU=y, and CONFIG_M68KFPU_EMU=y:
>>>>
>>>>       {standard input}:272: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.b %d1,%d3' ignored
>>>>       {standard input}:609: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a1){%d0,#8},%d0' ignored
>>>>       {standard input}:752: Error: operands mismatch -- statement `mulu.l 4(%a0),%d3:%d0' ignored
>>>>       {standard input}:1155: Error: operands mismatch -- statement `divu.l %d0,%d3:%d7' ignored
>>>>
>>>> The math emulation support code is intended for 68020 and higher, and
>>>> uses several instructions or instruction modes not available on coldfire
>>>> or 68000.
>>>>
>>>> Originally, the dependency of M68KFPU_EMU on MMU was fine, as MMU
>>>> support was only available on 68020 or higher.  But this assumption
>>>> was broken by the introduction of MMU support for M547x and M548x.
>>>>
>>>> Drop the dependency on MMU, as the code should work fine on 68020 and up
>>>> without MMU (which are not yet supported by Linux, though).
>>>> Add dependencies on M68K_CLASSIC (to rule out Coldfire) and FPU (to rule
>>>> out 68xxx below 68020).
>>>>
>>>> Fixes: 1f7034b9616e6f14 ("m68k: allow ColdFire 547x and 548x CPUs to be built with MMU enabled")
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>> ---
>>>> To be queued in the m68k for-v5.19 branch.
>>>>
>>>>    arch/m68k/Kconfig.cpu | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
>>>> index 16ea9a67723c09dc..9abddbbee819f1d3 100644
>>>> --- a/arch/m68k/Kconfig.cpu
>>>> +++ b/arch/m68k/Kconfig.cpu
>>>> @@ -327,7 +327,7 @@ comment "Processor Specific Options"
>>>>
>>>>    config M68KFPU_EMU
>>>>           bool "Math emulation support"
>>>> -       depends on MMU
>>>> +       depends on M68K_CLASSIC && FPU
>>>                         ^^^^^^^^^^^^
>>> Whoops, that's a silly typo...
>>
>> Are you going to resend, or are you thinking of changing the way this is done?
> 
> I was going to resend, with the above fixed, and an improved patch
> description w.r.t. the dependency on FPU.
> 
>> I had thought that CONFIG_FPU enabled meant you had some type of
>> floating point support in the kernel - be it hardware or software emulated.
>> So I don't have a problem with this "as is".
> 
> That matches my understanding, too.
> 
> BTW, I'm not familiar with Coldfire FPU support. Does it rely on any
> emulation (e.g. for transcendental functions, like '040/'060)?
> Would there be any point in making the math emulation code
> Coldfire-proof?

I have never really looked closely at it either. The FPU is optionally
present only in the v4 cores. But the operations looks like just the
basic set to me, so I expect it will need emulations for transcendentals.

Section 4.4.3 of the CF4e Core User Manual gives some guidance on the differences
between the traditional m68k FPU and the ColdFire FPU.

It would be nice if the code could deal with ColdFire FPU as well.
For the most part it looks possible, but might end up a little ugly.

Regards
Greg



> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
