Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4E0526FFD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiENISA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 04:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiENIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 04:17:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BED8;
        Sat, 14 May 2022 01:17:41 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mbj3e-1oLHQZ0uJK-00dFtL; Sat, 14 May 2022 10:17:09 +0200
Message-ID: <d130ce59-1a4b-901c-d038-07515db746ec@i2se.com>
Date:   Sat, 14 May 2022 10:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] clk: bcm2835: fix bcm2835_clock_choose_div
Content-Language: en-US
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>, regressions@lists.linux.dev
References: <20220428183010.1635248-1-stefan.wahren@i2se.com>
 <20220503145804.b2xz4etzc6kpr3fk@houat>
 <ee39ddd1-bfce-012d-5e04-448d779ed995@i2se.com>
 <20220510132756.qmyjca53xu44iwn7@houat>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220510132756.qmyjca53xu44iwn7@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:r2U+3GHILFBJRwdN1QPH4ahI0ZnQAgBHx5ON/pp7+M6xKkOOU7B
 cDh3ez2wjRJDVkrRmJyZwqRX20qLK1h0odGOKQA2gTvVdOIshrolMPvO+ltIotrDkCOtZNv
 LiY7PFDCv4rd6871n6rH6mVZPgjfoFEW85IhYK6dJd44NRceaaeueFrXBEdw6B6E6ArK/SB
 c4xfRAYikG3kU9drmxyug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OBUcdSwGzvA=:7kGSMmYVHvANedwOjmE35m
 SzdqVBJwDVp9wf95BaSpp3sfWCU4L4eNupi1Kk+MfxmfgsDIrCEsZ8raEt2qcUZGVa2pHV7yy
 fcGYyYA4dRRVjNLSDjx0rEAjq5hba/B6WdJsEoy/lsnaRzUgHjg0gU0lrvxFUM2D+3yNRVABR
 ZGGHtQVu7SGQm1nUgScsxQVFVur89dyT/bSSSzvHqNmocn/6s2wu9NPPcTIz//6DMs4+4avjz
 3hbnW1KFFA8F1VbVMWDbLBzD38/cQCB37EFv/lODaFi74u2JYDq5vs6Gy8Adqc4Kz0EE9ywBI
 4pobsDdp7eu/Oe5iT6P0KZaT47dzaNJVGSoYOZcRSKEftQ17Ph/wxaTz6Iajk7/fT2XtgFNLV
 IhFQEjRwHG9jlmgLQ+zz3HJ/piqnqMl092hVk/UB99bmp+mIdkhZDOEOWkdxK88lyFpIblB67
 ui15rI9kZThCBe34+KZVA3KtDdKBLGlYKee2Cxh0NCcShParsWRB6rYWhLKBtOy4YJuqacbeM
 Tceoun7RySowctJv9QYJST8OitRLcbuQwKamXV4gTVABcVCKs6zhfEmzELI82lWPnWufgHtCm
 plNtvNzjQNlMhylKibpNSMsedV+uPonc7BCxL/Rdr490wpCQmc1fc/bpdlyWoSsg+JDKl5dRi
 RP7Oaj0/h3aBtA0HDsX13QMCt6v97jUf7tzCVVySjnRasWRhCNIYnh3NwHdgMqdEc7i14er5N
 RX6jO9XoycglYTeatOVWytW1rkDApoI3Lrn/A1e+QF1eDQAedtgUdJd+ogk=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 10.05.22 um 15:27 schrieb Maxime Ripard:
> On Sat, May 07, 2022 at 11:26:28AM +0200, Stefan Wahren wrote:
>> Am 03.05.22 um 16:58 schrieb Maxime Ripard:
>>> Hi,
>>>
>>> On Thu, Apr 28, 2022 at 08:30:10PM +0200, Stefan Wahren wrote:
>>>> The commit 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
>>>> accidentially breaks the behavior of bcm2835_clock_choose_div() and
>>>> booting of Raspberry Pi. The removed do_div macro call had side effects,
>>>> so we need to restore it.
>>>>
>>>> Fixes: 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> I only found this patch after debugging why the HDMI driver was
>>> returning -EINVAL at probe on -rc5.
>>>
>>> Acked-by: Maxime Ripard <maxime@cerno.tech>
>>> Tested-by: Maxime Ripard <maxime@cerno.tech>
>> Thanks,
>>
>> does this go via clk-fixes?
> Yep, it should.
>
> Stephen, could we merge this?
Is there any chance to get this regression fix into mainline before 5.18 
is released?
>
> Maxime
