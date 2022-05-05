Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1ED51BBC5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352446AbiEEJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352401AbiEEJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:22:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42334EA0B;
        Thu,  5 May 2022 02:18:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2459IWqF085252;
        Thu, 5 May 2022 04:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651742312;
        bh=6V3a9+JlRTufTHiOEcQhgf3YVpwp351iscPPdjxeuYc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LVcNC/mZA6s2HiKPgzVQWtg9MHorI45RgWePdIfJCFArqExS/1/Ktq97Qbc7ndomX
         0pnxWqoKrVWEkhgl9JaklInaqXvvPbsQNHP+RbK0omDTbxdD+vxqqRGHTsEBXvuFJH
         FAbPDSII/eXGmo+YhuTmwLtOei4YxdTnEfeo1BB0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2459IWdp125024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 May 2022 04:18:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 5
 May 2022 04:18:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 5 May 2022 04:18:32 -0500
Received: from [172.24.223.223] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2459IS6E026459;
        Thu, 5 May 2022 04:18:29 -0500
Message-ID: <8253758f-54fa-4f89-10b0-7079e1a98136@ti.com>
Date:   Thu, 5 May 2022 14:48:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/2] Add support for DP and HDMI on j721e-sk
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>
References: <20220505090709.9252-1-r-ravikumar@ti.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20220505090709.9252-1-r-ravikumar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/05/22 14:37, Rahul T R wrote:
> The following series of patches enables DisplayPort and
> HDMI on j721e-sk
> 
> v2:
>    - Fix name for dpi1 dss endpoint
> 
> This series depends on
> https://lore.kernel.org/all/20220429112639.13004-1-r-ravikumar@ti.com/
> which adds required nodes in the SoC dtsi file
> 
> boot logs:
>    https://gist.githubusercontent.com/ravi-rahul/d2e139d8ff9446ede003291a6a3e8be5/raw/ed51498efe7f7bc4848dffb27e2b37e0beb7a94d/j7_sk_DP_HDMI_boot.log
> 
> kernel patch verify report:
>    https://gist.githubusercontent.com/ravi-rahul/1e2350b53ac7d6ba7694373c0b3bbb44/raw/f09f75821610b42ad1f8b4bf3e5ef7843de0c76e/report-kernel-patch-verify-sk-dp-hdmi.txt
> 
> Rahul T R (2):
>   arm64: dts: ti: k3-j721e-sk: Enable DisplayPort
>   arm64: dts: ti: k3-j721e-sk: Enable HDMI
> 
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 123 ++++++++++++++++++++++++-
>  1 file changed, 119 insertions(+), 4 deletions(-)
> 

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
