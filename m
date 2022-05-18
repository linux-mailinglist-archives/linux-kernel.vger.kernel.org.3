Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84052C78E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiERXco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 19:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiERXck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 19:32:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A91666B3;
        Wed, 18 May 2022 16:32:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p4so4827293lfg.4;
        Wed, 18 May 2022 16:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+LGXPC/nc5jPsFNWeFnV3sMHcGrlhqWcYZ7LdmbKRk8=;
        b=YTHEh7mTOmNtdzt4vQbdAc2SgEofQ268qYKBDuNf/dOC6SxLJE063CXRsT7pOhKL1B
         EGVemTL1TLKqWYa9CSGx5cbFZ4E9T+4Of+1+hsq50kvDC4VGTl+vLzagzw/9FIiMD3mD
         68EtqA8PUsGWxuwkNjJN7CN0F5dYVrBn60wH/8QkhglC7NjT1tcsmpDa3P1fOxbvWmqJ
         GGo/O2fedbOeYWcu0CSzqlUmHH69ulzsmxE4XTaT3WZenUfYjq66nFfHk9uJYHgiBNez
         3SGwnSe2PpE/fxhUokfLiy6EqKaSwofgOGt66tG6Ex/mFSOaAX1KZIwwHiS95tMT+i/l
         kFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+LGXPC/nc5jPsFNWeFnV3sMHcGrlhqWcYZ7LdmbKRk8=;
        b=XRWmeA9h/jW7mB0+0mHxKHMmhGYGAGvXdfR0metNHui3bHYfSZqa3uTsDb+LnawV2m
         CK0MaQcz6sf3ZJs58qMf4ZlwXdtck9NzTOfDra7dTMybDYlScKulycredohOXT0yWH5v
         ycHsNvYLjzwCbZJaWJgslfESZ6G0bo0xVDpmK5atEYnro1qC9NDOtVIniQjOT+HigdYP
         MOSLRU+D2NyZtQl968ZH9ntcAaY2ITKjakR9/18d6oM4QsNWv3nDcqfudiMQiNKiLcNR
         KxM7DAObE67iqtimkJbPshNrdRLakeTnt/jZBzpkPu9O1c84GHVT3IyjajmgIcc+Ghwi
         NJKA==
X-Gm-Message-State: AOAM530l4q6yZQrDcMIn+p+zEMONV6Vbz0MxBWLldUmLVpyLCsvVnwnr
        u4POMkObXQAV9xWhqU5RJHZp8aKCOJw=
X-Google-Smtp-Source: ABdhPJwjk0UvPnxiWmUdMMDJvHCgF0t+PGqTImMMJx2jyaDgM9Se5UhDGarsoLtoC23AOueCaP89SQ==
X-Received: by 2002:a19:494b:0:b0:476:5917:b67 with SMTP id l11-20020a19494b000000b0047659170b67mr1293318lfj.452.1652916757237;
        Wed, 18 May 2022 16:32:37 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id 189-20020a2e09c6000000b00253b5bb829esm358776ljj.98.2022.05.18.16.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 16:32:36 -0700 (PDT)
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
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
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
 <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
 <56e8c32d-6771-7179-005f-26ca58555659@gmail.com>
 <CAK8P3a1YhkEZ8gcbXHEa5Bwx-4VVRJO8SUHf8=RNWRsc2Yo-+A@mail.gmail.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <460a746c-6b61-214b-4653-44a1430e314d@gmail.com>
Date:   Thu, 19 May 2022 02:32:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1YhkEZ8gcbXHEa5Bwx-4VVRJO8SUHf8=RNWRsc2Yo-+A@mail.gmail.com>
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


On 18.05.22 19:39, Arnd Bergmann wrote:


Hello Arnd


> On Wed, May 18, 2022 at 5:06 PM Oleksandr <olekstysh@gmail.com> wrote:
>> On 18.05.22 17:32, Arnd Bergmann wrote:
>>> On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko <olekstysh@gmail.com> wrote:
>>>    This would mean having a device
>>> node for the grant-table mechanism that can be referred to using the 'iommus'
>>> phandle property, with the domid as an additional argument.
>> I assume, you are speaking about something like the following?
>>
>>
>> xen_dummy_iommu {
>>      compatible = "xen,dummy-iommu";
>>      #iommu-cells = <1>;
>> };
>>
>> virtio@3000 {
>>      compatible = "virtio,mmio";
>>      reg = <0x3000 0x100>;
>>      interrupts = <41>;
>>
>>      /* The device is located in Xen domain with ID 1 */
>>      iommus = <&xen_dummy_iommu 1>;
>> };
> Right, that's that's the idea,

thank you for the confirmation



>   except I would not call it a 'dummy'.
>  From the perspective of the DT, this behaves just like an IOMMU,
> even if the exact mechanism is different from most hardware IOMMU
> implementations.

well, agree


>
>>> It does not quite fit the model that Linux currently uses for iommus,
>>> as that has an allocator for dma_addr_t space
>> yes (# 3/7 adds grant-table based allocator)
>>
>>
>>> , but it would think it's
>>> conceptually close enough that it makes sense for the binding.
>> Interesting idea. I am wondering, do we need an extra actions for this
>> to work in Linux guest (dummy IOMMU driver, etc)?
> It depends on how closely the guest implementation can be made to
> resemble a normal iommu. If you do allocate dma_addr_t addresses,
> it may actually be close enough that you can just turn the grant-table
> code into a normal iommu driver and change nothing else.

Unfortunately, I failed to find a way how use grant references at the 
iommu_ops level (I mean to fully pretend that we are an IOMMU driver). I 
am not too familiar with that, so what is written below might be wrong 
or at least not precise.

The normal IOMMU driver in Linux doesn’t allocate DMA addresses by 
itself, it just maps (IOVA-PA) what was requested to be mapped by the 
upper layer. The DMA address allocation is done by the upper layer 
(DMA-IOMMU which is the glue layer between DMA API and IOMMU API 
allocates IOVA for PA?). But, all what we need here is just to allocate 
our specific grant-table based DMA addresses (DMA address = grant 
reference + offset in the page), so let’s say we need an entity to take 
a physical address as parameter and return a DMA address (what actually 
commit #3/7 is doing), and that’s all. So working at the dma_ops layer 
we get exactly what we need, with the minimal changes to guest 
infrastructure. In our case the Xen itself acts as an IOMMU.

Assuming that we want to reuse the IOMMU infrastructure somehow for our 
needs. I think, in that case we will likely need to introduce a new 
specific IOVA allocator (alongside with a generic one) to be hooked up 
by the DMA-IOMMU layer if we run on top of Xen. But, even having the 
specific IOVA allocator to return what we indeed need (DMA address = 
grant reference + offset in the page) we will still need the specific 
minimal required IOMMU driver to be present in the system anyway in 
order to track the mappings(?) and do nothing with them, returning a 
success (this specific IOMMU driver should have all mandatory callbacks 
implemented).

I completely agree, it would be really nice to reuse generic IOMMU 
bindings rather than introducing Xen specific property if what we are 
trying to implement in current patch series fits in the usage of 
"iommus" in Linux more-less. But, if we will have to add more 
complexity/more components to the code for the sake of reusing device 
tree binding, this raises a question whether that’s worthwhile.

Or I really missed something?


>
>          Arnd

-- 
Regards,

Oleksandr Tyshchenko

