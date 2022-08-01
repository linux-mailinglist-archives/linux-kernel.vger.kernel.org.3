Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518A586DC9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiHAPcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiHAPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:32:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C3C2CE01;
        Mon,  1 Aug 2022 08:31:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g12so10946138pfb.3;
        Mon, 01 Aug 2022 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+t9xOKmSs2XYTpGqxptgbdUnCvcEvsa6fv2+DNKaMdg=;
        b=d3DaonaGmoxMrTXLcyAkmvwXcAwurkWkaYZROH10MidO45k74LXTZulxTau6sJ+dnR
         2jYuz/jHv6HthT+WL6y4If4LTg0y3XPa+T29rqjT0kIrF5n9q9sFSnlyLspsuDiZSwcZ
         S242WgepOwkjB56dwDYAA7rICuudPFAy87XGDOAPjQB6x0EUsBrqTSOKto+lRsDgxtOh
         56zYVZVBxd6zCZERCLX1JphlSHO22sKZHapxpC8Pvmkr+kMtPURzqmeVHJb+JoTrGjFG
         ePZoC2lNORQ3rpSab6lhKZbmzkanq/wg0dJVV5Y4DD3Sba7KyRGNXZieTA6Lh4nmN2dB
         Lg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+t9xOKmSs2XYTpGqxptgbdUnCvcEvsa6fv2+DNKaMdg=;
        b=2QpS1W1PPeVQcDyyOBpyB2OQBze0DwW40Pm3wECbMNZLSnok8wxfhI6vLDTZGs3Mv/
         GXOq+HCalbiISfRNJidGNHVpyDtvwAahp6NhkxjBpyQm6FGbngzoQvjpEM5IZXtDqce1
         yQWwcGKFhH3PE+gOBXhE4kZJtmu0OrEFWz1bIgjjivvMI5jmSASptvc4q3XxPBgnfJma
         Ab1L1t57+wB5pzttEFeFXodnRbzledGg7GzZ6CgOkc1gHlIb7TUwhGrKSa84ohffjMjR
         OKpkr4w7+2+5myG16JrV2CgLNWCFS/ki+LXRiL0WHu6HnYO7GRepGD+vgQDjtY5g6Zup
         6Paw==
X-Gm-Message-State: ACgBeo3G8czkBogDGgqPWN+6au34R0eytiCLo18LVTYDyuQh5ZCOHm2k
        UzJI62RQ1qx7N82GVPgVvck=
X-Google-Smtp-Source: AA6agR4j4q8wx/jpkk4vvM9du61PDM81uCFhuAj4x+7aZO9ZUez3izBXkUmFDcuvaePWiKVZ2uSjfQ==
X-Received: by 2002:a63:d652:0:b0:41c:45e9:abee with SMTP id d18-20020a63d652000000b0041c45e9abeemr1684077pgj.110.1659367917660;
        Mon, 01 Aug 2022 08:31:57 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902d2c800b0016ed52b79besm5153838plc.271.2022.08.01.08.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 08:31:57 -0700 (PDT)
Message-ID: <166f2a6f-7608-d0a1-a316-8885295e3900@gmail.com>
Date:   Mon, 1 Aug 2022 08:31:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 1/4] ARM: dts: bcmbca: fix arch timer node cpu mask flag
 value
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        kursad.oney@broadcom.com, dan.beygelman@broadcom.com,
        f.fainelli@gmail.com, anand.gore@broadcom.com,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220729015029.14863-1-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220729015029.14863-1-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On 7/28/2022 6:50 PM, William Zhang wrote:
> The cpu mask flag value should match the number of cpu cores in the
> chip. Correct the value accordingly for BCM63178, BCM6846 and BCM6878.
> 
> Fixes: fc85b7e64acb ("ARM: dts: add dts files for bcmbca soc 63178")
> Fixes: de1a99ac0b64 ("ARM: dts: Add DTS files for bcmbca SoC BCM6846")
> Fixes: 6bcad714e173 ("ARM: dts: Add DTS files for bcmbca SoC BCM6878")
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

This looks fine, if you could split one patch per file you modify that 
would look a bit better, this is particularly relevant for bug fixes so 
if you can split patch 1 into 3, patch 2 into 2 and patch 3 into 2 that 
would be great. Patch 4 can be taken as is since it is sort of a 
bca-wide cleanup.

Right now all of those changes went into the same release cycle, but in 
the future that might not be the case.

Thank you!
-- 
Florian
