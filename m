Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5473B568EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiGFQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiGFQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:13:27 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4153AF;
        Wed,  6 Jul 2022 09:13:26 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id p128so14460184iof.1;
        Wed, 06 Jul 2022 09:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TvrtBUF3QCSk1zMA7Dk12dzB8jZO0FszbYgfQoyxdZg=;
        b=zrPw+4sJvBBRMWD3HdCEUepvFdghbwxN8NZwamTQ5ylShVLNIAxrFLpo34eTXH8kwE
         JnxAticURA5Mwq73usg92imGVd6mvNL4V11Q2yaR1WvlraxOBZ8d16Gls4QmbYgjpYXm
         jikU9NxGY9QMDChfZL0tPStk1+wcX2msEn345UL3+dkIHWZz+zUz4kUUJJ9dj2Z8JI04
         9rrL6pMOLFlr9drCChRvdyQaMI5hqN4JmuF5Vs6VNwZ5JlhwUR7mMiWf1JTbMsN6PRHr
         TF9reTlp3RV8nWzDzn5z9S5GILuu/2o1RI7xW6yHp+pmVkUVZV/gU2mkslTvFsaatyb0
         Ogdw==
X-Gm-Message-State: AJIora+rj0YP+RFH4ihIE/3Z3BMraczFhfu5K5vW8A1UKmuub2UFsiEB
        5lu9yJsK6Hr1/N+FK7SoQQ==
X-Google-Smtp-Source: AGRyM1vBtpYxC3SUwaxTGvXOV5v1/bmL0O3/t3lMZhg+53gxeih+OnIt/Wdk0ksZ1XWBJ/178iMCow==
X-Received: by 2002:a6b:7845:0:b0:64c:9acc:9f1a with SMTP id h5-20020a6b7845000000b0064c9acc9f1amr22309984iop.103.1657124005646;
        Wed, 06 Jul 2022 09:13:25 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j25-20020a02a699000000b00339c33df66bsm16050036jam.118.2022.07.06.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:13:25 -0700 (PDT)
Received: (nullmailer pid 140225 invoked by uid 1000);
        Wed, 06 Jul 2022 16:13:23 -0000
Date:   Wed, 6 Jul 2022 10:13:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Aurelien Jarno <aurelien@aurel32.net>,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <davidlt@rivosinc.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen L Arnold <nerdboy@gentoo.org>,
        Bin Meng <bin.meng@windriver.com>,
        linux-riscv@lists.infradead.org, linux-leds@vger.kernel.org,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        devicetree@vger.kernel.org,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ron Economos <w6rz@comcast.net>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: leds: pwm-multicolor: Add active-low
 property
Message-ID: <20220706161323.GA140190-robh@kernel.org>
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
 <20220705210143.315151-3-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705210143.315151-3-emil.renner.berthing@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jul 2022 23:01:41 +0200, Emil Renner Berthing wrote:
> Add the active-low property to LEDs that are part of a multicolor LED
> just like the regular PWM LEDs have.
> 
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  .../devicetree/bindings/leds/leds-pwm-multicolor.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
