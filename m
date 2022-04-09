Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628F44FA7EF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbiDINEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbiDINEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:04:47 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853372D35D0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:02:40 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ndAje-0000kD-79; Sat, 09 Apr 2022 15:02:38 +0200
Message-ID: <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
Date:   Sat, 9 Apr 2022 15:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tudor.Ambarus@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniels Umanovskis <du@axentia.se>,
        Patrice Vilchez <patrice.vilchez@microchip.com>,
        Cristian Birsan <Cristian.Birsan@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
 <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
 <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
 <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
 <8484ce66-639c-03f5-c5db-3574ea26690c@microchip.com>
 <075a196f-79c2-0d58-15f9-ad5e33e2306b@axentia.se>
 <3beb80ad-d6f8-8c6a-e17d-e40a644bba07@microchip.com>
 <e47c155a-f25d-11b3-3339-b2bf71b886ce@microchip.com>
 <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
 <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
 <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
 <a024180a-493c-af20-0910-da30dd5fe364@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649509360;cf77b79b;
X-HE-SMSGID: 1ndAje-0000kD-79
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Can somebody please provide a status update what the outcome of this
thread? It started as a regression report, that's why I'm tracking it --
but seems nothing happened for a while. Was it fixed? Did it fall
through the cracks? Or did it turn out that this is not a regression? If
the latter: please feel free to include a paragraph like "#regzbot
invalid: a few words why this is invalid in the lengths of a mail subject"

Ciao, Thorsten

#regzbot poke

On 10.03.22 11:40, Peter Rosin wrote:
> On 2022-03-10 10:58, Peter Rosin wrote:
>> [bringing this threadlet back to the lists, hope that's ok]
>>
>> On 2022-03-10 09:27, Nicolas Ferre wrote:
>>>  From that article:
>>> https://lwn.net/Articles/885941/
>>>
>>> I read:
>>>
>>> "Koschel included a patch fixing a bug in the USB subsystem where the 
>>> iterator passed to this macro was used after the exit from the macro, 
>>> which is a dangerous thing to do. Depending on what happens within the 
>>> list, the contents of that iterator could be something surprising, even 
>>> in the absence of speculative execution. Koschel fixed the problem by 
>>> reworking the code in question to stop using the iterator after the loop. "
>>>
>>> USB subsystem, "struct list_head *next, *prev;"... Some keywords present 
>>> there... worth a try?
>>>
>>> Regards,
>>>    Nicolas
>>
>> gr_udc.c is not built with the config that is in use, which is sad because
>> it looked like a good candidate.
> 
> at91_usba_udc.c, which is included, has the same pattern. But alas, doing
> the equivalent patch there does not fix things either. I.e. (whitespace
> damaged)
> 
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -863,6 +863,7 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>         struct usba_request *req;
>         unsigned long flags;
>         u32 status;
> +       bool found = false;
> 
>         DBG(DBG_GADGET | DBG_QUEUE, "ep_dequeue: %s, req %p\n",
>                         ep->ep.name, _req);
> @@ -870,11 +871,13 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>         spin_lock_irqsave(&udc->lock, flags);
> 
>         list_for_each_entry(req, &ep->queue, queue) {
> -               if (&req->req == _req)
> +               if (&req->req == _req) {
> +                       found = true;
>                         break;
> +               }
>         }
> 
> -       if (&req->req != _req) {
> +       if (!found) {
>                 spin_unlock_irqrestore(&udc->lock, flags);
>                 return -EINVAL;
>         }
> 
> The test started out with 3 good hashes though, so I got my hopes up. But
> no, it's about the same failure rate as usual. I have the feeling that I
> will never again trust a single sha256sum...
> 
> Cheers,
> Peter

