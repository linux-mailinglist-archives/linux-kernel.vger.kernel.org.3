Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF5583A61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiG1Ice (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiG1Icb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:32:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE36961DA3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:32:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a23so1777325lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hI2m9NPPZwjaeUAdv/OUDYJH2jCwotQ6GbUvku4Sz58=;
        b=eZdNWRmQOtaqbNQMyzuIC5DQa7hLZLvmFxlylaAYGkdiXMSUev4ygletmQSIAzWlKN
         P7zdd/nvDHynGU5Bz9kuAxcqhlOKnFsV9wqC7tB7aMRVHRKv/ZBOLvr/oQQ9W9tTrwKD
         E+Rvs+VZzIyVnXeC98gQDmDRLULQD52PwjxYR+R70MngNebqr81q82HA0S9MqWhVmIIP
         KroZ+DBjQVoc2SKLFtCgGj1utg8B0Q1pLeyDdxXTGKg6wix7YZmrH9JXXoAuFEzpWeP2
         Af3+oTj70SzmahTNwqCtMEPxoReEhcT9EjbiIdJMsztcx0xfoVt9oBvV6qak1GlvxcXF
         Dwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hI2m9NPPZwjaeUAdv/OUDYJH2jCwotQ6GbUvku4Sz58=;
        b=uEbfodOcOfIGicaIIq3ArArOtM/NJFkKBpRPfBbTYmT0M3UbH6Qnjf3gHXc6MPr0LO
         GzMWW0fePT9le1MItED9epXbNc0mv050SKwUUqYfXBLEFkcYmcXLBOxTfPpe/D7rGrUg
         mHy6pbQdo7EqB1HOkpIff2oMWuQmA32tLaPndBW1jZ8YIRTwuhQQHFXhVg1pGiuGIuba
         0k7pUwB68OHtDeY8zfkN+3UipvhGerMBnymT4ebtADQ7YdafnOZj89X5EKuKFWP7ML9d
         5lof4mXfD4Rfjvxj6csk4n9oRxXtKp2N5U/gJ2Iqz2nAn2FAeHhSzXNDlNxPVBzyMd3l
         NDUw==
X-Gm-Message-State: AJIora+t67KKtz8mhv7U+9DDJjTYM22MAkxNiICmxIdwZ78BqjFJPe8F
        63cqhy7pD7+652+0gde0/wRMCw==
X-Google-Smtp-Source: AGRyM1tNGhUok0FkmEJmPyrmh3QNCxe5DcCV7R3sFLucoHlfS1pQj7W+hsJlBnkTL3BBMpcSN/uxgQ==
X-Received: by 2002:ac2:5317:0:b0:48a:7227:5223 with SMTP id c23-20020ac25317000000b0048a72275223mr10107964lfh.376.1658997145937;
        Thu, 28 Jul 2022 01:32:25 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id t12-20020a19dc0c000000b0047f84ecae2esm86865lfg.236.2022.07.28.01.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 01:32:25 -0700 (PDT)
Message-ID: <49e4f45a-51da-ec4c-9ebb-dfa022bf8a88@linaro.org>
Date:   Thu, 28 Jul 2022 10:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1] pinctrl: samsung: Finish initializing the gpios before
 registering them
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220727013349.3056826-1-saravanak@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727013349.3056826-1-saravanak@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2022 03:33, Saravana Kannan wrote:
> As soon as a gpio is registered, it should be usable by a consumer. So,
> do all the initialization before registering the gpios. Without this
> change, a consumer can request a GPIO IRQ and have the gpio to IRQ
> mapping fail.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Looks good.

Linus,
It's too late for me to pick it up, so make you could grab it directly?

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Otherwise it will wait for merge window to finish.


Best regards,
Krzysztof
