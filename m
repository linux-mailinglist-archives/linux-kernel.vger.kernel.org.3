Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E772A4E4E24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiCWI2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiCWI1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:27:46 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE7F71EED;
        Wed, 23 Mar 2022 01:26:16 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id r22so1248019ejs.11;
        Wed, 23 Mar 2022 01:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ehS00HbDulz5or5Tk0fJMs+TQwrD5m0G1J5PJzgKMNE=;
        b=O7wU1RrkCqW8L4KqqarAIA+C9HKkVIEI3T66Bz2Dy9jo8L56XhsC0sxcSEQhd9eQpQ
         9u/UGSk5Jye3n7C+wrHpfsSYowpoZg4+qfo7XEZ31BnNpEwEoyF35uypLYxQqjj2gE4Y
         M5AJJtvKFdntqylXsCK8okTFzzRC2D5P3rulBFXEo5L/YahMSRXi84hwSiKoDTEPYT9O
         xaXFsPy1GjGxWMXauhW2PHPuDdf4bRxOl5W9Vn4saFS7/z/gAc71hwJQ9hyzpjYpMcGe
         cw8YYRWy+nZ97aDXPVxmwiedZJn2kqP52F9+NCNcmXBO0e9Ody0unQ/9tVX82MSYMexW
         sJPg==
X-Gm-Message-State: AOAM532ACQoFAfC5h06kYR6lWUg2NlO79InC+kg/3VplkcsRMEgv/8zo
        4/K2Lpj5+zu/X/bCJsTG8HY=
X-Google-Smtp-Source: ABdhPJxLajtMp/+EHc1cvlU/roEVfTYySa7UaAQ6Sq6d6IIvhvPnifr8g12eKahCKIKgAMkeHPZf1g==
X-Received: by 2002:a17:906:4fc9:b0:6e0:648e:5156 with SMTP id i9-20020a1709064fc900b006e0648e5156mr1416890ejw.412.1648023974871;
        Wed, 23 Mar 2022 01:26:14 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id b8-20020a170906728800b006e0351df2dcsm2441298ejl.70.2022.03.23.01.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 01:26:14 -0700 (PDT)
Message-ID: <0366bcc4-b38d-db36-22d6-e6f33af9dbef@kernel.org>
Date:   Wed, 23 Mar 2022 09:26:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 4/4] usb: host: add xhci-exynos driver
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220321090205epcas2p15ac16f281554b663062e0e31666defab@epcas2p1.samsung.com>
 <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
 <ad877924-68bb-f029-258a-0cf9094265eb@kernel.org>
 <20220323023420.GC19041@ubuntu>
In-Reply-To: <20220323023420.GC19041@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 03:34, Jung Daehwan wrote:
> On Tue, Mar 22, 2022 at 06:10:00PM +0100, Krzysztof Kozlowski wrote:
>> On 21/03/2022 09:59, Daehwan Jung wrote:
>>> This driver supports USB Audio offload with Co-processor.
>>
>> One do you need one more XHCI driver? How does it differ from existing
>> and why existing cannot be extended?
> 
> I have some exynos specific features and that's because need own driver.
> It's not good to modify other XHCI driver for my features.
> 
> Additinally, I've been developing some features with other IP or Co-Processors.
> Extending is not enough to cover them and I think owning driver is also better
> on structural view.

This reason is not good enough because it's not visible that you cannot
extend existing drivers.


Best regards,
Krzysztof
