Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665A34962BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381806AbiAUQZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:25:04 -0500
Received: from ale.deltatee.com ([204.191.154.188]:42922 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiAUQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=kytrEWZ9vHuQBWDT3D9VZ4/u4ZwGzsRQyn7am4nCe9A=; b=e2F4wgWjQ2SGCE7U40qgI5ddIj
        GEZMV67QFl9GAX3aE5cL4wspFp0IJ7uSr8USQfKTg9z1X4rG1QKxKaTOpJMFUdz0cwtA7K0MdAOFM
        HUH6a6UvJemzx1a2wZFde+Cl0o4BMaIqw4TJRQNHcPQFqGBdJiNuCVPnFYM5TQUtkuVzbm5kHHqPZ
        Ox6CE54rqIdRblbMTVkz4sAGp7h93H/Rhfz8ootaZRQrE1bLu+03FkbqmkLDna7HyBXSTNZovf9rV
        nn8sBggtEgNfrglVRfUWrC6lcyZx4gnA71LTKSqpp2pT4ck6f2l6xxmtYiCogdm9cB4aoxJD5Ne0N
        qyeoGvGg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nAwij-000Rlw-FT; Fri, 21 Jan 2022 09:25:02 -0700
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220120230247.GA40182@embeddedor>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b2d9c1ad-9a6d-4e0c-e877-44029f4c1a7e@deltatee.com>
Date:   Fri, 21 Jan 2022 09:24:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220120230247.GA40182@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, gustavoars@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        LR_URI_NUMERIC_ENDING,NICE_REPLY_A autolearn=no autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH][next] NTB/msi: Use struct_size() helper in devm_kzalloc()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 2022-01-20 4:02 p.m., Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/ntb/msi.c:46:23: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
