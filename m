Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A358026F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiGYQHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiGYQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:07:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560FADFBD;
        Mon, 25 Jul 2022 09:07:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y15so10805922plp.10;
        Mon, 25 Jul 2022 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mjgpg4ZV+VLOftEfwsbp2uyCZES8VtwrkrpG5A+4mFg=;
        b=PXdnEvIptvDcZIyG61PW8j3e6CaFKPs19zNKWybPquAAocjh6WbFtCYQABJRRGRkGu
         iSUSKehBWJ/TCJFMwYEg5SncOsQAV2wAtaVwamxeFssuKAK/HimjxRXHwBHxEz3f+YF6
         JsaO/9sidEX+KvCCwDDykoSyC6kiQMUsuY0/xl0xcBBKQ2xRkRfahd2it2a6kYagMQJp
         7/j0YYDIrp2F19w4rGdFzNIiGadoxK1raR5PJBfH2xdmtCYmrwsdophoyYam6qzOHwmZ
         gV/ZDaIPH9Vnvxd4Gt2jmI8c0wmeMDnDEWwbv/sRTUndC/hkzN11ZPd2Qe8Zf19mqaGz
         ccLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mjgpg4ZV+VLOftEfwsbp2uyCZES8VtwrkrpG5A+4mFg=;
        b=MWCr2pC8Qa3gG8WRGAVyVqpfUvbcKA0TjMLi/VGYJsTTVBckTV/lOgS4u+1KPodp//
         gjvHhys3h+/CtFlQrB5TDtXzG4tQkAPXtax1KGbBhrPz+QpcFLCW1b58uKBpZ+s+dHms
         buRqDqaLB0efQdB9Pp/g/CR+TZwsSUTM6FtoMXh7CZNpx/dI6u/oxldJZ5n6nRV0wJwB
         5H0Cnni2WkcEafLz+UkvN58XNji1g7MtbF9ahfAzwbJVm14Ad3Fcty34ZmMXYUlVPKJI
         WTpeQMJ1pXtBXCEcNQ+6qceFCR0QCT4FOhGNWj57j+zi+wxFDZYPPcYyq3oj0qUHdfyk
         Z1TA==
X-Gm-Message-State: AJIora9EMFkAgoC9cW+XqBMaShfCxs01ySsHf72ALUqtJZu/yL/T2LTg
        s5Na7evXQtTGjyivCEzr4r0=
X-Google-Smtp-Source: AGRyM1tycli7tWbSuKOfM9rGxt5Dyr1KuUTf/FDE2xa7x7hnJJiKYHpi7gi56Bzr++oS+nvtJdxlqA==
X-Received: by 2002:a17:903:41d0:b0:16d:23e9:41d0 with SMTP id u16-20020a17090341d000b0016d23e941d0mr12667651ple.47.1658765262423;
        Mon, 25 Jul 2022 09:07:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b124-20020a621b82000000b0052bf6789f02sm2914567pfb.178.2022.07.25.09.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:07:41 -0700 (PDT)
Message-ID: <3d29b8fc-f183-5883-edc0-cde55b76e4fd@gmail.com>
Date:   Mon, 25 Jul 2022 09:07:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] Documentation: sysfs: Document Broadcom STB memc
 sysfs knobs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220722201043.2731570-1-f.fainelli@gmail.com>
 <20220722201043.2731570-3-f.fainelli@gmail.com>
 <135be705-24f9-13b8-6939-0eaa569434d7@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <135be705-24f9-13b8-6939-0eaa569434d7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/22 10:59, Krzysztof Kozlowski wrote:
> On 22/07/2022 22:10, Florian Fainelli wrote:
>> Document the "srpd" and "frequency" sysfs attributes exposed by
>> the brcmstb_memc driver.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../ABI/testing/sysfs-platform-brcmstb-memc       | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-memc
>>
>> diff --git a/Documentation/ABI/testing/sysfs-platform-brcmstb-memc b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
>> new file mode 100644
>> index 000000000000..2bf0f58e412c
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
>> @@ -0,0 +1,15 @@
>> +What:		/sys/devices/platform/*/*/*/*/srpd
> 
> That's a lot of */. Are you sure it is correct path? Didn't you include
> here some driver-related path components? Can you paste in email full
> path as an example?

Yes this is the correct path:

/sys/devices/platform/rdb/rdb:memory_controllers/rdb:memory_controllers:memc@0/9902000.memc-ddr/

the 'rdb' node is our top level bus node, the 'rdb:memory_controllers' is an encapsulating node that groups all of the possible memory controllers in a system (there can be between 1 and 3), the rdb:memory_controllers@0 is the first of those memory controller and finally the 9902000.memc-ddr is the sub-node that contains the register controls of interest, since the memory controller aggregates different functions (arbitration, configuration, statistics, DDR PHY SHIM layer, etc.). Maybe I should provide a more complete binding while I am it.

> 
>> +Date:		July 2022
>> +KernelVersion:	5.21
>> +Contact:	Florian Fainelli <f.fainelli@gmail.com>
>> +Description:
>> +		Self Refresh Power Down (SRPD) inactivity timeout counted in
>> +		internal DDR controller clock cycles. Possible values range
>> +		from 0 (disable inactivity timeout) to 65535 (0xffff).
> 
> Using hex suggests one should write there hex? If so, skip decimal...
> You describe the user interface, not hardware registers.

Fair enough.
-- 
Florian
