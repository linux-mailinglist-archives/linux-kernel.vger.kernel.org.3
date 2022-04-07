Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC774F794A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbiDGIS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiDGISQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:18:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D841FF232
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:16:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id p23so5457799edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xUYWxyJEg6leDM0Xoa+hYl6e09Zj0klrd/06rKmbpmY=;
        b=VDt+MTz290lEtYWH2rYjozi9VS/wDkTwYnmZ1LHSDAEKP9qIm5ptabMoOVy2BND0Jd
         0L/LUQaem3vZwxfUuvDjdbtMswNl1eX0QWzsSivBnM1zpfkIFZ4hXbyDzByJBJkrf2yo
         llVHCnqcLTsm62tnuOi5v/6b71TBZCDJNbHwM/PM0+G57hSSWjRQi+4dEon9BUSW8EIA
         hozevSwzAYq/hABD6Yre/N7t1Spx9rVku5XMnFRlg8vFRtQ5gD5N0lyqR4Vr1D/G7s7d
         WDjA5Dm7s8ar9mDYFoj7tTOBGU+uGdcq4XJBDLpdni7lwiaorQQeU5BNNHm43b2JjE+I
         qywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xUYWxyJEg6leDM0Xoa+hYl6e09Zj0klrd/06rKmbpmY=;
        b=4BEbf1C9soTc1iLW4Fh49bXtLdN8mBdH7w/e/rd9SgxrZWOSI6iexi71vYSAN5Fm3v
         q/5Objv4mhTsz8iyB4W05iuMkYt1LDdOCJNgz4RTzGVs9SglInibLcbBh1CSwizfIygD
         /E/sPLwoVGfRUIlA+aHSEy+F9RUWHbpdF2hZ0AuwrF9i3gQ32Op9TbYMpz1DO5snOzCa
         s9H9fPpAS0+xF3r1vx3zNntpgLQ2v32CTPebXQ/0mVsT1VWabvLHWYdQOU1eD67ygGJW
         8LwRCsR3nNTWtw1ivmoe7QBHqD36oz+BCvA+EfNAXt8ovAbYs5buB+xULENskTvTgMki
         hNpA==
X-Gm-Message-State: AOAM532+Jm6xT2Uorr2nBDcMvaJO71Z0PPV14YRWBmNyb8gZALfYzoDx
        7amMIM/rslCk7cFXv6XrVhaR4Q==
X-Google-Smtp-Source: ABdhPJy/ERLqCYKh9BpiL5bF6j78reR9LcaBuPraPoj6GLaivpbUlPeSk3kUE3ntnN95zAfa0g/A9w==
X-Received: by 2002:aa7:cc96:0:b0:410:b9ac:241 with SMTP id p22-20020aa7cc96000000b00410b9ac0241mr13117970edt.246.1649319375803;
        Thu, 07 Apr 2022 01:16:15 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a056402090a00b004196250baeasm8923523edz.95.2022.04.07.01.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 01:16:15 -0700 (PDT)
Message-ID: <c46aa011-1292-0dfb-2f10-a4d9f9a4fdaa@linaro.org>
Date:   Thu, 7 Apr 2022 10:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GIT PULL] ARM: samsung: Fixes for v5.18 (current cycle)
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20220407080545.112290-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407080545.112290-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 10:05, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Hi,
> 
> For the v5.18, please.

Argh, I need to update my email in my scripts as well. The tag is done
with correct identity.


Best regards,
Krzysztof
