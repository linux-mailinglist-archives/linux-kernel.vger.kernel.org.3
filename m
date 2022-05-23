Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F4D531A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiEWTr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiEWTrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:47:55 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA6F20BC4;
        Mon, 23 May 2022 12:47:52 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.139]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mrh9Y-1nYAQI0bTQ-00neu2; Mon, 23 May 2022 21:47:30 +0200
Message-ID: <129470ff-7570-4643-2dfc-3a187b3fc39f@i2se.com>
Date:   Mon, 23 May 2022 21:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: WARNING: CPU: 2 PID: 3331 at drivers/firmware/raspberrypi.c:63
 rpi_firmware_property_list
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Phil Elwell <phil@raspberrypi.com>
References: <CA+G9fYt4+47GzfEYT1nV3dqbGa1YCwFm9XwC668D4PkK4BHFgQ@mail.gmail.com>
 <55d49dea-1a67-d857-218e-ef2343251361@i2se.com>
 <CA+G9fYvF7HGmJQtk7ktmakwQNjjraK3EoBeiMr+3NuEvsixi6Q@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <CA+G9fYvF7HGmJQtk7ktmakwQNjjraK3EoBeiMr+3NuEvsixi6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m6/4BZrp4B84xb75d/EtlTmi/xvpNb1VeM2r2H289cbnhPS6zJm
 x1qPfrXpQ1sI+cv+xxufaCiZQkc56HTa2kfr/ltVUIwSIsWczi1Liu08nSuDvebaGbS+UcZ
 3m7aSgUNn+4rMQsi+Q4ELiecsQfniNKEB+qJShNzw4iY05kLyI3spREwlWNlO/JOR65lCHt
 hiFE+MCxa/yAgsto+gGgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:88f2pVyoHx4=:dURGxktMBAWL627wqIjt8L
 7IIu1xFlzAwh8n6CWQAKfdOomlWjNTesH1f6ALujCWIclGt6p6Zz7F56QHQeajSK2tjkHhPrT
 osFQ3ZkObxbpeYj7rkRJ4AObv3gSOaVs1jH2RCCYn8YICoIldU0q+Nb8Vn3C1+jn/E5WovKnx
 EbjwvgonBWF73f3740UYW1B2ZcfO2AQWBriaApJcLaC0Qy4/KxG9OL4lzkklEMcngT5iseXsO
 TYT+8anx4Ypse6IGQy1LUTOoUG/9vIWEd+ZzYm0FA0dBssbfkmwQMJfBkb0MPJkjY0nFEUgDF
 5bz7lKXKw67cqRue/kXfKtl6H+1twKZp43QB2t1bGsVbl5VMKPzwAQD/v290Y7iU46hJLSUu4
 ECUAFRDqmH0Kd78M7WrBWEivYZw02RA9EZgt+uWaED3xSjO/PPIdUXmBT0Jwv90SPOwnkuqIk
 dSAE8z+y1f2p+ukNM3/LEf5yox5sCaJQGEDX0UCsqbdzuMY9Mx2SvVgpRs8TmFfUWpMirvyjD
 hn+KdKFg4GPnjmYX4A6I65Jk3M1GSTPJNVYebOcLD02vcHGi96bPqaJwvGA9vFfDLOgLL4RWB
 PnyHUEzAECUKh51PA34ghYB+8iIvr6GHniHF+0zYza4FTshsSZd1xYkVPSG0MGe5+OspbMaNm
 7hvVFu+493N9UhrwD87+7rAtLbyE39A5hM4hOuCBBTEm3j4WiyncxhdHQbRgyopozjVrT0Er/
 LGNgPFV3x+k1Xy0NlwiMCfE2AgC17KTfrPilvg12kGmcBp+uoE6MBXeNFrs=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

Am 23.05.22 um 14:35 schrieb Naresh Kamboju:
> On Mon, 23 May 2022 at 16:43, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Hi Naresh,
>>
>> Am 23.05.22 um 11:04 schrieb Naresh Kamboju:
>>> The following kernel warning was noticed on raspberrypi4 device while
>>> running LTP controllers with Linus mainline kernel tree.
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> metadata:
>>>     git_ref: master
>>>     git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>     git_sha: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
>>>     git_describe: v5.18
>>>     kernel_version: 5.18.0
>>>     kernel-config: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/config
>>>     artifact-location: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu
>>>     toolchain: gcc-11
>>>     System.map: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/System.map
>>>     vmlinux.xz: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/vmlinux.xz
>> thanks for your report.
>>
>> Do you know this worked before (e.g. 5.17)?
> Yes. it worked before.
>
>> Am I correct that you are using GPU firmware 2021-02-25T12:10:40?
> Correct.

Since i also experienced firmware crashes [1] with 5.18, it possible for 
you to update to a more recent firmware?

Best regards

[1] - 
https://lore.kernel.org/all/3dd4e0cb-8ba5-e0c7-cde5-29c56a5caa95@i2se.com/

>
> - Naresh
