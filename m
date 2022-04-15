Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2E55026CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351408AbiDOIl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiDOIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:41:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA39B644D;
        Fri, 15 Apr 2022 01:38:54 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7RHv-1o053a1yXN-017pkv; Fri, 15 Apr 2022 10:38:39 +0200
Message-ID: <117b7806-b394-7f8e-af4d-7db4d6108526@i2se.com>
Date:   Fri, 15 Apr 2022 10:38:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] clk: bcm: rpi: Add support for two more clocks
Content-Language: en-US
To:     "Ivan T. Ivanov" <iivanov@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220405082503.61041-1-iivanov@suse.de>
 <20220405090431.ktlybn62eueh7gqi@houat>
 <20220415074839.5ma5n57rmhv7tk4s@suse>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220415074839.5ma5n57rmhv7tk4s@suse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cZgK5sTZHfGRZeyxtgFg8pVkqJDjSp8tYu8rmtAorm2jijl5Dxl
 VXBWtP/oHE875dzas7+qhjMrSVMjgS0+cxarXqmjVWR0I7J7K+oE9bf2PlzHxr75w+at4BM
 ennNT9PZWMdrPzVg3zjxTOtB5WSdEMXNydOXEyFTDLP8eeWayusQkF4/SVN1BiqP+LgVz7D
 tESLpDVKrrOl5AUYlmUGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H8vQr8KjXGA=:WTzYYnsU7oX/1ocjDoO0as
 YnaX6vcbca7piDsyA9FFDIDp9O4APmGVLfAHzDTtxBM6lKkxCwMuz2Iegh5VCPWbp6pekutKt
 sShP2BN4ywHTxkbeq1R0jfoQTsveleJsMRnVMELk6DAQwlpSSX7/YpePpCDR/FuRYmJxtAFqx
 GOXa2VcIIAyztjGy5io5Fer38AAjpF5MhuNBL5SluJDbNfPkhPH4OZNjEdlEr0e+VqKACurXb
 5euxQVjwqnTTYg+nHBv7KSRhLT7ahguCU5PFNt2FtMIsyEmSzLXviPy6MAOGQJOLWNhLite2y
 C6F8Eg5jRDmONcNZm/U4K7L8vM28vDBmM/sVumsxvHNGZYxCMXFf/gqIg+n/VK/or3BuSCa6o
 OVgRQ8B+j2ajvGPZMhbEcVi5000eRzCbxd+La1AuIN5YSkb7SMGs0QAnurV7t+U0nEW/evMce
 ROM2d6pjhMPKLhPozC9bIzSvgs592IgxiKQgtnpWrjzPApWtbs2FCpMj2qMjIGKwzQHcQ5p6T
 XW46Vy7bT+YqkaiC1NuMNjeIBrRnAc0lPQRNodzi0h6tDOWbLeHFeeTRSUFl3Tua5GFkLXNbn
 cYciQxfNnbU+rS+BB8ZzLiGz1XzTIA5nM3V1/Iwj3/pMVb3DAImIzRMWNx5Bm16QUAw2GNSKD
 XzSGTn0FLeR+Iul39QiZKQl9B7munn3HheqwuJgxzmw9qbduoWFT3UdEACNEHuJ44zD6buojo
 31vyxGkwdAFZEKIF
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Am 15.04.22 um 09:48 schrieb Ivan T. Ivanov:
> Hi Michael, Stephen,
>
> On 04-05 11:04, Maxime Ripard wrote:
>> Date: Tue, 5 Apr 2022 11:04:31 +0200
>> From: Maxime Ripard <maxime@cerno.tech>
>> To: "Ivan T. Ivanov" <iivanov@suse.de>
>> Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
>>   <sboyd@kernel.org>, linux-clk@vger.kernel.org,
>>   linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v2 0/2] clk: bcm: rpi: Add support for two more clocks
>> Message-ID: <20220405090431.ktlybn62eueh7gqi@houat>
> Tags: all clk linux me ring
>> On Tue, Apr 05, 2022 at 11:25:01AM +0300, Ivan T. Ivanov wrote:
>>> Add missing clock required by RPiVid video decoder and make HDMI
>>> pixel clock more reliable.
>> For both patches:
>> Acked-by: Maxime Ripard <maxime@cerno.tech>
>>
> Any chance that this is merged in foreseeable future?
> Do you have any comments or objections?

could you please send a new version with all tags and consider the whole 
audience based on this patch [1]?

Thanks

[1] - 
https://lore.kernel.org/linux-arm-kernel/20220409184017.114804-1-stefan.wahren@i2se.com/T/

>
> Thanks,
> Ivan
>
>
