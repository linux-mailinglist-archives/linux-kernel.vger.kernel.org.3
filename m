Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE43502622
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350966AbiDOHYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346594AbiDOHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:24:02 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494D8939BF;
        Fri, 15 Apr 2022 00:21:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23F7LIpt034416;
        Fri, 15 Apr 2022 02:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650007278;
        bh=eDLUUFxUqpTW3MCa8U4C4VnaJ9sgEUwdiLW2sre19uk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mJavWI+YvxjFU0gPLbsDNMpepV1tLWkbOOfxYrsCtIDLR5NA7Vb4hKQDRQY9VyN20
         tv0IOx5oUO6LPlyY/0BAgi3gVmzIsxenQ4HTHhaTAs0d5ED8QWiFFp3B18MZLqMePt
         MWpu5Scuv2fhus0mC36ta07omNGxxToiwQzKy1WQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23F7LHsq097757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 02:21:17 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 02:21:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 02:21:17 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23F7LC42010072;
        Fri, 15 Apr 2022 02:21:13 -0500
Message-ID: <ed64bf63-95c6-94ae-4c4f-a206250f44a9@ti.com>
Date:   Fri, 15 Apr 2022 12:51:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/2] DSS: Add support for DisplayPort
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, <nm@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>
References: <20220406165852.13026-1-r-ravikumar@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220406165852.13026-1-r-ravikumar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/22 10:28 pm, Rahul T R wrote:
> The following series of patches enables DisplayPort on
> j721e-evm
> 
> Tomi Valkeinen (2):
>   arm64: dts: ti: k3-j721e-main: add DP & DP PHY
>   arm64: dts: ti: k3-j721e-common-proc-board: add DP to j7 evm
> 
> v2:
>    - use phandle with a parameter to refer clocks insted of
>      sub nodes in serdes_wiz node
>    - move phy link node to board DTS file
> 
> v3:
>    - Fix the regulator node name as per the DT spec
>    - Use Macro for GPIO type
> 
> boot logs:
>    https://gist.githubusercontent.com/ravi-rahul/1bdbc3f77ab381e486c8394650c2e85d/raw/f04584c30181821c4ee83aee7781a9ba143cd3f3/j7_DP_upstream.log
> 
> kernel patch verify report:
>    https://gist.githubusercontent.com/ravi-rahul/a982fef3fae03ec0dbdd5cb475a4cb25/raw/c8230370746e9878daf9527c3aa9d82eed7aa33c/report-kernel-patch-verify.txt

Hmm, With dtbs_check I see (on v5.18-rc1 tag)

+/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: ports: 'port@0' is a required property
+/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: ports: 'port@4' is a required property
+/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: 'phys' is a required property
+/workdir/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: dp-bridge@a000000: 'phy-names' is a required property

This goes away with 2/2 although adds:
+<stdout>: Warning (graph_child_address): /bus@100000/dss@4a00000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary


Do we need to have empty ports node in j721e-main.dtsi for dp-bridge?   And something similar wrt phys as well?

Regards
Vignesh

> 
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 78 ++++++++++++++++++-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 65 ++++++++++++++++
>  2 files changed, 139 insertions(+), 4 deletions(-)
> 
