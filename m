Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F3657D7B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiGVAZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiGVAZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:25:49 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BA3774B2;
        Thu, 21 Jul 2022 17:25:49 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id y197so1785891iof.12;
        Thu, 21 Jul 2022 17:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5rm4BFsSvYv37lsR3SyeGRLmP7dFOqjTJ+9txhzXmzk=;
        b=VF78yF4xK5RjpGPKhLcpS/da7sjELiLqGNK/grj3Qkbk7zt6VXEBGDCNxQc8ypj0oK
         syw0FjHIHAyjz65pJOSp+T5yrYkeXksI6Nx/DTfpbhA+2qFmX/0VQUZP2WlHNzwikVcv
         MSbS2rS4yoYVMc+2BgCy6s0DNihULmTi/PmnXiZwCe75hZ5RMhZZ1PqUrcSHUIhDUtDz
         9Zk6Iva1ShdfLu4/pPAxxfPo65ZzlA5OQhKPmOXdG7XvthZ4qOK5qML4e/GSjI+/VXKO
         cxj+4R3DsnWIZgapINGdBJdDzh9Jnn/nSrnTypoXYOMSeeJyG3tbJvDu7A+lJ0WcdVEs
         1dtQ==
X-Gm-Message-State: AJIora9+8/hMbPdpIM1y/NH9UlYFyKpiqHGsj5KIbll6Gt8BSyanAgQ2
        1YkzynBaWJS3miTX3grW/g==
X-Google-Smtp-Source: AGRyM1sU8bwcGjBEm0B3fkhvJdN7Glv0yQo9ZDLlq0aLwwezKmTVfOOZZ4cOs/i+bFBJvmc/Hb+Lgg==
X-Received: by 2002:a6b:fe13:0:b0:67c:3ed1:3cd0 with SMTP id x19-20020a6bfe13000000b0067c3ed13cd0mr381193ioh.53.1658449548266;
        Thu, 21 Jul 2022 17:25:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k83-20020a6bba56000000b0067beb49f801sm1498462iof.2.2022.07.21.17.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:25:47 -0700 (PDT)
Received: (nullmailer pid 2240200 invoked by uid 1000);
        Fri, 22 Jul 2022 00:25:46 -0000
Date:   Thu, 21 Jul 2022 18:25:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     christophe.jaillet@wanadoo.fr, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        amelie.delaunay@foss.st.com, linux-kernel@vger.kernel.org,
        alexandre.torgue@foss.st.com, heikki.krogerus@linux.intel.com,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: typec: add bindings for stm32g0
 controller
Message-ID: <20220722002546.GA2240166-robh@kernel.org>
References: <20220713120842.560902-1-fabrice.gasnier@foss.st.com>
 <20220713120842.560902-2-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713120842.560902-2-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 14:08:40 +0200, Fabrice Gasnier wrote:
> Add DT schema documentation for the STM32G0 Type-C PD (Power Delivery)
> controller.
> STM32G0 provides an integrated USB Type-C and power delivery interface.
> It can be programmed with a firmware to handle UCSI protocol over I2C
> interface. A GPIO is used as an interrupt line.
> It may be used as a wakeup source, so use optional "wakeup-source" and
> "power-domains" properties to support wakeup.
> The firmware itself may be flashed or later updated (optional). Choice is
> let to the application to allow firmware update. A default firmware could
> be already programmed in production and be customized (to not allow it).
> So the firmware-name is made optional to represent this option.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v3:
> - Add connector to the required properties as pointed out by Krzysztof.
>   Update commit message to explain why the firmware-name is optional.
> Changes in v2:
> - Krzysztof's review comments: update commit message, use ports, use
>   unevaluatedProperties: false for usb-connector schema, define maxItems
>   for power-domains, adopt generic node names, remove quotes
> ---
>  .../bindings/usb/st,typec-stm32g0.yaml        | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
