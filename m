Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C18C52FD5A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355262AbiEUOhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiEUOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:37:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C605864BF7
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:37:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f4so18635055lfu.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bIY1yUbknyVqSNNQl9k49YdfHFXypUK+qkCbMASPInM=;
        b=bkX8XNMCdE00Wl+Tn3SOqnu5S2DSHFkS0ASjG8U5MvDsDWWxG2xYpmaiewaESOyMH9
         Jr96sPR86V2MdsoYbVYHF1RjoXHMG8nkEuWZMjtXGyoy0BGj3MzbtlC4diUEhIx9KJ1T
         47ExF39SYS2ZbkvQziN+Yhw62mX1WxUEdV+f9EXeQx8Y7uVfVHEG+yyTxwe8S4bN57aG
         c6mGgjv2MZitv3Ldq5aOOVEeOHNV2cz8nTWJqjKmBDbvulxCtLnvu4B7I1UMMRxI3MF6
         b2MTpJLhkW3Ri6xqVLxmBIWReGnWdQdCsjv7/AGjPMy0GF18mcQ/JrQq7AZcpk+Wwppl
         qrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bIY1yUbknyVqSNNQl9k49YdfHFXypUK+qkCbMASPInM=;
        b=RXx5yrXnczTO8ympp+PGn8YnGY7DkPfiXA9B9eAi0QeAR/tBEMJ9AZQENf2joscnpr
         Tu6LerkVVHzkk/DPtJNdBxqclEH5bbbsHds3UkS4bawaUgLcA2XDVS95Vjuc61fvg2zI
         JCEaJaWYK3w1ekT5B44ZzC94yC9X1GACIYJqtRgCw2pYmHl/gyuFnPPVIDx32RsxW4p0
         i6OXRAnHJhoFJokUXWdj9EtyazXJn4M5eiNPsay8u7iS3mvEgTug6SvGUF+wbzuUSSCz
         qR47bMDUSmlCP/pxojx9laUNoBY4X97OZpAjoK4WT03f9GGHcxIiFGXTfkpgkXI+tB2w
         LRcQ==
X-Gm-Message-State: AOAM530vdka/vnP5yKgBhGwtrG010iAO0Rep2aH2imQZCATt7ITPX5nU
        n9AeDISTXjPtu1171u9sCLWDQw==
X-Google-Smtp-Source: ABdhPJz0JjJvYOFloztntmHbn0+EPKW+2LhRTJ3K/wSNWtmn5A6cMfAiFRzhARHiK3HCimydCYML9A==
X-Received: by 2002:a05:6512:3d26:b0:473:a5e5:1661 with SMTP id d38-20020a0565123d2600b00473a5e51661mr11030778lfv.239.1653143826160;
        Sat, 21 May 2022 07:37:06 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bf6-20020a056512258600b004785b0dfba4sm430276lfb.195.2022.05.21.07.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 07:37:05 -0700 (PDT)
Message-ID: <1385f9b7-b8e0-4c13-63d2-48e99a97e998@linaro.org>
Date:   Sat, 21 May 2022 16:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] Microchip LAN966x USB device support
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220520152335.352537-1-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520152335.352537-1-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 17:23, Herve Codina wrote:
> Hi,
> 
> This series add support for the USB device controller available on
> the Microchip LAN966x SOCs (LAN9662 and LAN9668).
> 
> Both SOCs have the same controller and this controller is also the
> same as the one present on the SAMAD3 SOC.
> 
> Regards,
> Herve
> 
> Changes v2:
> - Avoid wildcards in the DT compatible string
> - Rename the DT node

Thanks for changes. Please mark your patches as v2. The easiest is with
`git format-patch`.


Best regards,
Krzysztof
