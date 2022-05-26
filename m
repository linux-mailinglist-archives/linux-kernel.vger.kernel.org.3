Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241F535422
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 21:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbiEZTxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiEZTx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 15:53:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E1187A25
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:53:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j28so3008254eda.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zcI0j+SZmpkVzsMq2PW5CxldUKU0n+nczUjMbaMcGWA=;
        b=oZRAjN1znZCcsygLVUjghx7XStVObQCkFajTgSk6ib1vlsPrUOa8IWadOhCywOINcI
         GZsT67a0GhmzWb87LGsEk7pLv67ebhML7VXCt731ZoriXhkDSUYbW6HNgBK9+k/yimnv
         NdZ0XdOX3Il6kyOD41UvQG81y66JJAryD0+rIbSZ1QryM3/o9QddzEOI/BjB+9jCRsCY
         LXN9ukL0OMlX96kyp5NKM+eoX+AA8xFBs7xF+C3bY3Nfic04yFBKuGvVKAuypqbmR/V9
         Jz5uKb8XVUHOq+qgw5tLWPsugvBiZ8HruzCryHYgXFEbv0Ls7theldPaVxPwaLhIqx+n
         zcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zcI0j+SZmpkVzsMq2PW5CxldUKU0n+nczUjMbaMcGWA=;
        b=wz4ODy9EKDJ39AF1uqDnNsZiHak14MDpe7SZwplSYKrErSsPt0c2DVbSLuT/9QjJL6
         bdLuVK3rzCfnka8/Wq0w8z+gL9uJrLc0i/UaX3Ml4VHxet0MZSJj4xdAvw+gZ18PmzHf
         CyffNliS/MbcLJNNy/SsaLOQME5aMSkdx70Sz1ormGC8RpUjQcUhX5+PHeqsakqdrDkF
         cY6hDR+lMxIU6ZXQhhxSAAH1ZmdcSUSZYPdSt6dLaYF905YRyLeT/h4HlNyhgnZF7Dg8
         JTYlGcndaChTJ2JE9LKp7Ga38jIVL1IihdP6UB3FdF21xgv+2668Qgas2GmYyMTtZGBl
         JgCw==
X-Gm-Message-State: AOAM530lRogsR6reRMSlBaWzFQsXQK5yz2DeAEylaNbZyNViINnGf5P6
        NLl7L5bzkELFmUHwBvZ2mwknpQ==
X-Google-Smtp-Source: ABdhPJx1fll91ZTj0ONQumGglTP9iYHm3XjuLYrazMU4CeM0eulrg44IAj9UvneSRb3uoISirp4Kmw==
X-Received: by 2002:a05:6402:d75:b0:42a:c493:3736 with SMTP id ec53-20020a0564020d7500b0042ac4933736mr41198784edb.381.1653594805776;
        Thu, 26 May 2022 12:53:25 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w15-20020a05640234cf00b0042ab1735552sm41504edc.66.2022.05.26.12.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 12:53:25 -0700 (PDT)
Message-ID: <2c845cc6-d787-26bb-9bc3-ea28d72134b3@linaro.org>
Date:   Thu, 26 May 2022 21:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add TPS380x documentation
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20220525142019.3615253-1-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220525142019.3615253-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2022 16:20, Marco Felsch wrote:
> Add device-tree binding documentation for the tps380x reset driver. The
> binding uses enum to make it easy to add more devices from that family.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
