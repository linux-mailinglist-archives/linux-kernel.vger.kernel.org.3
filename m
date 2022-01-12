Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2E48CD77
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiALVKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiALVKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:10:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F5FC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 13:10:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s30so12573704lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 13:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KrbHF0DzPNfCOOgkFkmmAa72D7KbaWV3xb9yz2Rt3bM=;
        b=XbEGC7g/EgPNokcJrlfE/n7WGNBoNGbLkn9yVUz8n49hP1iGzSzDburUVxqWzgYetL
         COz/ZlUCJWiK5yJri/2IhCg1ndJTnFnyehv+Mprt6eL2Oeew+92qGEV/KveFfXjdnEw1
         bcyL5Fm1AJCwwnMAAP5QWSjPCQpwIXptig3ePQNwTJMngcZRQHELYp3aSpr1/VYg6z4B
         kUWObpwdXyOnu7sllSMysu6bUNXWAqVO2fvC6/tpCr6wfhxSqJeyy1MWLArmEfgQCDUI
         rmEG9pP+T8rubzuOO2doVOrMDzWvh1XiwsS0dtiVYgSk6QImLd08N+3F1BnPP2PpGRr+
         iczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KrbHF0DzPNfCOOgkFkmmAa72D7KbaWV3xb9yz2Rt3bM=;
        b=QcWAScR3whxw2nHEqmKzR58XBrD9dPfvttLi4s2t7ZACAsi6MOp3vrMNat1e3ZaLxq
         YHoiIxTvdr6Wa2hVP+TildHbS/KNoK2GmQf4rGKP9IoSkTPLHMGYTEdZ7rtr99YUEqby
         MydjS59ZBkxb4rCrj5DwabsFi81NkU2TSO+HVzfIv2cbu3lWm8Mqejrq8gDpe7KFYVCN
         0o16xKSXKfLtzQUajyIiOlJP/3Eb8OFo5k3dxGYmM/kUEbU4I2Nkn9pcKDe6ZCjh5xIF
         u5HSpGZXBs4jVsz+2EuVBCokn6igPotLq87ndGCdnIjoC4OaKhCcm8Pg/47LTj+Vn/KG
         +ILA==
X-Gm-Message-State: AOAM53289W+XUXWmrQssCh83jEeXozBhar2o1ijKrubqF/xGsxGv6Qa3
        c4FbRSNbm8gfv9VFL/C1m0Qn1w==
X-Google-Smtp-Source: ABdhPJw9RfokvC4wwM+qsCTx/+HZcVAAN/tnfXnOw39oZ0M2m9VGVeMk6Qq7nqQbK08fk1bliRmcUA==
X-Received: by 2002:a05:6512:3a85:: with SMTP id q5mr1140468lfu.35.1642021836492;
        Wed, 12 Jan 2022 13:10:36 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id q5sm91870lfb.135.2022.01.12.13.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 13:10:36 -0800 (PST)
Message-ID: <17b8de50-426a-2543-a79a-aab44c9d52cf@cogentembedded.com>
Date:   Thu, 13 Jan 2022 00:10:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
 <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
 <87626d61-ada0-c220-bea5-5330f5256629@cogentembedded.com>
 <YcyXQxW3kRqQ2Yv0@pendragon.ideasonboard.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <YcyXQxW3kRqQ2Yv0@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> +				port@1 {
>>>> +					reg = <1>;
>>>> +					lvds0_out: endpoint {
>>>>    					};
>>>
>>> Endpoints must have a remote-endpoint property. Let's drop the endpoint
>>> here and keep the port only, the endpoint can be declared in board
>>> files.
>>>
>>> If you're fine with this change I can make it when applying the patch.
>>
>> This empty endpoint is currently defined in dtsi files for other r-car
>> gen3 SoCs.
>>
>> Goal here is to define lvds0_out label that is then used in extension
>> board dtsi files to link to the port.
>>
>> In this patch I just used the same approach as in files laying nearby.
>>
>> If this approach is not appropriate, then perhaps need to fix it in
>> files for all SoCs, to make it possible for extension board dtsi to be
>> compatible with all of them.
> 
> I'm writing a patch to drop those right now :-) I'll CC you.

This is not the only place where rcag-gen3 dtsi files are using empty-endpoint pattern.

du rgb port is defined in the same way.

And, I've submitted a patch some weeks ago [1] that hooked into that.

[1] https://lore.kernel.org/lkml/20211225115308.2152364-1-nikita.yoush@cogentembedded.com/

Since there was no reply, I am about to resubmit it.
But, perhaps need to do something with empty-endpoint pattern first?

Nikita
