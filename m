Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB2B5657C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiGDNsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiGDNsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:48:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CAA2734;
        Mon,  4 Jul 2022 06:48:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ay16so16866194ejb.6;
        Mon, 04 Jul 2022 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=DuezbfYQsU3qAlG2AxqJIX7invg2mFOX4CCrrytmnWI=;
        b=TvlAjzeC17n6fwvxmrdz+AxjF1IvjtYSWiEkoRkZ4yqDqhESkN5YdquUtdWvwfvA5m
         pL/cK6b9ig8/s4q3rtOVVMwmvl9JlQ1G/KFac0kZZePNU6UAYGbk4PNC+ywqdxbwLyMt
         tVkKVPQse+TTQ2/Hi0+JA/qYytY0q+y4tq/oYAKY4xLE27v9nIpyW3dMr+VP3g5xXbhP
         QvWSQf5aEB7U7XpM5DT6Rnvl9LRNVjABc0uxxaO84ENPCkXaF+ounlcPkyr0XZnyx+HH
         +tc+VLDDwxxXy8WqaJxPOLWwe456ylSmi9LfhssKnfzAdjOsufMunMFIFZQo90IKFRAy
         O9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DuezbfYQsU3qAlG2AxqJIX7invg2mFOX4CCrrytmnWI=;
        b=S0ASJjxwbyX1jGfQ/9aVUY0+Lxw92UcMy9g4vNwzkIrX4LBrnZWx8GVN9nJtH4OS+s
         IhPwgxBT2dRXb0q8hHEfyzViGsdBHzWsrAWC6uOrufB9PWV0+K/btEEBgKU+XtHHn9wB
         cEjIHeIHiPjQ2PkdUCg22ab8wl975OvG5MhRbPAj2+sYr1Bd9H8DkMjUwA1uP0X4tRj1
         gRWYZphRxSWQWD+9GGU2GRR8UdWund/ex+ClY6iDiI4hZdzT3cJwhC1rlx8p+IxRsNAw
         qgHct8Ilc7XKzuo3A6jCBHvZmTeFWNkWsS/KLnDEoy4UGmnTduSgSlXR4MAUrqmxyIKf
         W/AQ==
X-Gm-Message-State: AJIora/9kRTBj0M4lDE25qtBo2WUr0qFVEeq9SMkZd3OpIY+8JCwt4ak
        INPPXwYgZOlbX8NdEyeC9nw=
X-Google-Smtp-Source: AGRyM1uI88ycJrc/hJ300rpJYQ5RUDcELFrq4VEsCVgtbZPW073pyy7a2yo6Tc+WoJSmxdOx2LMBYQ==
X-Received: by 2002:a17:907:72d2:b0:722:f9c8:c3fa with SMTP id du18-20020a17090772d200b00722f9c8c3famr27113222ejc.608.1656942485452;
        Mon, 04 Jul 2022 06:48:05 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:601b:af42:6b18:b5ef? ([2a02:908:1256:79a0:601b:af42:6b18:b5ef])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709060f5200b006fe9e717143sm14340094ejj.94.2022.07.04.06.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:48:04 -0700 (PDT)
Message-ID: <5eeefadd-7804-3876-c8da-3e6f1bcb9dc0@gmail.com>
Date:   Mon, 4 Jul 2022 15:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Linaro-mm-sig] Re: DMA-buf and uncached system memory
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        "Sharma, Shashank" <Shashank.Sharma@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media <linux-media@vger.kernel.org>
References: <4b69f9f542d6efde2190b73c87096e87fa24d8ef.camel@pengutronix.de>
 <adc626ec-ff5a-5c06-44ce-09111be450cd@amd.com>
 <fbb228cd78e9bebd7e7921c19e0c4c09d0891f23.camel@pengutronix.de>
 <e691bccc-171d-f674-2817-13a945970f4a@amd.com>
 <95cca943bbfda6af07339fb8d2dc7f4da3aa0280.camel@pengutronix.de>
 <05814ddb-4f3e-99d8-025a-c31db7b2c46b@amd.com>
 <708e27755317a7650ca08ba2e4c14691ac0d6ba2.camel@pengutronix.de>
 <6287f5f8-d9af-e03d-a2c8-ea8ddcbdc0d8@amd.com>
 <CAPj87rOykZv7bjNhHPT4StrsPz8Y_DWqab4Ryq=Qqh77LS2e=Q@mail.gmail.com>
 <578953dd-6298-2bfe-a8fb-52004b84fd17@amd.com>
 <YrY0cQY1BTL5H7Xp@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YrY0cQY1BTL5H7Xp@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am 25.06.22 um 00:02 schrieb Daniel Vetter:
> On Thu, Jun 23, 2022 at 01:32:18PM +0200, Christian König wrote:
>> Am 23.06.22 um 13:27 schrieb Daniel Stone:
>>> [SNIP]
>>> If it's really your belief that dmabuf requires universal snooping, I
>>> recommend you send the patch to update the documentation, as well as
>>> to remove DRIVER_PRIME from, realistically, most non-PCIE drivers.
>> Well, to be honest I think that would indeed be necessary.
>>
>> What we have created are essentially two different worlds, one for PCI
>> devices and one for the rest.
>>
>> This was indeed not the intention, but it's a fact that basically all
>> DMA-buf based PCI drivers assume coherent access.
> dma-buf does not require universal snooping.
>
> It does defacto require that all device access is coherent with all other
> device access, and consistent with the exporters notion of how cpu
> coherency is achieved. Not that coherent does not mean snooping, as long
> as all devices do unsnooped access and the exporter either does wc/uc or
> flushes caches that's perfectly fine, and how all the arm soc dma-buf
> sharing works.

We should probably start documenting that better.

> We did originally have the wording in there that you have to map/unamp
> around every device access, but that got dropped because no one was doing
> that anyway.
>
> Now where this totally breaks down is how we make this work, because the
> idea was that dma_buf_attach validates this all. Where this means all the
> hilarious reasons buffer sharing might not work:
> - wrong coherency mode (cpu cached or not)
> - not contiguous (we do check that, but only once we get the sg from
>    dma_buf_attachment_map, which strictly speaking is a bit too late but
>    most drivers do attach&map as one step so not that bad in practice)
> - whether the dma api will throw in bounce buffers or not
> - random shit like "oh this is in the wrong memory bank", which I think
>    never landed in upstream
>
> p2p connectivity is about the only one that gets this right, yay. And the
> only reason we can even get it right is because all the information is
> exposed to drivers fully.

Yeah, that's why I designed P2P that way :)

I also don't think it's that bad, at least for radeon, nouveau and 
amdgpu all the migration restrictions are actually handled correctly.

In other words when a DMA-buf is about to be used by another device we 
use TTM to move the buffer around so that it can actually be accessed by 
that device.

What I haven't foreseen in here is that we need to deal with different 
caching behaviors between exporter and importer.


> The issue is that the device dma api refuses to share this information
> because it would "leak". Which sucks, because we have defacto build every
> single cross-device use-case of dma-buf on the assumption we can check
> this (up to gl/vk specs), but oh well.
>
> So in practice this gets sorted out by endless piles of hacks to make
> individual use-cases work.
>
> Oh and: This is definitely not limited to arm socs. x86 socs with intel
> at least have exactly all the same issues, and they get solved by adding
> various shitty hacks to the involved drivers (like i915+amdgpu). Luckily
> the intel camera driver isn't in upstream yet, since that would break a
> bunch of the hacks since suddently there will be now 2 cpu cache
> incoherent devices in an x86 system.
>
> Ideally someone fixes this, but I'm not hopeful.
>
> I recommend pouring more drinks.
>
> What is definitely not correct is claiming that dma-buf wasn't meant for
> this. We discussed cache coherency issues endless in budapest 12 or so
> years ago, I was there. It's just that the reality of the current
> implementation is falling short, and every time someone tries to fix it we
> get shouted down by dma api maintainers for looking behind their current.

Well that explains this, I've joined the party a year later and haven't 
witnessed all of this.

> tldr; You have to magically know to not use cpu cached allocators on these
> machines.

Or reject the attachment. As far as I can see that is still the cleanest 
option.

Regards,
Christian.

>
> Aside: This is also why vgem alloates wc memory on x86. It's the least
> common denominator that works. arm unfortunately doesn't allow you to
> allocate wc memory, so there stuff is simply somewhat broken.
> -Daniel

