Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85979552AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbiFUGFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiFUGFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:05:49 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54F615A1F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:05:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25L65SXf121737;
        Tue, 21 Jun 2022 01:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655791528;
        bh=Ap0E3scOD56YBw0wixxDNJ51SA2kU8j9amKsGfVLewc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=N2GAXK6+v4JCbCskex3KsAVG3xV023TmieBob3Z1wGAGB6SCbjA+LW+1r5+MSB+TL
         55vcCGid2z3fsC7E8mzFPd8eBr40n2+lZfu+vl2ZF3ccf3BKmnq2GipGfEFDi67oRh
         NbNACo5kCAk7U2G3weMPsopwh/IiFYK7StLp86pY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25L65SkV121374
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jun 2022 01:05:28 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Jun 2022 01:05:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Jun 2022 01:05:28 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25L65RZM067872;
        Tue, 21 Jun 2022 01:05:27 -0500
Date:   Tue, 21 Jun 2022 11:35:26 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <dri-devel@lists.freedesktop.org>, <andrzej.hajda@intel.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <p.zabel@pengutronix.de>,
        <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>, <a-bhatia1@ti.com>
Subject: Re: [PATCH v2] drm/bridge: cdns-dsi: Add support for J721E wrapper
Message-ID: <20220621060525.kvm5wojt6kmfqhqv@uda0490373>
References: <20220619140158.30881-1-r-ravikumar@ti.com>
 <042c77d5-7db1-fa09-4be4-74dbfa85b5e2@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <042c77d5-7db1-fa09-4be4-74dbfa85b5e2@ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:02-20220620, Tomi Valkeinen wrote:
> Hi,
> 
> On 19/06/2022 17:01, Rahul T R wrote:
> > Add support for wrapper settings for DSI bridge on
> > j721e. Also set the DPI input to DPI0
> > 
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > ---
> 
> Nack... This wouldn't work with some other SoC using CDNS DSI.
> 
> See cdns-mhdp8546 for an example of a bit more generic wrapper support.
> 
>  Tomi

Thanks Tomi,

I have sent a respin with making changes similar to cdns-mhdp8546
please review

Regards
Rahul T R
