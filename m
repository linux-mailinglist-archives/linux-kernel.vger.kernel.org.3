Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD34804A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhL0UtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 15:49:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55468 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhL0UtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 15:49:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BRKn0vf081374;
        Mon, 27 Dec 2021 14:49:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640638140;
        bh=Sf+TygJTFGkJZaMoLDFtGI1kePsfZJMILid4Yayi3QY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lNJOuzS8kBS5Ms6YKmBSWuOZSTC9WqZt+t2ALBpx6KSeMgadLH5oXz+SLgCc9aLus
         c/1cCaoiFZgDH/gXZ0GWAX4xXeVvWlaSZqje/ClXIK4jt+7K8nAOpqixfNmQEMC42v
         5LZ5Xo5BaQji54CwkWMu0/6ba6rPryYioUuCQ1wo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BRKn0iR024882
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Dec 2021 14:49:00 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Dec 2021 14:49:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Dec 2021 14:49:00 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BRKmxHS123431;
        Mon, 27 Dec 2021 14:48:59 -0600
Date:   Tue, 28 Dec 2021 02:18:58 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v7 4/4] phy: dt-bindings: Add Cadence D-PHY Rx bindings
Message-ID: <20211227204856.o6s6kjt5yahuk2j7@ti.com>
References: <20211227105545.4852-1-p.yadav@ti.com>
 <20211227105545.4852-5-p.yadav@ti.com>
 <YcnwcpPdOOJ7WgSe@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YcnwcpPdOOJ7WgSe@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 27/12/21 12:57PM, Rob Herring wrote:
> On Mon, 27 Dec 2021 16:25:45 +0530, Pratyush Yadav wrote:
> > The Rx mode DPHY is different from Tx mode DPHY. Add a separate binding
> > for it.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > 
> > (no changes since v6)
> > 
> > Changes in v6:
> > - Add a new binding for DPHY Rx.
> > 
> >  .../devicetree/bindings/phy/cdns,dphy-rx.yaml | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
> > 
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Sorry. I missed adding your R-by. It was by mistake, since this patch 
has not changed since.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
