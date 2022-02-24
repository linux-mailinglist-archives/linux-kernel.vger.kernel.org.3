Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E2C4C3405
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiBXRvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiBXRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:50:58 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8392E1C6670;
        Thu, 24 Feb 2022 09:50:27 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 071931BF20B;
        Thu, 24 Feb 2022 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645725026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0YXRcE4sbpeB05G5f6AzNSVgrO8xl3ZmRPiwRuZ2ug=;
        b=X7qeBK22ai2Xi9AYqOOywCxngjJ+BuJNeFDTms/fYF33iHuTnvbiUO3QJviy7CweBQ+qRm
        CrbGJI2nIgGatBph2CsmKLAlv192zlRonMsIpWJ/XEOraKT5mHFCF06JzxVh2G36w0hQkS
        mAr4/6px555ZfyXsGfBXMyGge8BZk4y1WonDNS2KSl+raa0tVIrSkk3c5ugLAhEe30SblT
        nb+aN/1dAen6oifuHqQ70W5Kt/NQTRUWvXw4gBX2v6Dd2gNvf6vIcxhCVnrYC0ZCU1vsqi
        dPkArPCMyWFacJtxeSeTiLPLQ7A1NF+PbhYIs58v/As2lfqjAQd5upjcx/1fRw==
Date:   Thu, 24 Feb 2022 18:50:22 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Hari Prasath <Hari.PrasathGE@microchip.com>,
        claudiu.beznea@microchip.com, davem@davemloft.net,
        ludovic.desroches@microchip.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH] 1/3] ARM: dts: at91: sama7g5: Restrict ns_sram
Message-ID: <YhfFXowro9PlLxyv@piout.net>
References: <20220222113924.25799-1-Hari.PrasathGE@microchip.com>
 <YhVLpnQ5fKs5x1Hq@piout.net>
 <9858f8e2-619c-2c3b-f771-114bb5379876@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9858f8e2-619c-2c3b-f771-114bb5379876@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2022 16:47:03+0100, Nicolas Ferre wrote:
> On 22/02/2022 at 21:46, Alexandre Belloni wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 22/02/2022 17:09:22+0530, Hari Prasath wrote:
> > > Limit the size of SRAM available for the rest of kernel via genalloc API's to
> > > 13k. The rest of the SRAM is used by CAN controllers and hence this restriction.
> > > 
> > 
> > Certainly not, if the can controller need the SRAM, they have to
> > allocate it properly.
> 
> I'm not sure that bosh mcan driver can be used with dynamic allocation of
> SRAM. Is it what you're thinking about?
> 

Yes, simply add a new compatible and do the allocation where necessary.
IT would be just like how we have different compatible strings for every
different macb integrations.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
