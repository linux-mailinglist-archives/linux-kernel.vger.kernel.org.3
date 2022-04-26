Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917E6510131
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351835AbiDZO7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345047AbiDZO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:59:41 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A3692BF;
        Tue, 26 Apr 2022 07:56:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23QEuLXW054245;
        Tue, 26 Apr 2022 09:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650984981;
        bh=OnduF3LsOWR2zr4akgCgTA3k4E/PAj89iQ6krG9cm48=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HMtXvTAyrOXI4tLDhh/96Zojc2y+4rmxa2FPq/cwnqamOE+1RX9WZ5J3d/dAAQThp
         kVivtr7jU6XbM+y93Q9Lh+IXK0G9iDN+FI8UZXDjHCXRw5L4ueEBP/03iVmnPykcjy
         pkz66idina4Zck2i+HsoRSmkfyN78Sm0fRIw4WSU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23QEuLHh055593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Apr 2022 09:56:21 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 26
 Apr 2022 09:56:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 26 Apr 2022 09:56:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23QEuJIp008253;
        Tue, 26 Apr 2022 09:56:20 -0500
Date:   Tue, 26 Apr 2022 20:26:19 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>
Subject: Re: [PATCH v3 0/2] DSS: Add support for DisplayPort
Message-ID: <20220426145618.wcrggf3qmkldihv3@uda0490373>
References: <20220406165852.13026-1-r-ravikumar@ti.com>
 <ed64bf63-95c6-94ae-4c4f-a206250f44a9@ti.com>
 <20220422141637.4hz5nrlpjapmqezw@uda0490373>
 <20220422161711.jkderbw5r4wxwgjf@crudeness>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220422161711.jkderbw5r4wxwgjf@crudeness>
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

On 11:17-20220422, Nishanth Menon wrote:
> On 19:46-20220422, Rahul T R wrote:
> > On 12:51-20220415, Vignesh Raghavendra wrote:
> > > 
> > > 
> > > On 06/04/22 10:28 pm, Rahul T R wrote:
> > > > The following series of patches enables DisplayPort on
> > > > j721e-evm
> > > > 
> > > > Tomi Valkeinen (2):
> > > >   arm64: dts: ti: k3-j721e-main: add DP & DP PHY
> > > >   arm64: dts: ti: k3-j721e-common-proc-board: add DP to j7 evm
> > > > 
> > > > v2:
> > > >    - use phandle with a parameter to refer clocks insted of
> > > >      sub nodes in serdes_wiz node
> > > >    - move phy link node to board DTS file
> > > > 
> > > > v3:
> > > >    - Fix the regulator node name as per the DT spec
> > > >    - Use Macro for GPIO type
> > > > 
> > > > boot logs:
> > > >    https://gist.githubusercontent.com/ravi-rahul/1bdbc3f77ab381e486c8394650c2e85d/raw/f04584c30181821c4ee83aee7781a9ba143cd3f3/j7_DP_upstream.log
> > > > 
> > > > kernel patch verify report:
> > > >    https://gist.githubusercontent.com/ravi-rahul/a982fef3fae03ec0dbdd5cb475a4cb25/raw/c8230370746e9878daf9527c3aa9d82eed7aa33c/report-kernel-patch-verify.txt
> > > 
> > > Hmm, With dtbs_check I see (on v5.18-rc1 tag)
> > > 
> > > +/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: ports: 'port@0' is a required property
> > > +/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: ports: 'port@4' is a required property
> > > +/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: 'phys' is a required property
> > > +/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: 'phy-names' is a required property
> > > 
> > > This goes away with 2/2 although adds:
> > > +<stdout>: Warning (graph_child_address): /bus@100000/dss@4a00000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> > > 
> > > 
> > > Do we need to have empty ports node in j721e-main.dtsi for dp-bridge?   And something similar wrt phys as well?
> > > 
> > > Regards
> > > Vignesh
> > 
> > Hi Vignesh,
> > 
> > Thanks for the review!
> > Not sure why kernel patch verify did not catch this
> 
> if you are'nt able to install all the required packages and version of
> packages, then use the kpv wrapper script for docker container that
> already packages things.

Hi Nishanth,

kpv is expecting cross compile toolchain
to be present in /opt of host. Once I copied
the toolchain to /opt tests are running fine

I have fixed the dtbs_checks warnings, will
send v4 with the fixes

Thanks
Rahul T R

> -- 
> Regards,
> Nishanth Menon
> K ey (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
