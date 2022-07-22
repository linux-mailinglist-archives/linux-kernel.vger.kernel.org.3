Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FCB57E437
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiGVQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:16:48 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B06FD4;
        Fri, 22 Jul 2022 09:16:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26MGGL52061918;
        Fri, 22 Jul 2022 11:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658506582;
        bh=08PwfHBp1fRyc02qP294VlTMgUbHFS8jzINDzdDZnxc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DyD146mnXS6SnL91b4jDyoEvMxap92DghfdyWRa6UQTDYylbwrmLImf1YJomfvkAn
         DDWy1vsLJy0v4AlFCzxd8lglpHv9ZQ2Rg/MENCCKDbGnlrPEaKTHBbtp3W5YOlcf3l
         IzwGK/3a90lphq6ZflVziQzQhEhTgJz1A92HuKLc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26MGGL7N018124
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jul 2022 11:16:21 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Jul 2022 11:16:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Jul 2022 11:16:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26MGGLwu121736;
        Fri, 22 Jul 2022 11:16:21 -0500
Date:   Fri, 22 Jul 2022 11:16:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Darren Etheridge <detheridge@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: display: ti,am65x-dss: Add port
 properties for DSS
Message-ID: <20220722161621.p35apy5mstpgqhef@reverence>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-2-a-bhatia1@ti.com>
 <20220720232845.GA4164694-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220720232845.GA4164694-robh@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:28-20220720, Rob Herring wrote:
> > On the bridge side R0->R2, G0->G1, B0->B2 would be tied to ground.
> > The bridge sees 24bits of data,  but the lsb's are always zero.
> 
> Unless the bridge ignores the LSBs, that's not the right way to do 16 to 
> 24 bit. The LSBs should be connected to the MSB of the color component 
> to get full color range.

I unfortunately cannot point specifics without violating NDAs, so
will just give a broad perspective.

Correct, this is not ideal, but in certain scenarios with limited
pins (due to iovoltage groups), we are indeed starting to see this
kind of usage model starting to pop up. Tradeoff is in a limit on
image quality, but that tends to be acceptable in certain lower cost
solutions.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
