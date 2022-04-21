Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6FD50A234
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389231AbiDUOaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389208AbiDUOaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:02 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF043DA46;
        Thu, 21 Apr 2022 07:27:12 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e5c42b6e31so5506945fac.12;
        Thu, 21 Apr 2022 07:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BQKvyTXErlpSLbUeZkAqUZtd6lsEQb/vXCrtLmWTwLk=;
        b=vmIwPXNkys8de+c8SlEfAIpf96MluDGNzeZ6gq5HVKJPFzRbAmMMI+bm0AML28zRhQ
         VM79ZZYo+yGFXeRztR7JiUJcuRCjhd0FfZfWIzhvDKBqUXJjVnowbJ9yl4/oLoUnV2pC
         epZwh8l0yF24xfHU1mwPo1KM8bG8LCGOvNIE5rfW5YwG24R1f1cwGFI1tHxqKd9yZB0t
         VE07j7MImGpmyjxqAa3MwBu6+nh31XNWrm0w9idjUffIJK14knnh36HVgP4zj5SkiZ1U
         SFVG2UB9MAD44mNaY9qi74RwllVlgtSM5PgeLOOBNrCFrJwuYMjaNcNC+qrCE8X7OeCZ
         kSBQ==
X-Gm-Message-State: AOAM5329z3CQNEM2f0N55JpIj7wXlLNsNaq7dJDA4Ebe2yCKQNWHvtQu
        mRUQMQ53tUn973zlEu6LDg==
X-Google-Smtp-Source: ABdhPJy6fvPhSR4FPWrtZ8cYTzUqxxQrEHtByGvOfgjE8lr08QjiBEG9A3qmcnCXZ3jZwtWIRFxWxg==
X-Received: by 2002:a05:6870:5829:b0:de:ab74:44cf with SMTP id r41-20020a056870582900b000deab7444cfmr3862916oap.17.1650551231912;
        Thu, 21 Apr 2022 07:27:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x15-20020a056830408f00b006054688cba0sm5769853ott.52.2022.04.21.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:11 -0700 (PDT)
Received: (nullmailer pid 3426512 invoked by uid 1000);
        Thu, 21 Apr 2022 14:27:10 -0000
Date:   Thu, 21 Apr 2022 09:27:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jerry Huang <jerry.huang@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Message-ID: <YmFpvtZ9WtYWoFYZ@robh.at.kernel.org>
References: <20220420073146.38086-1-jerry.huang@nxp.com>
 <d74f62d7-7aea-b31f-1c2f-540c54df289c@linaro.org>
 <VE1PR04MB6477553510B6EB35D7C22C13FEF49@VE1PR04MB6477.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VE1PR04MB6477553510B6EB35D7C22C13FEF49@VE1PR04MB6477.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:11:59AM +0000, Jerry Huang wrote:
> 
> 
> 
> Best Regards
> Jerry Huang
> 
> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 
> Sent: 2022年4月20日 20:06
> To: Jerry Huang <jerry.huang@nxp.com>; broonie@kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-spi@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech sx1301
> 
> Caution: EXT Email

Please fix your email client/setup to not change the subject, use the 
right reply quoting (1 line, not quoting To, Subject, etc.), and 
not corrupting urls.

Rob
