Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC4550197
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382985AbiFRBLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiFRBLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:11:44 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53756AA76;
        Fri, 17 Jun 2022 18:11:43 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I1Bbks115437;
        Fri, 17 Jun 2022 20:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655514697;
        bh=qefky0L0/tfRDIoNIl7XHtyx0o2Vnqk7WTUmHifBdzM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=B4SMRerNjvLtbIEep3a1FF+q567dzP2Gnq2P0+wJ2Od7sRzOl7QFB3sdvijdgGMBN
         8+XudCWtEYBQqxtTgMgzK3x2oaehKZeVzCVzAqSa/5fVLqoGUsSvwDTRbADYBJBFV2
         8K1bJo/DjqDja7TzgzQgdGb/lPYs0KItqT70pIgY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I1BbmX016741
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 20:11:37 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 20:11:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 20:11:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I1BbI9067999;
        Fri, 17 Jun 2022 20:11:37 -0500
Date:   Fri, 17 Jun 2022 20:11:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Rahul T R <r-ravikumar@ti.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am62-main: Add node for
 Display SubSystem
Message-ID: <20220618011137.vg6rqzsujwwjli22@kahuna>
References: <20220505134303.23208-1-a-bhatia1@ti.com>
 <20220505134303.23208-2-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220505134303.23208-2-a-bhatia1@ti.com>
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

On 19:13-20220505, Aradhya Bhatia wrote:
> Add DT node for the Display SubSystem on the am62x soc in cbass_main.
> The DSS IP on this soc is compatible with the one on the am65x soc.
> 
> The DSS supports one each of video pipeline (vid) and video-lite
> pipeline (vidl1). It outputs OLDI signals on one video port (vp1) and
> DPI signals on another (vp2). The video ports are connected to the
> pipelines via 2 identical overlay managers (ovr1 and ovr2).
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Reviewed-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index eec8dae65e7c..ff21efa4ffad 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -515,6 +515,36 @@ cpts@3d000 {
>  		};
>  	};
>  
> +	dss: dss@30200000 {
> +		compatible = "ti,am65x-dss";


After looking closer at DSS last few days, the OLDI is unfortunately
different on AM62x.

Even though DPI interface works fine, OLDI TX integration needs a
separate compatible.

I suggest sending a patch introducing ti,am625-dss compatible.

I will need to drop the entire series - if we can get the compatible
integrated to master, i can pick the dts updates in the rc1 after.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
