Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B74C1734
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiBWPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiBWPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:41:27 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECFFBF956;
        Wed, 23 Feb 2022 07:40:50 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id qx21so53180779ejb.13;
        Wed, 23 Feb 2022 07:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WFKWHYEVTYdSkLxtSrxqY8mhLgNlskLotNcdJEfeS30=;
        b=vi/HxvtxQYmkTv/q91DPRntemiFSiU0nmGjbk+/L+aX5Kz+otbtEtFc821l+/Okeq7
         4Ldx75PFp5sZtGzpt6qrBOxrtY+2Uetrkx7FRi8mwIDEs/Wr/DBF610wG8jdRHckLDO5
         ldivKkJOO6Ergk4UN1NfRwogmcgvG9e9/BjaV6k5KtZqAUZwrRV9ZthQ7+NVF3kus2qk
         bhlRZU2HjcDKfDAJcMwcBHYYnrPathCqxhIL1XdrJDNtXfWOPoxJIaU/ZRChduyK3OeP
         o5GKHRb+X7grpQsQCbPXWC11mPIQBBNsbnAg57if9LJdiEfFgmalR5BO9CQUC+fDbE3Q
         TPSA==
X-Gm-Message-State: AOAM533rajEeMNLaStmNvNKX3vDSIHRWNQnEW8qjRSzqBqdED9N/Bb2N
        epVaT9k0hkuZ2Xyd3v5bmfc=
X-Google-Smtp-Source: ABdhPJwCjKeESc3L8IbeV5j21bvDk0eitpRamZsq6g9YoXBYxtk65XHiLToC3J+qPucyR9UNzMvs2A==
X-Received: by 2002:a17:906:31c1:b0:6c9:cfb3:4dd3 with SMTP id f1-20020a17090631c100b006c9cfb34dd3mr257861ejf.392.1645630848908;
        Wed, 23 Feb 2022 07:40:48 -0800 (PST)
Received: from [192.168.0.125] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id l6sm233ejz.189.2022.02.23.07.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 07:40:47 -0800 (PST)
Message-ID: <ac2c2075-3d5c-3f7e-d4e2-a8c80ec61883@kernel.org>
Date:   Wed, 23 Feb 2022 16:40:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 2/4] Documentation/dt: Add descriptions for loongson
 display controller
Content-Language: en-US
To:     =?UTF-8?B?6ZqL5pmv5bOw?= <suijingfeng@loongson.cn>,
        Rob Herring <robh@kernel.org>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <720f940e.5ac.17f26de3a5b.Coremail.suijingfeng@loongson.cn>
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

On 23/02/2022 14:56, 隋景峰 wrote:
> 
> 
> 
> &gt; -----Original Messages-----
> &gt; From: "Rob Herring" <robh@kernel.org>
> &gt; Sent Time: 2022-02-23 07:02:34 (Wednesday)
> &gt; To: "Sui Jingfeng" &lt;15330273260@189.cn&gt;
> &gt; Cc: "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Roland Scheidegger" <sroland@vmware.com>, "Zack Rusin" <zackr@vmware.com>, "Christian Gmeiner" <christian.gmeiner@gmail.com>, "David Airlie" <airlied@linux.ie>, "Daniel Vetter" <daniel@ffwll.ch>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Dan Carpenter" <dan.carpenter@oracle.com>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Andrey Zhizhikin" <andrey.zhizhikin@leica-geosystems.com>, "Sam Ravnborg" <sam@ravnborg.org>, "David S . Miller" <davem@davemloft.net>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Lucas Stach" <l.stach@pengutronix.de>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Ilia Mirkin" <imirkin@alum.mit.edu>, "Qing Zhang" <zhangqing@loongson.cn>, suijingfeng <suijingfeng@loongson.cn>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
> &gt; Subject: Re: [PATCH v10 2/4] Documentation/dt: Add descriptions for loongson display controller
> &gt; 
> &gt; On Sun, Feb 20, 2022 at 10:55:52PM +0800, Sui Jingfeng wrote:
> &gt; &gt; From: suijingfeng <suijingfeng@loongson.cn>
> &gt; 
> &gt; Follow the conventions of the subsystem for patch subjects. It should be 
> &gt; evident with 'git log --oneline Documentation/devicetree/bindings/display'.
> &gt; 
> &gt; Something like this:
> &gt; 
> &gt; dt-bindings: display: Add Loongson display controller
> &gt; 
> 
> Hi, 
> 
> We are not a platform device driver, there is no
> of_device_id defined in my driver. In other word, 
> my driver will not bind against devices whose compatible
> is "loongson,ls7a1000-dc". We just parse the device tree
> actively, find necessary information of interest. 
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


</suijingfeng@loongson.cn></suijingfeng@loongson.cn></zhangqing@loongson.cn></imirkin@alum.mit.edu></maarten.lankhorst@linux.intel.com></l.stach@pengutronix.de></jiaxun.yang@flygoat.com></davem@davemloft.net></sam@ravnborg.org></andrey.zhizhikin@leica-geosystems.com></krzk@kernel.org></dan.carpenter@oracle.com></tsbogend@alpha.franken.de></daniel@ffwll.ch></airlied@linux.ie></christian.gmeiner@gmail.com></zackr@vmware.com></sroland@vmware.com></tzimmermann@suse.de></mripard@kernel.org></robh@kernel.org>

This link does not work...

> This email and its attachments contain confidential information from Loongson Technology , which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this email in error, please notify the sender by phone or email immediately and delete it. 

Such automatic footers do not help. Could you work on a way to avoid them?



Best regards,
Krzysztof
