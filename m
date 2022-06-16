Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA2154E68F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiFPQAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377818AbiFPQAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:00:37 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159044477D;
        Thu, 16 Jun 2022 09:00:36 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id q11so1913782iod.8;
        Thu, 16 Jun 2022 09:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k8h1U4hPgh2BRfxurg7hGh/LZsiqV8Y2F6zGtf6ny+o=;
        b=5RG3nlR7WC+RPi15BRORMiobbE5B/ZNM8xyz1EfCUqODgTvuqbREuWk3eL66kvzcnC
         vy0i74HNoe/GGMaslPLWkmoDoikl2caNzzW0aBjBVXVuU9b17jDxRnMCtfCbqoXrUNiN
         bopGkSiwVBGKdBTSCYAipGeBjd5t6E2yRTDZDm5m73hk2xeMqamDoMtFlNw1tf0M7oo0
         chHJwPSPVkG5nIpFC74aU855woB2VsHByrj8+QnclAiQDwhIn3X0CV2vwwk86zizcf1J
         ezUCVaHUPeIlpzeuIBixzTG49hQzmUK/kuFjwPOFkRAFeF70qTF9a8EqqZMyORWMMVBe
         MqBg==
X-Gm-Message-State: AJIora9POalTmFB6aRi7AeWxFBZXKa2Xb5nLDVQmtAL820wqeGD8iosP
        bO4yeeh6BlliB4faiUOorw==
X-Google-Smtp-Source: AGRyM1uJTs4FDZxMRCj45jF2apTlmwONCj0E8OipnKt1Fs2e7QE05ytGmbrjTICQ6Of8TUoYZCr53Q==
X-Received: by 2002:a5d:81d9:0:b0:669:d5b1:3fe0 with SMTP id t25-20020a5d81d9000000b00669d5b13fe0mr2799297iol.214.1655395235356;
        Thu, 16 Jun 2022 09:00:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id h3-20020a056e020d4300b002d3de4c1ecbsm1122162ilj.68.2022.06.16.09.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:00:34 -0700 (PDT)
Received: (nullmailer pid 3555880 invoked by uid 1000);
        Thu, 16 Jun 2022 16:00:33 -0000
Date:   Thu, 16 Jun 2022 10:00:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@atmel.com, alexandre.belloni@bootlin.com,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, eugen.hristev@microchip.com,
        linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        krzk+dt@kernel.org
Subject: Re: [PATCH 12/16] dt-bindings: iio: adc: at91-sama5d2_adc: add id
 for temperature channel
Message-ID: <20220616160033.GA3555795-robh@kernel.org>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
 <20220609083213.1795019-13-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609083213.1795019-13-claudiu.beznea@microchip.com>
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

On Thu, 09 Jun 2022 11:32:09 +0300, Claudiu Beznea wrote:
> Add ID for temperature channel of AT91 SAMA5D2 ADC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  include/dt-bindings/iio/adc/at91-sama5d2_adc.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
