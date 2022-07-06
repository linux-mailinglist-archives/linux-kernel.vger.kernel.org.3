Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2B569162
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiGFSGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiGFSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:06:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37E726AC9;
        Wed,  6 Jul 2022 11:06:45 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 266I6IeG053505;
        Wed, 6 Jul 2022 13:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657130778;
        bh=qO4t6cmfh23im7UgeyOP3WmN4x1a+t/t+uJgmi2Mb+c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mEAFrzL0CUyIo6G5LfhPTC/52YWJi6F8glj6kMtfr9C4eamrL+7/zz3O7gvNOPn0/
         mtn+7kpTJIc1ZlFEtd23Z6M0oV85FFWMJfKfFCtYqACM9njqDFkgIQD+FQGGHfJudh
         Tmr8DxuJhjuqBbVFdvc1uDjlm3Movm+gN1GVGhuk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 266I6IPS069292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jul 2022 13:06:18 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Jul 2022 13:06:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Jul 2022 13:06:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 266I6HQe032426;
        Wed, 6 Jul 2022 13:06:17 -0500
Date:   Wed, 6 Jul 2022 13:06:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Florian Eckert <fe@dev.tdt.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ti-adc128s052: Add lower resolution
 devices support
Message-ID: <20220706180617.hkogg3znw7dceny6@going>
References: <20220701042919.18180-1-nm@ti.com>
 <20220701042919.18180-3-nm@ti.com>
 <20220701174011.14d17f43@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220701174011.14d17f43@jic23-huawei>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:40-20220701, Jonathan Cameron wrote:
> On Thu, 30 Jun 2022 23:29:19 -0500
> Nishanth Menon <nm@ti.com> wrote:
> 
> > The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> > interface. The device family responds with 12bit data, of which the LSB
> > bits are transmitted by the lower resolution devices as 0. We don't need
> > to mess with ADC108S102_BITS as a result for the lower resolution
> > devices.
> 
> whilst not strictly necessary I would prefer we did as it may reduce
> storage requirements, computation complexity etc for userspace (particularly
> if they are 8 bits).
> 
> Would affect scale and shift so slightly more complex, but not a lot
> so still a fairly simple change.  Just add resolution to your config
> structure and duplicate it where necessary to allow whatever resolutions
> we support.
> 
> > 
[...]

> >  #include <linux/acpi.h>
> > @@ -185,6 +199,12 @@ static const struct of_device_id adc128_of_match[] = {
> >  	{ .compatible = "ti,adc122s021", .data = 1},
> >  	{ .compatible = "ti,adc122s051", .data = 1},
> >  	{ .compatible = "ti,adc122s101", .data = 1},
> > +	{ .compatible = "ti,adc102s021", .data = 1},
> > +	{ .compatible = "ti,adc102s051", .data = 1},
> > +	{ .compatible = "ti,adc102s101", .data = 1},
> 
> Numeric order preferred. Not sure why these are in the middle.
> 
> > +	{ .compatible = "ti,adc082s021", .data = 1},
> > +	{ .compatible = "ti,adc082s051", .data = 1},
> > +	{ .compatible = "ti,adc082s101", .data = 1},
> 
> Andy's comment on using pointers instead follows through to here.
> To describe the channels more fully you'll need additional
> _config[] structures.


Thanks folks for the feedback. Will try to do a better job on the next
rev.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
