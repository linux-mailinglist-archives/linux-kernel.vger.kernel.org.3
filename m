Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C676B5141C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350401AbiD2Ffk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344891AbiD2Ffh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:35:37 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB15716B;
        Thu, 28 Apr 2022 22:32:20 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id e189so7526350oia.8;
        Thu, 28 Apr 2022 22:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=PvxIgnMATvEiUD7bbjMRcplT031fHVsjkSbxVAvSMVk=;
        b=dWJ+ouSdU+F0X4upxECy134VprloAJSN8FSAYnIUWCALe0IA04mzEUZqYEb956/vgk
         Wcf94qli9P89Xnm7BlQS4BdONOSQ1cYZhDRHkf1gtsXfepEgFJj6179uKQE4ecGNxmgG
         Ov8hS/Zc7dkgArKqVFvLDhloZrOqDC43qSi10kDX9ylx628Pc5/cnuFRuFYOsX0zjJ3p
         Sj8ZR8uqozw79DOP/PCOW1WX+kvtSkhe7AS1U/VhOp2vqFR13XBkwX3Yx+u9vPNxIDuQ
         pLEz4HNb3bAu+ezFM752jQ7CLRwh/gHt8tOX0xEA5TFHJS3tP48WeHx0lrcsio3G6NjR
         oMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=PvxIgnMATvEiUD7bbjMRcplT031fHVsjkSbxVAvSMVk=;
        b=qW5kLm6aN4UXhkqNWtRL7PpwaK+e0ES+OC6xDHZvZ9UARK/ULOUb4sII+NiR57ZNJN
         QFDhtb+q1fcUnosI4NQecRqo/NCV4d2aekJ63DNT9SRo7m/aJ6IKOt0a5km3g/u7lXe1
         guqyjQsdB/knhPnw4zSgH8fedpZAdoOd9D7yG6yH6lXL1wX07skHZTVzrdIetU5BFvBd
         HrCAr7tbBdJnjR5EnXW6bpI4PCXNAeeO+ihUblZW3Z3XFsVdd8g3PeUfqr8HI4u0xwyo
         LcWCi/h3UMPMbYo12wxoC26o5VIrr9ajVUouNLnQpTGRkNA8f5HZVgHQyYqPa2DZ3zSd
         xSBg==
X-Gm-Message-State: AOAM532CUCOT8V73xqWUbBAh5XXGVn6unt0mBRZb8wn04mDrPhhLO86i
        Xc6dydsr29tv1w8H5lPJwqQ=
X-Google-Smtp-Source: ABdhPJxbEc5TDyGbNFDxPcJKPEdzKdXuAMx3JyU/PBv8PKTSXsEdbokdfLY7ocbDp5i78GbURMJK8A==
X-Received: by 2002:aca:b7c4:0:b0:325:983f:659e with SMTP id h187-20020acab7c4000000b00325983f659emr796835oif.222.1651210339675;
        Thu, 28 Apr 2022 22:32:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dy40-20020a056870c7a800b000e686d1386asm2622782oab.4.2022.04.28.22.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 22:32:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e4d1a6c8-1afd-671e-76bf-b5bde9dc282f@roeck-us.net>
Date:   Thu, 28 Apr 2022 22:32:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Ruslan Zalata <rz@fabmicro.ru>
Cc:     Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <f79a8edf-36d4-02af-da8f-32b4e491bd47@roeck-us.net>
 <e0b57c7587dded38a92411994f353b3d@fabmicro.ru>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
In-Reply-To: <e0b57c7587dded38a92411994f353b3d@fabmicro.ru>
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

On 4/28/22 17:28, Ruslan Zalata wrote:
> Thank you Guenter for your valuable time.
> 
> I have added update_interval option (it's in ms units, right?) and fixed all other issues you pointed to. Will test it on real hardware and send third version of the patch for review.
> 
> Regarding IRQ. Alternatively the driver would need to sit and poll conversion ready bit in a loop which might cause a much worse load on system, is not it ? Anyway, the real problem with this piece of hardware is that there's no "conversion ready bit" provided, the only way to know data ready status is to receive an interrupt.
> 

Not necessarily. The data does not have to be "current", after all,
if the hardware is able to continuously convert. If not, the question
is how long a conversion takes. If it doesn't take too long, it would
be better to initiate a conversion and then wait for the completion.

> I think it still needs a semaphore/seqlock to synchronize conversions and reads. I.e. two consequent reads should not return same old value. Although it's not an issue in my case, but could be a problem for others.
> 
Why ? That happens for almost all hwmon devices. They will all report
the most recent conversion value. Some of them can take seconds
to complete a new conversion, so the reported value is always "old"
for a given defition of old (ie any time smaller than a conversion
interval).

Sigh. Looks like I'll have to dig up the documentation and read about
the ADC myself.

Guenter
