Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A5156A7F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiGGQXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiGGQXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:23:38 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061E229CA7;
        Thu,  7 Jul 2022 09:23:38 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c20so1196354qtw.8;
        Thu, 07 Jul 2022 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wsBPE796eb8NL5VRhVyD8CHurCZ3qut91uNmEDcRsO8=;
        b=A+nLbCPOPmoKxMbA5RoBxFjo24RspE0Aavh10Ja/2hX3R7KMHP0RBEAN4xNg+YPMzH
         jU5Vh7jWaZvqGJSSqte4/lRVFXdE0BS/2X6w4exmSWceM1d+lRiedSobtVnt2IblFWvq
         cwCWhqHJHfVu6hngvNTOYuwoiVhKU+GGrEzRNhVB1Mr131KTWd61OOkB3AvBJLMZwG51
         O2+rRh+nAneXZv8uoYaSHM60iFz9uS+7dRj1Qf2UNYRoyILqlc/HvEmw9QrcTyZvTFFa
         8lMyZB5XFS0JyyGx7aYtC9AwQGrA14QzjvfV0UciN2NJZ9ScrYn5X2x/Bh2+PQ0KvjnU
         VTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wsBPE796eb8NL5VRhVyD8CHurCZ3qut91uNmEDcRsO8=;
        b=5OM/I7B5iqKq+jUwJ/nxGgnVfbDp/VLrDo5X5oYe6UF9wFeVK0pqWImfH8UkMpqYja
         Bg72CLX4/66TfKGiPicq/1noG5c+WRPmv9bmMupvnDnYCrcc++fYjxNwKGutOpyC6hDG
         eK+6pYz22Vu2l1MO88ny6CkzZro8oEA1vwlOlzrFdjaOHv1s75sNH74hDxqk09Gc8hfZ
         GAHYz4hj7sNWp3BZUa+OTNy/XYx9bhQGUHo1TI9oMbbRShXVye972nZ3PP6VJXYMGHR7
         3qBgqgw66WQbn7NexVEfJAGCUws3Cm6zZN/BZfhqohr5SC5relNzAc5nJhmefHLrhmYN
         hhKw==
X-Gm-Message-State: AJIora8Znn8owitahVuD17WoF4cGFH82ilZMU4nUqeO1mCsR4N+ymmz2
        vG4xpmbbw6GvYcKUDCgLDkcgmQrysI4=
X-Google-Smtp-Source: AGRyM1tm5paGI1p1tPe9Ec0ZIudHLQx0onWlZ8QfnEXD20KCRjNu7ImEQi9DyyLcuVEp0rTvmkr+Pg==
X-Received: by 2002:ac8:5b0d:0:b0:31d:3b6f:969b with SMTP id m13-20020ac85b0d000000b0031d3b6f969bmr27258618qtw.84.1657211017058;
        Thu, 07 Jul 2022 09:23:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y17-20020a05620a25d100b006a6a5d1e240sm35712952qko.34.2022.07.07.09.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 09:23:36 -0700 (PDT)
Message-ID: <f14b59fb-c02f-cd59-3c92-cb4def7ad601@gmail.com>
Date:   Thu, 7 Jul 2022 09:23:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH 3/8] hwrng: bcm2835: bcmbca: Replace ARCH_BCM_63XX
 with ARCH_BCMBCA
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, Andre Przywara <andre.przywara@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-3-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220707065800.261269-3-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/6/22 23:57, William Zhang wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> HW_RANDOM_BCM2835 depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

There is no cover letter for this 8 patch series :/ it is not clear to 
me whether each subsystem maintainer will be in a posotion to merge 
these patches individually, yet still have all 8 (7 of them actually, 
see comment to patch 1) land in 5.20.

Alternatively, we can merge these patches through the Broadcom ARM SoC 
pull request(s) to ensure they all land at the same time.
-- 
Florian
