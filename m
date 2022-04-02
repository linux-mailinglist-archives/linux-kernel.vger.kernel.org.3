Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0519C4F050B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358405AbiDBQrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiDBQrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:47:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF10348E55
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:45:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i27so4685157ejd.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lMPLaifjlPREZXBjIBwue2MEcz05yGzVfgoyVmaFjVc=;
        b=jcRbVQ7gDzmFwowuWWQ6xJvWYfyqCNL5vGwkDQFJobitvVqY8+B3A0UeAzlBWwjiHX
         Eelggmqlw/iYUUPitF4AH8JGqVD2MwUm/LtRsDHZeGNp4y+A3gtD6mS/PfjX+eA/qHDo
         pz+YxUzoJ63J5yQoP+e/FOQzuNCunTjPjUsPRIdQTpRKU61gZ1zVdwgAXPlXBLGHrfHn
         0wr3/R2O6bIvwo1FUVNQEVuyxlJSrDsF3lQNx2omTxC/VmVyZEW8qHcQTkCbQtjxWiam
         JFQbqsObmgMQPD4gb3s/e/Sn1r9+0iOLhXnDIlZZq1biLZpmg7hMCMpGHyzSlyNf/5MO
         C4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lMPLaifjlPREZXBjIBwue2MEcz05yGzVfgoyVmaFjVc=;
        b=3i6O47aSGRIcssADAly2zg8C6rb8U4ihO/7LyS5yj8CesT/3osnTrsGApGri1f8KOw
         Rq1uD4jqdUVsHwqWO/omwsrIXeOGVHv5Zu/T7XAzhHTyGwJkcZwujhdAvwtfjEcL4Owl
         YJJzgi3DaKMDqgN7ZgMfA0EuB+Ve9dE5R5qGzUc0XhbUhP7uWVy9O+SnwcIum71OZVOd
         9kSRbvqucXDHMQJHCr2PNoiN4K7J0n9CsYvuPdb/pDQ9qosuaQD+8Guzdmkq0vY8Q9hA
         PVqmU8Szu0E7z5LNLuDxMqhDysNWJ2kwfv0irpe9YtT9yDuLMxdUI6TnpjGW0BhzSYub
         N65w==
X-Gm-Message-State: AOAM533cLrUigUU1JTDtuEe/fKhHkRi6fEVvgBxq62amiwVP1UmHdzYr
        nLA2rszG6M5Tj4PcD1Yvdjz30w==
X-Google-Smtp-Source: ABdhPJzhU+ug0BNuIctU+TjiJXc7sRo/j6vvpcsPZBTc4sus6x/7hOzEVPdrlIgjCgVySW155Cw/7Q==
X-Received: by 2002:a17:907:94cd:b0:6e0:b001:aeb6 with SMTP id dn13-20020a17090794cd00b006e0b001aeb6mr4354843ejc.283.1648917919486;
        Sat, 02 Apr 2022 09:45:19 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b006dfc0fe42b1sm2280633ejc.177.2022.04.02.09.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 09:45:18 -0700 (PDT)
Message-ID: <553ac698-48ea-d7e6-6338-34395efbf603@linaro.org>
Date:   Sat, 2 Apr 2022 18:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 00/16] Convert Rockchip clk
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220402143636.15222-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402143636.15222-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 16:36, Johan Jonker wrote:
> Combined serie of previously converted Rockchip clk bindings.
> 
> Changed V4:
>   combine dts patches
>   add more clocks
>   add clocks to example
>   add clocks requirement
> 

I think I reviewed most of them and gave you tags, but I do not see any
tags. Did you remove them because of some change?
See also:
https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L543


Best regards,
Krzysztof
