Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46D851E609
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446154AbiEGJay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354899AbiEGJal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:30:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AE454FB2;
        Sat,  7 May 2022 02:26:54 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7Qp1-1ntC1L1FW9-017pmc; Sat, 07 May 2022 11:26:30 +0200
Message-ID: <ee39ddd1-bfce-012d-5e04-448d779ed995@i2se.com>
Date:   Sat, 7 May 2022 11:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] clk: bcm2835: fix bcm2835_clock_choose_div
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220428183010.1635248-1-stefan.wahren@i2se.com>
 <20220503145804.b2xz4etzc6kpr3fk@houat>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220503145804.b2xz4etzc6kpr3fk@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TISiMMp8m/FV5qPKCF9n1osclmv+q2upYrueyJsVP9zlp6+v8u/
 dsk6fIGXhBVsiBaNwaN7QJ48EC/uL3zPRJWA39tnzUGtlQFN7ttJcUSnR6/Q8D2EHeTzVnH
 /KeQPVdsml1o24kI9JF7ZSud1R8Kdy34Xx5oQ5upZ/WKT8E45VvmsiHAnDUfoVkOs7Zdm9H
 FyCOQ26WpBkYBYI3vTT/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D0xWmPYIj00=:0PpTuUQc4n477rQ1kB0JQE
 DpBvR39rz31Z2qR4SJGWF05OkxhYTkuwhyO/NsYlI4g7I1Qu8zjsrKPz8vZZL3BpQoPUZUdNR
 v+fLBC4JezVsRvjoCLxEPREHJ55rObO7f/fnOWis6y9SxgFudWG6yXDghEBZu+H81gWIGxi+Q
 /YTGbVW1gIUxqd4a/5Vz1ktirIfad6ukiUQo65+nY2vZx/aoryGQ+DVINSs/+3m39fgzYJA02
 lmKvHOv/wxeMIpMe8DpQmv4A8UJx4DszXTxj7vcaRi0WLlMuxoJuPh0TWVtaMxP5Ah7QSjNHt
 t4sKGQ2i8XEtHrYM5VvRrNNJz7vvTVrdngteWYY8o55DYlNfp3nQzqbl87DjJAd4jKFTCueUv
 A9VQ+oBcQbf2X40OpAaYJCLprM6EzbLGxwEUW0dn7KBmhNCj6Zm9KQ4DpW3HQiwHCeujo9XqI
 SUTl5D9R4NvIK3gjmHVf79vf33CA/92BxwsilIkoEU286zNUas8oRdKQsYnKDhb7ev3mfXpbq
 qBvGB+vNiGS58G1rYH1skLUTV7HPNBIW3ikGgsrhlVV19xjPg+Lu9P2G2OUEoc/P5legIt88m
 kLbwrkiX6DNq2BZ1wpDhVOa3Bnlc5Ao0zdJJZJ7CvYvrZM2Gy59/LC87PQf3M5W12Bx94sb0Y
 wFR3Bn9EIcWbSyJGi/vKS8nws7Z+zCHdfbX0orz1KJANrAkWZ5iNw82yH0+1EgbU2ivXPalBJ
 3PVR7DOW/dJEvpIo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.05.22 um 16:58 schrieb Maxime Ripard:
> Hi,
>
> On Thu, Apr 28, 2022 at 08:30:10PM +0200, Stefan Wahren wrote:
>> The commit 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
>> accidentially breaks the behavior of bcm2835_clock_choose_div() and
>> booting of Raspberry Pi. The removed do_div macro call had side effects,
>> so we need to restore it.
>>
>> Fixes: 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> I only found this patch after debugging why the HDMI driver was
> returning -EINVAL at probe on -rc5.
>
> Acked-by: Maxime Ripard <maxime@cerno.tech>
> Tested-by: Maxime Ripard <maxime@cerno.tech>

Thanks,

does this go via clk-fixes?

>
> Thanks!
> Maxime
