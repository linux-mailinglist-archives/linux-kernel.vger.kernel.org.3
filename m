Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B87657B97C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbiGTPW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiGTPWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:22:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11405E82C;
        Wed, 20 Jul 2022 08:22:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z3so2887679plb.1;
        Wed, 20 Jul 2022 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AxcbwNROrPSny6jDSgptTuz7bYbyAsub2rLB4LJL6c0=;
        b=ErPjdKCP1uIFCgtZu4/aZ6DEM+gUhhT8Ns2PXsNjwcZgql/PUI5443lcUtXj2CgGoI
         pM+9LfLNrwyVj0Koujo+hTZ2jSW03gnQKvM9YIR1qjmc9YGNod5kJg0AH9c38k15CPXN
         fwQShGPhp/D8HY/+NtBgQLajV7kBtdi9H3Urwt/Kv7pL1tQavGRt4kpLaHwuOohP8Utb
         9USZ+CcB58/WxCb68Z922a/rba14XA8nikMckZR3q7qKQ/6l2YuL0lyAQoh4OdKYY8X7
         D+fxty5r4REIhJoONp/yLHNUbhVB8q9k+OaIlWNOE39erdYuK8ipuX6+T1Zb410KLRhW
         yWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AxcbwNROrPSny6jDSgptTuz7bYbyAsub2rLB4LJL6c0=;
        b=ld9Fbnkyo46vHc8WPDgZwi7KI2Tq4uqnbpt4Ce3rEvA95E566LtXH4xBGau/rZxyqN
         WsjU9wM7k/z2PtUMgfzTwcbCMwgApDC23y9GgdF/QfOcWHiBjnM9sVseZhHP05BF4Qjw
         gO6d8aEoiLC5WdgaW/OwcrqnuEU3nxKnFwmEMVFvkYDCZC6RxCjTV2prygKuwZjlLMzj
         1VVyAtzC71hk9XhJhzdCH4D5j53bcmpGgbyX60w/Wrb13Jm0zQBXwWQhdJM3WvYKosdU
         wC3zP1DPwbfR5HS77E6NCYoZpgYPxBT+LwH0v8Mbv8BI6tSWm5XkdpXiAttQ4tZX5ZO5
         7Zyg==
X-Gm-Message-State: AJIora+cc7lAAEIDMog66QogiMmgkwSzcoki/1zuxMDxcMNuUNTZW7iX
        80ow3Vu+ZvMpeoxTx54aNNA=
X-Google-Smtp-Source: AGRyM1t6ZlGmi3rykIgPP2swTymCCx9NyKOzwv3J9vYNXxRlWGFHL9/rh+k4wm4AtoRS1pT9eJe5sg==
X-Received: by 2002:a17:90b:4ad0:b0:1f0:28c6:9493 with SMTP id mh16-20020a17090b4ad000b001f028c69493mr5922834pjb.142.1658330557180;
        Wed, 20 Jul 2022 08:22:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709028c8c00b001678dcb4c5asm4003524plo.100.2022.07.20.08.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 08:22:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <56edd097-df41-b84b-3688-f1bcabda5046@roeck-us.net>
Date:   Wed, 20 Jul 2022 08:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 RESEND 0/6] Add support for upcoming chips to k10temp
 and amd_nb
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, dave.hansen@linux.intel.com,
        linux-hwmon@vger.kernel.org, babu.moger@amd.com,
        yazen.ghannam@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20220719195256.1516-1-mario.limonciello@amd.com>
 <YtgVDEQnZpjnIG0k@zn.tnic>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YtgVDEQnZpjnIG0k@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 07:45, Borislav Petkov wrote:
> On Tue, Jul 19, 2022 at 02:52:50PM -0500, Mario Limonciello wrote:
>> This series started as what looked like a correction to previous
>> commits, but I missed that the previous commits were for a different
>> family with the same chip models.  So while fixing up the series I also
>> noticed that a few upcoming chips have new PCIe IDs and CCD offsets not
>> yet supported, so add them to amd_nb/k10temp.
>>
>> v2->v3
>>   * Pick up tags
>>   * Group "ROOT" PCI IDs with others in patches 2 and 3.
>> v1->v2:
>>   * Correct commit messages
>>   * Add more missing chips and offsets
>>   * since so much changed, do not include Bjorn's Ack.
>>
>> V3 original submission:
>> * https://lore.kernel.org/lkml/20220613192956.4911-1-mario.limonciello@amd.com/#t
>>
>> Mario Limonciello (6):
>>    x86/amd_nb: Add AMD Family 17h A0-AF IDs
>>    x86/amd_nb: Add Family 19h model 70h-7Fh IDs
>>    x86/amd_nb: Add Family 19h model 60h-6Fh IDs
>>    hwmon: (k10temp): Add support for family 17h models A0h-AFh
>>    hwmon: (k10temp): Add support for family 19h models 70h-7Fh
>>    hwmon: (k10temp): Add support for family 19h models 60h-6Fh
> 
> Is there any particular reason why those are split into such small
> pieces?
> 
> I'd expect one patch adding all PCI IDs and a second patch doing the
> k10temp changes.
> 
> If no particular reason, I'll compact them all 6 into 2.
> 
Ok with me.

Guenter

