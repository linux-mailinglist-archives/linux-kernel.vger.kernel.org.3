Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD16B534183
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245454AbiEYQaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiEYQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:30:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12B895DDF;
        Wed, 25 May 2022 09:30:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v8so34930114lfd.8;
        Wed, 25 May 2022 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+i+Dct5KOGPoWYK+pPUyiAaWMirerzarztidBbbxZ50=;
        b=ZIDsYUSjntwVSYs3vZQiv9wBkNSJozZuXgBa82+HoJAikAvCUlWvwBZNMfLB8/l1Tm
         0g8Ybm/2mCAzS/JaKwQQ5C+kFvbo63EBpqb16lOVY7GjHFiZSlpxQ8/fTC7SqBl9J81l
         0Mn0B4qqJFUyvMmFoq1MFCJllsjSVlPVbwaC+n8wEZ94iMJ5/NcLE6Of3GvQsVKWP61a
         0rTaKU/Zkoecq05tbn/hqd+yYZTJQ4yWzUX8Uv6y906biVx6pDeW+5bPszd36lDbjem0
         lfVpRgdweA45U4nONp+eJEabdVTwV7SQg4QVujaFP7nMdse/KWFd1zvtLl6x0jT7ddlS
         sc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+i+Dct5KOGPoWYK+pPUyiAaWMirerzarztidBbbxZ50=;
        b=Yjy5oD34AxrA6ejYkxUvVe6gRfX8YnL/SlfWK7dK9Zau50yLsJDcWWK8DoL8RZ8hYj
         gFayr/gfhAipzXn2fJq0M+tgel3wesNg6JeLqzBp8PJFi8VkJbygL5NRTtYQdY9L/zAJ
         yNb9jdZx0DoWSEV0PuzrbY8+kcmCE3B3NNCJyTzZxulZXbDRdnqmglURz5BVsEM7ojzc
         1H7IK4e8I6Q2zy/JaGpHMHT3HimEAIxZclGAs099opVvgIvMjQDlyjiM2XE6DX2tLnMv
         TTiw+xZvKYO8AOGX7Bn/bhDhFa/eTFDvyk881pVDOAacRgLKl4EK+dpGXke4BJrH6qjW
         RlPw==
X-Gm-Message-State: AOAM532s4o/X75v9KINF0tMswDpiDmhNJt1D/Hohl90fI4XOw/U/a9tW
        scY8fvSZtvJNTrZ1O0MHA7A=
X-Google-Smtp-Source: ABdhPJyRJqRI3QzG8Wbqpo4lLfYsbAk6Wd5A09iq3QQCnhw2JyTAn6EmWhKwHvIjEqXcFQbDcFfXTA==
X-Received: by 2002:a05:6512:1051:b0:478:8351:6665 with SMTP id c17-20020a056512105100b0047883516665mr7696489lfb.390.1653496204674;
        Wed, 25 May 2022 09:30:04 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id u11-20020ac25bcb000000b0047889d37464sm1095708lfn.196.2022.05.25.09.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 09:30:04 -0700 (PDT)
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
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
 <6f469e9c-c26e-f4be-9a85-710afb0d77eb@gmail.com>
 <390ba7bb-ee9e-b7b7-5f08-71a7245fa4ec@gmail.com>
 <alpine.DEB.2.22.394.2205231856330.1905099@ubuntu-linux-20-04-desktop>
 <20220524160134.GE3730540-robh@kernel.org>
 <CAGETcx8k8VzdDgrijEYG_mAr_dPctQXT==DFWcieKKYoD9W_sQ@mail.gmail.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <c0f78aab-e723-fe00-a310-9fe52ec75e48@gmail.com>
Date:   Wed, 25 May 2022 19:30:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx8k8VzdDgrijEYG_mAr_dPctQXT==DFWcieKKYoD9W_sQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.05.22 21:34, Saravana Kannan wrote:

Hello all

> "
>
> On Tue, May 24, 2022 at 9:01 AM Rob Herring <robh@kernel.org> wrote:
>> +Saravana
>>
>> On Mon, May 23, 2022 at 06:58:13PM -0700, Stefano Stabellini wrote:
>>> On Mon, 23 May 2022, Oleksandr wrote:
>>>>>> On Thu, 19 May 2022, Oleksandr wrote:
>>>>>>>> On Wed, May 18, 2022 at 5:06 PM Oleksandr <olekstysh@gmail.com> wrote:
>>>>>>>>> On 18.05.22 17:32, Arnd Bergmann wrote:
>>>>>>>>>> On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko
>>>>>>>>>> <olekstysh@gmail.com> wrote:
>>>>>>>>>>      This would mean having a device
>>>>>>>>>> node for the grant-table mechanism that can be referred to using
>>>>>>>>>> the
>>>>>>>>>> 'iommus'
>>>>>>>>>> phandle property, with the domid as an additional argument.
>>>>>>>>> I assume, you are speaking about something like the following?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> xen_dummy_iommu {
>>>>>>>>>        compatible = "xen,dummy-iommu";
>>>>>>>>>        #iommu-cells = <1>;
>>>>>>>>> };
>>>>>>>>>
>>>>>>>>> virtio@3000 {
>>>>>>>>>        compatible = "virtio,mmio";
>>>>>>>>>        reg = <0x3000 0x100>;
>>>>>>>>>        interrupts = <41>;
>>>>>>>>>
>>>>>>>>>        /* The device is located in Xen domain with ID 1 */
>>>>>>>>>        iommus = <&xen_dummy_iommu 1>;
>>>>>>>>> };
>>>>>>>> Right, that's that's the idea,
>>>>>>> thank you for the confirmation
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>     except I would not call it a 'dummy'.
>>>>>>>>    From the perspective of the DT, this behaves just like an IOMMU,
>>>>>>>> even if the exact mechanism is different from most hardware IOMMU
>>>>>>>> implementations.
>>>>>>> well, agree
>>>>>>>
>>>>>>>
>>>>>>>>>> It does not quite fit the model that Linux currently uses for
>>>>>>>>>> iommus,
>>>>>>>>>> as that has an allocator for dma_addr_t space
>>>>>>>>> yes (# 3/7 adds grant-table based allocator)
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> , but it would think it's
>>>>>>>>>> conceptually close enough that it makes sense for the binding.
>>>>>>>>> Interesting idea. I am wondering, do we need an extra actions for
>>>>>>>>> this
>>>>>>>>> to work in Linux guest (dummy IOMMU driver, etc)?
>>>>>>>> It depends on how closely the guest implementation can be made to
>>>>>>>> resemble a normal iommu. If you do allocate dma_addr_t addresses,
>>>>>>>> it may actually be close enough that you can just turn the grant-table
>>>>>>>> code into a normal iommu driver and change nothing else.
>>>>>>> Unfortunately, I failed to find a way how use grant references at the
>>>>>>> iommu_ops level (I mean to fully pretend that we are an IOMMU driver). I
>>>>>>> am
>>>>>>> not too familiar with that, so what is written below might be wrong or
>>>>>>> at
>>>>>>> least not precise.
>>>>>>>
>>>>>>> The normal IOMMU driver in Linux doesn’t allocate DMA addresses by
>>>>>>> itself, it
>>>>>>> just maps (IOVA-PA) what was requested to be mapped by the upper layer.
>>>>>>> The
>>>>>>> DMA address allocation is done by the upper layer (DMA-IOMMU which is
>>>>>>> the glue
>>>>>>> layer between DMA API and IOMMU API allocates IOVA for PA?). But, all
>>>>>>> what we
>>>>>>> need here is just to allocate our specific grant-table based DMA
>>>>>>> addresses
>>>>>>> (DMA address = grant reference + offset in the page), so let’s say we
>>>>>>> need an
>>>>>>> entity to take a physical address as parameter and return a DMA address
>>>>>>> (what
>>>>>>> actually commit #3/7 is doing), and that’s all. So working at the
>>>>>>> dma_ops
>>>>>>> layer we get exactly what we need, with the minimal changes to guest
>>>>>>> infrastructure. In our case the Xen itself acts as an IOMMU.
>>>>>>>
>>>>>>> Assuming that we want to reuse the IOMMU infrastructure somehow for our
>>>>>>> needs.
>>>>>>> I think, in that case we will likely need to introduce a new specific
>>>>>>> IOVA
>>>>>>> allocator (alongside with a generic one) to be hooked up by the
>>>>>>> DMA-IOMMU
>>>>>>> layer if we run on top of Xen. But, even having the specific IOVA
>>>>>>> allocator to
>>>>>>> return what we indeed need (DMA address = grant reference + offset in
>>>>>>> the
>>>>>>> page) we will still need the specific minimal required IOMMU driver to
>>>>>>> be
>>>>>>> present in the system anyway in order to track the mappings(?) and do
>>>>>>> nothing
>>>>>>> with them, returning a success (this specific IOMMU driver should have
>>>>>>> all
>>>>>>> mandatory callbacks implemented).
>>>>>>>
>>>>>>> I completely agree, it would be really nice to reuse generic IOMMU
>>>>>>> bindings
>>>>>>> rather than introducing Xen specific property if what we are trying to
>>>>>>> implement in current patch series fits in the usage of "iommus" in Linux
>>>>>>> more-less. But, if we will have to add more complexity/more components
>>>>>>> to the
>>>>>>> code for the sake of reusing device tree binding, this raises a question
>>>>>>> whether that’s worthwhile.
>>>>>>>
>>>>>>> Or I really missed something?
>>>>>> I think Arnd was primarily suggesting to reuse the IOMMU Device Tree
>>>>>> bindings, not necessarily the IOMMU drivers framework in Linux (although
>>>>>> that would be an added bonus.)
>>>>>>
>>>>>> I know from previous discussions with you that making the grant table
>>>>>> fit in the existing IOMMU drivers model is difficult, but just reusing
>>>>>> the Device Tree bindings seems feasible?
>>>>> I started experimenting with that. As wrote in a separate email, I got a
>>>>> deferred probe timeout,
>>>>>
>>>>> after inserting required nodes into guest device tree, which seems to be a
>>>>> consequence of the unavailability of IOMMU, I will continue to investigate
>>>>> this question.
>>>>
>>>> I have experimented with that. Yes, just reusing the Device Tree bindings is
>>>> technically feasible (and we are able to do this by only touching
>>>> grant-dma-ops.c), although deferred probe timeout still stands (as there is no
>>>> IOMMU driver being present actually).
>>>>
>>>> [    0.583771] virtio-mmio 2000000.virtio: deferred probe timeout, ignoring
>>>> dependency
>>>> [    0.615556] virtio_blk virtio0: [vda] 4096000 512-byte logical blocks (2.10
>>>> GB/1.95 GiB)
>>>>
>>>>
>>>> Below the working diff (on top of current series):
>>>>
>>>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>>>> index da9c7ff..6586152 100644
>>>> --- a/drivers/xen/grant-dma-ops.c
>>>> +++ b/drivers/xen/grant-dma-ops.c
>>>> @@ -272,17 +272,24 @@ static const struct dma_map_ops xen_grant_dma_ops = {
>>>>
>>>>   bool xen_is_grant_dma_device(struct device *dev)
>>>>   {
>>>> +       struct device_node *iommu_np;
>>>> +       bool has_iommu;
>>>> +
>>>>          /* XXX Handle only DT devices for now */
>>>>          if (!dev->of_node)
>>>>                  return false;
>>>>
>>>> -       return of_property_read_bool(dev->of_node, "xen,backend-domid");
>>>> +       iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
>>>> +       has_iommu = iommu_np && of_device_is_compatible(iommu_np,
>>>> "xen,grant-dma");
>>>> +       of_node_put(iommu_np);
>>>> +
>>>> +       return has_iommu;
>>>>   }
>>>>
>>>>   void xen_grant_setup_dma_ops(struct device *dev)
>>>>   {
>>>>          struct xen_grant_dma_data *data;
>>>> -       uint32_t domid;
>>>> +       struct of_phandle_args iommu_spec;
>>>>
>>>>          data = find_xen_grant_dma_data(dev);
>>>>          if (data) {
>>>> @@ -294,16 +301,30 @@ void xen_grant_setup_dma_ops(struct device *dev)
>>>>          if (!dev->of_node)
>>>>                  goto err;
>>>>
>>>> -       if (of_property_read_u32(dev->of_node, "xen,backend-domid", &domid)) {
>>>> -               dev_err(dev, "xen,backend-domid property is not present\n");
>>>> +       if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
>>>> +                       0, &iommu_spec)) {
>>>> +               dev_err(dev, "Cannot parse iommus property\n");
>>>> +               goto err;
>>>> +       }
>>>> +
>>>> +       if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
>>>> +                       iommu_spec.args_count != 1) {
>>>> +               dev_err(dev, "Incompatible IOMMU node\n");
>>>> +               of_node_put(iommu_spec.np);
>>>>                  goto err;
>>>>          }
>>>>
>>>> +       of_node_put(iommu_spec.np);
>>>> +
>>>>          data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>>>          if (!data)
>>>>                  goto err;
>>>>
>>>> -       data->backend_domid = domid;
>>>> +       /*
>>>> +        * The endpoint ID here means the ID of the domain where the
>>>> corresponding
>>>> +        * backend is running
>>>> +        */
>>>> +       data->backend_domid = iommu_spec.args[0];
>>>>
>>>>          if (xa_err(xa_store(&xen_grant_dma_devices, (unsigned long)dev, data,
>>>>                          GFP_KERNEL))) {
>>>> (END)
>>>>
>>>>
>>>>
>>>> Below, the nodes generated by Xen toolstack:
>>>>
>>>>          xen_grant_dma {
>> Nit: iommu {
>>
>>>>                  compatible = "xen,grant-dma";
>>>>                  #iommu-cells = <0x01>;
>>>>                  phandle = <0xfde9>;
>>>>          };
>>>>
>>>>          virtio@2000000 {
>>>>                  compatible = "virtio,mmio";
>>>>                  reg = <0x00 0x2000000 0x00 0x200>;
>>>>                  interrupts = <0x00 0x01 0xf01>;
>>>>                  interrupt-parent = <0xfde8>;
>>>>                  dma-coherent;
>>>>                  iommus = <0xfde9 0x01>;
>>>>          };
>>> Not bad! I like it.
>>>
>>>
>>>> I am wondering, would be the proper solution to eliminate deferred probe
>>>> timeout issue in our particular case (without introducing an extra IOMMU
>>>> driver)?
>>> In reality I don't think there is a way to do that. I would create an
>>> empty skelethon IOMMU driver for xen,grant-dma.
>> Does it have to be an empty driver? Originally, IOMMU 'drivers' were not
>> drivers, but they've been getting converted. Can that be done here?
>>
>> Short of that, I think we could have some sort of skip probe list for
>> deferred probe. Not sure if that would be easiest as IOMMU specific or
>> global.
> Hi Oleksandr,
>
> If you do fw_devlink.strict=1, you'll notice that the consumers of
> this "iommu" won't probe at all or will delay the boot by some number
> of seconds. The eventual goal is to go towards fw_devlink.strict=1
> being the default.

ok, I got it.

Let's me please explain our particular case in details, sorry I may 
repeat some information which I have already mentioned elsewhere, but it 
maybe better to keep the whole context here.

We have Xen grant DMA-mapping layer added by previous commit [1]. For it 
to operate properly we need a way to communicate some per-device 
information using device-tree,
and this information is Xen specific. This is what the current commit is 
doing by introducing new binding to describe that. The next commit [2] 
will use that new binding to retrieve required information. There was a 
suggestion to consider reusing generic device-tree IOMMU bindings to 
communicate this specific information instead of introducing a custom 
property.

Although it requires more effort for the Xen toolstack (instead of 
adding a code to insert a single "xen,backend-domid" property, we need 
to generate fake IOMMU node, reserve phandle for it, etc), from the 
device tree PoV it looks indeed good (we reuse endpoint ID to pass the 
ID of the domain where the corresponding backend is running), and 
resulting code to retrieve this information in our DMA-mapping layer 
also looks simple enough [3].

Using generic device-tree IOMMU bindings:

          iommu {
                  compatible = "xen,grant-dma";
                  #iommu-cells = <0x01>;
                  phandle = <0xfde9>;
          };
          virtio@2000000 {
                  compatible = "virtio,mmio";
                  reg = <0x00 0x2000000 0x00 0x200>;
                  interrupts = <0x00 0x01 0xf01>;
                  interrupt-parent = <0xfde8>;
                  dma-coherent;
                  iommus = <0xfde9 0x01>;
          };

Using Xen specific property:

          virtio@2000000 {
                  compatible = "virtio,mmio";
                  reg = <0x00 0x2000000 0x00 0x200>;
                  interrupts = <0x00 0x01 0xf01>;
                  interrupt-parent = <0xfde8>;
                  dma-coherent;
                  xen,backend-domid = <0x01>;
          };


The main problem is that idea doesn't quite fit into how Linux currently 
behaves for the "iommus" property. Of course, just reusing IOMMU 
bindings (without having a corresponding driver) leads to the deferred 
probe timeout issue afterwards, because the IOMMU device never becomes 
available. From my understanding, our DMA-mapping layer we are consider 
to reuse IOMMU bindings for, *cannot* be converted into the proper IOMMU 
driver.

Sure, we will need to find a way how to deal with it, if we really want 
to reuse the IOMMU bindings. And yes, one idea was to just implement 
stub IOMMU driver for that purpose, I have rechecked, it works fine with 
that stub driver [4].

>
>  From a fw_devlik perspective, please implement a driver. Ideally a
> real one, but at least an empty one. The empty one doesn't need to be
> an IOMMU driver, but at least just do a return 0 in the probe
> function.


If I got things right, I am afraid, for the "of_iommu" case the empty 
driver is not enough. The driver should at least register iommu_ops, but 
the "of_xlate" callback should be *not* implemented.
In that case, we will get NO_IOMMU (>0 : there is no IOMMU, or one was 
unavailable for non-fatal reasons) which is also a success condition, so 
-EPROBE_DEFER won't be returned.

https://elixir.bootlin.com/linux/v5.18/source/drivers/iommu/of_iommu.c#L32

Otherwise, of_iommu_xlate() will call driver_deferred_probe_check_state().

https://elixir.bootlin.com/linux/v5.18/source/drivers/iommu/of_iommu.c#L43

>   Also, if it's not a device, why even have a "compatible"
> property (removing it won't necessarily remove the deferred probe
> timeout issue you see)? Will any code be using "xen,grant-dma" to look
> up the node?

Yes


>   If so, that driver could be the one that probes this
> device. At least from a fw_devlink perspective, it just needs to have
> a driver that binds to this device.

Agree


>
> Also, if we aren't going to implement a driver and have the supplier
> ("xen,grant-dma") behave like a device (as in, have a driver that
> probes), I'd rather that the iommu binding not be used at all as this
> would be an exception to how every other iommu device behaves.

Agree


Saravana, thank you for the explanation.


To summarize, as I understand, we have three options (the first two are 
clear enough, the third is unclear yet):

1. Do not try to reuse IOMMU bindings for current xen-virtio enabling 
work, use "xen,backend-domid" property.
2. Reuse IOMMU bindings, for that purpose introduce stub IOMMU driver. 
It is a standalone entity in my example, but it can be a part of 
grant-dma-ops.c which
actually uses "xen,grant-dma" compatible to look up a node.
3. Try to find other options how to reuse IOMMU bindings but *without* 
introducing stub IOMMU driver, such as skip list for deferred probe, etc.


What do the maintainers think regarding the option to go forward?


[1] 
https://lore.kernel.org/xen-devel/1651947548-4055-4-git-send-email-olekstysh@gmail.com/

[2] 
https://lore.kernel.org/xen-devel/1651947548-4055-7-git-send-email-olekstysh@gmail.com/

[3] 
https://lore.kernel.org/xen-devel/390ba7bb-ee9e-b7b7-5f08-71a7245fa4ec@gmail.com/

[4] 
https://lore.kernel.org/xen-devel/606dfdcc-ec10-0c4a-04e9-72cd73ee6676@gmail.com/

>
> -Saravana

-- 
Regards,

Oleksandr Tyshchenko

