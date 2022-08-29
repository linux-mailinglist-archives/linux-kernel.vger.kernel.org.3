Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21E5A54D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiH2TyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiH2TyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:54:06 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901F38287C;
        Mon, 29 Aug 2022 12:54:05 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11c4d7d4683so11754552fac.8;
        Mon, 29 Aug 2022 12:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=V7u+Bh9RpSlaYJuPHwhUdmvGa0EBqCLrlN332Ycl1Pc=;
        b=J7sHkwyowc4ZyMpR82OHKXOsOuerrsJ5O8n8RRmfycGgCS6JyVS1p5+Wlmc1s/aJuV
         61Wo1vfBxiOvb4vbfYyOqGNjjlHfqqiKypsAIsTvQxlXzSqPVYB6yvqautcw7eJ7z/Vp
         YLvlSRP9FHZUuaIibu60DYtJ96cGgV+KZjeJLE4g2xm8i+ZgqfmzlU80OtV+McPohbsP
         imJBSXOFjhxANW3se7mnIap5wlc6AGIGA709VwiR2ta1s40Y3bcnKSMbISh6om3km7Ol
         LjPey71DSnH9shK8WMxwd9MWauTW3GKELf4M+rWMIseEyg/T/lyivknpPDb7ISeBrLEa
         pNtQ==
X-Gm-Message-State: ACgBeo14KSKiPWAkAakWOIW9HT71u9DintZm+8kev0XPxIokfxR0K1BW
        5AA4QwgC+L6tvuIXe/LZM0xf386vOA==
X-Google-Smtp-Source: AA6agR78KtmMgJ+uUQLn+hXNfUXmQ3ezT1EjeM7ZMnQtrI9HbezgSzrt6/Pv05xZgGUy/Vh7E7lVkQ==
X-Received: by 2002:a05:6870:ec94:b0:11e:c890:64b8 with SMTP id eo20-20020a056870ec9400b0011ec89064b8mr5049422oab.14.1661802844464;
        Mon, 29 Aug 2022 12:54:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v188-20020acadec5000000b00342eade43d4sm5226612oig.13.2022.08.29.12.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:54:04 -0700 (PDT)
Received: (nullmailer pid 2307888 invoked by uid 1000);
        Mon, 29 Aug 2022 19:54:03 -0000
Date:   Mon, 29 Aug 2022 14:54:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: samsung_uart: drop ref from
 reg-io-width
Message-ID: <20220829195403.GA2307840-robh@kernel.org>
References: <20220823101000.386927-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823101000.386927-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 13:10:00 +0300, Krzysztof Kozlowski wrote:
> reg-io-width is a standard property, so no need for defining its type
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
