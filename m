Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1068C4B9B40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiBQIjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:39:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBQIjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:39:06 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D9C1FFF5B;
        Thu, 17 Feb 2022 00:38:52 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id w3so8291449edu.8;
        Thu, 17 Feb 2022 00:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w/AFtpF4QCrXUI7mVF4B682OTVEfmrPVxtaxPs2OWFY=;
        b=uof2IdvCe2FSmI9B2DTeGxfVzkfr8WeSnnU/GrQJCPOosP6om9VHDAq1gQC7upZBaN
         EbrU5uueI5PXvUPUG0BQOE+/SyPkfBsWu0olECRHEa7DwAFGTT/UP4dLuuPW4n/A9Fm6
         ZUGj5TT400N1oCCq2yO8R6LfNx+bV100T6mpYXrtUrUTh5kwHRV10opS+we1VPfKgY2Y
         SBJLWOuVxg8PBClklU4d+O5qcXjtPKxNcGLcoC/MixO/tfbk+KuxKHzZ1AmDq/AqmCBm
         rORBS44fVcip7bXZn4OWxchE5PuRVhj89qQAX8BQpX9VKxvpMnVBg7H+ssCgl4yeU8bv
         OGiA==
X-Gm-Message-State: AOAM530XHD03lxQd+aLP6x5+2vN95j6A1KCw4ASuNpYNcvkVQoczscOd
        YXymhzS9aC40SAOQ0mkpiTM=
X-Google-Smtp-Source: ABdhPJxn7pKwRyqx0Y0ea3DQzyUs/IBfs0QVvVW9owY+t89r21wY7ZRWhHHvWSfT2SYHVdGXghxYFA==
X-Received: by 2002:a05:6402:280d:b0:410:be87:c59d with SMTP id h13-20020a056402280d00b00410be87c59dmr1522546ede.95.1645087131134;
        Thu, 17 Feb 2022 00:38:51 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id r22sm925295ejo.48.2022.02.17.00.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 00:38:50 -0800 (PST)
Message-ID: <3cb77487-0c38-9607-46d9-5204b35b4fab@kernel.org>
Date:   Thu, 17 Feb 2022 09:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 2/3] dt-bindings: ls2k1000: add the display controller
 device node
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-3-15330273260@189.cn>
 <CAJKOXPfN+Ax8i_Mcax9LfbSG8VwM86YgUxuRUfSF_YEx4z0EaQ@mail.gmail.com>
 <3e34a508-3969-80d9-4ef7-7cb358c0147d@189.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <3e34a508-3969-80d9-4ef7-7cb358c0147d@189.cn>
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

On 16/02/2022 15:01, Sui Jingfeng wrote:
> 
> On 2022/2/3 16:50, Krzysztof Kozlowski wrote:
>> On Thu, 3 Feb 2022 at 09:26, Sui Jingfeng <15330273260@189.cn> wrote:
>>> From: suijingfeng <suijingfeng@loongson.cn>
>>>
>>> The display controller is a pci device, its vendor id is 0x0014
>>> its device id is 0x7a06.
>> The same as your patch 3 - these are not bindings.
>>
>> Best regards,
>> Krzysztof
> 
> Yes, you are right. As there is no compatible string in my driver to match against the compatible
> in the dc@6,1 device node.
> 
> I don't know how to write YAML document now, it seems no similar case can be reference?

I referred to the subject - this patch is not a "dt-bindings" patch.


Best regards,
Krzysztof
