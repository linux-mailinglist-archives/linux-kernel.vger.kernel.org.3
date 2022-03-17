Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF34DC9C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbiCQPS4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Mar 2022 11:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiCQPSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:18:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAB1205962;
        Thu, 17 Mar 2022 08:17:37 -0700 (PDT)
Received: from canpemm100005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KK9gn3zqhzCqmW;
        Thu, 17 Mar 2022 23:15:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 canpemm100005.china.huawei.com (7.192.105.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:17:34 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Thu, 17 Mar 2022 15:17:33 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: adjust entry for header movement in
 hisilicon qm driver
Thread-Topic: [PATCH] MAINTAINERS: adjust entry for header movement in
 hisilicon qm driver
Thread-Index: AQHYOTNV513lw7emgUOm96IZ4FdBD6zDr8SA
Date:   Thu, 17 Mar 2022 15:17:32 +0000
Message-ID: <75f18d2f04f949d390a9b97cdc81c284@huawei.com>
References: <20220316124224.29091-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220316124224.29091-1-lukas.bulwahn@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Lukas Bulwahn [mailto:lukas.bulwahn@gmail.com]
> Sent: 16 March 2022 12:42
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> Alex Williamson <alex.williamson@redhat.com>
> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; David S . Miller <davem@davemloft.net>;
> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org;
> kernel-janitors@vger.kernel.org; Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Subject: [PATCH] MAINTAINERS: adjust entry for header movement in hisilicon
> qm driver
> 
> Commit ff5812e00d5e ("crypto: hisilicon/qm: Move the QM header to
> include/linux") moves drivers/crypto/hisilicon/qm.h to
> include/linux/hisi_acc_qm.h, but misses to adjust MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Adjust the file entry in the HISILICON QM AND ZIP Controller DRIVER
> following this file movement.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Thanks for this.

Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Shameer

> Alex, please pick this minor clean-up on your -next tree on top of the
> commit above.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 845b36c0f0f5..963d7001f2ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8852,9 +8852,9 @@ L:	linux-crypto@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/debugfs-hisi-zip
>  F:	drivers/crypto/hisilicon/qm.c
> -F:	drivers/crypto/hisilicon/qm.h
>  F:	drivers/crypto/hisilicon/sgl.c
>  F:	drivers/crypto/hisilicon/zip/
> +F:	include/linux/hisi_acc_qm.h
> 
>  HISILICON ROCE DRIVER
>  M:	Wenpeng Liang <liangwenpeng@huawei.com>
> --
> 2.17.1

