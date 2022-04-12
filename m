Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08E4FDEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbiDLL7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiDLL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:57:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969CB59
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:43:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc2so15897000ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1/pvRvH0oNX+VMdJTF78jyz+TR/9ZtAyKlMuXkFoMFU=;
        b=UUgTJI0HPAlVMcr8MnCFAbme93x3J7V1EX5P78EjdEu1m/N5iM2BAbBhB0EDiwadPF
         nH7MYYHdxoqYvPe29GuiKcIC3v9vHeVxg5FfLU9F+NcsKJRCmVRzVrXEgkyDx1MIJ01e
         XhRZr2uz2j4yqQil4JkEOaUH75/1sGGyy+MeIh+wdrmLO8+7BDEFTZazCEmIwCkK7eYl
         Mm1tm7+uI8x9JpQnSVRo0NUt89h/xTngIIYj5xqHi6nusntYySqeTgvbXn/Qe+6DAH2w
         fpHuhCypwAdMHq9JI0jgl+dqELweHsUiYImOXZIPLMyV2tbzhWaFqHC5tcl1rbP63+HE
         nxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1/pvRvH0oNX+VMdJTF78jyz+TR/9ZtAyKlMuXkFoMFU=;
        b=IeKsXtB+CF5MctimPtGJykS2hqDhwfeYVWnhZPePS1diDy988l1p5Pm8IgTL7hF2xN
         Ti4e0p69aHA0jcE3vT/F6AUumFHwbBEylJcCQwVelrVK6C+qstrcL7qXbx9U3Axzwu7H
         6CtrxPUxysNvwxGVnvYL8dtlz/+G+PgHghN7FV8Gg/diRqURQSzE7+aaSCG6gAJjqxg6
         nAmyP01LqXVKPkADcjrH4V3RHnf6DAnwfemV7KE4UxRIu8g4BOf+TIgNRYnjYL7gA62j
         8dTurZ6WfvsWpRFXgKb5GmIAMuN7iGlR6ThxOKCJoqEbhJRnmt/gGYcQFB3yJqfyl3yV
         r7yQ==
X-Gm-Message-State: AOAM5324BT4v5kPtUNzoc/AU1VQwKjNwFOs5SDsGgjYwAJt/TguemFxR
        pC5z3VLd9L4gikFhNwO8qM0WuQ==
X-Google-Smtp-Source: ABdhPJx+pmlpdD4w/PiUggltHAdxlLW7rFnuX6rPDHwd9tRwZjjiyttwBB9QINBzifKEQ/qKLPICng==
X-Received: by 2002:a17:907:3d87:b0:6e6:f1f3:ba7c with SMTP id he7-20020a1709073d8700b006e6f1f3ba7cmr34138300ejc.128.1649760226431;
        Tue, 12 Apr 2022 03:43:46 -0700 (PDT)
Received: from [192.168.0.194] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709062ecc00b006e8558c9a5csm4865447eji.94.2022.04.12.03.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 03:43:46 -0700 (PDT)
Message-ID: <32b3f189-d284-274b-f238-0e09dc58f8e4@linaro.org>
Date:   Tue, 12 Apr 2022 12:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] ARM: dts: at91: align SPI NOR node name with dtschema
Content-Language: en-US
To:     Tudor.Ambarus@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        Lars.Povlsen@microchip.com, Steen.Hegelund@microchip.com,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220407143223.295344-1-krzysztof.kozlowski@linaro.org>
 <8eb6621b-78ca-e5f9-def9-47809dab9bb4@microchip.com>
 <0c0b19ac-9047-509b-1112-cb25fa00ae22@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0c0b19ac-9047-509b-1112-cb25fa00ae22@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 12:41, Tudor.Ambarus@microchip.com wrote:
>>>
> 
> I've just noticed that there are other node names that can be fixed,
> if you feel like resubmitting:
> arch/arm/boot/dts/at91rm9200ek.dts:				mtd_dataflash@0 {
> arch/arm/boot/dts/at91rm9200ek.dts:		nor_flash@10000000 {
> arch/arm/boot/dts/at91sam9260ek.dts:				mtd_dataflash@1 {
> arch/arm/boot/dts/at91sam9261ek.dts:				mtd_dataflash@0 {
> arch/arm/boot/dts/at91sam9263ek.dts:				mtd_dataflash@0 {
> arch/arm/boot/dts/at91sam9g20ek_common.dtsi:				mtd_dataflash@1 {
> arch/arm/boot/dts/at91sam9m10g45ek.dts:				mtd_dataflash@0 {
> arch/arm/boot/dts/at91sam9rlek.dts:				mtd_dataflash@0 {

These are not the same bindings, but I can fix them as well (separate
patch I guess?).


Best regards,
Krzysztof
