Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F825807EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbiGYXCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiGYXB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:01:59 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F63D248F3;
        Mon, 25 Jul 2022 16:01:59 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id r13so14913787oie.1;
        Mon, 25 Jul 2022 16:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tNDL9l45N5Qx84qzLXSWONA/jhkumfsBUM0cy83Dbwo=;
        b=qSHnlggwjy3JT0m3FQfeRIE8/PbaxBlz4bCz4dtTAEyW9rMuI9yjZcJf9ltgN9qa11
         /7cjY8cXjcOgBmETNXtTTc1xzQDkwk6CCH754yuvevP8jtzjeookv9W1psrSm/hxPnCL
         hbSCiPt0F7G7ymITCa64LwNsVbnJUD9DE94LF1u+uYxhTOEE2oMuI46MeSyKOCcCt9ST
         VQ4DXRYx0grkY5jGwLFcFhBr4/F+UdxD3fUTDQItC7XCY9yBpwfM0BUnPKwrYfkszw0A
         Kambyq82WrtCDOIuGpYqSbHUu45juuDO9pYcnNt6Lgp+bSjklgX7+UMXH4bqrmLsKPnv
         In9Q==
X-Gm-Message-State: AJIora8oia45OvqYnUZoYHnZVu/EDwBF0FLiyJChK3aR/f6l9kHGqYK7
        z25nCkKx+zNkq1Kkyx/qAw==
X-Google-Smtp-Source: AGRyM1thvIGbberDblL1SPGPjobM4rzELteLF6kUVV/nsNXwhdbWj3qKBLcrkhtLq6A0U4YTo1zXqg==
X-Received: by 2002:a05:6808:20f:b0:33a:6151:4e54 with SMTP id l15-20020a056808020f00b0033a61514e54mr6839840oie.257.1658790118535;
        Mon, 25 Jul 2022 16:01:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l7-20020a9d4c07000000b0061c4c925c87sm5537850otf.78.2022.07.25.16.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:01:57 -0700 (PDT)
Received: (nullmailer pid 2912875 invoked by uid 1000);
        Mon, 25 Jul 2022 23:01:55 -0000
Date:   Mon, 25 Jul 2022 17:01:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     robh+dt@kernel.org, amelie.delaunay@foss.st.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, mka@chromium.org, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/4] dt-bindings: usb: generic-ehci: allow usb-hcd schema
 properties
Message-ID: <20220725230155.GA2912841-robh@kernel.org>
References: <20220722130554.236925-1-fabrice.gasnier@foss.st.com>
 <20220722130554.236925-2-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722130554.236925-2-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 15:05:51 +0200, Fabrice Gasnier wrote:
> Allow properties and usb-device child nodes as defined in usb-hcd.yaml, by
> using unevaluatedProperties: false. By the way, remove the "companion"
> property as it's redundant with usb-hcd.yaml.
> As example, this allows an onboard hub, to be described in generic-ehci
> controller node:
> usb {
>   compatible = "generic-ehci";
>   #address-cells = <1>;
>   #size-cells = <0>;
>   /* onboard HUB */
>   hub@1 {
>     compatible = "usb424,2514";
>     reg = <1>;
>     vdd-supply = <&v3v3>;
>   };
> };
> 
> Without this, dtbs_check complains on '#address-cells', '#size-cells',
> 'hub@1' do not match any of the regexes: 'pinctrl-[0-9]+'
> From schema: ..../generic-ehci.yaml
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
