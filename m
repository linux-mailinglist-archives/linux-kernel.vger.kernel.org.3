Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCAF4D1D95
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiCHQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348471AbiCHQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:42:00 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7645A52E5B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:40:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso2700350pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OWnOkvoxF0nwP/XRvDD92sAAA8FIPxhix3DmlSJCZos=;
        b=JwiWRI1PhM0j0QrdRm6OeZka3Jby5z/isDaZpABe5noKYK0Kye/HJ/gb4qcWWUd3LX
         gaNTaysMAEfsNeYk30s9L6M18R94tLsI6Bfs4NfbhGPOwTvzavGviQf9gxeuGwQ/7UPU
         UZrH/lELjg2i+popDEcldVdcJ2sQ4sRZQQ7jlO412R0vHV/zy6Wg2p8J4ztgkwAvMsWR
         YTLGZUKABxTWsHzJPUfcwOdVR6TboaEzBw7vh7uoEOdVO9HiCZtPW5KxvXykDW24O/lV
         Vid7CTz9Z97Td1k25FPkxREw8EliMkddJQCwqYuOh8C2rAsdknqvKspeuocQJoWKbFWs
         oJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OWnOkvoxF0nwP/XRvDD92sAAA8FIPxhix3DmlSJCZos=;
        b=cvnnbu+1daKQ7LgOqJfW53LUagflXsI1GYZZBxD3ql8xGBC5qmFfvts+p2NCxoKjlF
         GrYY5eyXna73GvephkstUuwjOytPN/Elo6E1nmT91tF2GNPwFdz3EEJuhPlq74t/e4kR
         f5GA+KUFB5vuAvdfq6MptbbLDMQF+BRtyXm56K8DNHIxVuwKf+5NR2+5qn2+yNynkGfx
         nZE58mHjurwV3JvHDziVmXV85pjnOZSIs/2kRYC4uMLl/AD5toBiy5wH3Qc0vJncfwYn
         rL0UXNXdfOHbchfLnEpqzs7NjOipLCOqDzFVwNxJV2igwtg85VVmzSlddFUhqvNmrNEv
         tZPg==
X-Gm-Message-State: AOAM5322TcFKc8MA0z1ozmIa5CM6Rbijf9x9BJwI7seZ67B2gz0kw3VH
        Y1SAMGOuL0JmzEy9FVYK4K0=
X-Google-Smtp-Source: ABdhPJzn0oIFiUaCgctL3WP2NCXN002hpLP15O8BccbqygOOJu3B/tMYY0l+EWC4jHVf5240Az31Vw==
X-Received: by 2002:a17:902:da8d:b0:151:dcb7:46a6 with SMTP id j13-20020a170902da8d00b00151dcb746a6mr14454261plx.133.1646757638254;
        Tue, 08 Mar 2022 08:40:38 -0800 (PST)
Received: from ?IPV6:240b:10:2720:5500:8160:1ad9:d84e:7584? ([240b:10:2720:5500:8160:1ad9:d84e:7584])
        by smtp.gmail.com with ESMTPSA id h14-20020a63384e000000b00366ba5335e7sm15499674pgn.72.2022.03.08.08.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:40:37 -0800 (PST)
Message-ID: <08c76c86-c015-28c3-47b5-18d8e50258e9@gmail.com>
Date:   Wed, 9 Mar 2022 01:40:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [BUG] mtd: cfi_cmdset_0002: write regression since v4.17-rc1
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, Joakim.Tjernlund@infinera.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com, richard@nod.at,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, marek.vasut@gmail.com,
        cyrille.pitchen@wedev4u.fr,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linuxppc-dev@lists.ozlabs.org
References: <b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de>
 <dff2abcc-5813-2f2c-35ba-f03cd1f35ac3@leemhuis.info>
 <e11b76dc-5539-fb7e-da1c-a5005713d6b0@gmail.com>
 <3dbbcee5-81fc-cdf5-9f8b-b6ccb95beddc@pengutronix.de>
 <0f2cfcac-83ca-51a9-f92c-ff6495dca1d7@gmail.com>
 <b231b498-c8d2-28af-ce66-db8c168047f7@pengutronix.de>
 <66ee55d9-4f20-6722-6097-e53c2108ea07@gmail.com>
 <579eab10-594c-d6b2-0ddb-ea6ab8e02856@pengutronix.de>
 <cedb1604-e024-2738-5b33-15703a653803@gmail.com>
 <117facba-ba33-349d-1085-25315cc1ae92@gmail.com>
 <f9e46b61-37e5-a280-edb0-27f8e81a8680@pengutronix.de>
 <9621c512-06f2-17b2-5c68-943b1f0981eb@gmail.com>
 <b23e4089-6431-de26-8666-bae4c3c8df88@pengutronix.de>
 <510adc50-79aa-3ed2-ab6f-9f9711d9bb23@gmail.com>
 <48ad0f65-a12e-e3b0-8c56-3197464c0b59@pengutronix.de>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <48ad0f65-a12e-e3b0-8c56-3197464c0b59@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/03/09 1:23, Ahmad Fatoum wrote:
> Hello Tokunori-san,
>
> On 08.03.22 17:13, Tokunori Ikegami wrote:
>> Hi Ahmad-san,
>>
>> On 2022/03/08 18:44, Ahmad Fatoum wrote:
>>> Hello Tokunori,
>>>
>>> On 06.03.22 16:49, Tokunori Ikegami wrote:
>>>> Hi,
>>>>
>>>> On 2022/03/04 20:11, Ahmad Fatoum wrote:
>>>>> Hello Tokunori-san,
>>>>>
>>>>> On 20.02.22 13:22, Tokunori Ikegami wrote:
>>>>>> Hi Ahmad-san,
>>>>>>
>>>>>> Could you please try the version 2 patch attached for the error case?
>>>>>> This version is to check the DQ true data 0xFF by chip_good().
>>>>> I had a similar patch locally as well at first. I just tested yours
>>>>> and I can't reproduce the issue.
>>>> Thanks for your support.
>>>> Sorry if possible could you please retest the attached the patch again since this fixed the version 1 patch maintainer review comments?
>>> Works good.
>>>
>>> Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> Thank you so much for your test.
>>>>>> But I am not sure if this works or not since the error is possible to be caused by Hi-Z 0xff on floating bus or etc.
>>>>> That it works for me could be because of Hi-Z 0xff, which is why
>>>>> decided against it.
>>>> I see.
>>>>>>>>>> What seems to work for me is checking if chip_good or chip_ready
>>>>>>>>>> and map_word is equal to 0xFF. I can't justify why this is ok though.
>>>>>>>>>> (Worst case bus is floating at this point of time and Hi-Z is read
>>>>>>>>>> as 0xff on CPU data lines...)
>>>>>>>>> Sorry I am not sure about this.
>>>>>>>>> I thought the chip_ready() itself is correct as implemented as the data sheet in the past.
>>>>>>>>> But it did not work correctly so changed to use chip_good() instead as it is also correct.
>>>>>>>> What exactly in the datasheet makes you believe chip_good is not appropriate?
>>>>>>> I just mentioned about the actual issue behaviors as not worked chip_good() on S29GL964N and not worked chip_ready() on MX29GL512FHT2I-11G before etc.
>>>>>>> Anyway let me recheck the data sheet details as just checked it again quickly but needed more investigation to understand.
>>>>>> As far as I checked still both chip_good() and chip_ready() seem correct but still the root cause is unknown.
>>>>>> If as you mentioned the issue was cased by the DQ true data 0xFF I am not sure why the read work without any error after the write operation.
>>>>>> Also if the error was caused by the Hi-Z 0xff on floating bus as mentioned I am not sure why the read work without any error after the write operation with chip_ready().
>>>>>> Sorry anyway the root cause is also unknown when the write operation was changed to use chip_good() instead of chip_ready().
>>>>> I've be ok with v1 then. Restores working behavior for me and shouldn't break others.
>>>> Noted but still I am thinking the version 2 patch to check 0xff seems better than to use chip_ready() so let me consider this again later.
>>> The original version has less room for surprise as it restores previously
>>> working behavior. Assuming 0xFF to be good without backing from documentation
>>> is more risky IMO.
>> The change to check 0xFF can be limited for the S29GL064N chip do you have any comment about this?
> I see that, but I am not sure it's the correct thing to do on the S29GL064N,
> even if it seems to work. In absence of definitive information from the vendor,
> I'd prefer we just restore behavior as it was before, i.e. using chip_ready
> instead of chip_good for S29GL064N. This is the way of least surprise.

Thanks for your comment. I see okay I will keep the version patch 2 
reverting to use chip_ready() for S29GL064N under the review without the 
change to check 0xFF.

Regards,
Ikegami

>
>> Just attached the patch changed as so and thinking to send the patch as version 3 to the maintainer if you are okay.
>>
>> Regards,
>> Ikegami
>>
>>> Thanks for your continued support,
>>> Ahmad
>>>
>>>> Regards,
>>>> Ikegami
>>>>
>>>>> Cheers and thanks again,
>>>>> Ahmad
>>>>>
>>>>>> Regards,
>>>>>> Ikegami
>>>>>>
>>>>>>> Regards,
>>>>>>> Ikegami
>>>>>>>
>>>>>>>> Cheers,
>>>>>>>> Ahmad
>>>>>>>>
>>>>>>>>
>
