Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56A4CE621
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiCEQ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiCEQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:56:58 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E14A931;
        Sat,  5 Mar 2022 08:56:04 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 225GtVwN011482;
        Sat, 5 Mar 2022 10:55:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646499331;
        bh=y9pljp/pPzhOyhCwyrHJTvduYB4Oz8enqlds0O1sMPU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=c6o1oX/ZiYF9xzNXDZ9tjTeRB6WAE3NRV42QwEH+ZyP6IOgeXP6f2PkzzyKDhHG6/
         iew7Mdumy3p+D4I19YkQC6q4W+vtoRcXS7jveic9ugdkbdn+FelRyGulBMExhVrU9F
         0+D76l09pj2cpzi0iAUkG6hmn1+9wSiDuks6sFWg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 225GtUT2082346
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Mar 2022 10:55:31 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 5
 Mar 2022 10:55:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 5 Mar 2022 10:55:30 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 225GtURZ076806;
        Sat, 5 Mar 2022 10:55:30 -0600
Date:   Sat, 5 Mar 2022 10:55:30 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <edubezval@gmail.com>, <j-keerthy@ti.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <rui.zhang@intel.com>, <romain.naour@smile.fr>,
        <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] thermal: ti-soc-thermal: Remove unused function
 ti_thermal_get_temp()
Message-ID: <20220305165530.lro7ups4xv2injik@bryanbrattlof.com>
References: <20220305125047.26948-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220305125047.26948-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March  5, 2022, thus sayeth YueHaibing:
> commit b263b473bf62 ("thermal: ti-soc-thermal: Remove redundant code")
> left behind this, remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Bryan Brattlof <bb@ti.com>

thanks for helping clean the codebase :)
~Bryan

> ---
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 0959632b2170..703039d8b937 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -107,14 +107,6 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
>  	return ret;
>  }
>  
> -static inline int ti_thermal_get_temp(struct thermal_zone_device *thermal,
> -				      int *temp)
> -{
> -	struct ti_thermal_data *data = thermal->devdata;
> -
> -	return __ti_thermal_get_temp(data, temp);
> -}
> -
>  static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
>  {
>  	struct ti_thermal_data *data = p;
> -- 
> 2.17.1
> 
