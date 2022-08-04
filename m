Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7101589AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbiHDLRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbiHDLRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:17:15 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7035D222A3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:17:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z25so30354624lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DFmOIiziRPNHpWBKPpt5n7VcF29o4zvH/5qsiASfuJE=;
        b=nlJGJWNTVoIvGb3gO+IPObXtugKj4yzm2Yk9zkrt+FJFwObIj1yg8k+J0I6+Q7+9oo
         bPKqLC9NiBaZW9m2+TRI0Cf6ey1a2BHQ3gugXvnWarUUhVb8FGoHPcdt8ZFEA+fxtM3e
         n3oVK9M0DZytRCRIqVQ07KSKktda3oFeaJ+mpFzEPu4gjQ5JlAPFo/j3LCEvIKKZIj3D
         R36I98/7toeLID8Cef+PWo2PbeuGHXKSqlm2lY893Y8ULIRSh+z4o6M7zxnFJopLiNS3
         n0BqxNcHZoX+8GimNOTcJ5YjQIPtgithd4x+CtZGC7WXkIXVWs+P0gEt4l9TGwh/HPCI
         kUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DFmOIiziRPNHpWBKPpt5n7VcF29o4zvH/5qsiASfuJE=;
        b=CEezRkIuH8XWqPkE1aTh7BT8AdHDYWnBuTEbrG9YNGTxmqc56VKe3Z7Q4pcXWJNeV8
         Mwp9ZIZkrv5cHP3y2s3VNKKY1S1FvxL2tgIdH1JH1OvT1abZHO5BmdIUY2sB+THN6ING
         4Gmu+Qr/VRsYqc53+SIW5HW8m88zei3DfzA9vtLAzL3/3MwSxV8ScrK8tv0f3owYaitr
         npDlZqL5I+3uDQDyIrWmAghtlbpdEEkb/ytta/KbLs4+/BDwQE4o8XATWrIGJwG7gGuZ
         6pOqPyXIHz+CLBNhhHwZUu8tIjPeHXfeXna4DhvU2nyy9Tisfp4vVZW38ODgiPEAo5UZ
         6IXA==
X-Gm-Message-State: ACgBeo1vXWpdHdKEaWWTyX82Qg5gybvfd7kjzEDj2SCJMaTG864m/NwF
        FSql5mlkS3iiy7qirYAipRiO4Q==
X-Google-Smtp-Source: AA6agR6d2B3qGNq1+UrltNjZCPnPA4K5bPcpt5A7YbDer92puTmpFgDwvvFtCljQp4kiPgZ0vdnTpg==
X-Received: by 2002:a19:5e49:0:b0:48a:7697:ddb1 with SMTP id z9-20020a195e49000000b0048a7697ddb1mr553962lfi.323.1659611832850;
        Thu, 04 Aug 2022 04:17:12 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id 19-20020ac24853000000b0048b0176bac6sm91644lfy.93.2022.08.04.04.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 04:17:12 -0700 (PDT)
Message-ID: <258c3ed7-2247-d4c3-73be-ddcddee3a3a0@linaro.org>
Date:   Thu, 4 Aug 2022 13:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel
 link MSI bus binding
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        robh@kernel.org
References: <20220804061133.4110734-1-victor.liu@nxp.com>
 <20220804061133.4110734-4-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804061133.4110734-4-victor.liu@nxp.com>
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

On 04/08/2022 08:11, Liu Ying wrote:
> Freescale i.MX8qxp pixel link MSI bus is a simple memory-mapped bus.
> It is used to access peripherals in i.MX8qm/qxp imaging, LVDS, MIPI
> DSI and HDMI TX subsystems, like I2C controller, PWM controller,
> MIPI DSI controller and Control and Status Registers (CSR) module.
> 
> Reference simple-pm-bus bindings and add Freescale i.MX8qxp pixel
> link MSI bus specific bindings.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Thank you for your patch. There is something to discuss/improve.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    bus@56200000 {
> +        compatible = "fsl,imx8qxp-display-pixel-link-msi-bus", "simple-pm-bus";
> +        reg = <0x56200000 0x20000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        interrupt-parent = <&dc0_irqsteer>;
> +        interrupts = <320>;
> +        ranges;
> +        clocks = <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>,
> +                 <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>;
> +        clock-names = "msi", "ahb";
> +        power-domains = <&pd IMX_SC_R_DC_0>;

The example should be complete, so you should have here children.
Otherwise it is not a bus.

Best regards,
Krzysztof
