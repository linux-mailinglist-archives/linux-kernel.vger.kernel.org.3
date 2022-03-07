Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E724D0BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiCGXTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiCGXTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:19:10 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5392FFE6;
        Mon,  7 Mar 2022 15:18:16 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso19884586ooc.7;
        Mon, 07 Mar 2022 15:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1eYH5LzkgdU6jpG2HhAfPxnYbI/wmwp3XDqYY0cCFis=;
        b=5fuouBviDbhAhV1DEzXDeLsxqFTVU9oO7Gd2r+zjSrwHIB2s1RtNx3jK9I62edeeZo
         in0D8mA3iBaRRN8ol8fIy7x8ulFmOUoZfF72eGubNMj3tryYQlSBJgUSHdWBxRKRCBkE
         ZYDeY1inUYCjjldXnltWNaIxvPz8bOEqbCFk5YMgQolI+Gnuk36aaKbSIX2XaU17SyCu
         q956DN5vEPWMh9lnlfM5puD1bSlPaaikVRVc1F1CL5hzenzuMXmCD3voXuTw7XrEcAPW
         GxNQy89yf4CMVnZB01k+FvBjysSAY97sz+A+c1e3gjmfQyDV+YSajpjXFiEWNjoOrYk/
         482g==
X-Gm-Message-State: AOAM533HBNtjple75iVOf4G9RxQrnNt3BF60UO/HTmFhh5b3fiaOvAEB
        XKoLJoQC3O5KNYPsG3pU+Q==
X-Google-Smtp-Source: ABdhPJxtAt0kquLQKafmRDFI779u0QNiU3qKgeI3NW63XN5lJ8QdUhYcl74kj2jxq9JNC0EhE6OHNQ==
X-Received: by 2002:a05:6870:a986:b0:da:b3f:3279 with SMTP id ep6-20020a056870a98600b000da0b3f3279mr746426oab.297.1646695095451;
        Mon, 07 Mar 2022 15:18:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t40-20020a05680815a800b002d48ffad94bsm7598050oiw.2.2022.03.07.15.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:18:14 -0800 (PST)
Received: (nullmailer pid 3447775 invoked by uid 1000);
        Mon, 07 Mar 2022 23:18:13 -0000
Date:   Mon, 7 Mar 2022 17:18:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Tom Rini <trini@konsulko.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, devicetree@vger.kernel.org,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables
 binding
Message-ID: <YiaStXmE8nYjBHqF@robh.at.kernel.org>
References: <20220228131250.16943-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228131250.16943-1-zajec5@gmail.com>
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

On Mon, Feb 28, 2022 at 02:12:50PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot uses environment variables for storing device setup data. It
> usually needs to be accessed by a bootloader, kernel and often
> user-space.
> 
> This binding allows describing environment data located in a raw flash
> partition. It's treated as NVMEM device and can be reused later for
> other storage devices.
> 
> Using DT should be cleaner than hardcoding & duplicating such info in
> multiple places. Bootloader & kernel can share DTS and user-space can
> try reading it too or just have correct data exposed by a kernel.
> 
> A custom "compatible" string allows system to automatically load
> relevant NVMEM driver but phandle can be also used for reading raw
> location.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Update descriptions to don't make this binding MTD (flash partition)
>     specific. Mention multiple possible storage ways.
> V3: Drop
>     allOf:
>       - $ref: nvmem.yaml#
>     as we don't use anything rom the nvmem.yaml. Thanks Rob.
> ---
>  .../devicetree/bindings/nvmem/u-boot,env.yaml | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml

A u-boot maintainer should ack this.

Rob
