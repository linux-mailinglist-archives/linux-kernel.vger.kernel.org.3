Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A014950C971
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiDWK4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiDWK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:56:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928EF2117E5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:53:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d6so8145832ede.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yr1zDNPtkjW900aFLa3t0O5qJZ8LqAWPxDbn7nFougw=;
        b=bdojJAOuJSx0c7Q3dlBLZLdiScxAQHM/6QKbpaISyBNe7aZVIdlYpHKE0vmZWqm27M
         2woc4vWbWIy6wDOKIupFVVISaw5SZ2oBCkI1U9yOBBo0DYb9UFPriTZMLT5/qRd+dgHd
         Zy7acBXuj6wj9me9xM0DPHYLcVSWrOqVlM2uV7FtCMyQi7O4WdNhG4D9JMFA35nwgHja
         o/RicXaRB3xeRmJ36jr9AN9xblPa7hqNEAK7He+F1f2P/degMWa6ptvXayCl/B80Vk3J
         RQt3W4c54SSAKOyNKhK7N9Sr+ZVPb8b2A2A+0rVvGA69tvLibyeaSDgj7u90BPSQ8Wgg
         mfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yr1zDNPtkjW900aFLa3t0O5qJZ8LqAWPxDbn7nFougw=;
        b=dTwrmR+MzYzNrokuNMSjtCoyuK3I3kxsyVMvZsie8oQP1d4q5HAbGtk9ABRsKJ66SD
         dXu6Raflb+GTUQLv82ocEDxePKfG9kzgXxIyq+dexwsJbsmg7eYufD8IqX+4758AbudC
         iabmwmvKB/jfMm+OJW4uurX72styVOKTKqzXACW4G9icg6UPAic+FeYMVEF+UYDe7S6J
         4cJ8ptD+E3SUUZvbv2uAtN8utd2NH83xoGUJNzz2DPDqvvskqrCn+2QLNvPy4B5vpjSG
         EHGWirV5wweSoPMhWub6NxNLCA3Sm2K+1c3zr6w0temkdo7LBqwHV2XL11OQTYCETPon
         ltUg==
X-Gm-Message-State: AOAM532QeCxWS2YPoH8mPDZwWAw5zfizRjV9qmLgofHJfB8t7IogQe+c
        yi2RCk0cCON7vUqm++xv4XLF7g==
X-Google-Smtp-Source: ABdhPJzYtLa0sLCpEYWQkmaqUJh55e8ipbIGVhqmN9ILB24+teL38E3AZCDDleTlU/a7PV/Pbft57g==
X-Received: by 2002:a05:6402:134e:b0:41d:774f:4c40 with SMTP id y14-20020a056402134e00b0041d774f4c40mr9550142edw.202.1650711208184;
        Sat, 23 Apr 2022 03:53:28 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm1574618ejb.104.2022.04.23.03.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:53:27 -0700 (PDT)
Message-ID: <45cab06a-1483-fbae-6724-5cf25bb81cce@linaro.org>
Date:   Sat, 23 Apr 2022 12:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 09/11] dt-bindings: usb: generic-ohci: Add HPE GXP ohci
 binding
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-10-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421192132.109954-10-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 21:21, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add hpe,gxp-ohci to the generic-ohci list. This is to
> enable the device tree support.

The last sentence is not needed, it's kind of obvious.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
