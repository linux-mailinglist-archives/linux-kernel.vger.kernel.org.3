Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6915A9153
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiIAH41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIAH4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:56:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5847DC22BB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:56:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bx38so16998789ljb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=r8eeyBUz/AejyYcfK9aDruO5TFd1r/0aWMzRXUi01rA=;
        b=Qtph0lOE/qbpWfkG8HO7vELfP8Rw1uUguP0CrXIrkXL16FdDT/XQadqIBIOTDN1Lxe
         9sngKQPoFyKpMk0O+N3quz2IZpbswTuW8aVFYTYT1qVP+OeVDuOIqpf06tygeBEFVU4+
         6zBmQRIgSBc+5tgEHNmoaqTG6j1EikX6hORXR7HZIrDRNbMnNzO9PN+0twaVEI5+nkGu
         TxRZNtODuRjaO+Hw6RZEb9oUu7nYJga8Py08MOmCJYIWEmMTQJISiaaz4rGTfrQuXa+2
         XWLgaOzwDzFUtjpqWr5bB+Cjz8O7BV72B/5R1UDx72Esh/RJjfUq6ESyKLXR0NKda7n1
         74Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=r8eeyBUz/AejyYcfK9aDruO5TFd1r/0aWMzRXUi01rA=;
        b=x6gNot4lmW+HZJwcCp8TsSBNeFBsv4yxSshGyQ2niTwfS+YnQv508iaeTvPZTC/K/X
         73BgcJAFuKzLxqaseIemRjfZ7t8PABb3q/omVp++ngEBPUgcY4oioG05licSoGOYkBrm
         hynfmg6pXp9MZ0kuXzyRSgleQ1rHpD4TqRjEmubEABSk+79IVAVfcMM5/UJQjhpmjyoj
         tbwMY8Z9cEssfPl34Q4lJqKvadiQ4DTPvLFcyRHu4nSoQZWIgviCkfn199eVI4NM2ahK
         9OruubulBPKzBT7TJCMfxWBR9Kyeg+Vj1NXYLjHwNQ21I+cMxzr0eU6oeQgb7M66YpEo
         8HsQ==
X-Gm-Message-State: ACgBeo3pvvxtM4HxDRPWGFrdMI0HiIw9lMkyvrSVlnqKbpFkaQEhSYxk
        Vn0XypnEVlsu/2Em1pxB0mEZxQ==
X-Google-Smtp-Source: AA6agR7nX/X8aC54yXCn5glhEfcjq587P8aXcd+d9X6kHSUljHmf4I9rbPjvsR36jIJPljXf/DS4Dw==
X-Received: by 2002:a2e:9942:0:b0:265:e313:7fb7 with SMTP id r2-20020a2e9942000000b00265e3137fb7mr4534739ljj.449.1662018980742;
        Thu, 01 Sep 2022 00:56:20 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c22-20020a056512325600b0049496855494sm377446lfr.104.2022.09.01.00.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:56:20 -0700 (PDT)
Message-ID: <6b06f88e-128d-7ce6-b97b-b5cacfc4834d@linaro.org>
Date:   Thu, 1 Sep 2022 10:56:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: spi-nor: Add reset-gpios
 property
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
        git@amd.com
References: <20220901072914.30205-1-sai.krishna.potthuri@amd.com>
 <20220901072914.30205-2-sai.krishna.potthuri@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901072914.30205-2-sai.krishna.potthuri@amd.com>
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

On 01/09/2022 10:29, Sai Krishna Potthuri wrote:
> SPI-NOR flashes have RESET pin which can be toggled using GPIO
> controller, for those platforms reset-gpios property can be used to
> reset the flash device.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---

You still miss the user (DTS) of this change... The JEDEC spec did not
mention a reset pin. Can you provide the user?

Best regards,
Krzysztof
