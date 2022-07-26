Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3685810A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiGZKAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiGZKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:00:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C56455
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:00:12 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q16so12729284pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mRh/G63uXFb/m/g4glGo/TFB6cAKq2kxka9sd5vTbAQ=;
        b=S8Wxdbx1Zd0XXYo8YtaytgKmdxCAYZuFipvn6aXJz0JTWd6M3o7/Og/HswNPqV1vFw
         OHVi8abn+4FpDdEgKUFgWGH/20AywoQ7YOOoKZiruhKk8nCUOFOSFSqwlK5shPrQ/FSJ
         upZUC1Ic+hy/kTv7s/Q4I74Dp1Vwv8gKTyvtFG9Ll31cDlgqv7q8q30L4peOr9Umw16t
         2ysiHygkPgeC9WRJEns9NHJSKtlM78ldhpjasvdMvdsAbp5YG5zcor7Xp78Xx94oHrCJ
         THSbaOA8GMDwqESH0w/XZRIh/ndeMjFOJhnWreTkI3V05ecmUXQEjVnIYk87KHPuSU88
         Assw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mRh/G63uXFb/m/g4glGo/TFB6cAKq2kxka9sd5vTbAQ=;
        b=unGXnh9Jjies0gh4p+WcxCW2nrf+1J7IyhOw1xkv/+0Sqo1PWqFGxohZVfEj/QXKDT
         NayBPSOy64q1xDxe4uCwawCFAIL3UOLewc56Knzll2nJiynd5HpyYUfZQN36Y9U1Zetg
         0ViMZlXh+aJJAgeoXNMaszoseoFr4zAnTsLUfOcHldTc3Wh4pNVKDzC64HNl/TKGlzig
         tvKmakJ0yDej0l8Na+IR7dW0+cHwN66AV5x+fRMQiSS4Qmr7pTx0phR1TMnethYRLRkX
         ZZ5o2TASXYIdmPcZJsWYZDX2PZwmnmHPZslOZqE66yS46RLpmOt0RrHL5uKARl+R4UCN
         sKhg==
X-Gm-Message-State: AJIora/uvh3oyJvOY2lNNZfP/eUcJyN900/uQEiaHjZK9ZUEZxfm3cV+
        Vs0SJ8PPyCQHG7J7/BBaJ5k=
X-Google-Smtp-Source: AGRyM1s+NXwzdR0/LDg/tPJPyJDNjn4Vi7Pcc9WY2s6aHDWTi7FwEjTnmyNofx0gbWnJkhwY4WrYbw==
X-Received: by 2002:a65:5605:0:b0:419:d863:8d94 with SMTP id l5-20020a655605000000b00419d8638d94mr14196384pgs.359.1658829612415;
        Tue, 26 Jul 2022 03:00:12 -0700 (PDT)
Received: from [192.168.0.10] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e80c00b0016a11b7472csm11054574plg.166.2022.07.26.03.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 03:00:12 -0700 (PDT)
Message-ID: <a37fe861-ee02-f17d-07b4-501ab15ff9a7@gmail.com>
Date:   Tue, 26 Jul 2022 19:00:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/6] mtd: spi-nor: hide jedec_id sysfs attribute if not
 present
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20220513133520.3945820-1-michael@walle.cc>
 <20220513133520.3945820-2-michael@walle.cc>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20220513133520.3945820-2-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/2022 10:35 PM, Michael Walle wrote:
> Some non-jedec compliant flashes (like the Everspin flashes) don't have
> an ID at all. Hide the attribute in this case.
> 
> Fixes: 36ac02286265 ("mtd: spi-nor: add initial sysfs support")
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Best Regards,
Takahiro
