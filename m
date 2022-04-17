Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCBC504897
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiDQR0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiDQR0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:26:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294A1CFC1;
        Sun, 17 Apr 2022 10:24:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a8so14400596ljq.5;
        Sun, 17 Apr 2022 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BzXYSzvfK+AdGCOQfhtjoV/H2s/prwGV3n0qtSorc04=;
        b=TfLFZImLLGFLitXlcV5CC54oDV7wPZeOc/E2oAolOwNyvhSJHXphZzRM3dpmgyQCRe
         ODu5+qawstLwAF36zv5uxkWthN/ZlZOrbjCYMoCwpDAsndrnK+ej6cNahBLYhNLoef6y
         HxDXOb8x6+XUKiBRtkH9U5lx0lFSfg/W2AGqhAS7h6HYThF9BdulGC9ibWBSuolxF1E0
         Y4FCW/iFqBg3x9L5byXkdwS1MzVqYmaLs0/WNqkLUpfRLWU/WvP1TbUJZrBsaS6jibsY
         0nbYf0kkYmnEpQRsopT0oZlbiK7KPhDsohAdwvHLRkyQYq5YGkwVe/LDNEY9dcO5VVKK
         0v3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BzXYSzvfK+AdGCOQfhtjoV/H2s/prwGV3n0qtSorc04=;
        b=AnGwbzhl6k33kSppAuGTWtQfiKKsfejXhbp47KZftsDE0ff3/gKKMQNbVaeDxpgb1x
         vlPAnTcchPR9E3orp8fYYuYbea8LWLTMT4X2hfq8Wv7KrwLDPbZvp2SEBWXxICiOJIli
         UBwRDThWV0Y7QQPigvr5EpVJBF0oslc9lviCWSfA9mngKSUdNiZTUaRnvnNP4w6NKzgF
         7BJHulGZoDg4GjquvC8KCZHBogdvGX6sEw6wsCIg1oMrNuabfDCWvVAz/KcwLKeax2JV
         Kn3Rm+FNkozqzFjEul1Grs4Kvvn61C49sYHpbtce/9lsTXeqSFzImeqR+gfzgd2bdUkZ
         bzZg==
X-Gm-Message-State: AOAM530lbSceATWuf+V2SiF3LkKjM3LrmA4DL7FNGnYR6F2yjjF0KJyH
        5dLgyKBIWwOdDuVCZJPG/Qw=
X-Google-Smtp-Source: ABdhPJxTemiKeMLlnU7cPGCdgJGGmlp8j7m20rDTsAgzxwVprfeIhsQG7I18pOXBCqf5AZgV84wFEQ==
X-Received: by 2002:a2e:9654:0:b0:24d:b57c:5f29 with SMTP id z20-20020a2e9654000000b0024db57c5f29mr2869471ljh.70.1650216249064;
        Sun, 17 Apr 2022 10:24:09 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id o2-20020a056512052200b0047067a6e5d5sm524448lfc.218.2022.04.17.10.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 10:24:08 -0700 (PDT)
Subject: Re: [RFC PATCH 3/6] dt-bindings: xen: Add xen,dev-domid property
 description for xen-virtio layer
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-4-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151300130.915916@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <fd3a53da-e3a4-5503-30d7-07b180c6d227@gmail.com>
Date:   Sun, 17 Apr 2022 20:24:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2204151300130.915916@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.04.22 01:01, Stefano Stabellini wrote:

Hello Stefano


> On Thu, 14 Apr 2022, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> Introduce Xen specific binding for the virtio-mmio device to be used
>> by Xen virtio support driver in a subsequent commit.
>>
>> This binding specifies the ID of Xen domain where the corresponding
>> device (backend) resides. This is needed for the option to restrict
>> memory access using Xen grant mappings to work.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
>>   .../devicetree/bindings/virtio/xen,dev-domid.yaml  | 39 ++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml b/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
>> new file mode 100644
>> index 00000000..78be993
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
>> @@ -0,0 +1,39 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/virtio/xen,dev-domid.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xen specific binding for the virtio device
>> +
>> +maintainers:
>> +  - Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> +
>> +select: true
>> +
>> +description:
>> +  This binding specifies the ID of Xen domain where the corresponding device
>> +  (backend) resides. This is needed for the option to restrict memory access
>> +  using Xen grant mappings to work.
>> +
>> +  Note that current and generic "iommus" bindings are mutually exclusive, since
>> +  the restricted memory access model on Xen behaves as a kind of software IOMMU.
> I don't think that this last statement is necessary or fully accurate, so
> I would remove it.


ok, will remove


> Other than that, this looks good to me.


thank you


>
>
>> +properties:
>> +  xen,dev-domid:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Should contain the ID of device's domain.
> Maybe better as:
> "The domid (domain ID) of the domain where the device (backend) is running"


ok, will change


>
>
>
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    virtio_block@3000 {
>> +            compatible = "virtio,mmio";
>> +            reg = <0x3000 0x100>;
>> +            interrupts = <41>;
>> +
>> +            /* The device is located in Xen domain with ID 1 */
>> +            xen,dev-domid = <1>;
>> +    };
>> -- 
>> 2.7.4
>>
-- 
Regards,

Oleksandr Tyshchenko

