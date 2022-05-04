Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAE4519A51
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbiEDIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbiEDIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:50:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A022B24BE0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:47:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y3so1508781ejo.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QmtWwByo/ZIKuv6qy4yEByVOiPKOIaqS2BZn64y92Q4=;
        b=AL3CjXJc7FL0+ahMAGnCQ7qmyxM+AoFMp+n++syujpzPeLdz3G9e8SumISuj6OAEA0
         mN+gxfyTym9cCFHXVM2ma5gj6lTOqSS9+fFFVIN9K17+VhI/O5XELTfaBERRbjmSI/Nl
         vvObVZ+lE/oHjIPDG5c3kZEYjJQEe1NvGt+HsrQ0Q+6yNj+8se8zRPFmuQGMPF5BpxNO
         +M/mEz0tJP9w1V148yHSRWo5dQEAebdJpQrcp3fpkdmwYxogU+MGAbkl5NmYDLl3m4oe
         Nv5JLzbG6l6Ef2KxCmwdwW2oy1uCKa2pWneGeT1ndmrmk+5OUccDsfooF869KS0AeRi0
         oAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QmtWwByo/ZIKuv6qy4yEByVOiPKOIaqS2BZn64y92Q4=;
        b=HYTYc1wqo7AoCApY4YAUt5SM20n01xtHHdg2kAdYgHRJPPlVUUMCfZbUVkf4+F5Yt7
         ilgDFOXdJdCoJqxY62nybouFEsrp7Nr4JPGC9kYx78B5L6NGlujc9QGa74gT6BP4Xaor
         UjTlDQHBEAFRlzmy82xsOmg99lyEF7OvdO9A9hvSgEykPhkiL8QaCKu2JeTGV3EKneEb
         EnHi5HgbbIMYgvxsEoc0n/eRnQgdP4NZ4Mplaj0G/OqM8GMhG5Y+VOeIhw2rN5MjhWBK
         h3MA8wkS13MSeSvKCl4qXe9JW/YM0It4fdoBowRnjKBAoTwTSSDFbNhheNc/wrhRBzpp
         aTRg==
X-Gm-Message-State: AOAM532MP68JdSKIUCZtwQlBmq5kmLkw4WbD4FQv82Xm5Vu1oS7yGBY8
        PXduxs+fjK/KcVrquN9LgUppnw==
X-Google-Smtp-Source: ABdhPJxKi7C4JKAEzHKaoMX1d2sBQ/HwAm7M6aW+7svbe2ak15MPFJVqHU4FxQsE+k7anyG0Uq+cjQ==
X-Received: by 2002:a17:906:4fc6:b0:6f4:b5c0:aa3f with SMTP id i6-20020a1709064fc600b006f4b5c0aa3fmr2810602ejw.382.1651654035170;
        Wed, 04 May 2022 01:47:15 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b6-20020aa7cd06000000b0042617ba63a9sm8799226edw.51.2022.05.04.01.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 01:47:14 -0700 (PDT)
Message-ID: <38ddc169-7e8d-c8b5-62cb-7fd3de567e91@linaro.org>
Date:   Wed, 4 May 2022 10:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/4] scsi: core: fix white-spaces
Content-Language: en-US
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
 <20220408103027.311624-2-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220408103027.311624-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 12:30, Krzysztof Kozlowski wrote:
> Remove trailing white-spaces and correct mixed-up indentation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/scsi/scsi_debug.c         |  2 +-
>  drivers/scsi/scsi_priv.h          |  4 +--
>  drivers/scsi/scsi_proc.c          | 14 ++++-----
>  drivers/scsi/scsi_scan.c          | 10 +++----
>  drivers/scsi/scsi_sysfs.c         |  4 +--
>  drivers/scsi/scsi_transport_spi.c | 49 +++++++++++++++----------------
>  drivers/scsi/scsicam.c            |  6 ++--
>  include/scsi/scsi_cmnd.h          |  2 +-
>  include/scsi/scsi_device.h        | 10 +++----
>  include/scsi/scsi_host.h          | 13 ++++----
>  include/scsi/scsi_ioctl.h         |  2 +-
>  include/scsi/scsi_transport.h     |  2 +-
>  include/scsi/scsi_transport_spi.h |  2 +-
>  include/scsi/scsicam.h            |  2 +-
>  include/scsi/sg.h                 |  2 +-
>  15 files changed, 61 insertions(+), 63 deletions(-)

Hi folks!

I understand that patch #1 in the series is discussed/needs followup,
but what about patches 2-4? Could you pick them up?

Best regards,
Krzysztof
