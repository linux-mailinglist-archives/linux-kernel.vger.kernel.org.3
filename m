Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA84E5524
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245138AbiCWPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245145AbiCWPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:25:33 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471E374DEE;
        Wed, 23 Mar 2022 08:24:01 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id p15so3530764ejc.7;
        Wed, 23 Mar 2022 08:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=jn6YrIbl1vuu7GwVLmJ9KNX8jl/4kcRTdmUaWrepIhw=;
        b=FLeYHlYAy7ucZS0wltSUZM1pA+rXHg4QcTgDqhKGkUqzo220i9YN93ve+2BwIDa8xW
         qrj94qs0DTJQsp3p4MV3LYR643Yo+ay1ZiiI5t3Imi0VQsHl7wEYiV3uQ7KruNj0M2js
         ljWj0G0VQMFkv0UNxqFAB5HfnwKY4IdX33DJSH8Kw4I7xomExGojYHqoNfyG2rUCNMu6
         ubz6OfJS+UyIsnSKnixdd+MWUVBqIbLGW0rJdM7SUTE/1HILG2sYCTiRyMkTXdQ3U8oE
         c93feziebaXCiOnGHCXepGWtEeVB2urFuO4QRGQEeIJrjvaezrvwQ7VEL51PRs/czrs7
         lHrw==
X-Gm-Message-State: AOAM532wBZHu9lPe9AOHb1PjUJO66LuaHmeFQNWeAsi4wrQYWGR0HVus
        ES3ZlwlpRi0Xcusuj6kS2uQ=
X-Google-Smtp-Source: ABdhPJzAn7TRIOQhY/R9zjRp1Re/trZp7xCDwmqKgSmCA60mujwP2DsLmZjaAEwBk7guM3fulhRthg==
X-Received: by 2002:a17:907:9703:b0:6da:6412:508a with SMTP id jg3-20020a170907970300b006da6412508amr528406ejc.77.1648049039728;
        Wed, 23 Mar 2022 08:23:59 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id f2-20020a170906738200b006df69629a3dsm74833ejl.28.2022.03.23.08.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 08:23:59 -0700 (PDT)
Message-ID: <3dba9313-cc29-320a-cc37-a25245f14350@kernel.org>
Date:   Wed, 23 Mar 2022 16:23:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   krzk@kernel.org
Subject: Re: [PATCH 5/7] ARM: dts: s5pv210: Correct interrupt name for
 bluetooth in Aries
Content-Language: en-US
To:     Jonathan Bakker <xc-racer2@live.ca>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220323150311.26699-1-xc-racer2@live.ca>
 <CY4PR04MB0567DC7336ECABC67A1EC78ECB189@CY4PR04MB0567.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB0567DC7336ECABC67A1EC78ECB189@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 16:03, Jonathan Bakker wrote:
> Correct the name of the bluetooth interrupt from host-wake to
> host-wakeup.
> 
> Fixes: 1c65b6184441b

Incorrect tag.

Best regards,
Krzysztof
