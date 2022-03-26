Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288334E8028
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 10:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiCZJGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiCZJGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 05:06:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DAFE01D;
        Sat, 26 Mar 2022 02:04:46 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.126]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mhl8Y-1o2gGc2cbI-00dlml; Sat, 26 Mar 2022 10:04:14 +0100
Message-ID: <d20fd8f2-c47a-2f3e-4efa-be705f1517b9@i2se.com>
Date:   Sat, 26 Mar 2022 10:04:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] Add support for bcm2711 in vchiq_arm
Content-Language: en-US
To:     Adrien Thierry <athierry@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        linux-staging@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20220324172647.167617-1-athierry@redhat.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220324172647.167617-1-athierry@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MF0J0jzDKrDVpVSeRs+yL5+DPjsuUuOKN6ic8X9ZRn9nO5noxHE
 pkVO2sNitXCFmRHUYlBBUZ1tQN3NKo0K433u9l4QCIRYICQwOtKUy4GWlj/riTRa0PTSVdE
 tbIw+2vzeG0sgDVscEhHT0arSZ+SaGUcpV8UnfRX2uCI2h5Pff0VKrPgwFoimW8T16j6S+k
 QX4wZ8bO1NS22VMOx5AbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d6HKoQudEVo=:GbponABS8VCxPl4Deiz4Az
 eszX52sV7NCtNdzh/sBB82qpMGmqS2nUFBE8RV8c4MJ/RWCWqyjbVTOLqD6ZHdQLP1UZvxdR/
 /vCN5ZIwM/jBEdZs2qof9iwitLQTzmYg9z4tuFMwWe2KQnG6CAJeFXGM02k7pZoXYhgJThrS1
 3zhiXBrT6eHXFKw7NgtFIxCVQdbGy2kdtOqlVMbcCvbBs6SJxx+tRAqFDxCBY5EOVjtZTAh06
 GGf1VidSwJhsRw6tebMG7AQeVLUUiB0o42A8NMgHHngGPAUvl8MVDB4bNvB5G+WLhSm5nSBni
 LBlwC4ZyjtLu2MiPV8li5VyCtZy4oGY/bNKjJ0D0kBXFBqRIjGJpArOk0bgjJWVct2RAmHbvX
 PQMgBLaiAq8Vi6SJrDQ2XjQOuHkWHGvV2nT+zhp1CuZALrVAcE89G70g9DJHlMUm7kVNY9sIs
 8eaNv+rOdaC/xQTpCkD/mK3b4cc+0ByzZI2I8BDRIe5RZyb4cU2hCaKpyYGWCA4EkwBxXF1ed
 TyxhqU8ZWgrxu0t23yDqBfpPqIySAt3dkx6mRb2IqZeaoIVcHQKw9mOcergZCc4w4iI2SHvKY
 doaFO+EorTyx2r4gA7+sVrrLpFDJ8TcX5Oj0dPMtUBEkL+LsAxaWsZ0xveJSQ0RTIxJm1Auf1
 BQPoByxX0t3jORx7+j/K2aTwU719WptaLFfYBkPyz7QbfDXllgc8ubzrAQqrMhTO5aff9lLVj
 HTts3do4QFfzJvvH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

Am 24.03.22 um 18:26 schrieb Adrien Thierry:
> The goal of this patch series is to use the bcm2711 compatible string in
> vchiq_arm for the Raspberry Pi 4.

there was already a patch series to enable VCHIQ on BCM2711, which 
wasn't accepted:

https://lore.kernel.org/linux-arm-kernel/20211014223230.451659-1-mguma@redhat.com/T/

Could you please explain your approach, especially leaving out 36 bit 
DMA support?

>   This allows using the downstream device
> tree with the upstream kernel.

This is a really bad idea and caused a lot of trouble in the past. A lot 
of the issues in the Fedora or Arch Linux forums or mailing lists 
results from this idea. It wastes the time of the kernel developer since 
these DT files has never been reviewed by the devicetree maintainers.

Best regards

>
> ---
> Changes since v1:
> - Removed duplicate compatible string for bcm2711 in
>    brcm,bcm2835-vchiq.yaml
>
> Adrien Thierry (2):
>    dt-bindings: soc: bcm: bcm2835-vchiq: Add support for bcm2711
>    staging: vchiq_arm: Use bcm2711 compatible string for bcm2711-based
>      RPi
>
>   .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml      | 5 +++++
>   arch/arm/boot/dts/bcm2711-rpi.dtsi                           | 1 +
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 5 +++++
>   3 files changed, 11 insertions(+)
>
>
> base-commit: ed4643521e6af8ab8ed1e467630a85884d2696cf
