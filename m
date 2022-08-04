Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6E589CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbiHDNfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239915AbiHDNfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:35:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FDC3B972;
        Thu,  4 Aug 2022 06:35:44 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lz8kJ2RzGz67NKF;
        Thu,  4 Aug 2022 21:30:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 15:35:42 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 4 Aug
 2022 14:35:41 +0100
Date:   Thu, 4 Aug 2022 14:35:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] cxl/region: describe targets and nr_targets members
 of cxl_region_params
Message-ID: <20220804143540.000041c2@huawei.com>
In-Reply-To: <20220804075448.98241-3-bagasdotme@gmail.com>
References: <20220804075448.98241-1-bagasdotme@gmail.com>
        <20220804075448.98241-3-bagasdotme@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Aug 2022 14:54:47 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Sphinx reported undescribed parameters in cxl_region_params struct:
> 
> ./drivers/cxl/cxl.h:376: warning: Function parameter or member 'targets' not described in 'cxl_region_params'
> ./drivers/cxl/cxl.h:376: warning: Function parameter or member 'nr_targets' not described in 'cxl_region_params'
> 
> Describe these members.
> 
> Fixes: dd5ba0ebbdc414 ("cxl/region: Add a 'uuid' attribute")
That seems unlikely to be right tag. Probably b9686e8c8e39

With that tidied up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/cxl/cxl.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 75674400cc8d41..65aaf15aa17e29 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -362,6 +362,8 @@ enum cxl_config_state {
>   * @interleave_ways: number of endpoints in the region
>   * @interleave_granularity: capacity each endpoint contributes to a stripe
>   * @res: allocated iomem capacity for this region
> + * @targets: active ordered targets in current decoder configuration
> + * @nr_targets: number of targets
>   *
>   * State transitions are protected by the cxl_region_rwsem
>   */

