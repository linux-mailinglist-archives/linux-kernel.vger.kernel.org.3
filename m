Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C24550212
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383892AbiFRCk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiFRCk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:40:56 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A982579AB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:40:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I2emso008858;
        Fri, 17 Jun 2022 21:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655520048;
        bh=oXLqMye2VzEFwSwRHpDgWkr1vSMEoKi8gVzaBkQA9xA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ivX39e6m1HD2Ie1wZMEbzomCsgpi6GKSstZSBweUkSWhAjWo3gv/gYB/PDycsyCrf
         nTINIqhQ86BhqWOXJiTTVHLnq/nOCxIxdpHwanfYajhB6Kkc02kp+B23at8Rcpc+Ll
         9Zkuzk9C4pN0rWMfWpDz5s/DSJ9VjGyVNjzBLH1U=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I2emef060805
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 21:40:48 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 21:40:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 21:40:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I2em3f006228;
        Fri, 17 Jun 2022 21:40:48 -0500
Date:   Fri, 17 Jun 2022 21:40:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Yihao Han <hanyihao@vivo.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@vivo.com>
Subject: Re: [PATCH] soc: ti: wkup_m3_ipc: replace DEFINE_SIMPLE_ATTRIBUTE
 with DEFINE_DEBUGFS_ATTRIBUTE
Message-ID: <20220618024048.hr7hgphogmdaeq2x@kahuna>
References: <20220505024833.8494-1-hanyihao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220505024833.8494-1-hanyihao@vivo.com>
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

On 19:48-20220504, Yihao Han wrote:
> Fix the following coccicheck warning:
> ./drivers/soc/ti/wkup_m3_ipc.c:198:0-23: WARNING: 
> wkup_m3_ipc_option_fops should be defined with
> DEFINE_DEBUGFS_ATTRIBUTE
> 
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
>  drivers/soc/ti/wkup_m3_ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
> index 0076d467ff6b..2142d8fb3f5c 100644
> --- a/drivers/soc/ti/wkup_m3_ipc.c
> +++ b/drivers/soc/ti/wkup_m3_ipc.c
> @@ -195,7 +195,7 @@ static int option_set(void *data, u64 val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(wkup_m3_ipc_option_fops, option_get, option_set,
> +DEFINE_DEBUGFS_ATTRIBUTE(wkup_m3_ipc_option_fops, option_get, option_set,
>  			"%llu\n");

Please run ./scripts/checkpatch --strict patch
+CHECK: Alignment should match open parenthesis
+#29: FILE: drivers/soc/ti/wkup_m3_ipc.c:199:
++DEFINE_DEBUGFS_ATTRIBUTE(wkup_m3_ipc_option_fops, option_get, option_set,
+                       "%llu\n");
+      mechanically convert to the typical style using --fix or --fix-inplace.
+      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Could you fix and post a V2?
>  
>  static int wkup_m3_ipc_dbg_init(struct wkup_m3_ipc *m3_ipc)
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
