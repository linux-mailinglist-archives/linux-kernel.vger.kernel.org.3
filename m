Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDA652BDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbiEROci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiEROcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:32:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008913CA38;
        Wed, 18 May 2022 07:32:33 -0700 (PDT)
Received: from mail-yw1-f175.google.com ([209.85.128.175]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDPqi-1nzcRl0xTq-00ATkr; Wed, 18 May 2022 16:32:31 +0200
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ec42eae76bso26304877b3.10;
        Wed, 18 May 2022 07:32:30 -0700 (PDT)
X-Gm-Message-State: AOAM533Sr58KVGRRaHUSQv7V1Nd3Y10h59aVcVe1VZBmEOHeyDkrAXNy
        Qjmy8ydJ9C89ob4MgbgsZM5qhzuQiuvEasBy7G8=
X-Google-Smtp-Source: ABdhPJxlE4uUCuxvYT1DUTMaDWGZzPyyY5pBzmvWGxQQ4rCwL5f9fheKzGazF0y+V/+NQaENE1GQBL2EymP+kgt99NY=
X-Received: by 2002:a81:6283:0:b0:2ff:2443:6f3c with SMTP id
 w125-20020a816283000000b002ff24436f3cmr9731868ywb.135.1652884349891; Wed, 18
 May 2022 07:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com> <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
In-Reply-To: <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 May 2022 15:32:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
Message-ID: <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:I8P72aKSQ2Xh2Mr8yCIqWgdCOXwuNa3X4bHOcxJ0MPB97DSIZ+s
 kAql0G1eIJVNfZARljZW/QYrd4v7JJSm/ILUPMORBxNPb2+3og2CVeStgww1knQPSx2T/9n
 dQBFUxPl8sf6KyOZlRFvLxILPKNtIVwYIqG6MJms7Fh8tufVHGdHGX61VglJpXjho5CgYJJ
 iN2EjIKBigYpgFL26VtFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W2fHljF5B7E=:iFwkzB8Hure8dRhEGuKNjg
 Vta7KgCHNXLYD9nafg4UbQIk11Pnqpvjj3dOeklUuNsLLopxFHFjBfFe1WHtTevPSQ8amOkdv
 qPThL+0Fut7MZQXw/ZQ2XY+/OSdzZTkpfEOC8BmMEJSOmU1NCrRKpB68IVkaUHbK0/Av8M0jo
 pPFuYhr/WfZ5d3g//F4tX0zYIGoeJ4cNFJLvLPAwsA5AcwTKaKzDkAVaTOgOXrOVDnhjjpndQ
 pq7pWgKJFAw4ZwKSL/N7OqYA6X91Ybfy3SAGQxoVlijd+tRYVV/j0vfj2GeH7EqTIN6qPNGDE
 WEZoVatsjOqJzAq6DsAUrJ15hU2ALbvV0Pw4tYEl8iEWOwPB23KDSJ58lU0NQrSN1EuAuL0ks
 5Sy9he1SJN+9VI12u7yLy2ISmKcKhbyUcfpkkgI5GaSHUlWE6an4mJFty4zFr2dKVPHFy0cg9
 mKSkZKbl+slC0yWQYGDxtiBgEufrYbdJep51P1U4Iv0ovxW1JSPy0vfp5XXDf0za1p0fjcDZS
 +oeCR1GvVl+0jDAWAL9auE7NAHaGaTO1ggSjSQDKt6Sff60NTR5BqLTmVH0D7RJ/4ZWoZg4ye
 7cRKt1EGUkBdirN7jPM0ykH8C8dsedhyxT7Lix7kqcLcUKvlDQf4X4VFAuA8y1tAW3rSee/cL
 zT5sqMgpGqWFwM0LlTg9w4sMTQoJrIYDzsyV09mETP5HOwDDc79t7eKdB6rMnw8rnFPtALdQi
 sjz4ig90G9n/Ti2Bh44/NM19wU+/NYLiiaosrnNvupnn0pULo6ygBlkEePZwVSvvOU0CZkarT
 1IEcP9vD2Zq6QHD8Gv9CCySKET+XdSzeKEl+obc2R6K87WpbXRRHaFPAdmv5HJeHlZwDmBdQS
 pkWEWtzFopfo4gq1/GTsdmJzxJE1yLsgskWJbd9ww=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko <olekstysh@gmail.com> wrote:
>
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> index 10c22b5..29a0932 100644
> --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> @@ -13,6 +13,9 @@ description:
>    See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
>    more details.
>
> +allOf:
> +  - $ref: /schemas/arm/xen,dev-domid.yaml#
> +
>  properties:
>    compatible:
>      const: virtio,mmio
> @@ -33,6 +36,10 @@ properties:
>      description: Required for devices making accesses thru an IOMMU.
>      maxItems: 1
>
> +  xen,dev-domid:
> +    description: Required when Xen grant mappings need to be enabled for device.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>  required:
>    - compatible
>    - reg

Sorry for joining the discussion late. Have you considered using the
generic iommu
binding here instead of a custom property? This would mean having a device
node for the grant-table mechanism that can be referred to using the 'iommus'
phandle property, with the domid as an additional argument.

It does not quite fit the model that Linux currently uses for iommus,
as that has an allocator for dma_addr_t space, but it would think it's
conceptually close enough that it makes sense for the binding.

         Arnd
