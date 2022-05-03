Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5252E51835A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiECLkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbiECLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:40:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00D734BA7
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 04:37:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l7so32908779ejn.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=X1FUNuB7P3eW2ayDNUqILdNTj2LgjfmvS/GJDjAZwJ8=;
        b=m1lsa/lUBG13ARmSDKBacb1BxkHOLDYVNgdzx87jaByNzrYBqQjteQH9jkfbbdF0QO
         gVBjSQDRDw79CP7VbvuDmFkUQHW5Y/2HQOpqKUZd50/mRQE0HrMFgj8B66PmfYRy61kb
         8mQDe2M8M3SeuqAHv+CkuKeCTRxKJ8py6uI2LM1l0QxqNtLGG3TQ/E1drhj9elaMYM+Z
         xFA/t/PW27qFlRei0Or6PigQwyezhQQlkaMdEd86vK4ijPxTDPA3k4qBDuVAyd7WmywV
         UJb9Ji7I8Ftv+i2NiOVJKZ3oCXUG0kPPc9hYXimNdHyqsP34bD3r76D1aIy486doAtNa
         cl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X1FUNuB7P3eW2ayDNUqILdNTj2LgjfmvS/GJDjAZwJ8=;
        b=g5vYx7NY392acHomxrYgDnmLYGEWACZ57ve79JLD97OLlAJekGO1viab0UoH26+58l
         5WpgE0p0qGDclvmdZIP53lBF22YsgmVR/ZYyIjImRfD5+JAPkhT81o8vT9LFvu7hOdlZ
         +vd4e9wUxAkQMxBTfwdY7zKfFyL7iwlWc84HqLuZZIh0qy32u1X4R7rlS5vY3lwMrv5Q
         j8bTf5OxyB6OSe6UB6vgALCt2Fzoyatv0oxd+u+j8+fL5VAiknAve6URsTBoLLEn7h20
         iocpu7M06wMpmuA9FminwKzZmrgjc2fnHo/n11qcDGUmCd+TA9eramFRCTPF16ae4L18
         KsGg==
X-Gm-Message-State: AOAM5326kowOg8E25RtAkcuZp/NfuxlEl78u0d85KPfrsdNL7eAu/rJ6
        uYVgMquPnDgD9Bi3+1gxgPcRHg==
X-Google-Smtp-Source: ABdhPJzQ+6Vtojorbgz03fnGzcETCdUI4hWoJhuVofseBZB8aIdh7DtxCNdBnYFVXj5i+orsRW9lFg==
X-Received: by 2002:a17:907:1c9c:b0:6f4:2918:5672 with SMTP id nb28-20020a1709071c9c00b006f429185672mr12582950ejc.439.1651577838380;
        Tue, 03 May 2022 04:37:18 -0700 (PDT)
Received: from [192.168.0.202] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l24-20020a056402029800b0042617ba63a7sm7841464edv.49.2022.05.03.04.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 04:37:17 -0700 (PDT)
Message-ID: <b7bf8ab3-9680-6318-a575-bb1dfaeef405@linaro.org>
Date:   Tue, 3 May 2022 13:37:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC v2 0/2] Hi3521a support.
Content-Language: en-US
To:     "Marty E. Plummer" <hanetzer@startmail.com>, arnd@arndb.de,
        cai.huoqing@linux.dev, christian.koenig@amd.com,
        devicetree@vger.kernel.org, gengdongjiu@huawei.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@armlinux.org.uk, michael@walle.cc, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, novikov@ispras.ru, olof@lixom.net,
        p.yadav@ti.com, rdunlap@infradead.org, richard@nod.at,
        robh+dt@kernel.org, sboyd@kernel.org, soc@kernel.org,
        sumit.semwal@linaro.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, xuwei5@hisilicon.com
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501173423.2473093-1-hanetzer@startmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 19:34, Marty E. Plummer wrote:
> Resend RFC.
> 
> Changes in v2:
> - Actually include the dts files.
> - DT Bindings still missing, as the the driver is not quite complete
>   (need to add the reset controller bindings, have't quite figured that
>   out yet.)
> 
> Marty E. Plummer (2):
>   clk: hisilicon: add CRG driver Hi3521a SoC
>   arm: hisi: enable Hi3521a soc

Still no bindings for boards/SoC.



Best regards,
Krzysztof
