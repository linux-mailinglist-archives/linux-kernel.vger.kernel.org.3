Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A6C4F78A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbiDGIAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242499AbiDGIAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:00:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7686A062
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:58:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dr20so9067095ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fC6I6LDKsU1dL3jt1bsaP5phqIETRSXO+VpMuWduiYY=;
        b=NAZwd9Y1aI51SSrlItLOHf6v0nHWXaJbmoEqV+YhgRAyLkkoxOa5cltHyIpiWq+udo
         Q7pm4lK8hOLsOzBI6fZ0h3sFvUw9+YHii8xE/FsSNofSfHQ0dhfETHfTTpNZrIBuHNm0
         yb4bXva/J1xsiIbj0hXVpqs3MtfaN7MMDHTWFU+eXCSvteTggFOx9vHS5qOr5XWeaBVe
         Xjvlp205sGeqb7kZvudhePFw89bLO1AguIPSd1gmuTNIx3oo1TWn7WQK+f7fe536o33s
         HdCOo1Nz8dyW9L/ITGsOQANC/UxkLUA78xsEx/0lgLvFej2PU3pKfrd32YCqcTuLuWTw
         rxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fC6I6LDKsU1dL3jt1bsaP5phqIETRSXO+VpMuWduiYY=;
        b=wsiJ81fJABHHdqBhRsxsleysUBeSjzIk3i+13samKq62KcBwbuVmUYIcIRDwR0xGkr
         0OskSHEteBdq/oxX6xVlplhkyzEVsKeqfTsRg8MI/QcjipVdyeUp33QFr3PTaN6IXbWe
         it9k8pYQGh6HUsDyD+onwVj+dWNNBBYvUsxeOmAyOxB3YU96y442rd/q/hgzvoZKJolx
         lxeDry9EpffjkDTCS0T/OFZYW9hAzHUu4keEXAXGtXPOSuWNdZiAaQu59sn/3oI/kSwG
         r2FMs2hNDOtSB+Z3Rtu43WvP3tKYEdPxanYutBzxvQFStFd6aiWP3Y55eA0+V8fb9Ph+
         vubw==
X-Gm-Message-State: AOAM531kg+KcxCWOSMkMiuVKDchq4W3ZTfw1lS2lYCAOvUUj/2CeVrhl
        KOr7eGsWgwcYOP1HSSnUWnJ4XT3EQo68oHCy
X-Google-Smtp-Source: ABdhPJwwBAjsNMwOIy95cYsA0aUV86ZNq+qMhjorORQ1aYLZQYgUC+I4uFf/XjF04nHEADZmXCtm2g==
X-Received: by 2002:a17:907:7f04:b0:6e1:39b8:d1a5 with SMTP id qf4-20020a1709077f0400b006e139b8d1a5mr12393193ejc.83.1649318298136;
        Thu, 07 Apr 2022 00:58:18 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906604a00b006e07c76f3d7sm7390612ejj.210.2022.04.07.00.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 00:58:17 -0700 (PDT)
Message-ID: <6dcddc8a-7ca2-b424-fc8f-7000be3f9116@linaro.org>
Date:   Thu, 7 Apr 2022 09:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/1] tty: serial: samsung: add spin_lock for interrupt
 and console_write
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20220407071619.102249-1-jaewon02.kim@samsung.com>
 <CGME20220407071223epcas2p16bb11821a0894a3375e84d17c4ff0844@epcas2p1.samsung.com>
 <20220407071619.102249-2-jaewon02.kim@samsung.com>
 <b53be23f-7935-dae3-9dc8-f850493a5fa9@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b53be23f-7935-dae3-9dc8-f850493a5fa9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 09:46, Jiri Slaby wrote:
> On 07. 04. 22, 9:16, Jaewon Kim wrote:
>> The console_write and IRQ handler can run concurrently.
>> Problems may occurs console_write is continuously executed while
>> the IRQ handler is running.
> 
>  From the patch POV:
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> But given this is a v3 with no version changelog below "---", you've 
> just kicked the Greg's bot to wake up :P.
> 

There was a cover letter with such changelog:
https://lore.kernel.org/all/20220407071619.102249-1-jaewon02.kim@samsung.com/

It's indeed easy to miss...

Best regards,
Krzysztof
