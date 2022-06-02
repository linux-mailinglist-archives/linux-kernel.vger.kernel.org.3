Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BF153B8EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiFBMUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiFBMUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:20:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB4FD13
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:20:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x62so6026741ede.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FtOiIkV4ug7vKNy9XOE34Pci3xBG3uAAi0c6Gr7aiC4=;
        b=CkOaDxIoAlZOkpylrHDPhpkBKUbqAy4R65Mlsp7VpFhLqe5PM4xJVQPAwG5UrV8XH8
         vU1mjuKZZ+letq1VvxeF7YdDO9ISLQJtCZwp/A8opjh0n//AZKnVAzze0C3Vf2TvgziI
         7lHotX0lW708CXxXvuLhaNeabPppTXcXIDJbxSC/S38+SQiiH14cmhOYOYGW2uq2WoKT
         DNFkgZFJ6YKfRa4KfBOSw55gdFUJ0yH20sUCExBVLFn/olFDldQoi3X4598x/1FPtYk5
         a8m7KqURE7PhGjeaEoH+agsnFXdKCb+jsHkNipy5VjeiZliamX/sV1XHQOEA5AbLOvIB
         /j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FtOiIkV4ug7vKNy9XOE34Pci3xBG3uAAi0c6Gr7aiC4=;
        b=TpKZb//TQEQgbb+3xjHGyZNtUfo8ARSGAAh5tiohDFWCfKIdx4POODqSZdYewRu2/7
         qUiqhIf5J+eRz8qHFnZaLNYq3D1h0lWMZrjNSpVusudxTDHAIlqWKQry7ypv/Fknlzzj
         i5TenburkPYHCp2TKmgQigHaIahsCvZimgUBPXLUumQefTM0MEhKLVQ4kXa9jPdPaovI
         I4NfQyK1G3sevfaUTnx3esifxWGXQd47gAc+Kz5fl0WzBN3Oe9gJ4Aaifw1VFdNZmcxM
         NQoJd/AO4LEUXGIPkakGIbD5pA6jAeVEcNI2Bp48e7Qx+UKQPVew2Ho1VliqZFZ9t0PC
         Zyaw==
X-Gm-Message-State: AOAM5300R4za6HWGeRgbONiU2YRCJwBI0k4/Hgr/vzKdzYVMHLITyYBY
        ctYPUwGyr+TctVh4U9dwfqC9hJHc7b06Kafa
X-Google-Smtp-Source: ABdhPJyUxSuNQJGlhNRIME/yhmzD8Iv88CDO5k/3PT93otIJAaLpe2nfe2tUn55lCuMSellx5ETl1A==
X-Received: by 2002:aa7:dbc1:0:b0:42b:77a2:4f81 with SMTP id v1-20020aa7dbc1000000b0042b77a24f81mr5084597edt.287.1654172448433;
        Thu, 02 Jun 2022 05:20:48 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w7-20020a056402070700b0042aa153e73esm2382597edx.12.2022.06.02.05.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 05:20:48 -0700 (PDT)
Message-ID: <1cb6d111-25d2-a608-21b6-899ef20d735c@linaro.org>
Date:   Thu, 2 Jun 2022 14:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/3] dt-bindings: soc: ti: pruss: Update bindings for
 K3 AM62x SoCs
Content-Language: en-US
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220602120613.2175-1-kishon@ti.com>
 <20220602120613.2175-3-kishon@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220602120613.2175-3-kishon@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 14:06, Kishon Vijay Abraham I wrote:
> Update the PRUSS bindings for the PRUSSM instance present in
> AM625 SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
