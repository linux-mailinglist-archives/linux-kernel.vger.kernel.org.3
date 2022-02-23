Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1094C1767
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiBWPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242342AbiBWPoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:44:34 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0CEC1148;
        Wed, 23 Feb 2022 07:44:06 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id bg10so53324117ejb.4;
        Wed, 23 Feb 2022 07:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D9YoXmL0fH0aKcdRK7BK9p6bYV4a8ZT32GFRySXCBdU=;
        b=RIV+5pwRmII3crrgV/JucWi0BPJWGTQ+CRLXqi5IRsjf4U7TcYZDgjd3mX9V14Bx4s
         OqBGQHnyQx7FiEkzh+o6CK9OPWccSXqgl99gTpR/Kp0n51Ov600SSirjnK+0JXcuvyCl
         WS72KrwxZHHzKCMRI1i3/Bq7AbveLGC12hvota+S5WdY0jXENgdpG1IaGLfOhzlXLElQ
         xAAdxSfA5IRafzyUIjC4nkt9bYwJViKQupZNON+i2EXcxN4xqHKt3013YpnESRKyCBVz
         ISyJQK/R+JQ4VCaJEikyuKvep+Kn+JkiEnnCJ4eE9s96bymcmZg4M40hgwGWDPSJC8O3
         fcIQ==
X-Gm-Message-State: AOAM532OjLIwv1+F9PA9yqSyKuXE+5uuC/nchMMbPW31mH+mm7JBVvW4
        9ymjsAHQKq9Yott0yZtyDQM=
X-Google-Smtp-Source: ABdhPJxXI094jfo93LhxnFNB5bGS9gHU1H1rFlcOLOWlSh9AKcr6Cm2g1nUnSRsQyalvpUvbbLbSDA==
X-Received: by 2002:a17:906:35d5:b0:6b7:faf7:9611 with SMTP id p21-20020a17090635d500b006b7faf79611mr238158ejb.537.1645631044590;
        Wed, 23 Feb 2022 07:44:04 -0800 (PST)
Received: from [192.168.0.125] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id f3sm8446edy.72.2022.02.23.07.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 07:44:03 -0800 (PST)
Message-ID: <2929cc96-b272-7144-f4a4-71d60852c5cd@kernel.org>
Date:   Wed, 23 Feb 2022 16:44:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 2/4] Documentation/dt: Add descriptions for loongson
 display controller
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>, Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20220220145554.117854-1-15330273260@189.cn>
 <20220220145554.117854-3-15330273260@189.cn>
 <YhVrigEnXTiNgk67@robh.at.kernel.org>
 <720f940e.5ac.17f26de3a5b.Coremail.suijingfeng@loongson.cn>
 <72e3790f-088d-1a70-a5f7-3a18c14a6eae@189.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <72e3790f-088d-1a70-a5f7-3a18c14a6eae@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 16:35, Sui Jingfeng wrote:
> 
> On 2022/2/23 21:56, 隋景峰 wrote:
>> Something like this:
>>   
>> dt-bindings: display: Add Loongson display controller
> 
> Hi,

Thanks for resending in a proper format. I already replied to your
original post, so let me paste it here as well.

> 
> We are not a platform device driver, there is no
> of_device_id defined in my driver. In other word,
> my driver will not bind against devices whose compatible
> is "loongson,ls7a1000-dc". We just parse the device tree
> actively, find necessary information of interest.
> 
> What's the meaning of dt-bindings by definition ?
> In this case, can I use the word "dt-bindings" in the commit title?

This is a patch for specific subsystem, so as Rob said, it should follow
subsystem conventions.

The patch itself is a dt-bindings patch, so there is nothing here
special which would encourage for any exception.

> 
> I want to follow the conventions, but get some push back,
> Krzysztof say that he can not see any bindings, these are not bindings.

I said in comment to your patch with DTS, which you called bindings,
that there are no bindings at all in it. Because in your patch with DTS
you did not include bindings, but you called it bindings.

Here, this is a patch with bindings, so your comment "these are not
bindings" is not true.

Best regards,
Krzysztof
