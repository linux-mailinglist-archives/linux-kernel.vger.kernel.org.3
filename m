Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C250BAF4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449078AbiDVPBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449081AbiDVPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:01:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D315C874
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:58:47 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mtf39-1o2LKa1H6V-00v3tm; Fri, 22 Apr 2022 16:58:23 +0200
Message-ID: <97917592-6e11-dd82-3f41-893da6b15f6a@i2se.com>
Date:   Fri, 22 Apr 2022 16:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: bcm2835-audio: delete TODO
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220420174401.305964-1-athierry@redhat.com>
 <YmK+aiaaVLtadGVT@kroah.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <YmK+aiaaVLtadGVT@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Azmqdv5Lw8395Uj2ssTrSrEqmg++rKEqbcPwvcaegaDqayqaqIs
 SsGECzmDdFaH6Xlmp/FP5hGO78ro+uhiEqqhHa09IuZBWZyiU7DpEDs9VIHDO2k9CHG4KkU
 1SlWrjIG+ip3d15C7jxOqMpAIojNseHgryDbSQA07BOxexjbfk0/QbPbOtXJCmKUOAAwYl4
 k1dakxRpyu1wsqRWUdiuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8UNhkHDGgk8=:TXJ6ezpD3AR+ZOTQCLTAeN
 +9DM0d8RCT8EnSyTgzO0qJxUrQDxGgr4XTKBL+lwznSO8RTgZleuY1AN5AxwDRIefH9X3avph
 vwm1RbXkTjjdotnZEUEQuSQKxUKxYDcyV+wPSE0Cv2gxwA0JTsJ4mcfCqXb+TmAqC4iEuR/FD
 m3Ehq5Cg0Oio9tvMjS6gjLE4WZiHaWqE7/JdX/c516cV+9RHJBFGMh9zeJsX8PPF961OgDhu1
 NOE19kZLtBMfUCjltOtiwvQzXfpqYo5OqI8Pp0HlTBiHTE5ocFM3C00GEL5EHvnKo0ti41xMx
 pFXslPAzEmjEsTb35cbIB+m0jej/15/IWvAnqVxFiOt5L7FQHO+M2aDLZw1nLTiM15baOD3EP
 krVReAemM9Jpx0HrGx3MSYHH27gIIBd0aZS1Jf6/DfzkF5rNIo1Gk1dmo0aNVxSpRa07/Y/gV
 ge27m0ubOBoKP2NWt1402o/7Czjtvt0K3Hgeyazs5kUzMcpbNdPWPTR19vJauvTfRJm+iI2O6
 uRYkFYHsuD8g9qflhwgOadU1Zix0ePNNEkACXpp27cQcWj8+uwGG5iFDIIjd1Z7wAoLT5pdtX
 xnoO7W5cBr0OJJIRMFJyS4TuMUyK+icdYv0pCNwbzf2/F/azG7W7xbSLtXz52S0wd9oO7I3Do
 EjgluwJbEEczFretjD1TMKjO/Xc0/RjPQhOQCU7tif7mAncwoEEFJH2yND4cEfJWwSZJO9P34
 hMT9MAot0vfAOBmV
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Am 22.04.22 um 16:40 schrieb Greg Kroah-Hartman:
> On Wed, Apr 20, 2022 at 01:44:00PM -0400, Adrien Thierry wrote:
>> Delete TODO since all tasks were completed:
>>
>> 1 - fixed here:
>> https://lore.kernel.org/all/20220408150359.26661-1-athierry@redhat.com/
>>
>> 2 - there are no remaining checkpatch.pl errors or warnings
>>
>> Signed-off-by: Adrien Thierry <athierry@redhat.com>
>> ---
>>   drivers/staging/vc04_services/bcm2835-audio/TODO | 10 ----------
>>   1 file changed, 10 deletions(-)
>>   delete mode 100644 drivers/staging/vc04_services/bcm2835-audio/TODO
>>
>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/TODO b/drivers/staging/vc04_services/bcm2835-audio/TODO
>> deleted file mode 100644
>> index b85451255db0..000000000000
>> --- a/drivers/staging/vc04_services/bcm2835-audio/TODO
>> +++ /dev/null
>> @@ -1,10 +0,0 @@
>> -*****************************************************************************
>> -*                                                                           *
>> -*                           TODO: BCM2835-AUDIO                             *
>> -*                                                                           *
>> -*****************************************************************************
>> -
>> -1) Revisit multi-cards options and PCM route mixer control (as per comment
>> -https://lore.kernel.org/lkml/s5hd0to5598.wl-tiwai@suse.de)
>> -
>> -2) Fix the remaining checkpatch.pl errors and warnings.
>> -- 
>> 2.35.1
>>
>>
> Great, so now it can be merged to the real part of the kernel?  If not,
> what's left for that to happen?

bcm2835-audio depends on interface/vchiq_arm in a parallel directory. 
Its TODO list is a little bit longer.

Best regards

>
> thanks,
>
> greg k-h
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
