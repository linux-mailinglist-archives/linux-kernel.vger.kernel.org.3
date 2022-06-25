Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F3F55ACE4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiFYWUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiFYWUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:20:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28C13CC0;
        Sat, 25 Jun 2022 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656195613;
        bh=elP5Ix8g7dGoColM+2BwFdyvDAU4gFD7NlbDYJejqd0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jNcADOpPp2BWVVWMZHY+0i8w264xCCPzErGVsmU3TGN4Kz96WAXuW6LVcAUUVr5NZ
         3m0/nIycDmR6QU2Pxvd+5vFRVOlj2QtDP05W4fOozAepf25kIdsDyXvgHwE5U1axsC
         iwbVbg3cILhYgysLchlVbgR7F+IubS4B2rq/IYkY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.162.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKUp-1oNAG33kuV-00Lp8w; Sun, 26
 Jun 2022 00:20:13 +0200
Message-ID: <6d2b4f81-1715-2b20-d419-e661ce7f92bc@gmx.de>
Date:   Sun, 26 Jun 2022 00:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] parisc: aligned '*' in comments
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Jiang Jian <jiangjian@cdjrlc.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220621063823.22064-1-jiangjian@cdjrlc.com>
 <202206241039.B98CEE0735@keescook>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202206241039.B98CEE0735@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ORik/xWtQWRS21tF4PV0igGhKOW3f14iu2VijyVfKZ3ZnI2waWw
 WFRXhrw7YYsk5BFM7ryfOBy4DIWVDVOE6eJflJ/0FStt20/cqXJNdCCD7dTABE6MdOmEiuP
 mUnRaULHpa/WDOg+ItAdbM5gZPAylh+tYMoXY6Vuu22pv5CaTU0BwHIEfcNly29oFg6PyrS
 DUl09OkUk9i6uVrMaB8Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GEyCDEOsuQc=:u9+shoKvA3y6I4lHTQzxeP
 blRUKmcgq6aCsMVHTJGoPyzfZN/K7HHON6kTLPnY6UG6FjTGSHXR7sHzteYix4lkh3B3pd3Hh
 +1uW0zlS7LZHph/xWlIA8gyjxqw0gOym34M6HqFN9CIrh/JhUhVPUwKMQgAXP+Lxu8HxrKS/M
 jJLEwmEA55PAIjeDg5/h+BtMjKiDoMwS2gsvKrfYWupRPUi3IVep1tOdpyhgrMwRHoisOk5Id
 3BVd0bSAKBrGcba9cHAISqGwLCHzDanmAGpojRiUwsun6Hzu8u2qmsIVs51LuXRNnOgTolaYK
 WLAwSPn+jtvY+T0uK01xX7C/i5Z/ffiNRzHVuMi3PO1B47qTMW1o1YuGEObRUj+wFs22b/E+S
 jSYCxdwaAbTa+0h341HPCaTO3bmfB2eShZNqAHnLCLYHZ1y9t/hkxKVUVvspR8vvLyeSY/T99
 XdVQsIyroz7ssdsv4RCqXzjhSRnXXy7n49YWqZbHdfYQMHzGn6zP+z9+gIilYedjmKtM59bJ6
 2GACIuquVME8sM17YkIjhVNgbX+w2McX3ZQ/3Gu/uj7h7J03RoGrDbVPVwfhAOWbuh8fHloY3
 FxgEyOG2wYv0t+AKWdbskobnGVvI7FeUjPK3G9xqVG9FL4Bd+dutSedhfyxAQ4gLyYw5vVTs7
 Fv+5HjBEOxaarggpDpFpKEaFt8EIWrGKfsb+A9ehYlKyp4JueRheGBvuonad+oudrkjRZyQOl
 uL93K9UZWasTPvNG1U4wzEezNDlWJj22mzT0dxS5k98tlvvKqmmjBxbjS+wi9jhlQoKAXIu/6
 LerS7wbzkiyUoAX5cd2HgHAnG0CLsss2HtXJ/7wrcNsJAecDbDs0w45pP7WbSuVT+uxCRP+/+
 P/aGXkWdJ29HDsRuyLerTMdanBOAM+HysOr2mgbdM0+23NV9FhFc2MGCTh3+8/mkECGp6Lo6e
 ONPutf0fbDaqzbUKeef+qNRlyBda1XQQGd2kESlo9Qsm1skOin1bvgLq1Vq0y0cI48mjvio6b
 ypOOGcO6qjIRjR/B1laZq1I5ck3SbohfYCy8lg2sQXLA5hsnjNUQh/In44OdJLVzyoRxEnFIS
 A0X7oa2Xz4rL/ScBYz7uvHsrXEJOMA3fMZymDpH1tmp24HOS3sojt4m5Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 19:39, Kees Cook wrote:
> On Tue, Jun 21, 2022 at 02:38:23PM +0800, Jiang Jian wrote:
>> Consider * alignment in comments
>>
>> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

applied.

Thanks!
Helge
