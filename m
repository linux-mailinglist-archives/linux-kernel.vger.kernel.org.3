Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF75A7B85
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiHaKkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiHaKkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:40:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D356CBE4C1;
        Wed, 31 Aug 2022 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661942440; x=1693478440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iN7KMiFLh0DoaPA2bfV6omYoHGxgYoE8MOyNtDAZ1qQ=;
  b=TsGYp/h2tECmppXBiYnohnQtlg0mDAQdWIOmbsIR/+8V20OAO4fZf1Nm
   Hqet9K6XxVSti+HjwsMU38u+odQ229scVz/D1weh6mvOxUV1+9xW63aO7
   t72cI1mphRiCx7PlapjzgxeNYBoVieIOl4q/BjbhHK7QS/7rNA8q+IMd/
   DM2kBF758p30a5/hGlQfPVAldPSeqp2ky2ht2QYnpFRIthYHE047BMYAW
   xmoi+3St4LzNiNfWDEeobx4v8bF9pkdGDiHas8x6fyqlEPZEqjH+5hKH7
   Z5LUhZ46RoQgVlX4UYXuu7ub13ekZoF3ftP5UEXwehFXCOrsftUWseU3k
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="178449398"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 03:40:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 03:40:38 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 31 Aug 2022 03:40:38 -0700
Date:   Wed, 31 Aug 2022 12:44:55 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: lan9662-otpc: document Lan9662 OTPC
Message-ID: <20220831104455.2oc24fokicieyh37@soft-dev3-1.localhost>
References: <20220831064238.102267-1-horatiu.vultur@microchip.com>
 <20220831064238.102267-2-horatiu.vultur@microchip.com>
 <393933f5-9a87-4d12-2527-5adfa4aeccca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <393933f5-9a87-4d12-2527-5adfa4aeccca@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 08/31/2022 10:28, Krzysztof Kozlowski wrote:

Hi Krzysztof,

> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: microchip,lan9662-otpc
> > +          - const: microchip,lan9668-otpc
> > +      - enum:
> > +          - microchip,lan9662-otpc
> 
> This is not what I wrote and this does not make sense. You now listed
> twice 9662 and 9668 does not have its entry.

As you figured it out, I am quite noob at these bindings.
The only difference between what you wrote and what I wrote is the order
under items. So the order matters?

> 
> Best regards,
> Krzysztof

-- 
/Horatiu
