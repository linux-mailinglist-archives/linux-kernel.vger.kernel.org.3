Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3B64C0443
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiBVWCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiBVWCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:02:47 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898AA240B8;
        Tue, 22 Feb 2022 14:02:21 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 12so8149747oix.12;
        Tue, 22 Feb 2022 14:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=plJv0KvTlwq/u4nqONQbBW3iQhM4p7amAGlTvUHglg0=;
        b=0SFfiTV1Ihou4rRMhsSk4Ta5b205594NSJtJakwNWsTbEe1zpgtbXVV5DyBh4h+MaT
         hRkez2VLpq4OHgcFFCn9TThxP92Q3dCXhF0dejBHNXVJw9DlaT4LvgOo2zh/BRQdxDuw
         WTPRHmKo8Oxh5ZaZHM0TFDb1Gb6wgQ98GC/vL77s09WMzmpD5vPTC3Fu+Cxkl3wlFTEw
         yZTmsSSZFH2mLiA4lJ3EM9y+MZAT3niajoBhRy1klYibAPHIQSh6Jd0+7fE/eju09OEW
         ZaWzjyRNEU8WmWvtcz+VAWJj37dmT+BNuVjrUL1mhx1cEeNR4+B5uot0f3RwPO0EyYpX
         6LOA==
X-Gm-Message-State: AOAM532nPRiKEE9sM6MYX7Qs1ZIyYkUWgANEovzfdn4djkvLIgtubkbp
        7unxtSTto6Nhs+xmSe/BuA==
X-Google-Smtp-Source: ABdhPJxZZ7p2fZpni5f612X1fPpzkYPXoD3YFzTdDRIy+MKKE4SHYgZ/w4eucmp/gtyFhc2iyUmzng==
X-Received: by 2002:a05:6808:21a2:b0:2d4:c3e6:6873 with SMTP id be34-20020a05680821a200b002d4c3e66873mr3134537oib.253.1645567340856;
        Tue, 22 Feb 2022 14:02:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q4sm7705610otk.39.2022.02.22.14.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:02:20 -0800 (PST)
Received: (nullmailer pid 3668753 invoked by uid 1000);
        Tue, 22 Feb 2022 22:02:19 -0000
Date:   Tue, 22 Feb 2022 16:02:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     David Heidelberg <david@ixit.cz>, Roger Quadros <rogerq@ti.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add second HiSilicon
 prefix
Message-ID: <YhVda7zSwd+DYkc2@robh.at.kernel.org>
References: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
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

On Mon, 21 Feb 2022 09:22:26 +0100, Krzysztof Kozlowski wrote:
> There are few boards DTS using "hisi,rst-syscon" property -
> undocumented "hisi" prefix.  The property will not be changed in DTS to
> non-deprecated one, because of compatibility reasons.  Add deprecated
> "hisi" prefix to silence DT schema warnings.
> 
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: David Heidelberg <david@ixit.cz>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> See:
> https://lore.kernel.org/all/61AF1E3B.5060706@hisilicon.com/
> https://www.spinics.net/lists/arm-kernel/msg887577.html
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
