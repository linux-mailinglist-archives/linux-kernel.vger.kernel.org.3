Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4FC4D0780
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245053AbiCGTUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245048AbiCGTUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:20:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786632AC47;
        Mon,  7 Mar 2022 11:19:47 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id q11so14855324pln.11;
        Mon, 07 Mar 2022 11:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=43yabkppNO1PYVoZMxx6aJIsWh5rjZqMAPLH7WugjRk=;
        b=BiU7ljLkABKd52bdqKlmQSQxuZHrvKjIcWIu0kgzths5Wv3fC+rSB1XY4ylTKxasIH
         GCf2vqRq4qhva8TkFh3mdfpRQsBGWaYC5skR05sJp1qb74iZzYIuXEelcJ/ZgA5Mhk4P
         ecvaFIVcknL4o1wK2MGWNRCuglj65pFDaWM/4W0CkJyYekiB29pHJR4oGJyjzvLIA4zn
         b+YGVjRyvlebVhAf2gRkZAe5nBtj4clWMKMl9aItPXP+ibpsE69eOEMmIZZgVf9PAg1h
         /mZV268xz9jDpT/zIuzqm8RbaQ8kMonFfVNM+cJWEhHD8bZGHqsCNgkqd9Z6nZGwDV+R
         YCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43yabkppNO1PYVoZMxx6aJIsWh5rjZqMAPLH7WugjRk=;
        b=5pDUt8iXh6hAtoXFJleam6JFiu32jEHTs7ZaBACc66LhAvq4ceylpc3QjtCVJBhaWf
         rrOQOjsiV7lWp1v5S7Ac2WFcoJTZY2S93cMezP6vT/rQeqO48IyUqOGngWtHmb3anaPC
         CFmYix1eac5YCaAjAQncq8A0cnhhbpdVZQd304Z8XTzw/X1Wftqrp/w23JYRViciYLWb
         DhUniCjKmWBgoisaPkdMGHExIjaTnfdan5KWctlWgUlQMYgpwAcMvW3j+UHbqbiuDFaI
         jF1XqOFMH2KNrbTUwcBux485E79SydkF3Y8dgNYfxSRczXjhDhRwRkwnjYpbTCdkogP8
         BOWQ==
X-Gm-Message-State: AOAM532Yt1MNE7p6oU+hr0OxrWE4dICupDTTVwKpiM+GNcVFRS0pW+Dg
        CzdERq3CwCdXHLTbK81SaJMMZfDvWxI=
X-Google-Smtp-Source: ABdhPJyQJ9ofpleVaAS2F2cj7Hpt/138dCFRjiYzkwHQXlgarEhFkIFCi1K75z9VBBKt0JLtpGKLAw==
X-Received: by 2002:a17:90a:a418:b0:1bf:2e8f:f0f5 with SMTP id y24-20020a17090aa41800b001bf2e8ff0f5mr487295pjp.59.1646680786942;
        Mon, 07 Mar 2022 11:19:46 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e11-20020a17090a280b00b001bf23a472c7sm137098pjd.17.2022.03.07.11.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:19:46 -0800 (PST)
Subject: Re: [PATCH 2/3] arm64: dts: ns2: Fix spi clock name
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>
References: <20220307182101.84730-1-singh.kuldeep87k@gmail.com>
 <20220307182101.84730-2-singh.kuldeep87k@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8709766c-4b49-7f45-6ae9-08ff5f371320@gmail.com>
Date:   Mon, 7 Mar 2022 11:19:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220307182101.84730-2-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 10:21 AM, Kuldeep Singh wrote:
> SPI clock name for pl022 is "sspclk" and not "spiclk".
> Also fix below dtc warning:
> clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

Applied to deviceree-arm64/next
-- 
Florian
