Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A16531CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbiEWSNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbiEWRu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:50:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A158532DA;
        Mon, 23 May 2022 10:37:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p4so25402825lfg.4;
        Mon, 23 May 2022 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mPzl0IxVpOBD7BXqIA/dVHyw+aKjOBb3ATUZ7spN2qg=;
        b=YBXi34/97S1J6MVRP9bjFSy6nwf8akZPAOC/SZxPbaoEJt38sG+LmdKjzh08RriLXa
         /82hF+iabCGUoXkCr++jGmyKd2eu0EPfZuPLmIYT2uuXAE1b2qAPOVGDak/cGhL4fEjO
         W4MPf0p9X1zgwnrLxftV+Tzaxe6/boss5X1KQb5kPEawpyIt6kV100rXzWTZveBjJutc
         wwFm+vv8k1hjJztqFZhroiNW32+bzO04NNPPf6PlnO8Z7YvGXEx3+RnfTBTFsaE0aTVf
         hjech1zrcYaDw6PSWg8f9wOaMmC4Qn28WLbCEyYpLmkNv0YwawmXEPOS1JUsFnuEqS14
         hz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mPzl0IxVpOBD7BXqIA/dVHyw+aKjOBb3ATUZ7spN2qg=;
        b=xS7cSLsS+H53gF5SLPgTeEzaPNM0bfMmRF7xCOjgDyzGGvx9iV0HtJ8+4bxdvGZLQy
         bTh8TyTSn30eK7n44TuxNtuob7c2DNAahehKAhLnUmA16E1k1fXQpHH2dYpeG6uOiN7k
         44JxSVjXCeAuGeJkHpD1KAL7PCkgJQG71dnoVEZpvtR9dHS+HhrAf+Scu8pKrVvqhyvk
         Ka6N02bLGrWG0S6g7tCbdBE35z4XBYJO3gUqvUq0f3yKcBDH3hgu/7qeTn8DBwtswfi3
         lFkQl0IeoA/HAk0kV7ZAylWZWGYQqaLBO3APWdpFEG6MsZpwq4YH7ClNzUoGKQJ/VnSA
         smPA==
X-Gm-Message-State: AOAM530SOsXqwWHUCgBw1kx5TCHtGCbjZmb3va1RUStSazz4CMYE2WK7
        kiYyGxRBcrPikz9LRgZ5Q9TeO/zjZGw=
X-Google-Smtp-Source: ABdhPJzwZfozEnQDt+CrjQ7uTvPbLWypALeKVlqUmFxBKfIWsyPw8Alci4bEMHh/m6nHITXZtcC2TA==
X-Received: by 2002:a2e:7a0d:0:b0:253:decb:be0f with SMTP id v13-20020a2e7a0d000000b00253decbbe0fmr9414809ljc.525.1653327022433;
        Mon, 23 May 2022 10:30:22 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id f11-20020a05651232cb00b004786243ab08sm1229661lfg.108.2022.05.23.10.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 10:30:22 -0700 (PDT)
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
From:   Oleksandr <olekstysh@gmail.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <390ba7bb-ee9e-b7b7-5f08-71a7245fa4ec@gmail.com>
Date:   Mon, 23 May 2022 20:30:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6f469e9c-c26e-f4be-9a85-710afb0d77eb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19.05.22 09:03, Oleksandr wrote:

Hello Stefano, all


>
> On 19.05.22 04:06, Stefano Stabellini wrote:
>
>
> Hello Stefano, all
>
>> On Thu, 19 May 2022, Oleksandr wrote:
>>>> On Wed, May 18, 2022 at 5:06 PM Oleksandr <olekstysh@gmail.com> wrote:
>>>>> On 18.05.22 17:32, Arnd Bergmann wrote:
>>>>>> On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko
>>>>>> <olekstysh@gmail.com> wrote:
>>>>>>     This would mean having a device
>>>>>> node for the grant-table mechanism that can be referred to using the
>>>>>> 'iommus'
>>>>>> phandle property, with the domid as an additional argument.
>>>>> I assume, you are speaking about something like the following?
>>>>>
>>>>>
>>>>> xen_dummy_iommu {
>>>>>       compatible = "xen,dummy-iommu";
>>>>>       #iommu-cells = <1>;
>>>>> };
>>>>>
>>>>> virtio@3000 {
>>>>>       compatible = "virtio,mmio";
>>>>>       reg = <0x3000 0x100>;
>>>>>       interrupts = <41>;
>>>>>
>>>>>       /* The device is located in Xen domain with ID 1 */
>>>>>       iommus = <&xen_dummy_iommu 1>;
>>>>> };
>>>> Right, that's that's the idea,
>>> thank you for the confirmation
>>>
>>>
>>>
>>>>    except I would not call it a 'dummy'.
>>>>   From the perspective of the DT, this behaves just like an IOMMU,
>>>> even if the exact mechanism is different from most hardware IOMMU
>>>> implementations.
>>> well, agree
>>>
>>>
>>>>>> It does not quite fit the model that Linux currently uses for 
>>>>>> iommus,
>>>>>> as that has an allocator for dma_addr_t space
>>>>> yes (# 3/7 adds grant-table based allocator)
>>>>>
>>>>>
>>>>>> , but it would think it's
>>>>>> conceptually close enough that it makes sense for the binding.
>>>>> Interesting idea. I am wondering, do we need an extra actions for 
>>>>> this
>>>>> to work in Linux guest (dummy IOMMU driver, etc)?
>>>> It depends on how closely the guest implementation can be made to
>>>> resemble a normal iommu. If you do allocate dma_addr_t addresses,
>>>> it may actually be close enough that you can just turn the grant-table
>>>> code into a normal iommu driver and change nothing else.
>>> Unfortunately, I failed to find a way how use grant references at the
>>> iommu_ops level (I mean to fully pretend that we are an IOMMU 
>>> driver). I am
>>> not too familiar with that, so what is written below might be wrong 
>>> or at
>>> least not precise.
>>>
>>> The normal IOMMU driver in Linux doesn’t allocate DMA addresses by 
>>> itself, it
>>> just maps (IOVA-PA) what was requested to be mapped by the upper 
>>> layer. The
>>> DMA address allocation is done by the upper layer (DMA-IOMMU which 
>>> is the glue
>>> layer between DMA API and IOMMU API allocates IOVA for PA?). But, 
>>> all what we
>>> need here is just to allocate our specific grant-table based DMA 
>>> addresses
>>> (DMA address = grant reference + offset in the page), so let’s say 
>>> we need an
>>> entity to take a physical address as parameter and return a DMA 
>>> address (what
>>> actually commit #3/7 is doing), and that’s all. So working at the 
>>> dma_ops
>>> layer we get exactly what we need, with the minimal changes to guest
>>> infrastructure. In our case the Xen itself acts as an IOMMU.
>>>
>>> Assuming that we want to reuse the IOMMU infrastructure somehow for 
>>> our needs.
>>> I think, in that case we will likely need to introduce a new 
>>> specific IOVA
>>> allocator (alongside with a generic one) to be hooked up by the 
>>> DMA-IOMMU
>>> layer if we run on top of Xen. But, even having the specific IOVA 
>>> allocator to
>>> return what we indeed need (DMA address = grant reference + offset 
>>> in the
>>> page) we will still need the specific minimal required IOMMU driver 
>>> to be
>>> present in the system anyway in order to track the mappings(?) and 
>>> do nothing
>>> with them, returning a success (this specific IOMMU driver should 
>>> have all
>>> mandatory callbacks implemented).
>>>
>>> I completely agree, it would be really nice to reuse generic IOMMU 
>>> bindings
>>> rather than introducing Xen specific property if what we are trying to
>>> implement in current patch series fits in the usage of "iommus" in 
>>> Linux
>>> more-less. But, if we will have to add more complexity/more 
>>> components to the
>>> code for the sake of reusing device tree binding, this raises a 
>>> question
>>> whether that’s worthwhile.
>>>
>>> Or I really missed something?
>> I think Arnd was primarily suggesting to reuse the IOMMU Device Tree
>> bindings, not necessarily the IOMMU drivers framework in Linux (although
>> that would be an added bonus.)
>>
>> I know from previous discussions with you that making the grant table
>> fit in the existing IOMMU drivers model is difficult, but just reusing
>> the Device Tree bindings seems feasible?
>
> I started experimenting with that. As wrote in a separate email, I got 
> a deferred probe timeout,
>
> after inserting required nodes into guest device tree, which seems to 
> be a consequence of the unavailability of IOMMU, I will continue to 
> investigate this question.


I have experimented with that. Yes, just reusing the Device Tree 
bindings is technically feasible (and we are able to do this by only 
touching grant-dma-ops.c), although deferred probe timeout still stands 
(as there is no IOMMU driver being present actually).

[    0.583771] virtio-mmio 2000000.virtio: deferred probe timeout, 
ignoring dependency
[    0.615556] virtio_blk virtio0: [vda] 4096000 512-byte logical blocks 
(2.10 GB/1.95 GiB)


Below the working diff (on top of current series):

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index da9c7ff..6586152 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -272,17 +272,24 @@ static const struct dma_map_ops xen_grant_dma_ops = {

  bool xen_is_grant_dma_device(struct device *dev)
  {
+       struct device_node *iommu_np;
+       bool has_iommu;
+
         /* XXX Handle only DT devices for now */
         if (!dev->of_node)
                 return false;

-       return of_property_read_bool(dev->of_node, "xen,backend-domid");
+       iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
+       has_iommu = iommu_np && of_device_is_compatible(iommu_np, 
"xen,grant-dma");
+       of_node_put(iommu_np);
+
+       return has_iommu;
  }

  void xen_grant_setup_dma_ops(struct device *dev)
  {
         struct xen_grant_dma_data *data;
-       uint32_t domid;
+       struct of_phandle_args iommu_spec;

         data = find_xen_grant_dma_data(dev);
         if (data) {
@@ -294,16 +301,30 @@ void xen_grant_setup_dma_ops(struct device *dev)
         if (!dev->of_node)
                 goto err;

-       if (of_property_read_u32(dev->of_node, "xen,backend-domid", 
&domid)) {
-               dev_err(dev, "xen,backend-domid property is not present\n");
+       if (of_parse_phandle_with_args(dev->of_node, "iommus", 
"#iommu-cells",
+                       0, &iommu_spec)) {
+               dev_err(dev, "Cannot parse iommus property\n");
+               goto err;
+       }
+
+       if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
+                       iommu_spec.args_count != 1) {
+               dev_err(dev, "Incompatible IOMMU node\n");
+               of_node_put(iommu_spec.np);
                 goto err;
         }

+       of_node_put(iommu_spec.np);
+
         data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
         if (!data)
                 goto err;

-       data->backend_domid = domid;
+       /*
+        * The endpoint ID here means the ID of the domain where the 
corresponding
+        * backend is running
+        */
+       data->backend_domid = iommu_spec.args[0];

         if (xa_err(xa_store(&xen_grant_dma_devices, (unsigned long)dev, 
data,
                         GFP_KERNEL))) {
(END)



Below, the nodes generated by Xen toolstack:

         xen_grant_dma {
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



I am wondering, would be the proper solution to eliminate deferred probe 
timeout issue in our particular case (without introducing an extra IOMMU 
driver)?




>
>
>
>
-- 
Regards,

Oleksandr Tyshchenko

