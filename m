Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E623D47E41F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348665AbhLWNch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:32:37 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38966 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243693AbhLWNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:32:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNDWSHX081159;
        Thu, 23 Dec 2021 07:32:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640266348;
        bh=iWcG4R+lsaeGi92qcynqwDmqiEjQemoFrPOmJi6oC1U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uZ1+QHZzKq5q8PaujQPVpXnk29FMTXFnglT5oqn/Q6wSPx4XI+TeFlO25CrwBL7dD
         Y8DZbGfliD1/WNE1jC5NLGQybsb9+sSDpwr7/SvY9Y4yKzd193iXe2K9jfGGYSJ/zm
         KuA+sjpoiEMiDE5pQjr9KByTSbiQdaMSRoOWo9yM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNDWSlc022874
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 07:32:28 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 07:32:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 07:32:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNDWSnd097752;
        Thu, 23 Dec 2021 07:32:28 -0600
Date:   Thu, 23 Dec 2021 07:32:28 -0600
From:   Nishanth Menon <nm@ti.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        <SantoshShilimkarssantosh@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] soc: ti: smartreflex: Use platform_get_irq_optional() to
 get the interrupt
Message-ID: <20211223133228.7zy63enji7jkwuwc@enquirer>
References: <20211218153943.28014-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211220133145.uiww2nuormjks7gc@unruly>
 <CA+V-a8unRn=TJSnikVJffB3ebQn7RofoCn2yDLne15gW-ch9Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+V-a8unRn=TJSnikVJffB3ebQn7RofoCn2yDLne15gW-ch9Yg@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:28-20211221, Lad, Prabhakar wrote:
[...]
> Yes, the probe will fail silently in case of error while getting an
> interrupt if it exists in DT. Do you want me to add an error message
> in case of an error? I'll be sending v2 anyway dropping the check for
> IRQ0.

Yes please, please add an error message.

[...]
> rc should be OK, as there will be tree wide changes.

Lets try and do that (hopefully we should have a new respin by rc1).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
