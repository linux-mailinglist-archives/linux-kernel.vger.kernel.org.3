Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F675538EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245634AbiEaKXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245439AbiEaKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:23:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6AD87209
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:23:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v25so8802450eda.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=okkjH+OvjfXBZJCEvPqx1oMMabLTIRR9I538z3D2Z2E=;
        b=qD3IcmAVnmp2zDDZTlQkysZvufGqKTQyC8kp2mgB+0jbKXVLdOd5OCQrgjLoMIadXh
         dRxiQUq38i5PT8O6a2v43oFufrmxADf5tV+FgLSEHFqcTXd/Ug+50qtFbCvqN87gtPa3
         +8cW/wM8K2DmZmSQa+92E2q/qbQww0kt4H9GdKKKs0/+90GiH6sOMa8DrG/E7eXURAl3
         GNk7IoiXCOyKz/if0ujDnQPm7DiFyMrM1l3lRPriFUGTUlSGoHO4oFzkyNhETfS9Nt31
         aUgD2uIjsm+XvD5xp8WgVDDMgUmpVvOLOujj/1cgRjeECD60P7sNf4bDliYDEz9OYNF2
         98rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=okkjH+OvjfXBZJCEvPqx1oMMabLTIRR9I538z3D2Z2E=;
        b=kL6oHI48ZCxkm4gWNFQ1HHeXBIs1j/jrQ63WTih5StUZeNI+yd/LfWFOQW2fOdA5i5
         5UzNPyuqt0H2D5uEguGa78ebNk/E+/dg4O58zF0UyEQxD3H8KTe/FxsYbEYPy6uRb4Tx
         nwL2eq9nAB8uIjYBtEuVDFoUCLFlbDKpzoe7uDzf7AzK59M5kWpvwrn5flzm4axgfMX/
         bx6vZQt6sv8Wbb0Hu4N2Hh8ydaZ8Ib8snGMIGST7DeCmqxTADhEugJr+NL7nd1RDqHXX
         hpxsxfD6ofOK6JW0IAWwnqaLjYZW6X0JbUPs7dMIpk4zMN2rYsZtmJVwaWyHmoUcQ/7C
         81ZQ==
X-Gm-Message-State: AOAM533hahNu77wa9go8PnuxMBaJCPSYN86sDdcj/6FizQvD937x+oqv
        78mg+2lH1MQRyVVQ6v0l+iLm6Q==
X-Google-Smtp-Source: ABdhPJzlM64G6AqKheHVTraVewtNN6C01iaEbZeoyV1aFovsz6k7lQ5XFNKRXSeMOCiVV8Tyikw1Sg==
X-Received: by 2002:a05:6402:e99:b0:41d:11f2:85e0 with SMTP id h25-20020a0564020e9900b0041d11f285e0mr62935867eda.339.1653992603489;
        Tue, 31 May 2022 03:23:23 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t9-20020a50c249000000b0042bd2012196sm8149688edf.85.2022.05.31.03.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 03:23:23 -0700 (PDT)
Message-ID: <b1f0e92a-7150-fd40-7253-91bb58e9d3c8@linaro.org>
Date:   Tue, 31 May 2022 12:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     edward_chen@jabil.com, ben_pai@jabil.com
References: <20220531011100.882643-1-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531011100.882643-1-David_Wang6097@jabil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 03:10, David Wang wrote:
> The initial introduction of the jabil server with AST2600 BMC SoC.
> 
> ---
> 
> v5
> - Compatible value chamged to "jabil,rbp-bmc".
> 
> v4
> - Add document the new compatible.
> - Delete redundant blank lines.
> - Add a new line at end of file.
> 
> v3
> - Adjustment entries are ordered by name.
> - Remove the bootargs property and modify the stdout-path property.
> - Group multiple LED devices into a group.
> - Modify the "gpio3_71" node name format.
> - Delete unneeded blank line at the end.
> 
> v2
> - Disable empty i2c bus.
> - Remove gfx node because aspeed-g6.dtsi isn't supported.
> - Modify the led format and add some properties.
> - Fix wrong indentation.
> - Add stdout property in chosen node.
> - Rename temp to temperature-sensor in i2c bus 0.

Thanks for the changes.

> +&lpc_snoop {
> +	snoop-ports = <0x80>;
> +	status = "okay";
> +};
> +

You still have here additional blank line about which I already
commented. Then you removed both blank lines - this one and the usual
trailing one.

I mean... really... Just remove the unneeded one, leaving the proper
patch like every other file in Linux kernel.

Best regards,
Krzysztof
