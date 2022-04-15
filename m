Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2605026EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351566AbiDOIoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351496AbiDOIno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:43:44 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDF3BA30F;
        Fri, 15 Apr 2022 01:41:04 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nfHVj-003EZj-GL; Fri, 15 Apr 2022 18:41:01 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Apr 2022 16:40:59 +0800
Date:   Fri, 15 Apr 2022 16:40:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com, liulongfang@huawei.com
Subject: Re: [PATCH 00/11] add regitser checking and last word dumping for ACC
Message-ID: <Ylkvm35u8kfQVUf0@gondor.apana.org.au>
References: <20220409080328.15783-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409080328.15783-1-yekai13@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 04:03:17PM +0800, Kai Ye wrote:
> Add register detection function to accelerator. Add last word dumping
> function during acc engines controller reset. It can help to improve
> debugging capability.
> 
> Kai Ye (11):
>   crypto: hisilicon/qm - add register checking for ACC
>   crypto: hisilicon/hpre - support register checking
>   crypto: hisilicon/sec - support register checking
>   crypto: hisilicon/zip - support register checking
>   Documentation: update debugfs doc for Hisilicon HPRE
>   Documentation: update debugfs doc for Hisilicon SEC
>   Documentation: update debugfs doc for Hisilicon ZIP
>   crypto: hisilicon/qm - add last word dumping for ACC
>   crypto: hisilicon/sec - support last word dumping
>   crypto: hisilicon/hpre - support last word dumping
>   crypto: hisilicon/zip - support last word dumping
> 
>  Documentation/ABI/testing/debugfs-hisi-hpre |  14 ++
>  Documentation/ABI/testing/debugfs-hisi-sec  |  14 ++
>  Documentation/ABI/testing/debugfs-hisi-zip  |  14 ++
>  drivers/crypto/hisilicon/hpre/hpre_main.c   | 222 ++++++++++++++----
>  drivers/crypto/hisilicon/qm.c               | 239 +++++++++++++++++++-
>  drivers/crypto/hisilicon/sec2/sec_main.c    | 108 ++++++++-
>  drivers/crypto/hisilicon/zip/zip_main.c     | 185 ++++++++++++++-
>  include/linux/hisi_acc_qm.h                 |  18 ++
>  8 files changed, 765 insertions(+), 49 deletions(-)
> 
> -- 
> 2.33.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
