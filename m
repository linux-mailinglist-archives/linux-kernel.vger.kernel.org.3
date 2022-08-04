Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE85899C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbiHDJPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbiHDJPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:15:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731D65573;
        Thu,  4 Aug 2022 02:15:08 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lz2xc18ybz67Qtq;
        Thu,  4 Aug 2022 17:10:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 4 Aug 2022 11:15:06 +0200
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 4 Aug
 2022 10:15:05 +0100
Date:   Thu, 4 Aug 2022 10:15:03 +0100
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
Subject: Re: [PATCH 1/3] cxl/regions: add padding for cxl_rr_ep_add nested
 lists
Message-ID: <20220804101503.000039ff@huawei.com>
In-Reply-To: <20220804075448.98241-2-bagasdotme@gmail.com>
References: <20220804075448.98241-1-bagasdotme@gmail.com>
        <20220804075448.98241-2-bagasdotme@gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
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

On Thu,  4 Aug 2022 14:54:46 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Sphinx reported indentation warnings:
> 
> Documentation/driver-api/cxl/memory-devices:457: ./drivers/cxl/core/region.c:732: WARNING: Unexpected indentation.
> Documentation/driver-api/cxl/memory-devices:457: ./drivers/cxl/core/region.c:733: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/driver-api/cxl/memory-devices:457: ./drivers/cxl/core/region.c:735: WARNING: Unexpected indentation.
> 
> These warnings above are due to missing blank line padding in the nested list
> in kernel-doc comment for cxl_rr_ep_add().
> 
> Add the paddings to fix the warnings.
> 
> Fixes: 384e624bb211b4 ("cxl/region: Attach endpoint decoders")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Looks right to me.  Sphinx white space around lists is annoyingly fiddly but
such is life.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index dc71ec457608d2..616db51c4e78cf 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -728,11 +728,14 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
>   * in particular decoder target lists.
>   *
>   * The steps are:
> + *
>   * - validate that there are no other regions with a higher HPA already
>   *   associated with @port
>   * - establish a region reference if one is not already present
> + *
>   *   - additionally allocate a decoder instance that will host @cxlr on
>   *     @port
> + *
>   * - pin the region reference by the endpoint
>   * - account for how many entries in @port's target list are needed to
>   *   cover all of the added endpoints.

