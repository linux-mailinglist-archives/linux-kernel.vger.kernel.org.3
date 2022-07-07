Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B350569EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiGGJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiGGJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:40:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AD31277C;
        Thu,  7 Jul 2022 02:40:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n10so183222wrc.4;
        Thu, 07 Jul 2022 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=KzcoFhGBop3Dr3qrgA6FnfDOc9NV/gjra01y9OpQ03E=;
        b=d4C8549OVT/OTfYI2dsl8Y3TYD1BSb9zXe1l4DYZ3uv6ATbmseapVMOFsMRQZVrpQI
         DRYfZ4FQx0DrPKMqL+e29YpcSB1APqwPtOZ4QvVvAGP85zNjBVbxry4jWgE7cbIvE/Ob
         hLlI9AypWPX8S5/ClEvxWwZZgQIethgKSRjwFoCYgpL39mwjbas4a3GGPstHsBYggdCy
         25hCt+2fGMEg0pel3fMAgp1qlveIatuxMRbQ0Na0T5jS68EmMb8jFaHoYoyjK3+komvK
         IC0yx5aZ1+B/DwBMKfJCFe7A6P7eIVA7NWP494X3rx5ZJYJGSLCllcVYHoBN6vaFQEsb
         lVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=KzcoFhGBop3Dr3qrgA6FnfDOc9NV/gjra01y9OpQ03E=;
        b=UBecljXSqu3PlcyTjw1O5UtPpNUtYNyxe+whkTLK9ztqggihxqDQ5VO9cO/5/YwuA/
         Q1uuv2vrw7G+mi3g3xCNlJUQnu3txkckncwObfjHRZCTt9/gKWb4znenlYzznuCdQ99g
         9W2CYO6ws07RJC5ql6rHn0v1ONSkO0UWhCZk6p9fy8pwFusTftNvCkfS4r5RuFyFvPv9
         PgzjJ5VXs9Faw5ezhxpyqW0Unrq8sMSlVvDwa8FkrsmU9cqt5RfeqOMOQxapby5eEQbq
         c+C9qGKHRD1UJI3u+47P6gHTYuz6ECOwgTsEzoZJELfc+e0RfP9CxKZmvQd87MQVI/LL
         wjMA==
X-Gm-Message-State: AJIora/6B1LjnWC7BmtUZXZG+fbd+vJZu5GDvfjymqk2BsNUZJLkZ0e/
        Zl2wqjIrGwHxmOO2npnWCZSZPjoIhygGEQ==
X-Google-Smtp-Source: AGRyM1talsypiyhvDrz+cqTOcMGBF2fEVNMqtrU/unM4e6cE62b3PJIhpaTGU+Cj8oBlP8vh9KBoLA==
X-Received: by 2002:adf:e112:0:b0:21d:7195:3a8d with SMTP id t18-20020adfe112000000b0021d71953a8dmr13968308wrz.371.1657186836348;
        Thu, 07 Jul 2022 02:40:36 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d4304000000b0021b829d111csm38650085wrq.112.2022.07.07.02.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 02:40:35 -0700 (PDT)
Message-ID: <0f758c3d-a1cd-5e28-d3bb-70833b53c14b@gmail.com>
Date:   Thu, 7 Jul 2022 11:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v11 0/3] Add basic node support for MediaTek MT8186 SoC
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, hsinyi@chromium.org
References: <20220520122217.30716-1-allen-kh.cheng@mediatek.com>
 <37fb545a-bc45-65b0-b67b-5ef1b0346777@gmail.com>
In-Reply-To: <37fb545a-bc45-65b0-b67b-5ef1b0346777@gmail.com>
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



On 22/06/2022 17:40, Matthias Brugger wrote:
> 
> 
> On 20/05/2022 14:22, Allen-KH Cheng wrote:
>> MT8186 is a SoC based on 64bit ARMv8 architecture.
>> It contains 6 CA55 and 2 CA76 cores.
>> MT8186 share many HW IP with MT65xx series.
>>
>> This patchset was tested on MT8186 evaluation board to shell.
>>
> 
> Applied, thanks!
> 

Based on the review from Angelo I dropped patch 3 from the tree. Please address 
the issues and submit again.

Regards,
Matthias

>> Based on next-20220519, linux-next/master
>>
>> changes since v9:
>>   - remove some merged PATCHs from series
>>   - reorder nodes in dts (cpu-map)
>>   - remove okay status in auxadc
>>   - remove unnecessary suffix node name for i2c
>>   - add pwm node
>>   - add dsi-phy node
>>   - add dpi node
>>
>> changes since v9:
>>   - add one space before equal sign of drive-strength-adv
>>   - corect compatible name for big cores (ca76)
>>   - use upper case of address in pinctrl
>>   - add pwrap node
>>   - add pwm node
>>
>> changes since v8:
>>   - change name from pins_bus to pins-sda-scl
>>   - correct email address
>>   - add capacity-dmips-mhz for each CPU
>>   - add ppi-partitions in gic node
>>   - change name to power-domain
>>   - remove status "okay" in scp node
>>   - update timer and pericfg compatible in series
>>
>> changes since v7:
>>   - add scp&auxadc node
>>
>> changes since v6:
>>   - remove unnecessary blank line
>>
>> changes since v5:
>>   - replace Mediatek a to MediaTek
>>   - use GPL-2.0-only OR BSD-2-Clause
>>
>> changes since v4:
>>   - correct driver clock of mt8186
>>   - add power domains controller and clock controllers
>>   - add pinctrl, usb host, spi and i2c nodes
>>   - add node status in mt8186-evb.dts
>>   - correct some dtbs_check warnings
>>
>> changes since v3:
>>   - remove serial, mmc and phy patch from series. (already merged)
>>   - remove mcusysoff node
>>   - move oscillator nodes at the head of dts
>>   - change name from usb-phy to t-phy
>>
>> changes since v2:
>>   - add soc {} in mt8186.dtsi
>>
>> changes since v1:
>>   - add dt-bindings: arm: Add compatible for MediaTek MT8186
>>
>> Allen-KH Cheng (3):
>>    dt-bindings: arm: mediatek: Add mt8186 pericfg compatible
>>    dt-bindings: arm: Add compatible for MediaTek MT8186
>>    arm64: dts: Add MediaTek SoC MT8186 dts and evaluation board and
>>      Makefile
>>
>>   .../devicetree/bindings/arm/mediatek.yaml     |    4 +
>>   .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
>>   arch/arm64/boot/dts/mediatek/Makefile         |    1 +
>>   arch/arm64/boot/dts/mediatek/mt8186-evb.dts   |  232 ++++
>>   arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 1016 +++++++++++++++++
>>   5 files changed, 1254 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
>>
