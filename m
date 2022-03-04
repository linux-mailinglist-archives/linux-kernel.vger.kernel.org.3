Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C99D4CDA32
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbiCDRXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbiCDRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:23:08 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBB51520DF;
        Fri,  4 Mar 2022 09:22:20 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A8EB62C0;
        Fri,  4 Mar 2022 17:22:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A8EB62C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1646414539; bh=oxqXpFYHpIv/m/1a18AtruSu7jdnaHfA1jf9v/hyMxc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IuNBJ/vCvpz4WPzgxJh1rF8qnaiA6UOVPqBlG7Wul0TcLAUqL34b6xFpj3O5EELVw
         /YHCLJtElqC3aOpiPsIDDTDUeoMKMhBC70l4Lq+vSSRYwcKrNLU3EaEldjb0OPB8Vb
         MnM6fT+HBSp1zwGFWdf+reJyta4fJXo+WGojEfQNBnL9MP8J0SBluoeps6BOAxzP0Z
         o8uqp0cYTa03INFYNY3PA4LskGXWSjttrembjacwl9XeSTHaHU/GDHcmqhrpe4uqwS
         vHuDsJgA1u9skxLatY6r7Poby1AGhXNNfa9eo9dt+PTGZnovr011rYySkY0gbOwHQm
         HNxMiUqSetkcg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Qi Liu <liuqi115@huawei.com>, Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com
Subject: Re: [PATCH] docs: fix 'make htmldocs' warning in perf
In-Reply-To: <20220228031700.1669086-1-wanjiabing@vivo.com>
References: <20220228031700.1669086-1-wanjiabing@vivo.com>
Date:   Fri, 04 Mar 2022 10:22:19 -0700
Message-ID: <87tucdfx9w.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wan Jiabing <wanjiabing@vivo.com> writes:

> Fix following 'make htmldocs' warnings:
> ./Documentation/admin-guide/perf/hisi-pcie-pmu.rst: WARNING:
> document isn't included in any toctree
>
> Fixes: c8602008e247 ("docs: perf: Add description for HiSilicon PCIe PMU driver")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  Documentation/admin-guide/perf/index.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 5a8f2529a033..69b23f087c05 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -8,6 +8,7 @@ Performance monitor support
>     :maxdepth: 1
>  
>     hisi-pmu
> +   hisi-pcie-pmu
>     imx-ddr

Applied, thanks.

jon
