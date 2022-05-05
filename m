Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D65A51BBA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352025AbiEEJQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351912AbiEEJQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:16:27 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D3A4BFCB;
        Thu,  5 May 2022 02:12:48 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2459CaQP083383;
        Thu, 5 May 2022 04:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651741956;
        bh=ikGXkgdLE1DkMj1btIvsFn4UR8U22+rJPBhuFGJ5eJ8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=MNzJbU/JMAvu+V2Fg092jIbIPFypbpkdLhhWUBD3bKafF0Cjs/K/ANN6VkVdcr/S8
         UAteGvcYiIE1E96p/Ps+rzdoDFj1tAwyCmV9zA+CvuaJ0XlvSYmiB9ym3lKea/4Xpp
         8m8Ux7IU6EnFuXVo/Em7BdEzOi9yR/1pR8Ctm7cE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2459Ca94121330
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 May 2022 04:12:36 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 5
 May 2022 04:12:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 5 May 2022 04:12:35 -0500
Received: from [172.24.223.223] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2459CVlv094171;
        Thu, 5 May 2022 04:12:32 -0500
Message-ID: <205118bb-d74d-3966-d89e-95e385154760@ti.com>
Date:   Thu, 5 May 2022 14:42:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 0/2] DSS: Add support for DisplayPort
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>
References: <20220429112639.13004-1-r-ravikumar@ti.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20220429112639.13004-1-r-ravikumar@ti.com>
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


On 29/04/22 16:56, Rahul T R wrote:
> The following series of patches enables DisplayPort on
> j721e-evm
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
> v4:
>    - Move adding of phy link nodes from 2/2 to 1/2, to fix dtbs checks warnings
>    - Add leading zeros to align reg property addresses and sizes
>    - Add empty ports for mhdp node in dtsi file to fix dtbs checks warnings
> 
> v5:
>    - Fix a typo in regulator name
> 
> boot logs:
>    https://gist.githubusercontent.com/ravi-rahul/1bdbc3f77ab381e486c8394650c2e85d/raw/2327c9894c3236950a00f4511ae668ac4399b71e/j7_DP_upstream.log
> 
> kernel patch verify report:
>    https://gist.githubusercontent.com/ravi-rahul/a982fef3fae03ec0dbdd5cb475a4cb25/raw/9ef482f96fa351cff7980e4340e9bcb8471ec3ab/report-kernel-patch-verify.txt
> 
> Tomi Valkeinen (2):
>   arm64: dts: ti: k3-j721e-*: add DP & DP PHY
>   arm64: dts: ti: k3-j721e-common-proc-board: add DP to j7 evm
> 
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 77 ++++++++++++++++++-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 75 +++++++++++++++++-
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 16 ++++
>  3 files changed, 162 insertions(+), 6 deletions(-)
> 

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
