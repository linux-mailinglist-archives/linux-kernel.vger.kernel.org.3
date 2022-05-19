Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9E52CBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiESGDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiESGDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:03:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2769661635;
        Wed, 18 May 2022 23:03:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h29so7302544lfj.2;
        Wed, 18 May 2022 23:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X+iyqLf77Krjb4QH3xlKBzqBdXBeBxfWT5vFT9hWB/E=;
        b=jMiIn+oPqAbUSnsl0S1EqWOpvRnIcpeNMiwZI6oyIi8xhmBfbS0iXSTPrI9fRM0yK3
         shzE8bDkGkYA9EhOOUX0QU0wLP4QQoFJglzVWFRGUFihYkHMmO4E6qMuMAwRmBE3Fb29
         LEbCqY6aee+/3T+wPLd3RffpjN6/xgG291hMA+v9JF2TUTVdVeWsT6J6ofyyeD01qlKm
         fBBHfR1YeYk1vyGq0IXKTNfhaswYcqCTmShveU5CSbuNb0b2uKBm9D5eUMnaLKaogBcO
         IVdN60uPvVqB2IVOgavpFDPsgOrh/GOMGkUwu0zXQ//s/G6C/9uX5K58kzqdB8e9hAMB
         XgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X+iyqLf77Krjb4QH3xlKBzqBdXBeBxfWT5vFT9hWB/E=;
        b=VFJjq3A0yvOghofrMz1EKm4VsrG2qcVksid0zWrzODQC6sXxmMA5m8maf/TIw4ROla
         790V/KIZ99k0JTg3EA50tPMWTYQuQTWE1DFsJUV3bAXGH0q0sUrpgEuCsIdHbDIPMPdd
         RqhgLY4Qb5eTa4C+tU3XuDeYnoLlS50qnGdmLe3ZNTX9Jp/8RHQyvuH1DH5w1drqpvZx
         6WBUd84ffLafQqPi+8TrrWUVGCHSUeYWFKVT8wjsHduurjWxgRWZ7LQ4JhXgbZkf8Ogo
         08rvjRl2mPZayN2vKSBWMNyfsOEZOWOQiREBJAKTx+3UXL0oEUyPg8f24aEjWLmTS5nv
         Zuug==
X-Gm-Message-State: AOAM5332TaNPzXcRA8kdFrL7mEWJOn1XthVnwQ5S5q9c4+xv6gMtjjDN
        vM9fVfqdGJKxYOfgnmEx6As=
X-Google-Smtp-Source: ABdhPJzwmwkFDCRWW2Cad13XCWqyTTIZvwGLTYnv5Wt5Re5HVYbl0W10atfcLup8GeN/5VWUJmeMMg==
X-Received: by 2002:a05:6512:ace:b0:473:ba5b:8e06 with SMTP id n14-20020a0565120ace00b00473ba5b8e06mr2114663lfu.614.1652940210293;
        Wed, 18 May 2022 23:03:30 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id z9-20020ac25de9000000b0047255d211b3sm159674lfq.226.2022.05.18.23.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 23:03:29 -0700 (PDT)
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
 <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
 <56e8c32d-6771-7179-005f-26ca58555659@gmail.com>
 <CAK8P3a1YhkEZ8gcbXHEa5Bwx-4VVRJO8SUHf8=RNWRsc2Yo-+A@mail.gmail.com>
 <460a746c-6b61-214b-4653-44a1430e314d@gmail.com>
 <alpine.DEB.2.22.394.2205181802310.1905099@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <6f469e9c-c26e-f4be-9a85-710afb0d77eb@gmail.com>
Date:   Thu, 19 May 2022 09:03:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2205181802310.1905099@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19.05.22 04:06, Stefano Stabellini wrote:


Hello Stefano

> On Thu, 19 May 2022, Oleksandr wrote:
>>> On Wed, May 18, 2022 at 5:06 PM Oleksandr <olekstysh@gmail.com> wrote:
>>>> On 18.05.22 17:32, Arnd Bergmann wrote:
>>>>> On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko
>>>>> <olekstysh@gmail.com> wrote:
>>>>>     This would mean having a device
>>>>> node for the grant-table mechanism that can be referred to using the
>>>>> 'iommus'
>>>>> phandle property, with the domid as an additional argument.
>>>> I assume, you are speaking about something like the following?
>>>>
>>>>
>>>> xen_dummy_iommu {
>>>>       compatible = "xen,dummy-iommu";
>>>>       #iommu-cells = <1>;
>>>> };
>>>>
>>>> virtio@3000 {
>>>>       compatible = "virtio,mmio";
>>>>       reg = <0x3000 0x100>;
>>>>       interrupts = <41>;
>>>>
>>>>       /* The device is located in Xen domain with ID 1 */
>>>>       iommus = <&xen_dummy_iommu 1>;
>>>> };
>>> Right, that's that's the idea,
>> thank you for the confirmation
>>
>>
>>
>>>    except I would not call it a 'dummy'.
>>>   From the perspective of the DT, this behaves just like an IOMMU,
>>> even if the exact mechanism is different from most hardware IOMMU
>>> implementations.
>> well, agree
>>
>>
>>>>> It does not quite fit the model that Linux currently uses for iommus,
>>>>> as that has an allocator for dma_addr_t space
>>>> yes (# 3/7 adds grant-table based allocator)
>>>>
>>>>
>>>>> , but it would think it's
>>>>> conceptually close enough that it makes sense for the binding.
>>>> Interesting idea. I am wondering, do we need an extra actions for this
>>>> to work in Linux guest (dummy IOMMU driver, etc)?
>>> It depends on how closely the guest implementation can be made to
>>> resemble a normal iommu. If you do allocate dma_addr_t addresses,
>>> it may actually be close enough that you can just turn the grant-table
>>> code into a normal iommu driver and change nothing else.
>> Unfortunately, I failed to find a way how use grant references at the
>> iommu_ops level (I mean to fully pretend that we are an IOMMU driver). I am
>> not too familiar with that, so what is written below might be wrong or at
>> least not precise.
>>
>> The normal IOMMU driver in Linux doesn’t allocate DMA addresses by itself, it
>> just maps (IOVA-PA) what was requested to be mapped by the upper layer. The
>> DMA address allocation is done by the upper layer (DMA-IOMMU which is the glue
>> layer between DMA API and IOMMU API allocates IOVA for PA?). But, all what we
>> need here is just to allocate our specific grant-table based DMA addresses
>> (DMA address = grant reference + offset in the page), so let’s say we need an
>> entity to take a physical address as parameter and return a DMA address (what
>> actually commit #3/7 is doing), and that’s all. So working at the dma_ops
>> layer we get exactly what we need, with the minimal changes to guest
>> infrastructure. In our case the Xen itself acts as an IOMMU.
>>
>> Assuming that we want to reuse the IOMMU infrastructure somehow for our needs.
>> I think, in that case we will likely need to introduce a new specific IOVA
>> allocator (alongside with a generic one) to be hooked up by the DMA-IOMMU
>> layer if we run on top of Xen. But, even having the specific IOVA allocator to
>> return what we indeed need (DMA address = grant reference + offset in the
>> page) we will still need the specific minimal required IOMMU driver to be
>> present in the system anyway in order to track the mappings(?) and do nothing
>> with them, returning a success (this specific IOMMU driver should have all
>> mandatory callbacks implemented).
>>
>> I completely agree, it would be really nice to reuse generic IOMMU bindings
>> rather than introducing Xen specific property if what we are trying to
>> implement in current patch series fits in the usage of "iommus" in Linux
>> more-less. But, if we will have to add more complexity/more components to the
>> code for the sake of reusing device tree binding, this raises a question
>> whether that’s worthwhile.
>>
>> Or I really missed something?
> I think Arnd was primarily suggesting to reuse the IOMMU Device Tree
> bindings, not necessarily the IOMMU drivers framework in Linux (although
> that would be an added bonus.)
>
> I know from previous discussions with you that making the grant table
> fit in the existing IOMMU drivers model is difficult, but just reusing
> the Device Tree bindings seems feasible?

I started experimenting with that. As wrote in a separate email, I got a 
deferred probe timeout,

after inserting required nodes into guest device tree, which seems to be 
a consequence of the unavailability of IOMMU, I will continue to 
investigate this question.



-- 
Regards,

Oleksandr Tyshchenko

