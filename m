Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719594B940A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 23:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiBPWwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 17:52:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiBPWwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 17:52:09 -0500
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B98945AE7;
        Wed, 16 Feb 2022 14:51:56 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id e79so1568808iof.13;
        Wed, 16 Feb 2022 14:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=3r6h2sBdcW1kkCKh7UVq3dUjkuKu9ak2ZM+xBcxiBd0=;
        b=PrjSbjFYBRZsSCFrFuV2l25GRfp9peqpmZ6iroyZ3V49mVfkkgr5bCMjHTz9pNjTuU
         OB7AfsdusJQSXIrwTuOqQ8lXITNJw24kxDmiOSo3SPWQAlSfnQMzGi2rkknvzPwm598f
         oF84/lW1G6ws1U/hS0ufWKY8mB9+aBFAqe031n7KAh6EaBydGQ2GlfK2QPaLAm99nYmK
         prtiDmSGjYJSM7NT07smUG9HMvjWRRxgacq/J/w0BUCdBIPrzsaJD0WEAkcSCGdxLSNf
         NC+OkX790A2uF+Fh1PX2CMOvBg2X5i/M81r6aY0vxH/Wqy/quL67bfjHfm89mO3xhAyb
         +okg==
X-Gm-Message-State: AOAM533ty24nQPm6kuyzRXDPxkmoFZ0BVnFdBfUXWVEiR7QS9wFOMyI5
        xJGkf/2xwBVB7OVqW7na2w==
X-Google-Smtp-Source: ABdhPJyhkxR5J8ILPyX1MmO7R0auSfTU9wY7qKGqq0W+NoKQgFqJrxA0ffZkJwTt3tb0CM71gtO84A==
X-Received: by 2002:a05:6638:1241:b0:311:b694:ef58 with SMTP id o1-20020a056638124100b00311b694ef58mr70606jas.88.1645051915548;
        Wed, 16 Feb 2022 14:51:55 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i13sm762384ilv.58.2022.02.16.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:51:54 -0800 (PST)
Received: (nullmailer pid 1825831 invoked by uid 1000);
        Wed, 16 Feb 2022 22:51:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, linux-rtc@vger.kernel.org,
        a.zummo@towertech.it, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        alexandre.belloni@bootlin.com
In-Reply-To: <20220215144649.14378-1-sergiu.moga@microchip.com>
References: <20220215144649.14378-1-sergiu.moga@microchip.com>
Subject: Re: [PATCH] dt-bindings: rtc: convert at91sam9 bindings to json-schema
Date:   Wed, 16 Feb 2022 16:51:53 -0600
Message-Id: <1645051913.059197.1825830.nullmailer@robh.at.kernel.org>
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

On Tue, 15 Feb 2022 16:46:49 +0200, Sergiu Moga wrote:
> Convert RTC binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/rtc/atmel,at91sam9-rtc.txt       | 25 --------
>  .../bindings/rtc/atmel,at91sam9-rtc.yaml      | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml:22:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.example.dt.yaml: rtt@fffffd20: $nodename:0: 'rtt@fffffd20' does not match '^rtc(@.*|-[0-9a-f])*$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.example.dt.yaml: rtt@fffffd20: atmel,rtt-rtc-time-reg:0: [4294967295, 0] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1593106

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

