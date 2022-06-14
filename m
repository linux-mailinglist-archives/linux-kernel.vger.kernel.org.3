Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797A154BD83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbiFNWQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiFNWQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:16:00 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C3B517E2;
        Tue, 14 Jun 2022 15:15:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g186so9754419pgc.1;
        Tue, 14 Jun 2022 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mOOADoNR4DGuoQaFlilbRe0jU293y9VGdZpvVpe1nsA=;
        b=NmmbxmbbOprX/zSFCrUhOCZ824//g4cTKYTWXdumeNdjKtc3kP9EIaX9tvxY8TYw2U
         JPxjX2JaRhH/scb7G35UXH0cFJqEbt2KLB2bfc3S5HX8zzIzLwjG3imNzV5n0/nsjuSx
         6ioHIUNTwdPlwE8fMmps8Xo2y3mbBgvYLtyP7P//uIZJ3wj7ywjfk3Rs2y3bwG9buVs9
         TDKxCHE/t0DbLbU/56O4nluba5SYAXTh7jzsdsCMmY4PgTqB3fiv6hKxCFpoE+d5Mjp4
         TpcMUHM2XevLydjJ5O0Rz8CoCu6gSmkeTvZVvT6z4aJAGppdDdjA8bFm1ifWozLpFoBx
         wj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mOOADoNR4DGuoQaFlilbRe0jU293y9VGdZpvVpe1nsA=;
        b=GthXSmflUqOXMOnkRIxmCrq6dEUEHWM3m1z88HjqWL+pA6CZoUUXiA6VlFLspQSnwJ
         VotPD3w55OUSI9ThxSkuufCO84ekHTQvudCQWQmFaaqIdmmm/wYEgtEeo9p2qPjYF7do
         BY0SRW9x0FzC5KddUd/hKOc+JrY1PPJ7QZ5+TAdgpUxfYE8KUCwnVGl2ahWHo2kGLGB0
         heHBsFuSQA9EfMcYj3Fh6Pyq2Tr3zAzQCdggHTuM+iZhtSe3RJxB5SUQDFOtHbPsOm05
         5AfjWUhqn+AD8/6GJiwCnLE9ceJ3Tz0CRlmXJreNAb9lJqOc8dnScx3f6kf6C7H6FI8c
         04hw==
X-Gm-Message-State: AOAM532xQeSkPeNUKZR/1gaEwoq87avFRF+1rQKddhw2gDK5JWas7wS6
        2SyZgSXXOkzWuFlf76rupQXwqim4Vf4=
X-Google-Smtp-Source: ABdhPJxBT3OLZvYSExo4h5ZIxGMiHDgXBtxJ1wy/zhk6MQtacPPBseSWOv99BhnkqXyRrU2yma//Yg==
X-Received: by 2002:a63:f156:0:b0:3ab:ada6:b463 with SMTP id o22-20020a63f156000000b003abada6b463mr6129114pgk.462.1655244956232;
        Tue, 14 Jun 2022 15:15:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h30-20020aa79f5e000000b00519cfca8e30sm8089435pfr.209.2022.06.14.15.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 15:15:55 -0700 (PDT)
Message-ID: <8b676d6a-2f6b-1906-a41e-9c1dd5288534@gmail.com>
Date:   Tue, 14 Jun 2022 15:15:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 05/23] dt-bindings: ata: sata-brcm: Apply common AHCI
 schema
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-6-Sergey.Semin@baikalelectronics.ru>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220610081801.11854-6-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 01:17, Serge Semin wrote:
> The Broadcom SATA controller is obviously based on the AHCI standard. The
> device driver uses the kernel AHCI library to work with it. Therefore we
> can be have a more thorough DT-bindings evaluation by referring to the
> AHCI-common schema instead of using the more relaxed SATA-common one.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
