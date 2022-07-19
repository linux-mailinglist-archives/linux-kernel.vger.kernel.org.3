Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8D4579A08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiGSMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbiGSMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:08:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943250056
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:01:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q7so17064144lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=13/NnKJpd70PTMK9kZ5dgVlJtFfN05EcbVDMd8GoMwc=;
        b=AQB/kKBsayBytIdgmCx2efH5Juv9bq4q7qm5bzTtUfE6puwvo1ohA1wNqzdlF8r66J
         a/8WpcwcCf/N2Dyk6nVGYeVkEI2BaZ0tYaznmGII5dugznQumSh2cGUvmI0gNJySbBi5
         4RK+LgQFVUlr55QBFLaMxRS6OgaFP+ENi9EEa25I/baHPw/zh3ajHKYfkdatxBipzRiH
         QfLOjPMXD7TFk35Hd/4frr0Bt97egyT+HXsIyE1yghotyOKnuDlXN8vgWWx6+youUhIM
         3ym5iXakYlwBuIvvb+mI91bHTvg+8NIpncyz2KUH2LTG97FdmgruBl8lgGp/93AeTj/3
         H9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=13/NnKJpd70PTMK9kZ5dgVlJtFfN05EcbVDMd8GoMwc=;
        b=O87p7GLHyyGtFpIRbBpPjhh7hdpuNYMyonHALZhceY1rjkGOLWrA55lj1NeGsXX27t
         Iwx3VbSivVkIZKu7uHM0Nf7Ts8xrOBpwD5zLCQDzULnFn58JpYa2IPSm55oVmwJu5LYW
         745NhN7WBnbKKVZZd6l1w6+kN8NvNVztverEaLkUaBWtweQfqjATN9u9Zmly74ngvBfN
         XXlXRB/MSnthqQ9/5t7NpmWJHPaT2EjzcO6XeE14/VIzD5ZgUpVaLB/QOWs3LL4EbIZ9
         kjWVF+t3fkeid4HpOPh85HGjWkMDeo1A7cbDEY7Ix63M8D+j89rgfZPcQrEi3Y0xGuxL
         cMQg==
X-Gm-Message-State: AJIora9FTHp/UOXRNHqoucOiK1qfBClzIxsAAulm45xwkFjBl317sisd
        oggtUfyjHlIHyXGKZvV9mA8PKA==
X-Google-Smtp-Source: AGRyM1vuiI5amreRlAA+TpAg7fM7AHTqjdGNjhtrNKbV4bs1XaM+u0ph9q8O+RdiGl58rkIUZAaIOg==
X-Received: by 2002:a2e:9849:0:b0:25d:63f7:ce3b with SMTP id e9-20020a2e9849000000b0025d63f7ce3bmr14095035ljj.427.1658232115658;
        Tue, 19 Jul 2022 05:01:55 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id u14-20020a19790e000000b0047fab4c3651sm3180289lfc.85.2022.07.19.05.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 05:01:54 -0700 (PDT)
Message-ID: <3ac8f0cb-492e-968e-1b74-ead3e40478e3@linaro.org>
Date:   Tue, 19 Jul 2022 14:01:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Question: regmap_field_write() - why using update?
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e759045a-bc01-c194-35ad-42b534ccaa01@linaro.org>
 <YtAxK1lIooDmdVBP@sirena.org.uk>
 <14b0e150-511c-867a-281a-1d13e7e318e8@linaro.org>
 <277e0484-60bd-7405-4cd1-acf0a03ef195@linaro.org>
 <YtBgEreCVZyD0kwb@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YtBgEreCVZyD0kwb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 20:27, Mark Brown wrote:
> The write only registers are a good point - we could handle them through
> special casing, that'd avoid any overhead from reading or issues if a
> physical read happens to return something unfortunate for some reason.

I have something ready and I will send it soon.

> Now I think about it there's also the fun case of registers which don't
> have symmetric read and write, though at some point regmap_field does
> stop being useful and those might well be pushing it.

Right.

Best regards,
Krzysztof
