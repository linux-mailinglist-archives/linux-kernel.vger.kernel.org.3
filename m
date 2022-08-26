Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C45F5A21CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbiHZH1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245327AbiHZH0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:26:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A521E5F120;
        Fri, 26 Aug 2022 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661498809; x=1693034809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bQ66rxBi1p20bacYHk7InPQ7hqfavItr+gjhZj1ZfJU=;
  b=RNVuZPXOwxtg95z7OPGo4elBGb5uz4lguNoTsWAwbfTa6RU+kvR2DNJW
   G1SkAiPHrjqXS8YlxQUyrPzKzCgppf9D7JOF3aerM+77V3DdTecQgibBP
   HJWZ+P9t+DIPDSYjpvMFiCKOxh4rUNPriFUkmVY7I1z9zOxCGRS6IYnqa
   mVpuhsAu2MfoRZW7Ox+thkyzM6DZHJB3qsYUfC5Xfsy6A6YKQBBIDI3+7
   oBgfyiAPXo4BnYTcBF3DD4II/zLXTDOE66EIJGYs1Yp6ragigY//9xrA/
   97xdNiEcn0CHQE7Uisuw5HT7ZB2cmmTG5ISyll4pQ+Ts6AUFng/rBFJj2
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="174276053"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 00:26:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 00:26:48 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 26 Aug 2022 00:26:48 -0700
Date:   Fri, 26 Aug 2022 09:31:03 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: lan9662-otpc: document Lan9662 OTPC
Message-ID: <20220826073103.kkotbaxc3latculo@soft-dev3-1.localhost>
References: <20220825204041.1485731-1-horatiu.vultur@microchip.com>
 <20220825204041.1485731-2-horatiu.vultur@microchip.com>
 <96da4897-7b55-84d5-8f1d-892e116153df@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <96da4897-7b55-84d5-8f1d-892e116153df@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 08/26/2022 09:42, Krzysztof Kozlowski wrote:

Hi Krzysztof,

> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: microchip,lan9662-otpc
> > +      - const: microchip,lan9668-otpc
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> 
> This won't work...

You are right. That was a silly mistake on my side.

It should be:
---
properties:
  compatible:
    enum:
      - microchip,lan9662-otpc
      - microchip,lan9668-otpc
---
Because what I want to achive is to be able to use any of
string(microchip,lan9662-otpc or microchip,lan9668-otpc) as compatible
string.

Or this is not the correct change?
At least with this change dt_binding_check is happy.

> 
> Best regards,
> Krzysztof

-- 
/Horatiu
