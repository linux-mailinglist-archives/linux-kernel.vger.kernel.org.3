Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DB55858FA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 09:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiG3Hgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 03:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiG3Hgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 03:36:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33B12ACD;
        Sat, 30 Jul 2022 00:36:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rq15so5930027ejc.10;
        Sat, 30 Jul 2022 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:from:to:cc
         :references:in-reply-to:content-transfer-encoding;
        bh=drgKUHxXzDzdw/F11BxJRs7kGHLK8c7Lg4zAHhZAKeg=;
        b=AswpHQx750JQzlyBizvvwrKrATjsCZ80we4mdJbgQeK88teGPJOJUK2CZ3CzHlgMtc
         d5W/Csfz1+foKIZo4FrPHV7oMGJ0toXNE02VKVdc9cJER36u8trOZ7Q5idGcWk9Bv13D
         mn/0kh5N7IccmP/3A92C/BT2/+F7N1bLkym9ggg48wtNuiEbzjani11JpYiE/OwDh2yH
         Q13WahkT7e0GJeiiO2SEFIewqX0k/5KU0NbfbzlbjCy61RHEFkKY1JV5zL8OPpAVM6C5
         KBY0gCrM9m2QTEHvJdbgc0mW/qr1ILZaBvwQfDdXYQwjRUwtLXJs/GLMEBKTZdzybDVE
         SwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=drgKUHxXzDzdw/F11BxJRs7kGHLK8c7Lg4zAHhZAKeg=;
        b=BraWsIRz23fPLGRHQB6XyQLltytxJXTx6s2+BTTJPvfTS8g6L96IKKfi7bSrPWuo81
         au9qkM0W5gA3yHtxfkV70JTDNt9XHXbYRiv8Rv21hRZqpgEZEoOUukU/cR6w6UIwO+Hr
         bq45WE8AdQ0x6nGcWjbBjPkyrjDOm0HKPI+H40uZD9DZkTp33Xk3eD5jO5ouNWPtkXIG
         4Fj8vzefzvXrmrMM07dg0gDDuzCnKKmDOQf+VZIwyG+cHfim+deREa25n88aQvUohBeS
         wrwT/FB0hUyU6/qJMc9OG6iZ5c4CNG3YNoj1HxhFAlg6PT9BeZ3TDjDtuQVGisnsJrI6
         ACsA==
X-Gm-Message-State: AJIora9jw1MsPIHqQ8kLeZ50dQtKfWQN679KkkSV4ySkFcR+LWZbPcGS
        YZk+s9DisOaGIK9bjcFrDifviJuGcRAH2A==
X-Google-Smtp-Source: AGRyM1vkAKYIp3O+PCxBJpd9QsCeRZlaP7BoN3phYnT4vCUYwb7OmjZukZa1NkMJUwlZKAwEVoQfbg==
X-Received: by 2002:a17:907:16a2:b0:72b:87c9:af07 with SMTP id hc34-20020a17090716a200b0072b87c9af07mr5548602ejc.121.1659166593207;
        Sat, 30 Jul 2022 00:36:33 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id a12-20020a170906368c00b0072af890f52dsm2605144ejc.88.2022.07.30.00.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 00:36:32 -0700 (PDT)
Message-ID: <22bc845c-dffc-7967-a542-f0697feec603@gmail.com>
Date:   Sat, 30 Jul 2022 09:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: fw_devlink=on breaks probing devices when of_platform_populate()
 is used
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>
References: <696cb2da-20b9-b3dd-46d9-de4bf91a1506@gmail.com>
In-Reply-To: <696cb2da-20b9-b3dd-46d9-de4bf91a1506@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 16.07.2022 22:50, Rafał Miłecki wrote:
> I added of_platform_populate() calls in mtd subsystem in the commit
> bcdf0315a61a2 ("mtd: call of_platform_populate() for MTD partitions"):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bcdf0315a61a29eb753a607d3a85a4032de72d94
> 
> I recently backported that commit in OpenWrt to kernels 5.10 and 5.15.
> We started receiving reports that probing Ethernet devices stopped
> working in kernel 5.15. I bisected it down to the kernel 5.13 change:
> 
> commit ea718c699055c8566eb64432388a04974c43b2ea (refs/bisect/bad)
> Author: Saravana Kannan <saravanak@google.com>
> Date:   Tue Mar 2 13:11:32 2021 -0800
> 
>      Revert "Revert "driver core: Set fw_devlink=on by default""
> 
>      This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.
> 
>      Since all reported issues due to fw_devlink=on should be addressed by
>      this series, revert the revert. fw_devlink=on Take II.
> 
>      Signed-off-by: Saravana Kannan <saravanak@google.com>
>      Link: https://lore.kernel.org/r/20210302211133.2244281-4-saravanak@google.com
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> For me with above commit kernel just never calls bcm4908_enet_probe().
> Reverting it from the top of 5.13.19 and 5.15.50 fixes it. I believe the
> same issue happens with other drivers.
> 
> Critical detail is that in DT Ethernet block node references NVMEM cell
> of MTD partition (see below).
> 
> Could you help me dealing with this issue, please? Can you see something
> obvious breaking fw_devlink=on + of_platform_populate() case? Can I
> provide some extra information to help fixing it?

Any ideas about this problem / solution?


> Relevant DT part:
> 
> partitions {
>      compatible = "fixed-partitions";
>      #address-cells = <1>;
>      #size-cells = <1>;
> 
>      partition@0 {
>          compatible = "nvmem-cells";
>          reg = <0x0 0x100000>;
>          label = "bootloader";
> 
>          #address-cells = <1>;
>          #size-cells = <1>;
>          ranges = <0 0x0 0x100000>;
> 
>          base_mac_addr: mac@106a0 {
>              reg = <0x106a0 0x6>;
>          };
>      };
> 
>      partition@100000 {
>          reg = <0x100000 0x5700000>;
>          label = "firmware";
>      };
> };
> 
> ethernet@2000 {
>      compatible = "brcm,bcm4908-enet";
>      reg = <0x2000 0x1000>;
> 
>      interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>      interrupt-names = "rx", "tx";
> 
>      nvmem-cells = <&base_mac_addr>;
>      nvmem-cell-names = "mac-address";
> };
> 
> OpenWrt bug report:
> https://github.com/openwrt/openwrt/issues/10232

