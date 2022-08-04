Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14342589CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiHDNdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiHDNcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:32:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710CC3E74D;
        Thu,  4 Aug 2022 06:32:45 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lz8gd6dbpz67KSZ;
        Thu,  4 Aug 2022 21:28:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 15:32:43 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 4 Aug
 2022 14:32:42 +0100
Date:   Thu, 4 Aug 2022 14:32:41 +0100
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
Subject: Re: [PATCH 3/3] Documentation: cxl: remove dangling kernel-doc
 reference
Message-ID: <20220804143241.000065d7@huawei.com>
In-Reply-To: <20220804075448.98241-4-bagasdotme@gmail.com>
References: <20220804075448.98241-1-bagasdotme@gmail.com>
        <20220804075448.98241-4-bagasdotme@gmail.com>
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

On Thu,  4 Aug 2022 14:54:48 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Sphinx reported kernel-doc failure warning, pointing to non-existent
> drivers/cxl/region.h (which doesn't also exist throughout repo history):
> 
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 2.4.4 -no-doc-sections ./drivers/cxl/region.h' failed with return code 1
> 
> Above cause error message to be displayed on htmldocs output.
> 
> Delete the reference.
> 
> Fixes: 779dd20cfb56c5 ("cxl/region: Add region creation support")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Ah. That went in some refactoring along the way.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/driver-api/cxl/memory-devices.rst | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 66ddc58a21b159..5149ecdc53c796 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -364,9 +364,6 @@ CXL Core
>  
>  CXL Regions
>  -----------
> -.. kernel-doc:: drivers/cxl/region.h
> -   :identifiers:
> -
>  .. kernel-doc:: drivers/cxl/core/region.c
>     :doc: cxl core region
>  

