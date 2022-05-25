Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05775533B87
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbiEYLPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242919AbiEYLPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:15:31 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2703C994FD;
        Wed, 25 May 2022 04:15:28 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a23so24073024ljd.9;
        Wed, 25 May 2022 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rPxl8EkhMMu+QvnTQcsLCQ39ZkFGiBXennA9WmD/9Xs=;
        b=Sev4dNUIIq6/hOqo3rTmmqxntKAU4xaF+48cF3pp7VSmzkTmwTqSR9zZzHKe/hCgs5
         BjINnYkT2EtLp+pZ4hPkapj8D2zAJ7Uv/S3/mm8ZpHQGKczqqvbTFw821a2hzfjdplS8
         MOxEqVBpC01I8sUvgzqiwV/YX1Gf5s7krK3xt0y/FFpww6ebrrkodExkj2vCAWc0LST5
         zpOFcHGLPw0VjkhJDNdpGaHEjDBLdS6rKI+aE5jJMTv486tQgYNyLzt6d4vJcd9fZ7gu
         dlD/b91ezj5/qIrnUOsA4wpGgj5wQBGJH1Vnfi1HJnEaUEeJTWucfWhfl9ECZcNrcKfD
         GjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rPxl8EkhMMu+QvnTQcsLCQ39ZkFGiBXennA9WmD/9Xs=;
        b=Idk6HwkJ7iMuVq/+Sa/dloIqGYLJF0OS8RAP8OWWWKPtGmxDMJV9gq9OdYOanwY7Oq
         EyrJlWK6TdUYQwKZYd8gbZw3uMVsx1r0lsZnJw92vEi3tF5AG0Oqz0X2U2ChQSBdD97a
         ktPVGeNGUuMCXalgfrjsYp+piWGROe3LCSEV1hMgZRZ6D+prDHXW+wUzMa8ysl3J2v1I
         8mNtdgfC4ba4FOpo210i487s9M4ftDX5nF/9d9DUuinZqJQjVWFuMq7AQVJS1Hg1Uz9f
         16B4NG8H9dXB800Tz5tl7CjbEOLoRoqKDB+jZNL7yjUf7CO5SURQu4oFNBdqqJsnMRWK
         Tb+g==
X-Gm-Message-State: AOAM5312TNWmNtQNma4QHGLWjFsMuNqXNgByGDgYuioA1S/ku/7sbTz1
        26O20sp0qwChCmT1bx2xjXA=
X-Google-Smtp-Source: ABdhPJwp7kkMcPxnXQqJwdXUyiWS1oOxGDDYvKQD945JkwJmUXqWkwd/51bNu6XAoe39FG4SvK20tw==
X-Received: by 2002:a2e:981:0:b0:253:d97f:9686 with SMTP id 123-20020a2e0981000000b00253d97f9686mr17016016ljj.227.1653477326120;
        Wed, 25 May 2022 04:15:26 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id v14-20020a2e990e000000b00253cc665797sm3059951lji.14.2022.05.25.04.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 04:15:25 -0700 (PDT)
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
 <6f469e9c-c26e-f4be-9a85-710afb0d77eb@gmail.com>
 <390ba7bb-ee9e-b7b7-5f08-71a7245fa4ec@gmail.com>
 <alpine.DEB.2.22.394.2205231856330.1905099@ubuntu-linux-20-04-desktop>
 <606dfdcc-ec10-0c4a-04e9-72cd73ee6676@gmail.com>
 <alpine.DEB.2.22.394.2205241058430.1905099@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <a32df11c-f29c-484b-a9ee-ef42f7c0464b@gmail.com>
Date:   Wed, 25 May 2022 14:15:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2205241058430.1905099@ubuntu-linux-20-04-desktop>
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


On 24.05.22 20:59, Stefano Stabellini wrote:

Hello Stefano

> On Tue, 24 May 2022, Oleksandr wrote:
>>> On Mon, 23 May 2022, Oleksandr wrote:
>>>>>> On Thu, 19 May 2022, Oleksandr wrote:
>>>>>>>> On Wed, May 18, 2022 at 5:06 PM Oleksandr <olekstysh@gmail.com>
>>>>>>>> wrote:
>>>>>>>>> On 18.05.22 17:32, Arnd Bergmann wrote:
>>>>>>>>>> On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko
>>>>>>>>>> <olekstysh@gmail.com> wrote:
>>>>>>>>>>       This would mean having a device
>>>>>>>>>> node for the grant-table mechanism that can be referred to
>>>>>>>>>> using
>>>>>>>>>> the
>>>>>>>>>> 'iommus'
>>>>>>>>>> phandle property, with the domid as an additional argument.
>>>>>>>>> I assume, you are speaking about something like the following?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> xen_dummy_iommu {
>>>>>>>>>         compatible = "xen,dummy-iommu";
>>>>>>>>>         #iommu-cells = <1>;
>>>>>>>>> };
>>>>>>>>>
>>>>>>>>> virtio@3000 {
>>>>>>>>>         compatible = "virtio,mmio";
>>>>>>>>>         reg = <0x3000 0x100>;
>>>>>>>>>         interrupts = <41>;
>>>>>>>>>
>>>>>>>>>         /* The device is located in Xen domain with ID 1 */
>>>>>>>>>         iommus = <&xen_dummy_iommu 1>;
>>>>>>>>> };
>>>>>>>> Right, that's that's the idea,
>>>>>>> thank you for the confirmation
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>      except I would not call it a 'dummy'.
>>>>>>>>     From the perspective of the DT, this behaves just like an
>>>>>>>> IOMMU,
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
>>>>>>>>> Interesting idea. I am wondering, do we need an extra actions
>>>>>>>>> for
>>>>>>>>> this
>>>>>>>>> to work in Linux guest (dummy IOMMU driver, etc)?
>>>>>>>> It depends on how closely the guest implementation can be made to
>>>>>>>> resemble a normal iommu. If you do allocate dma_addr_t addresses,
>>>>>>>> it may actually be close enough that you can just turn the
>>>>>>>> grant-table
>>>>>>>> code into a normal iommu driver and change nothing else.
>>>>>>> Unfortunately, I failed to find a way how use grant references at
>>>>>>> the
>>>>>>> iommu_ops level (I mean to fully pretend that we are an IOMMU
>>>>>>> driver). I
>>>>>>> am
>>>>>>> not too familiar with that, so what is written below might be wrong
>>>>>>> or
>>>>>>> at
>>>>>>> least not precise.
>>>>>>>
>>>>>>> The normal IOMMU driver in Linux doesn’t allocate DMA addresses by
>>>>>>> itself, it
>>>>>>> just maps (IOVA-PA) what was requested to be mapped by the upper
>>>>>>> layer.
>>>>>>> The
>>>>>>> DMA address allocation is done by the upper layer (DMA-IOMMU which
>>>>>>> is
>>>>>>> the glue
>>>>>>> layer between DMA API and IOMMU API allocates IOVA for PA?). But,
>>>>>>> all
>>>>>>> what we
>>>>>>> need here is just to allocate our specific grant-table based DMA
>>>>>>> addresses
>>>>>>> (DMA address = grant reference + offset in the page), so let’s say
>>>>>>> we
>>>>>>> need an
>>>>>>> entity to take a physical address as parameter and return a DMA
>>>>>>> address
>>>>>>> (what
>>>>>>> actually commit #3/7 is doing), and that’s all. So working at the
>>>>>>> dma_ops
>>>>>>> layer we get exactly what we need, with the minimal changes to guest
>>>>>>> infrastructure. In our case the Xen itself acts as an IOMMU.
>>>>>>>
>>>>>>> Assuming that we want to reuse the IOMMU infrastructure somehow for
>>>>>>> our
>>>>>>> needs.
>>>>>>> I think, in that case we will likely need to introduce a new
>>>>>>> specific
>>>>>>> IOVA
>>>>>>> allocator (alongside with a generic one) to be hooked up by the
>>>>>>> DMA-IOMMU
>>>>>>> layer if we run on top of Xen. But, even having the specific IOVA
>>>>>>> allocator to
>>>>>>> return what we indeed need (DMA address = grant reference + offset
>>>>>>> in
>>>>>>> the
>>>>>>> page) we will still need the specific minimal required IOMMU driver
>>>>>>> to
>>>>>>> be
>>>>>>> present in the system anyway in order to track the mappings(?) and
>>>>>>> do
>>>>>>> nothing
>>>>>>> with them, returning a success (this specific IOMMU driver should
>>>>>>> have
>>>>>>> all
>>>>>>> mandatory callbacks implemented).
>>>>>>>
>>>>>>> I completely agree, it would be really nice to reuse generic IOMMU
>>>>>>> bindings
>>>>>>> rather than introducing Xen specific property if what we are trying
>>>>>>> to
>>>>>>> implement in current patch series fits in the usage of "iommus" in
>>>>>>> Linux
>>>>>>> more-less. But, if we will have to add more complexity/more
>>>>>>> components
>>>>>>> to the
>>>>>>> code for the sake of reusing device tree binding, this raises a
>>>>>>> question
>>>>>>> whether that’s worthwhile.
>>>>>>>
>>>>>>> Or I really missed something?
>>>>>> I think Arnd was primarily suggesting to reuse the IOMMU Device Tree
>>>>>> bindings, not necessarily the IOMMU drivers framework in Linux
>>>>>> (although
>>>>>> that would be an added bonus.)
>>>>>>
>>>>>> I know from previous discussions with you that making the grant table
>>>>>> fit in the existing IOMMU drivers model is difficult, but just reusing
>>>>>> the Device Tree bindings seems feasible?
>>>>> I started experimenting with that. As wrote in a separate email, I got a
>>>>> deferred probe timeout,
>>>>>
>>>>> after inserting required nodes into guest device tree, which seems to be
>>>>> a
>>>>> consequence of the unavailability of IOMMU, I will continue to
>>>>> investigate
>>>>> this question.
>>>> I have experimented with that. Yes, just reusing the Device Tree bindings
>>>> is
>>>> technically feasible (and we are able to do this by only touching
>>>> grant-dma-ops.c), although deferred probe timeout still stands (as there
>>>> is no
>>>> IOMMU driver being present actually).
>>>>
>>>> [    0.583771] virtio-mmio 2000000.virtio: deferred probe timeout,
>>>> ignoring
>>>> dependency
>>>> [    0.615556] virtio_blk virtio0: [vda] 4096000 512-byte logical blocks
>>>> (2.10
>>>> GB/1.95 GiB)
>>>>
>>>>
>>>> Below the working diff (on top of current series):
>>>>
>>>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>>>> index da9c7ff..6586152 100644
>>>> --- a/drivers/xen/grant-dma-ops.c
>>>> +++ b/drivers/xen/grant-dma-ops.c
>>>> @@ -272,17 +272,24 @@ static const struct dma_map_ops xen_grant_dma_ops =
>>>> {
>>>>
>>>>    bool xen_is_grant_dma_device(struct device *dev)
>>>>    {
>>>> +       struct device_node *iommu_np;
>>>> +       bool has_iommu;
>>>> +
>>>>           /* XXX Handle only DT devices for now */
>>>>           if (!dev->of_node)
>>>>                   return false;
>>>>
>>>> -       return of_property_read_bool(dev->of_node, "xen,backend-domid");
>>>> +       iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
>>>> +       has_iommu = iommu_np && of_device_is_compatible(iommu_np,
>>>> "xen,grant-dma");
>>>> +       of_node_put(iommu_np);
>>>> +
>>>> +       return has_iommu;
>>>>    }
>>>>
>>>>    void xen_grant_setup_dma_ops(struct device *dev)
>>>>    {
>>>>           struct xen_grant_dma_data *data;
>>>> -       uint32_t domid;
>>>> +       struct of_phandle_args iommu_spec;
>>>>
>>>>           data = find_xen_grant_dma_data(dev);
>>>>           if (data) {
>>>> @@ -294,16 +301,30 @@ void xen_grant_setup_dma_ops(struct device *dev)
>>>>           if (!dev->of_node)
>>>>                   goto err;
>>>>
>>>> -       if (of_property_read_u32(dev->of_node, "xen,backend-domid",
>>>> &domid)) {
>>>> -               dev_err(dev, "xen,backend-domid property is not
>>>> present\n");
>>>> +       if (of_parse_phandle_with_args(dev->of_node, "iommus",
>>>> "#iommu-cells",
>>>> +                       0, &iommu_spec)) {
>>>> +               dev_err(dev, "Cannot parse iommus property\n");
>>>> +               goto err;
>>>> +       }
>>>> +
>>>> +       if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
>>>> +                       iommu_spec.args_count != 1) {
>>>> +               dev_err(dev, "Incompatible IOMMU node\n");
>>>> +               of_node_put(iommu_spec.np);
>>>>                   goto err;
>>>>           }
>>>>
>>>> +       of_node_put(iommu_spec.np);
>>>> +
>>>>           data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>>>           if (!data)
>>>>                   goto err;
>>>>
>>>> -       data->backend_domid = domid;
>>>> +       /*
>>>> +        * The endpoint ID here means the ID of the domain where the
>>>> corresponding
>>>> +        * backend is running
>>>> +        */
>>>> +       data->backend_domid = iommu_spec.args[0];
>>>>
>>>>           if (xa_err(xa_store(&xen_grant_dma_devices, (unsigned long)dev,
>>>> data,
>>>>                           GFP_KERNEL))) {
>>>> (END)
>>>>
>>>>
>>>>
>>>> Below, the nodes generated by Xen toolstack:
>>>>
>>>>           xen_grant_dma {
>>>>                   compatible = "xen,grant-dma";
>>>>                   #iommu-cells = <0x01>;
>>>>                   phandle = <0xfde9>;
>>>>           };
>>>>
>>>>           virtio@2000000 {
>>>>                   compatible = "virtio,mmio";
>>>>                   reg = <0x00 0x2000000 0x00 0x200>;
>>>>                   interrupts = <0x00 0x01 0xf01>;
>>>>                   interrupt-parent = <0xfde8>;
>>>>                   dma-coherent;
>>>>                   iommus = <0xfde9 0x01>;
>>>>           };
>>>    Not bad! I like it.
>>
>> Good.
>>
>>
>>
>>>      
>>>> I am wondering, would be the proper solution to eliminate deferred probe
>>>> timeout issue in our particular case (without introducing an extra IOMMU
>>>> driver)?
>>> In reality I don't think there is a way to do that. I would create an
>>> empty skelethon IOMMU driver for xen,grant-dma.
>> Ok, I found yet another option how we can avoid deferred probe timeout issue.
>> I am not sure whether it will be welcome. But it doesn't really require
>> introducing stub IOMMU driver or other changes in the guest. The idea is to
>> make IOMMU device unavailable (status = "disabled"), this way
>> of_iommu_configure() will treat that as success condition also.
>>
>> https://elixir.bootlin.com/linux/v5.18/source/drivers/iommu/of_iommu.c#L31
>> https://elixir.bootlin.com/linux/v5.18/source/drivers/iommu/of_iommu.c#L149
>>
>>          xen_grant_dma {
>>                  compatible = "xen,grant-dma";
>>                  #iommu-cells = <0x01>;
>>                  phandle = <0xfde9>;
>>                  status = "disabled";
>>          };
>>          virtio@2000000 {
>>                  compatible = "virtio,mmio";
>>                  reg = <0x00 0x2000000 0x00 0x200>;
>>                  interrupts = <0x00 0x01 0xf01>;
>>                  interrupt-parent = <0xfde8>;
>>                  dma-coherent;
>>                  iommus = <0xfde9 0x01>;
>>          };
>>
>> I have checked, this "fixes" deferred probe timeout issue.
>>
>>
>> Or we indeed need to introduce stub IOMMU driver (I placed it to driver/xen
>> instead of driver/iommu, also we can even squash it with grant-dma-ops.c?).
>> This stub driver also results in NO_IOMMU condition (as "of_xlate" callback is
>> not implemented).
>>
>> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
>> index a7bd8ce..35b91b9 100644
>> --- a/drivers/xen/Kconfig
>> +++ b/drivers/xen/Kconfig
>> @@ -335,6 +335,10 @@ config XEN_UNPOPULATED_ALLOC
>>            having to balloon out RAM regions in order to obtain physical memory
>>            space to create such mappings.
>>
>> +config XEN_GRANT_DMA_IOMMU
>> +       bool
>> +       select IOMMU_API
>> +
>>   config XEN_GRANT_DMA_OPS
>>          bool
>>          select DMA_OPS
>> @@ -343,6 +347,7 @@ config XEN_VIRTIO
>>          bool "Xen virtio support"
>>          depends on VIRTIO
>>          select XEN_GRANT_DMA_OPS
>> +       select XEN_GRANT_DMA_IOMMU
>>          help
>>            Enable virtio support for running as Xen guest. Depending on the
>>            guest type this will require special support on the backend side
>> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
>> index 1a23cb0..c0503f1 100644
>> --- a/drivers/xen/Makefile
>> +++ b/drivers/xen/Makefile
>> @@ -40,3 +40,4 @@ xen-privcmd-y                         := privcmd.o
>> privcmd-buf.o
>>   obj-$(CONFIG_XEN_FRONT_PGDIR_SHBUF)    += xen-front-pgdir-shbuf.o
>>   obj-$(CONFIG_XEN_UNPOPULATED_ALLOC)    += unpopulated-alloc.o
>>   obj-$(CONFIG_XEN_GRANT_DMA_OPS)                += grant-dma-ops.o
>> +obj-$(CONFIG_XEN_GRANT_DMA_IOMMU)      += grant-dma-iommu.o
>> diff --git a/drivers/xen/grant-dma-iommu.c b/drivers/xen/grant-dma-iommu.c
>> new file mode 100644
>> index 00000000..b8aad8a
>> --- /dev/null
>> +++ b/drivers/xen/grant-dma-iommu.c
>> @@ -0,0 +1,76 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Stub IOMMU driver which does nothing.
>> + * The main purpose of it being present is to reuse generic device-tree IOMMU
>> + * bindings by Xen grant DMA-mapping layer.
>> + */
>> +
>> +#include <linux/iommu.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +
>> +struct grant_dma_iommu_device {
>> +       struct device *dev;
>> +       struct iommu_device iommu;
>> +};
>> +
>> +/* Nothing is really needed here */
>> +static const struct iommu_ops grant_dma_iommu_ops;
>> +
>> +static const struct of_device_id grant_dma_iommu_of_match[] = {
>> +       { .compatible = "xen,grant-dma" },
>> +       { },
>> +};
>> +
>> +static int grant_dma_iommu_probe(struct platform_device *pdev)
>> +{
>> +       struct grant_dma_iommu_device *mmu;
>> +       int ret;
>> +
>> +       mmu = devm_kzalloc(&pdev->dev, sizeof(*mmu), GFP_KERNEL);
>> +       if (!mmu)
>> +               return -ENOMEM;
>> +
>> +       mmu->dev = &pdev->dev;
>> +
>> +       ret = iommu_device_register(&mmu->iommu, &grant_dma_iommu_ops,
>> &pdev->dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       platform_set_drvdata(pdev, mmu);
>> +
>> +       return 0;
>> +}
>> +
>> +static int grant_dma_iommu_remove(struct platform_device *pdev)
>> +{
>> +       struct grant_dma_iommu_device *mmu = platform_get_drvdata(pdev);
>> +
>> +       platform_set_drvdata(pdev, NULL);
>> +       iommu_device_unregister(&mmu->iommu);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct platform_driver grant_dma_iommu_driver = {
>> +       .driver = {
>> +               .name = "grant-dma-iommu",
>> +               .of_match_table = grant_dma_iommu_of_match,
>> +       },
>> +       .probe = grant_dma_iommu_probe,
>> +       .remove = grant_dma_iommu_remove,
>> +};
>> +
>> +static int __init grant_dma_iommu_init(void)
>> +{
>> +       struct device_node *iommu_np;
>> +
>> +       iommu_np = of_find_matching_node(NULL, grant_dma_iommu_of_match);
>> +       if (!iommu_np)
>> +               return 0;
>> +
>> +       of_node_put(iommu_np);
>> +
>> +       return platform_driver_register(&grant_dma_iommu_driver);
>> +}
>> +subsys_initcall(grant_dma_iommu_init);
>>
>> I have checked, this also "fixes" deferred probe timeout issue.
>>
>> Personally I would prefer the first option, but I would be also happy to use
>> second option in order to unblock the series.
>>
>> What do the maintainers think?
>   
>
> I don't think it is a good idea to mark the fake IOMMU as disabled
> because it implies that there is no need to use it (no need to use
> dma_ops) which is a problem.

I got your point. You are right, this indeed sounds weird. I expected 
this simple solution wouldn't be welcome.


>
> If we don't want the skelethon driver then Rob's suggestion of having a
> skip list for deferred probe is better.


I am not sure I understand the idea completely.

Does it mean that we will need new command line option (?) to pass some 
string (I assume, the "compatible" for IOMMU device) to not defer probe 
if corresponding driver is missing,

but just return NO_IOMMU right away?


>
> I think the skelethon driver also is totally fine.

ok, thank you for the feedback.


-- 
Regards,

Oleksandr Tyshchenko

