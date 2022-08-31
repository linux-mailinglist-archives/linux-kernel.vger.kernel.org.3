Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F395A8094
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiHaOsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiHaOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:48:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8DED11D8;
        Wed, 31 Aug 2022 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661957282; x=1693493282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HGG00z9VPzI67MCrhZLtqGYOmLwbGjjL8fdF5oJmzFA=;
  b=V7wL09HcxvtbpO0KIx9be4NIovtCricBEDVXT7wZkY7i4/aaz+mr1Div
   VIrAPhl5OxhiTPdz8q72FR7uqXc21UA7gL5zFxjLuHJN3/yqwuoKWrIKP
   cQFG1EvqOhJkC4kfkzMqbpTu83zStqiB3FiJcCSNrRThBt2VSDu0Mtqtt
   ZqjQ5j6r+UpmuGROO/b073yuIDSKM6jqi/ATWSQLeBlhKuE+PWV2viAK6
   znkYhRRGCB/lrh0ItRc6xwnOIXQTkr7NwhjkNNFVmKileuvGJejRku28C
   PWEgBXovO+sL8uqjqVXZC6pqusmY3eNIgdsVjctFr/Pj42f39tz3Y1SNh
   w==;
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="171793394"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 07:48:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 07:47:59 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 31 Aug 2022 07:47:59 -0700
Date:   Wed, 31 Aug 2022 16:52:16 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v3 2/2] nvmem: lan9662-otp: add support.
Message-ID: <20220831145216.cw6gignx3b2fo4u6@soft-dev3-1.localhost>
References: <20220831064238.102267-1-horatiu.vultur@microchip.com>
 <20220831064238.102267-3-horatiu.vultur@microchip.com>
 <1ddf261e-55fb-e30c-93b0-efb9bc0987b3@linaro.org>
 <20220831105237.ot5aaawnrwjqmjgj@soft-dev3-1.localhost>
 <9e37285e-9408-7adb-1242-77f580573283@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <9e37285e-9408-7adb-1242-77f580573283@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 08/31/2022 15:52, Krzysztof Kozlowski wrote:
> 
> On 31/08/2022 13:52, Horatiu Vultur wrote:
> > The 08/31/2022 10:29, Krzysztof Kozlowski wrote:
> >
> > Hi Krzysztof,
> >
> >>
> >> On 31/08/2022 09:42, Horatiu Vultur wrote:
> >>
> >>> +static const struct of_device_id lan9662_otp_match[] = {
> >>> +     { .compatible = "microchip,lan9662-otp", },
> >>> +     { .compatible = "microchip,lan9668-otp", },
> >>
> >> This is still wrong, does not match your bindings at all and still
> >> duplicates entries without driver data. One entry - 9662.
> >
> > I have look at some other drivers, where I can see they don't have any
> > driver data. For example [1] and the bindings are here [2].
> >
> > [1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/ti/cpsw_new.c#L1832
> > [2] https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml#L23
> 
> There are plenty of poor examples in Linux kernel code and it is not a
> reason to re-use their patterns...
> 
> > Is this also wrong, or I still can't understand how the bindings are
> > working?
> 
> The topic here is not that much related to the bindings, but device
> matching in Linux kernel.
> 
> >
> > If I put only one entry:
> > ---
> > static const struct of_device_id lan9662_otp_match[] = {
> >      { .compatible = "microchip,lan9662-otp", },
> > ---
> >
> > Wouldn't be a problem that the binding mentions also lan9668?
> 
> No. What could be the problem exactly, which you are afraid? Why
> implementation should be a problem for a binding (which we try to be
> mostly implementation independent)?

The implementation wouldn't be a problem for the binding.
The only thing was if the binding has more compatible strings than what
the driver supports. As an example, in the binding we mention about
lan9668 but nothing in the driver.

> 
> Best regards,
> Krzysztof

-- 
/Horatiu
