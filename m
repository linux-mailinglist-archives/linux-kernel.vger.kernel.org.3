Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CE448AA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349172AbiAKJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236757AbiAKJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641892276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEY4b4g5DYT+cIJBREL/mouUq/7jCThhmlzvu53CyFU=;
        b=ABByK9cMagzrnmAgL5hepU3j2KFddqHH0R6BVI0whizoRmnyBul7O2iZcJK/7AqUph1Ejc
        J27tPXiFTbuNeSXXpk6gTdrgM2ZHpBG6mqrQ9tftjyAAHCJ+sBERxleNYaha5ACTD/2Jnp
        rcv+Kb86Zj069C4Elf4MKkZY9NaKNZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-cYzklqRHM62Vw--O0m8BFQ-1; Tue, 11 Jan 2022 04:11:15 -0500
X-MC-Unique: cYzklqRHM62Vw--O0m8BFQ-1
Received: by mail-wm1-f70.google.com with SMTP id d4-20020a05600c34c400b00345d5d47d54so1483569wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BEY4b4g5DYT+cIJBREL/mouUq/7jCThhmlzvu53CyFU=;
        b=c7txB9Fg3hNKl7yz8vwDdLZPux1OONMdNBG2JItyf2o7coOL3NtMeHE8ZOIccYI0tI
         +jYMnHfoCI54jPdX1QVSU2ESkIHboKfyUAghioQ7NFVQtYdlEZArKqdtA+OnqY+bPuJ6
         cReD9gYOcEZ/cjQAG+3XviV6apGC3bKzf7vPKUG9k43yZwddMeSrLS+dtjjHgN1Sfwh8
         Sr9xasO5AvEplSRbcjVindvTmkYSKFtpYM663ZQH/WxbGnuXcXwwD02jMb3+8Tc3GF93
         DPb4WTgHNgBt/FlZV1AGCZhVt29UbpaxhzUnArS/7+6MKkIZxny8e3X9HNF3RVyZx2Lb
         UGmQ==
X-Gm-Message-State: AOAM531jFZK4l+hztFtlsB2X6YyqFRxZrtWIZKRN2ym1n2E7fRb2Fd+s
        vNQlyo6YIJhIWSKVogGOPatb31nWu9eG9CkPH8BILJl/t1Vyy02tPN1gEtOEVkVfBBh2P17Rdns
        6hwlDgHnX1SwmOB8DDNNaxYvN
X-Received: by 2002:a7b:c341:: with SMTP id l1mr1625522wmj.60.1641892273632;
        Tue, 11 Jan 2022 01:11:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzo2U92/RGstwNQj9VAOnM/X4Ui1oVvHfIlVxa8zywDWfjs/4P0T5D6vLyWBOFQ7WAkNXu2iA==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr1625504wmj.60.1641892273424;
        Tue, 11 Jan 2022 01:11:13 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 5sm9945202wrb.77.2022.01.11.01.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 01:11:13 -0800 (PST)
Message-ID: <def83410-30fa-ff9a-ac8d-6b652e314a2e@redhat.com>
Date:   Tue, 11 Jan 2022 10:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/2] drm/sprd: remove the selected DRM_KMS_CMA_HELPER
 in kconfig
Content-Language: en-US
To:     Kevin Tang <kevin3.tang@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        lukas.bulwahn@gmail.com, orsonzhai@gmail.com, zou_wei@huawei.com,
        pony1.wu@gmail.com, dan.carpenter@oracle.com
References: <20211224141213.27612-1-kevin3.tang@gmail.com>
 <20211224141213.27612-2-kevin3.tang@gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211224141213.27612-2-kevin3.tang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kevin,

On 12/24/21 15:12, Kevin Tang wrote:
> On linux-next, commit 43531edd53f0 ("drm/sprd: add Unisoc's drm kms master") adds the config DRM_SPRD,
> which selects DRM_KMS_CMA_HELPER.
> 

According to "The canonical patch format" section in [0], the body of the
explanation has to be line wrapped at 75 columns. But your sentences are
much longer than that.

[0]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

> However, commit 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option") just removed the
> DRM_KMS_CMA_HELPER. So, the select DRM_KMS_CMA_HELPER refers to a non-existing kconfig symbol.
> 
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---

Other than that, the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

