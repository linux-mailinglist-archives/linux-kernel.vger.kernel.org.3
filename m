Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B134F7560
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 07:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbiDGFeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 01:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiDGFeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 01:34:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10577DD5;
        Wed,  6 Apr 2022 22:32:44 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2375WfAq111462;
        Thu, 7 Apr 2022 00:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649309561;
        bh=9X51TdJHUCLYh+di/XNgaYLQgZEYwINWiXfEVFy5c5w=;
        h=Date:From:Subject:CC:References:In-Reply-To;
        b=oXnFTsgtzn7avFPnFhDTxyFk6oRHJpQ2dr0zd6nuOJOG8Blv2+VOax4Z6ARMPEk5U
         0u+7W/lsVJDXxsTQOysHuGDsl+WJOnEWWGJulU4oY26ORIfPQroBz4S/VsATdMs1SZ
         r1eFDFuiGiaY5uYZMQOi2cCeRKhhp8l4++pP9GkM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2375Wfjc115909
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Apr 2022 00:32:41 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Apr 2022 00:32:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Apr 2022 00:32:41 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2375Wb8S018307;
        Thu, 7 Apr 2022 00:32:38 -0500
Message-ID: <301bc860-bab7-9e18-9cef-7c8069d112dc@ti.com>
Date:   Thu, 7 Apr 2022 11:02:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Aswath Govindraju <a-govindraju@ti.com>
Subject: Re: [PATCH v2 0/2] AM62: Add support for AM62 USB wrapper driver
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20220324073425.18607-1-a-govindraju@ti.com>
Content-Language: en-US
In-Reply-To: <20220324073425.18607-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 24/03/22 13:04, Aswath Govindraju wrote:
> The following series of patches add support for AM62 USB wrapper driver
> and its corresponding bindings.
> 
> changes since v1:
> - Fixed the error with dev_pm_ops uninitialization, in patch 2.
>   This was reported by kernel test bot
> - In patch 1, made correction in grammer of clocks property description
>   and added maxItems in the interrupts property based on comments
>   received from Roger
> - In patch 1, corrected the title, fixed the description of
>   ti,syscon-phy-pll-refclk, added pattern properties and child node
>   in the example based on the comments from Krzysztof.
> 

Thank you for all the review and comments. I have posted respin(v3) for
this patch series. Here is the link to the series

https://patchwork.kernel.org/project/linux-usb/list/?series=629613

Regards,
Aswath

> Aswath Govindraju (2):
>   dt-bindings: usb: Add documentation for AM62 USB Wrapper module
>   drivers: usb: dwc3: Add AM62 USB wrapper driver
> 
>  .../devicetree/bindings/usb/ti,am62-usb.yaml  | 117 ++++
>  drivers/usb/dwc3/Kconfig                      |   9 +
>  drivers/usb/dwc3/Makefile                     |   1 +
>  drivers/usb/dwc3/dwc3-am62.c                  | 581 ++++++++++++++++++
>  4 files changed, 708 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>  create mode 100644 drivers/usb/dwc3/dwc3-am62.c
> 
