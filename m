Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB12554DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358786AbiFVOut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358577AbiFVOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:50:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9BD3ED1F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:50:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id cw10so11048393ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=4ruOCvOAEmoUdLQh3ey+6bqLOiu0xvMxMCbpqmFwoUs=;
        b=OeRxIzd9nZ8EWPSu2aJ+6lZbW+Xi4a9NtmKfcgCKy5B6154b1lDVK2X5LPN5OeHUmw
         tziY4sYx0rxsyzjYxrVVQGbqA9vvTXX+BuOm9rfpQ9IEC6o/SxhSMHIoYJ5zmBDDuUlt
         EIpobCAJzDoHRl3NFi3ruf2oBMBdE7Hcy0WMmCzem1tA8mQEoLQou/qNMoGJ2aSW9tZO
         Hu/Y5hDY52yHVscaQ11xjQBky2kKgJ+YNNhIEGnVJhdm/fA+rKHc/DY4Q8/SWJ1b27zp
         Ds9XgtQAa+fG9EqmkBiAI1QYJNfTB5Fv/XbTsMd6ftjpLGILbYFBukc33k+aN2NyrrJY
         4FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4ruOCvOAEmoUdLQh3ey+6bqLOiu0xvMxMCbpqmFwoUs=;
        b=vFecpzkdjkNIkdGcKBAGHFvzTn7McwvkwzGqX+nqlk3rYVROmC5VrIXJBKzv9LITCE
         hC3Cpzzjk0ptENVejvh9PI4Ke5EIzMGql9iGu0pmoGRW+f5V5MfebFVqdShkoHXIb8A3
         upRK6rxYXEX7C7sZcK7KbGIazM79wQ4F2nmDc9Ffr7IE/hZMhO1ugltaAjag0bPmQqA5
         i1/KSecGvUdVyUaGlug4NB1IrQAEohDkzBC4yFZSWRusVeIbBLayxdPjnc17HU26D6HA
         qNX0kT2CB/ybHJYdoHX8Vq5KqGl/+4/rDRdtdNcA0HsXrB8LboxABHDB/wOBFmJPh2u6
         Wbsg==
X-Gm-Message-State: AJIora/EvediXMdGLSEfwrfFTI93ze17PpaG9/RFy7EOnBTeymmrYVwD
        tDr9fMOsmB132Ax0hIShp3NxbA==
X-Google-Smtp-Source: AGRyM1vteyKfwtr5E534VzKDwjdk2afkiq/TExdKehpSTsXQorJLF3v9ubUmlBNqNQXVQB2pHcH3SQ==
X-Received: by 2002:a17:906:3f09:b0:712:466:e04a with SMTP id c9-20020a1709063f0900b007120466e04amr3388409ejj.719.1655909405491;
        Wed, 22 Jun 2022 07:50:05 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0070abf371274sm9396702ejg.136.2022.06.22.07.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:50:05 -0700 (PDT)
Message-ID: <349ba57a-87c4-b49f-aca5-7d62d55068d5@linaro.org>
Date:   Wed, 22 Jun 2022 16:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/3] scsi: ufs: minor cleanups
Content-Language: en-US
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20220613100655.105301-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613100655.105301-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2022 12:06, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v2
> ================
> 1. More whitespace cleanups.
> 
> Changes since v1
> ================
> 1. Drop patch 1 (needs further work).
> 2. Rebase on current linux-next (including Bart Van Assche's work).
> 
> v1: https://lore.kernel.org/all/20220408103027.311624-1-krzysztof.kozlowski@linaro.org/
> 

Hi folks,

Any comments? Patches are BTW independent, so the UFS one can be applied
separately.

Best regards,
Krzysztof
