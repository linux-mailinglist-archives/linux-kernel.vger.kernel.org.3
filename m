Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A525222EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348288AbiEJRmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbiEJRmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:42:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF066668B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:38:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u3so24818381wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZZMSgeH50EgZ2k2CW9lxM/Z3t0UYa8S+CXFtKaa9+OI=;
        b=cnCBj0bGQFR5XYbDWXn0VlW306SuJCKc7MGdSWpl7NR783sSAeQ1WTW7RNtiRazkQl
         yCjh1YUcnuogZEkVuwkgximSRoU6hD56sVsrxBLE3h2W/8RHz2F6LIcsGpkhILIRE+tf
         OelGPH5OGxf7zoIbxVHqfndGpTMPxhd4Xl34XdQMY1d3Fkh59mcPKwWSaiEbN/17rqAg
         J+GzjbB5PsHd2Xp1pLE1otBR2asi6OTMLfPN79fxPM7H9THW9R9K9VSOFFkLYhRoTu6f
         99d+5uiCDLwEFjUgFh2a/5Nc1aW4i1JgTjY3J8v7xHTh/2xczWPN7T7wntYfu4XUEXa6
         /Knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZZMSgeH50EgZ2k2CW9lxM/Z3t0UYa8S+CXFtKaa9+OI=;
        b=Lv1kd8QhqbmmustPxfuSvwRygwy/kvR3Q57c3/hWPbGDbdKv2odArAhSMifo+gEbv1
         zECDCg3GuqNn826Ca+cnN8axfgmX4c94t+Rpe8b2ExL+Rt6CIU2hw8HZsmNtKZ+UWKXP
         a+9zSR7tsbGcVMIshD5CE/DbSRIZzKY/0WiU/912J/3p98ttz657s5kE5M2+5ED2yzcx
         BSqOCWDCSfPePScIIdYdzsYmr2GXrGKdSqnDvQGc0DAO+LwTwA/DCdbkul7DwGS9NiyU
         qo8rdYIOdC4RHSEMUC8laf24g5TcTPCXXLvZ+HEXibySv/I+8tKpbWGU5GDsvNm/GsKM
         /mxg==
X-Gm-Message-State: AOAM532iVzMp7uaYIcyQRoUETm8kLBID1yqdhkT99Jvlgs3Fgqhffc14
        +1/hH/Z2pB/PnYCB+pxBWJI/Qg==
X-Google-Smtp-Source: ABdhPJxtGfvXTi8r9vPKDMdTNxnGRRp4Om2umX7iejByqOHJISwdnTIoxYwzFrqbbehOzo/+LkP0uA==
X-Received: by 2002:a5d:4401:0:b0:20a:d6e8:2c0e with SMTP id z1-20020a5d4401000000b0020ad6e82c0emr19463097wrq.168.1652204284966;
        Tue, 10 May 2022 10:38:04 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d67ca000000b0020c5253d8cfsm17271569wrw.27.2022.05.10.10.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 10:38:04 -0700 (PDT)
Message-ID: <76e12c64-9e87-d407-0676-3fa2955c3680@linaro.org>
Date:   Tue, 10 May 2022 19:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 4/4] thermal: k3_j72xx_bandgap: Add the bandgap driver
 support
Content-Language: en-US
To:     "J, KEERTHY" <j-keerthy@ti.com>, robh+dt@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, kristo@kernel.org,
        vigneshr@ti.com, krzysztof.kozlowski@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427064635.24898-1-j-keerthy@ti.com>
 <20220427064635.24898-5-j-keerthy@ti.com>
 <78a3cc4d-8ce4-0dae-2f4e-7522a0a3aa0b@ti.com>
 <d94ea6b0-e138-951d-5405-375255104adb@linaro.org>
 <ffafc50e-9adb-9d66-3d1f-4ebc9f91f47d@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ffafc50e-9adb-9d66-3d1f-4ebc9f91f47d@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 19:17, J, KEERTHY wrote:
> 

[ ... ]

> Hi Daniel,
> 
> Patch 1 & 4 i.e Documentation patch and driver patch can be picked by 
> you. I believe Vignesh will take the dts patches.

Will you send a V7 with Krzysztof comments fixed ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
