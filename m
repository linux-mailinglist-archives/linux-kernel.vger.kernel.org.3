Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A35521CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345000AbiEJOnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345770AbiEJOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:42:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8272FBBD9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:59:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z19so20127976edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=svE7D7raICTcswKmlZyGfw+j5n0q0z/eO2/j4YJcVVE=;
        b=clYZ3E4PvpwShzWS+GRxHqDLlGwakjZVKIZjvmSaSq5b2DQ3XbXuI4cyHQMt/rkvxY
         B9mmnwhRmMOgcJxs3bSN4ijt0M8+R1GpNSbuhMokBi9fFy6dz135FUS7fdJDcIS4/uI4
         2csnOogXyyHMwyTdp70YzxUkRZEkh4OCOG/8cKafwuRA4BceeqLLOHeTMgipUwpTD0Gl
         p3lsVcwhQNRvrxpSaxe3QxrZcS3L2U47OvrmUv+b5qjE9JmhOteyRNMWU+HVuqCDRLQL
         d0eQ4XDLPswOvFGVHc6vvIIL0/60PB7/UFzFCyTyewA8tglFrQppwZnIcufd1WKkmeYW
         NLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=svE7D7raICTcswKmlZyGfw+j5n0q0z/eO2/j4YJcVVE=;
        b=3oV4V/DKjh6rMWOPyBSU1jnqXvkf6Iuv/KXvtCIvpS3z8CaBu8bNMgHn0mo4z7tANB
         gbYK+LiQyWMFZRBuWJxmtLpd1H//yyotz4Gf4IljnB8AGXCYVxcR0PAQJ86zDmFXLv74
         aLuFO1vbYLE5JsvzWFOXrOrVwjCpdWS/wrgjtTY9o27Wi2rV/vOBwnlaY8waxX66o9A+
         HvnIsJXH4Mp+AIGeCYXAidok7CQr7AT73VcDFoRDGnZNJdsO9Lr6eTB60uKkW5hFKHpN
         Fg8YSo2kEfFpgbiylQcjTgTozOunWCtNXTcGvVvy/B4dXQWXitpKQgjjmxYTIjE9vapF
         nPkg==
X-Gm-Message-State: AOAM533s+4gMBTc9RZsHmiuWFcZh4nunQA2ELYTpiOoH33ZwNg35VqR+
        UKL41nSZjXp1zkwMYrSlTi32dg==
X-Google-Smtp-Source: ABdhPJwNYcAh0SYi4grd77JDHU1ZiH4pCjfhn2XQt9Yp0qugct3X74wDvVvnd+WAg0WonxkQqGd9dA==
X-Received: by 2002:aa7:d459:0:b0:427:bd8f:61f8 with SMTP id q25-20020aa7d459000000b00427bd8f61f8mr23743119edr.157.1652191146619;
        Tue, 10 May 2022 06:59:06 -0700 (PDT)
Received: from [192.168.0.253] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906241000b006fb6d9d25bfsm781919eja.22.2022.05.10.06.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 06:59:06 -0700 (PDT)
Message-ID: <5ca7ddc9-dfe6-a897-a0b7-09d04316cf28@linaro.org>
Date:   Tue, 10 May 2022 15:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: manual merge of the mvebu tree with the arm-soc tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
References: <20220510094102.099d5e54@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510094102.099d5e54@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 01:41, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mvebu tree got a conflict in:
> 
>   arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> 
> between commit:
> 
>   2f00bb4a69c7 ("arm64: dts: marvell: align SPI NOR node name with dtschema")
> 
> from the arm-soc tree and commit:
> 
>   5e9b59bd3737 ("arm64: dts: uDPU: update partition table")
> 
> from the mvebu tree.
> 
> I fixed it up (I just used the former) and can carry the fix as
> necessary.

Thanks Stephen, that's the correct resolution.

Arnd, Olof,

This conflict will come to you when Gregory sends Marvel SoC pull request.

The correct resolution is to take my commit 2f00bb4a69c7 ("arm64: dts:
marvell: align SPI NOR node name with dtschema"), so the node name
should be "flash", not "spi-flash".

Best regards,
Krzysztof
