Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24EA5101B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352247AbiDZPVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352330AbiDZPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:21:29 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7139BBC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:14:20 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MlO9r-1o96hT37dt-00lkXu; Tue, 26 Apr 2022 17:12:58 +0200
Message-ID: <4971fae3-8a47-50af-dedb-aac90db90de2@i2se.com>
Date:   Tue, 26 Apr 2022 17:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 0/6] Raspberry Pi Sense HAT driver
Content-Language: en-US
To:     Conor.Dooley@microchip.com, nsaenzju@redhat.com,
        cmirabil@redhat.com, miguel.ojeda.sandonis@gmail.com
Cc:     linux-kernel@vger.kernel.org, serge@raspberrypi.org,
        mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        dbauman@redhat.com, mguma@redhat.com, jsavitz@redhat.com
References: <20220419205158.28088-1-cmirabil@redhat.com>
 <CANiq72n1gBE+tv3oAF4wjdK2jEJJmU4V=Y1CTZ1PpCEeqLbo9g@mail.gmail.com>
 <CABe3_aE-nQzZazLfxk1OnCNRF0sDqcWi6gieYSf4O4aYS_Ahog@mail.gmail.com>
 <06e0138a526f1fd9fe5b18184163c1ff98f0103b.camel@redhat.com>
 <4719fce9-4235-f1d7-f95e-67e5a47a0968@i2se.com>
 <60c3e7e4-6406-ecaa-e89b-fc2d359d8d31@microchip.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <60c3e7e4-6406-ecaa-e89b-fc2d359d8d31@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oZjibNcfz/UR8WE/djzPbVyCS4HWuQukMeJ0iNh2tNMK0oa5Hqm
 isDi7BIZpq5sJK43wjqKEbSAb9bseLQF8+KlCNuvxsnIiuoaxPqlv/r33G9FGoJemvc7g8k
 XgXXvVDWa4S2BRRztNIrzc6VluTpxkDOW40M3pkRSN27qz7y9veD7NSKZP1JUqRi8+zDBOI
 J+Xrf0HpdamvH6U6gCFXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cHQud7lpRWo=:mZn+loQ/xCkyhk7qc80tuj
 NXMqg0HJs4KMcSwbs7lambwls8OhmLVVt0oCnEXbcvtNI0d+0twEI2AvI9ojWi+m3lmwXkCJm
 nkacOM+Z+NP/0i5sQ8T5PxYaUu6jUdfE7pXSp+dc6wdgBTDZStDoAgm7307hwnGyQU2veQi1O
 vPTmLO3EVc8TJbee1YYAZDkL+cqrWAHLp20jQ8XWpb6mw9zaELH8q3tZcOBYc5t0BrQ1Qha7f
 A3mI82LI2tRlfxu39FtCOBOO/9zKB2kr0J0fqTwFMHz4Y/SWDRMz8TYNM3u6XLO+W3pZtcqKG
 SmaDTh1W9/kbp4TLIPERmak/s10pvJYsCbDcgjKbazM4SXP9ZmJNlVLtIWxqDM9legYydZ5U+
 SIDgMSjLDuBkrWsrW+4aeqHWdMON0rlUCO9OqHBB2nABleP1+zL75KhC3E7Bc2DxB3GzY9gBl
 29bqSqkiMkOuLEComqQ69ibtLtiOFJlGDuO4SO+HsuC1zO3KaeKBGumBi5dOtQMmyo9WEmtuu
 mAba9IbHOiE4122n0D3UPxFKLtY4wZImwZsUl98B0VHL9iN7/0noNWom2ZC9g+PncnJX6Fle0
 42rUstN133QbZW0cAmMLXvp4nKiTrXUVr8DnWbykyRAeNDbnUO+8aoQyj4rj/zCexjdV/+IRo
 E+NAYbzPsR6l98iY9AaIemkxIgfkHU7k6OipuWXQrkiOO23WMNgLSi/+xRFgU+qcB4lYaWmLI
 1AUPILE8CRWb4XbE
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.04.22 um 14:03 schrieb Conor.Dooley@microchip.com:
> On 26/04/2022 12:48, Stefan Wahren wrote:
>> Am 26.04.22 um 12:18 schrieb Nicolas Saenz Julienne:
>>> Hi Charles, Miguel,
>>>
>>> On Mon, 2022-04-25 at 19:34 -0400, Charles Mirabile wrote:
>>>> Hi Miguel—
>>>>
>>>> Thanks for your help in reviewing this patch. I think all of the feedback is cleared up.
>>>>
>>>> I am not sure which tree this should go into, but maybe the Raspberry Pi tree maintained
>>>> by Nicolas Saenz Julienne (git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-
>>>> rpi.git)? What do you think? Thanks!
>>> Since there is no code dependency between the different drivers/patches I
>>> suggest for each patch to go through its respective maintainer tree. Also, if
>>> we were to move the whole series through as single tree, it's important to have
>>> ACKs from all the subsystem maintainers.
>> Yes, we still need a Ack of Rob for the device tree bindings. Please give him the common 2 weeks for a review.
> You have one from Krzysztof on the bindings, that should be sufficient?
>
> https://docs.kernel.org/process/maintainers.html#open-firmware-and-flattened-device-tree-bindings
Yes, you are right
>
>>> I'll do a last review during the week.
>>>
>>> Regards,
>>>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
