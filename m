Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B74E4144
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbiCVO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiCVO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:27:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E9D3524D;
        Tue, 22 Mar 2022 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647959143;
        bh=MbjQ8ngPUYiViOJVeuhy6MOj6FjhcYketyZ/x/URxDw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dSmhOUHUpwLP1/2+yUaoB+QXL6Xp43zmNf6riSj8CALGp/90RpCXHnS1qC7tYtn0C
         f0U+V7WsSDfiLwUJCx8RN4zrV8zOPBp0Kyp2zNYNoh28XRXrSW1p6MWNHYKGLdRaAo
         /E+GrsGziPUWFQRwCyTdf7uF491JVDyH/GFZc5KU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.132]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1nPHBg094B-00AjLy; Tue, 22
 Mar 2022 15:25:43 +0100
Message-ID: <ccc25312-890a-a534-1681-5ecde56328d0@gmx.de>
Date:   Tue, 22 Mar 2022 15:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: hppa vDSO and compiler (non-)support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
 <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
 <dd4e55aa-0b3e-6e18-7ec2-3bec02cafde0@kernel.org> <YjjJNb0D/b+ZXBVZ@ls3530>
 <28696c20-21ad-b0ac-8093-4ce07225fcd8@kernel.org>
 <812d4a38-8cb1-a7be-c504-87d095aea883@gmx.de>
 <20220322130516.GA724287@roeck-us.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220322130516.GA724287@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EgWnZNVwca2AUlh8w37+u3MyrL47xG7BNA3Zr9Qrbdit1BeFxgg
 hNq0sF9Vqx0LnHbiGaTTlFU6WuYLz8aNg7WB/NE6eRkYhtFof7TBiX5MujTzhl+NnqZT+lK
 KsZn34r35cL0jPSuYEWwp5He1upIRIC8azDHint56ngabeuy56ldceaUtU9WxiftP7+I2Lm
 TbEKQoMwc9c6oEpP5SlrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KAbXK5HtyYU=:0fSj6y84YXVhn/c3PAkC84
 WShaij9f2A0ZRBvyJup81BiQ0kpkGcawgYQuYzy2HeqOwm8FoiS4ighpzPu8QOzNpd2onZome
 kmcNLqhPW//fFEfK9TF1CYmn9jt/gBos81dPIX3zsi7G++WYZGFuRA+aUZc7TT92BCD6cdSCx
 ivvL/dEBv+QOd+YEg8sochV9rpCdCQovf1hmMopqsWCuDzD75GWkIFMADcqbELrvfxpcRqoCc
 DFfjUr3hmlymPAfbAxeC7E+8NAWAbTGnG0X3hq/F6Qd4W85uQMspUAJGYFn6NkjKcLQ7ptGs4
 cgDjWqKfh0nek9X4cDOW1IxzL+yOjbolq3tsuIKRfibUrTF209YB4h2XRdzgo8Uy5Wk3ddBK5
 tJE0OZEX5Qhjd2YJNXqJ3jtlfZtRc/fLnjmghKewurqd8IC6oDbLl1POfXEXGOsmwPqjl+gz7
 0+fwVFdLbpJKLuqV9Xe7CSMJ3Fs2IhRCCZXHEjgadnTIYsb707QkDKWC/gJkQ7TwbAnzfPZgw
 gSUQFRABOUqjguEwFIplWjrSOH6SsxU9MgYBfBfVSu6oQZ5TEnjozQVkr+QNX+lfCqkqm7RA8
 q0u7V6uFzlpP91iljT+hTnkuocP2XQvXGRC7s+Tdx1EHwQe6RheYsUCUqyjU++vaWrTggoCqI
 ShE7DRfPGd5tBj42mUJh/OMhltZZ9og1VzrE0PQ2qSQQMM9Jr+GFZ5XT6eh6brxHtgZU5tZBb
 9HbsWFcHmRuF4B1jVvX+WPRrxND9x2M7qXFAjbwrd0i2BtonV6PsHL75Q4vf5lpmOQICUWMWw
 NjzIWFu8BCcSuWY7SpnyHtHHgtlNgTyrf6fwy8gK44ceUfqHiaz1RawM6CsHBEX9vWHLnhPTE
 PJXMen43ZgkjkQnbFsIdChiY2VoiNh2pvSyckuyZ5Fon167jzXdDTE7hlbi4V0trmRf42cKLH
 1P5op6iVBHFM7fGIruw1kd+QepCHIK4qWqUPxrOE73s9uOroZJEsYD43nTLan/5WepIgWAyfr
 WDz67kwGeMfBNn03yf/7pAkwIRyTCoKQMxxlLWhEe6Qd4cIrDI9DI764TVesErKdODDJzoYNJ
 chQadze1CnUJsA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 14:05, Guenter Roeck wrote:
> Does that also fix the build problems now seen in mainline ?

No.

> Building parisc64:generic-64bit_defconfig ... failed
> --------------
> Error log:
> arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
> arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.pro=
c'
> ...
> arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc with=
out corresponding .cfi_startproc
> make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/=
vdso32/restart_syscall.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/=
vdso32/sigtramp.o] Error 1
> make[1]: *** [arch/parisc/Makefile:177: vdso_prepare] Error 2
> make: *** [Makefile:219: __sub-make] Error 2
>
> This is with hppa64-linux-gcc (GCC) 11.2.0.

Can you check if you have the 32-bit compiler (hppa-linux-gcc) installed t=
oo?
The errors above happen when building the 32-bit vDSO, for which you need =
the 32-bit compiler.

Helge
