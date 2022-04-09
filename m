Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25084FA726
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbiDILTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiDILTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:19:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49422BB1C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:17:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k23so16403498wrd.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RVterRRaZ+wDMCvb3zP8wG2Xuuu/HBX+zRywYLtvhOw=;
        b=KTlPVlkh5EYkuv9z0wxVRBQuDcyyuLWE94P6DiYAg8BA695ar8Cc8gM0+mcCjcNvHX
         HFdMqBtkWLv3ExhclQhnlu7AbZAvLGFthzS+kGhF0bv7fG0gyROxGgyapmh9rToQwCAi
         DzRi4N1p3y0+2/+TNvO+5pySMV1q8isxR1tUl31F7J1DTKGF3/E5tKfnpjAbXut8gxbH
         nQWGVbAX5wjGtzEkfDvYTSTHGlxwzUQJSLejeyBGTee6n0L3M1YM8V7BYd8vSyV0dgzo
         dYobW6cI7ql62cIspXyGR+McWgT7FPnmplU++7MXyp9cNfW/5zLlFPTWv1oBG7vDXSgN
         cB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RVterRRaZ+wDMCvb3zP8wG2Xuuu/HBX+zRywYLtvhOw=;
        b=Ju1EucNDxMHH6BIqhmolVVtTWLgLCvkGfhzYY0DOUoIf0FJUE1uWgpJmhQFGUEkDsE
         COiwgzX2tUzazB3ixb6VXHiW1GDyehVgSnqFR+l+WUKvirAERLIFaZ00olwJ64qu3BsF
         lekHusf2keTNSkZqG9D5y8sjUA9ZSUgs1OG/cBIM6VZ3UK8l8+ePmlAUbH73/pyuTD4n
         SP0BJ9c+OFDPKdQ/pUCPcR7XAr4VdCymsRULUrgZgeL6UBFbFzPH2zME7aAkrDC00UB7
         gaq8TwDOTNTVK8cDao2JQdMDd4PQcBhuQMI84/jupmkPTENXKU+cHlYf+WgACy0JK1aQ
         C1yw==
X-Gm-Message-State: AOAM530iAvZEOdcE4SZR87Dr4DN8Bd/W+SDaBiZia9fzljwLcwANFrZZ
        i8eDOBvD5jdX4D/xT63H7S7+cw==
X-Google-Smtp-Source: ABdhPJwe62UgwLyi5zEjgage7fef1jaKxNLPs48BCfnq45Qp2gOWGbokc4XlrqlOIG/4sIZJ9AEYtA==
X-Received: by 2002:a5d:5689:0:b0:206:ff7:1a28 with SMTP id f9-20020a5d5689000000b002060ff71a28mr17578238wrv.228.1649503025312;
        Sat, 09 Apr 2022 04:17:05 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m128-20020a1ca386000000b0038ea1accbe9sm4125487wme.27.2022.04.09.04.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 04:17:04 -0700 (PDT)
Message-ID: <2f0646d9-c247-61e6-3332-715f20c8b66e@linaro.org>
Date:   Sat, 9 Apr 2022 13:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 08/18] MIPS: DTS: jz4780: fix lcd controllers as reported
 by dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <a948ce9c6126eb9d5daf9a24e76cc6c01c22c685.1649443080.git.hns@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a948ce9c6126eb9d5daf9a24e76cc6c01c22c685.1649443080.git.hns@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
> /Volumes/CaseSensitive/master/arch/mips/boot/dts/ingenic/ci20.dtb: lcdc0@13050000: $nodename:0: 'lcdc0@13050000' does not match '^lcd-controller@[0-9a-f]+$'
> 	From schema: /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
> /Volumes/CaseSensitive/master/arch/mips/boot/dts/ingenic/ci20.dtb: lcdc0@13050000: clock-names:0: 'lcd_pclk' was expected
> 	From schema: /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
> /Volumes/CaseSensitive/master/arch/mips/boot/dts/ingenic/ci20.dtb: lcdc0@13050000: clock-names:1: 'lcd' was expected
> 	From schema: /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/display/ingenic,lcd.yaml

It's enough, no need to have two same warnings, so all duplicated
messages below can be removed.

With that change:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
