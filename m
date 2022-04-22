Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344CB50B9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448547AbiDVOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448526AbiDVOTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:19:50 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED75AEDB;
        Fri, 22 Apr 2022 07:16:56 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23MEGep0020829;
        Fri, 22 Apr 2022 09:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650637000;
        bh=Btht3bJsm2pNgZ1+h8mMkgg47aM7ac0qLihAqIO4ZCY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uyxtvlYqS6hJG0InCHJqL6ouH+zvY7ZmLo6L8inFqms7sonKrL+RRH4uicW6/cZUx
         2cHIDeGTbv26IYYiEwylXnNkMpaH6/aFQvyKMEjYB5H6sYQm+O7HRURo9GYGIv9gjj
         BNPnykeWst1R3g0DP4wtVwwm+H5Z2sPR8OqdQIAk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23MEGeeg034900
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 09:16:40 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 09:16:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 09:16:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23MEGcui026816;
        Fri, 22 Apr 2022 09:16:39 -0500
Date:   Fri, 22 Apr 2022 19:46:38 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>
Subject: Re: [PATCH v3 0/2] DSS: Add support for DisplayPort
Message-ID: <20220422141637.4hz5nrlpjapmqezw@uda0490373>
References: <20220406165852.13026-1-r-ravikumar@ti.com>
 <ed64bf63-95c6-94ae-4c4f-a206250f44a9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ed64bf63-95c6-94ae-4c4f-a206250f44a9@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:51-20220415, Vignesh Raghavendra wrote:
> 
> 
> On 06/04/22 10:28 pm, Rahul T R wrote:
> > The following series of patches enables DisplayPort on
> > j721e-evm
> > 
> > Tomi Valkeinen (2):
> >   arm64: dts: ti: k3-j721e-main: add DP & DP PHY
> >   arm64: dts: ti: k3-j721e-common-proc-board: add DP to j7 evm
> > 
> > v2:
> >    - use phandle with a parameter to refer clocks insted of
> >      sub nodes in serdes_wiz node
> >    - move phy link node to board DTS file
> > 
> > v3:
> >    - Fix the regulator node name as per the DT spec
> >    - Use Macro for GPIO type
> > 
> > boot logs:
> >    https://gist.githubusercontent.com/ravi-rahul/1bdbc3f77ab381e486c8394650c2e85d/raw/f04584c30181821c4ee83aee7781a9ba143cd3f3/j7_DP_upstream.log
> > 
> > kernel patch verify report:
> >    https://gist.githubusercontent.com/ravi-rahul/a982fef3fae03ec0dbdd5cb475a4cb25/raw/c8230370746e9878daf9527c3aa9d82eed7aa33c/report-kernel-patch-verify.txt
> 
> Hmm, With dtbs_check I see (on v5.18-rc1 tag)
> 
> +/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: ports: 'port@0' is a required property
> +/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: ports: 'port@4' is a required property
> +/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: 'phys' is a required property
> +/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: 'phy-names' is a required property
> 
> This goes away with 2/2 although adds:
> +<stdout>: Warning (graph_child_address): /bus@100000/dss@4a00000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> 
> 
> Do we need to have empty ports node in j721e-main.dtsi for dp-bridge?   And something similar wrt phys as well?
> 
> Regards
> Vignesh

Hi Vignesh,

Thanks for the review!
Not sure why kernel patch verify did not catch this

I can fix the warnings for ports by adding empty ports in 1/2
For "phys" I can move the phy node from 2/2 to 1/2
But the commit will spill over both dtsi and dts files
is that okay, can you please give your inputs here

Regards
Rahul T R
 
> 
> > 
> >  .../dts/ti/k3-j721e-common-proc-board.dts     | 78 ++++++++++++++++++-
> >  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 65 ++++++++++++++++
> >  2 files changed, 139 insertions(+), 4 deletions(-)
> > 
