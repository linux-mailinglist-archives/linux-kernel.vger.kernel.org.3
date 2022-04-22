Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6108F50C1E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiDVV5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiDVV4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:56:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BDF407ED4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:42:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23MIeMoG033941;
        Fri, 22 Apr 2022 13:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650652822;
        bh=jL5+JwCMsTSzM2LVGeKWU46/zHtkF+EJ8LNwJy/lJNM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cTkH6TMEhd/jT7YSK904kjPRxu962l78xyt8Dhv0/OvVn4MNtq/9sVLnVXfg3bmux
         ZlMAVyn3QwcyX3x4EpL9+HQPUuwV/4cG6jOjKSb4llGQIA0iJLT9Q0EjMO0R3dMVIq
         j+/8wotR7NnktIST0hxWIh5h62OXE5zdZXr3kwjY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23MIeMAp011441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 13:40:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 13:40:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 13:40:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23MIeL4o078154;
        Fri, 22 Apr 2022 13:40:21 -0500
Date:   Fri, 22 Apr 2022 13:40:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <cgel.zte@gmail.com>, <tony@atomide.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] soc: ti: pm33xx: using pm_runtime_resume_and_get instead
 of pm_runtime_get_sync
Message-ID: <20220422184021.v2w55kbvllu3flar@daughter>
References: <20220418063059.2558074-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220418063059.2558074-1-chi.minghao@zte.com.cn>
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

On 06:30-20220418, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Tony: Could you check?

> ---
>  drivers/soc/ti/pm33xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
> index 7bab4bbaf02d..ce09c42eaed2 100644
> --- a/drivers/soc/ti/pm33xx.c
> +++ b/drivers/soc/ti/pm33xx.c
> @@ -555,11 +555,9 @@ static int am33xx_pm_probe(struct platform_device *pdev)
>  #endif /* CONFIG_SUSPEND */
>  
>  	pm_runtime_enable(dev);
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		goto err_pm_runtime_disable;
> -	}
>  
>  	ret = pm_ops->init(am33xx_do_sram_idle);
>  	if (ret) {
> -- 
> 2.25.1
> 
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
