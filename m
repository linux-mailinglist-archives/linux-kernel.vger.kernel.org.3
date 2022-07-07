Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B019856A806
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiGGQZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiGGQZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:25:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7328F31374;
        Thu,  7 Jul 2022 09:25:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g126so5992370pfb.3;
        Thu, 07 Jul 2022 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H4RZAcIlnem+IGqTUKKTJ3dC19pLxBxcc0bb23if6uo=;
        b=Hbhk0sPfiQ0kdyFpDtQ8ohlraEKNwHgjJW1TFqY3F5HK9oyi0kUsyFZNFAH1VulXqj
         im4Eg0fhJUb4r6ZMm1T1PBqICsIXE/KYP8AJS5FKl1D6KfI1rpdto9RgVuyKcF1PKGdS
         TeDziZ7nLCx8mf8hmu8jho5Hy+N1pUEkxFK8sbLcr9LY9Zkn7dFvs+Kw3gXZ525y/5GP
         kg1PDbWyWdLrw0AfyrhDouv/RKgBAXjKzCClGVLIFcpDPoY7wGTvbTESkXD9DShNu8y3
         ioRucrPCoszQ5oazaxyL+bO8KhaTVsBMX0V2wm3dgWnSNvnNVWmxzLQsZ84VQg+s4U3v
         FXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H4RZAcIlnem+IGqTUKKTJ3dC19pLxBxcc0bb23if6uo=;
        b=1Qt5Dmt+/8N/knB/WaNlLzBlAs515GEy1mxYNtR+FdGT/R38G00so16Y4qivTbO5Og
         dZULVEJVcGfP3K4NR7Kf9hS2kytj917a/mK7qRr/i7L6z8Jw9VDcW1V+VPvZgtz8r/06
         OrEegak2CVNmOuV8RAmyl/sZ7DfDLv8HWg0F5EcLrqlRA/CHnfOWSRKj6Dkh7D9Hna/+
         gQX5mHkFpCEdztVGZ+7kgKDHprCCP8JwYqE+BjYhFZXw8I8eRYJNBfygx+fG7ncF5pEi
         y99HSy9j9aqOffZgtob3tIGCwLPbFB3Wvg3DnilLEsfP3btkUd830pXX3tsBWdAvOO5B
         E2Bg==
X-Gm-Message-State: AJIora9lnwNqKn7zV0ndOfILrzq52gbOHyUAzgD/2It0UNNAoq0efgRf
        mEn1zFjPna+mbsZVL6HQWF0=
X-Google-Smtp-Source: AGRyM1vmXgOpYdzSElFrhzsiePi0U0HxRsB+KliiIT0vEyVgAnCMYQNQXniSZltXp7mS8rNqCidY9g==
X-Received: by 2002:a17:902:ba90:b0:16a:2863:fb85 with SMTP id k16-20020a170902ba9000b0016a2863fb85mr54065550pls.15.1657211151921;
        Thu, 07 Jul 2022 09:25:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 19-20020a170902e9d300b0016bfdcb34d4sm4479735plk.152.2022.07.07.09.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 09:25:51 -0700 (PDT)
Message-ID: <0b5fef8c-b42f-ad42-03e1-e50fe286ed9d@gmail.com>
Date:   Thu, 7 Jul 2022 09:25:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH 7/8] spi: bcm63xx-hsspi: bcmbca: Replace
 ARCH_BCM_63XX with ARCH_BCMBCA
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-7-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220707065800.261269-7-william.zhang@broadcom.com>
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
> SPI_BCM63XX_HSSPI depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

There is no cover letter for this 8 patch series :/ it is not clear to 
me whether each subsystem maintainer will be in a position to merge 
these patches individually, yet still have all 8 (7 of them actually, 
see comment to patch 1) land in 5.20.

Alternatively, we can merge these patches through the Broadcom ARM SoC 
pull request(s) to ensure they all land at the same time.
-- 
Florian
