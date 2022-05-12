Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0006352583A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359446AbiELX0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354801AbiELX00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:26:26 -0400
X-Greylist: delayed 185 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 16:26:22 PDT
Received: from hfcrelay.icp-osb-irony-out6.external.iinet.net.au (hfcrelay.icp-osb-irony-out6.external.iinet.net.au [203.59.1.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C35D1EAC2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:26:20 -0700 (PDT)
IronPort-SDR: 6ED5Nm2L9KnP/3fOBxfIkd6wEWdTDOcmkgDiNW+dcYpVa+dZGr46kt9pDtiFEYr3ZcG7bQdZCQ
 QzzNDaA6Tw9DP1VjljiTbvGjzAnxQ2WtdNCwFvHhlcvJJdVhyHl13PzWZT/lCvamUVlUjyXZOL
 PHI/bK6GftBf2S8amzlq9+Dyp2+jlUdAmGQmp3gn3bE75wnoVFRZGwlB2SiAlEn6vS/dNWrjDP
 3xwER9pjucNUN3cns+PcV+MOdQyVYGaAVrndhLOr+P4wDfiCxKe+Mw7cei40Hhqk0yZXhb5uvj
 j3w=
X-SMTP-MATCH: 0
X-IPAS-Result: =?us-ascii?q?A2BqAAAaln1i/0gv8TwNTR0BAQEBCQESAQUFAUAJgTQGA?=
 =?us-ascii?q?QsBhHWETpELA4skhHeCB4pCgXwLAQEBAQEBAQEBSwQBAYIOgnQChT8mNgcOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBBwEBAQUBAQEBAQEGAwGBHIUvhwkBAQEDIxVBEAsSBgICJ?=
 =?us-ascii?q?gICSQ4GDQYCAQGCea8feoExgQGIGYFlgRAsjmBDfYEQgTwMgnc+hAuED4JlB?=
 =?us-ascii?q?IFok3QoBA8DHTiBBhKBIXEBCgYDAwcKBTIGAgwYFAQCFRFTHgITBQcKHA4UH?=
 =?us-ascii?q?CQZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyMLAgMYCQcKAx0IChwSEBQCBBMfC?=
 =?us-ascii?q?wgDGh8tCQIEDgNDCAsKAxEEAxMYCxYIEAQGAwkvDSgLAxQPAQYDBgIFBQEDI?=
 =?us-ascii?q?AMUAwUnBwMhBwsmDQ0EHAcdAwMFJgMCAhsHAgIDAgYXBgICcgooDQgECAQcH?=
 =?us-ascii?q?iYTBQIHMQUELwIeBAUGEQkCFgIGBAUCBAQWAgISCAIIJxsHFhkdGQEFXgYLC?=
 =?us-ascii?q?SMcCiQNBgUGFgMnOAYiARsCUpcLexNDgS5aHjqhWZ8Mg1WfdAYTLahTlmWpD?=
 =?us-ascii?q?AqCBDMaCCgIgyNRKJ0CYzsCBgsBAQMJikaCSAEB?=
IronPort-Data: A9a23:d9O0FKv/WTRWE0Nh5Zq3gi/MWufnVCZfMUV32f8akzHdYApBsoF/q
 tZmKWrSPvmDZmryfI9/OY2z8R4G75WHxoNjSFZsrX89RnhE9ZqZD4/BJB+pbn3Oc5bOFUg45
 p5PN9DKcMlpEnSC/R3xa+iwpnRV6/qFF+H2YALm1oCdZuPFpAMJ008LdzsR29Yw6TSB7oLkV
 era+6UzAnf8s9JPGj9SuvvrRC9H5qyo4mtF5wZmPpingXeH/5UrJMNHTU2OByagKmVkNrbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36ZGBivkFrt52K2XCukMCTPpETb5LwYW8P49mAt4wqk
 o0V7fRcQy9xVkHHsLx1vxVwT3okZfUekFPKCSDXjCCd86HJW1jC8dQtS09vBJUj2uhFGSJp9
 qQUKQlYO3hvh8ruqF66Yto1155ldZe7ettZ4CtVpd3bJah+B8qfGuOWupkHhl/chegXdRraT
 8UUczVHcR/EYhtSKhEQEp1WcOKA3SekKWQH9gzJzUYxy0zJyVFJi7XUC/7yWfrTT4JSkx2Ki
 32TqgwVBTlfbrRz0wGt/X+hnPPnmSL9RZJXEePo9bhtmlL77mgSDgAGEF7l8fqRjk+lR8kZL
 00S5zprqPZi9wqsVNaVdxm5pmOU+x0RQdxdF8Uk5wyXjKnZ+QCUAi4DVDEpQNglrOc3QyAn0
 hmCmNaBONB0mOPNDCjBr/LI8nbtY24JNWADIyQDSE0M/rEPvb0Os/4Gdf47eIbdszE/MWqYL
 +yixMTmu4gusA==
IronPort-HdrOrdr: A9a23:9HB8+KzroiRNxeKs69BMKrPw9b1zdoMgy1knxilNoH1uA7Glfq
 WV98jzuiWUtN9vYgBHpTntAsW9qDDnhOdICPAqTMyftVDdyRGVxeJZnPffKl/bexEWn9Q1vc
 1dms5FZ+EYZmIWsS+V2meF+6tJ+qj+zEl9v5a9858QJTsaDJ2Ilz0JaTpz5XcGIDWurKBJca
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,221,1647273600"; 
   d="scan'208";a="363217664"
Received: from 60-241-47-72.tpgi.com.au (HELO [192.168.0.22]) ([60.241.47.72])
  by icp-osb-irony-out6.iinet.net.au with ESMTP; 13 May 2022 07:23:14 +0800
Message-ID: <db869491-142f-4360-0f3c-e4395563088b@uclinux.org>
Date:   Fri, 13 May 2022 09:23:11 +1000
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
From:   Greg Ungerer <gerg@uclinux.org>
In-Reply-To: <CAMuHMdW3BsuJOx6r1TmUJJYhqn_v5iDznTw0gnbayQAjBp2OYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 11/5/22 22:54, Geert Uytterhoeven wrote:
> On Wed, May 11, 2022 at 11:48 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> If CONFIG_M54xx=y, CONFIG_MMU=y, and CONFIG_M68KFPU_EMU=y:
>>
>>      {standard input}:272: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.b %d1,%d3' ignored
>>      {standard input}:609: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a1){%d0,#8},%d0' ignored
>>      {standard input}:752: Error: operands mismatch -- statement `mulu.l 4(%a0),%d3:%d0' ignored
>>      {standard input}:1155: Error: operands mismatch -- statement `divu.l %d0,%d3:%d7' ignored
>>
>> The math emulation support code is intended for 68020 and higher, and
>> uses several instructions or instruction modes not available on coldfire
>> or 68000.
>>
>> Originally, the dependency of M68KFPU_EMU on MMU was fine, as MMU
>> support was only available on 68020 or higher.  But this assumption
>> was broken by the introduction of MMU support for M547x and M548x.
>>
>> Drop the dependency on MMU, as the code should work fine on 68020 and up
>> without MMU (which are not yet supported by Linux, though).
>> Add dependencies on M68K_CLASSIC (to rule out Coldfire) and FPU (to rule
>> out 68xxx below 68020).
>>
>> Fixes: 1f7034b9616e6f14 ("m68k: allow ColdFire 547x and 548x CPUs to be built with MMU enabled")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> To be queued in the m68k for-v5.19 branch.
>>
>>   arch/m68k/Kconfig.cpu | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
>> index 16ea9a67723c09dc..9abddbbee819f1d3 100644
>> --- a/arch/m68k/Kconfig.cpu
>> +++ b/arch/m68k/Kconfig.cpu
>> @@ -327,7 +327,7 @@ comment "Processor Specific Options"
>>
>>   config M68KFPU_EMU
>>          bool "Math emulation support"
>> -       depends on MMU
>> +       depends on M68K_CLASSIC && FPU
>                        ^^^^^^^^^^^^
> Whoops, that's a silly typo...

Are you going to resend, or are you thinking of changing the way this is done?

I had thought that CONFIG_FPU enabled meant you had some type of
floating point support in the kernel - be it hardware or software emulated.
So I don't have a problem with this "as is".

Regards
Greg


