Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446EF4CE0CC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiCDXOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCDXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:14:16 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFF5E020;
        Fri,  4 Mar 2022 15:13:27 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id u17-20020a056830231100b005ad13358af9so8550297ote.11;
        Fri, 04 Mar 2022 15:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8tXT4S0piSpQICQpgP+9oA4HWrt9IUaGgLMB7vO8b84=;
        b=k1qMbmoEO3KVTtEpQCrC+uTmGsCUdPNNoVULTqM/Pt8Yal14FDiAkC4g3qVEEKJADn
         bNEalCvdwU27BM93ri8m6VWLhhhOFNDIe77iS6j7jmfHfIeRCpWlh69V4gY3kAOzO4dP
         xCLYGCJRmBhCbkK5AaKBZjVjIyjVFRuhgoIoroXkwmtKeJqLaGENuy1qiGxdZMERo1Ks
         uWsg2GXd4jKj8fI9vAJsgYcfGaJC2//K0uVPlOlOnT3fg6lWODDxhLyAkQMLVEQcqIjv
         AmI2ECLz4x3F8ZEL/JkZTlJ1OsVyqt7itu4G9Oiu2Zze28z2I6HAzy+KllSb5ZD4JPDC
         YyFA==
X-Gm-Message-State: AOAM532W2LstjAh7L++e83ANS6SKrJdK21FoWni6lS4ppCMdCmtHtZlh
        c0rk8aDf6mpkvFtpBcXUWg==
X-Google-Smtp-Source: ABdhPJwj+VuafiICwCgnIKimWglwgIZWkpcyb5FEymTdjCHIYmSjfCFoLcu3YupK4D8uOWJ8G4jcig==
X-Received: by 2002:a9d:7306:0:b0:5af:91d8:875f with SMTP id e6-20020a9d7306000000b005af91d8875fmr458801otk.144.1646435607274;
        Fri, 04 Mar 2022 15:13:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x25-20020a056830409900b005af164235b4sm2835755ott.2.2022.03.04.15.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:13:26 -0800 (PST)
Received: (nullmailer pid 640205 invoked by uid 1000);
        Fri, 04 Mar 2022 23:13:25 -0000
Date:   Fri, 4 Mar 2022 17:13:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     michael.riesch@wolfvision.net, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 03/11] dt-bindings: usb: dwc3: add description for
 rk3568
Message-ID: <YiKdFdYtTS+KKCvP@robh.at.kernel.org>
References: <20220226184147.769964-1-pgwipeout@gmail.com>
 <20220226184147.769964-4-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226184147.769964-4-pgwipeout@gmail.com>
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

On Sat, 26 Feb 2022 13:41:39 -0500, Peter Geis wrote:
> The rk3568 dwc3 controllers are backwards compatible with the rk3399.
> Add the device tree description for it.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
