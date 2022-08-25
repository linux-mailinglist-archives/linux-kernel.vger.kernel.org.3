Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6435A1AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243559AbiHYVR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiHYVR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:17:56 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A19B69C7;
        Thu, 25 Aug 2022 14:17:56 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id o15-20020a9d718f000000b00638c1348012so14804524otj.2;
        Thu, 25 Aug 2022 14:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hwV//rNcbQ3+qAB3daw/4GgV/Z1x4soD0T+4tNDY0tA=;
        b=MaaPqdQEsxJmvrF/97EBH2PgcuLQST+8K+29tN7xh0jPKMuTCojFOQZvepp4Zz8k1t
         9ufAOn95O+i2L6ERbfeDYt6CnAKjRikYo/grh50RN3V05M53M8by4t03N8fApOoaMKWE
         v/2HjoGX2yck/it98KpXWxKt0GO13FdleFkw5Xo2G5AiiEevpCOq7gIskBjEwwi/W8fi
         y2vHoH36cmY0AngFHV/dOmF60L73fRNwDQUnV+WyekO2NHeo6iwS2CsdGDaZPJzAKSYd
         maHuvWzD81kGqhB1idcdmlimW5FMkBVxoZPpXue7nB+LvkRkPJ8o8kGMRjYBJz/dHVnQ
         uR3g==
X-Gm-Message-State: ACgBeo0rCD6MvcS278uTQb6ceIuLEutp/oPdXLxSaOsnKzezqQ+yFzfA
        FUIv0EOvhPBJ1gXqxXuNGA==
X-Google-Smtp-Source: AA6agR5ixmp6Z28HcogDYhiF72sAG63FXLBl/ZP/60D9Q1GSLvk1YFQKRZhsLMFb6kb/KMiIP6jXXg==
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id r30-20020a056830449e00b00638c72b68ffmr361404otv.26.1661462275255;
        Thu, 25 Aug 2022 14:17:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s23-20020a9d7597000000b006391adb6034sm51044otk.72.2022.08.25.14.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:17:54 -0700 (PDT)
Received: (nullmailer pid 1704224 invoked by uid 1000);
        Thu, 25 Aug 2022 21:17:54 -0000
Date:   Thu, 25 Aug 2022 16:17:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     gregkh@linuxfoundation.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, geert+renesas@glider.be,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, saravanak@google.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        festevam@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, shawnguo@kernel.org
Subject: Re: [PATCH RESEND v4 2/2] dt-bindings: bus: Add Freescale i.MX8qxp
 pixel link MSI bus binding
Message-ID: <20220825211754.GA1704113-robh@kernel.org>
References: <20220822060323.3481384-1-victor.liu@nxp.com>
 <20220822060323.3481384-3-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822060323.3481384-3-victor.liu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 14:03:23 +0800, Liu Ying wrote:
> Freescale i.MX8qxp pixel link MSI bus is a simple memory-mapped bus.
> It is used to access peripherals in i.MX8qm/qxp imaging, LVDS, MIPI
> DSI and HDMI TX subsystems, like I2C controller, PWM controller,
> MIPI DSI controller and Control and Status Registers (CSR) module.
> 
> Reference simple-pm-bus bindings and add Freescale i.MX8qxp pixel
> link MSI bus specific bindings.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3->v4:
> * Add child nodes in the example MSI bus node of the MSI bus dt-binding. (Krzysztof)
> * Resend v4 to imply this patch is based on v6.0-rc1 so that there are not any
>   dependencies. (Rob)
> 
> v2->v3:
> * Add a pattern property to allow child nodes. (Rob)
> 
> v1->v2:
> Address Krzysztof's comments:
> * Add a select to explicitly select the MSI bus dt-binding.
> * List 'simple-pm-bus' explicitly as one item of compatible strings.
> * Require compatible and reg properties.
> * Put reg property just after compatible property in example.
> 
>  .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232 ++++++++++++++++++
>  1 file changed, 232 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
