Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D804B2FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353041AbiBKVt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:49:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiBKVt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:49:56 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9713BC;
        Fri, 11 Feb 2022 13:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1644616195; x=1676152195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2DZlz+KWRMuPBUe4kbrkD1rG3/fuBWjI9bjWXaq3ZVA=;
  b=fDdnKonYgkDhugrv6DRT9Hy4hjFhsjgaPf3rO0ENsE4uh4v/w54R1Yml
   D2KvFZOXbGdd9arQoQ7/UIo9FFj7HFC0dvtwAWyQ+wXbb9YIczFWPIKFA
   +EmfL4EFaUNn6hg8801WSc7Un2PleCEqN/cA+e1hcXRqulBh5K+X9UYgJ
   A=;
X-IronPort-AV: E=Sophos;i="5.88,361,1635206400"; 
   d="scan'208";a="176138757"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-98691110.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 11 Feb 2022 21:49:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-98691110.us-east-1.amazon.com (Postfix) with ESMTPS id 15656813F8;
        Fri, 11 Feb 2022 21:49:49 +0000 (UTC)
Received: from EX13D47UWC001.ant.amazon.com (10.43.162.39) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 11 Feb 2022 21:49:44 +0000
Received: from amazon.com (10.43.162.144) by EX13D47UWC001.ant.amazon.com
 (10.43.162.39) with Microsoft SMTP Server (TLS) id 15.0.1497.28; Fri, 11 Feb
 2022 21:49:43 +0000
Date:   Fri, 11 Feb 2022 14:49:41 -0700
From:   Jordan Crouse <jorcrous@amazon.com>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <bhupesh.linux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <stephan@gerhold.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v5 00/22] Enable Qualcomm Crypto Engine on sm8150 & sm8250
Message-ID: <20220211214941.f55q5yksittut3ep@amazon.com>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
User-Agent: NeoMutt/20171215
X-Originating-IP: [10.43.162.144]
X-ClientProxiedBy: EX13D14UWB002.ant.amazon.com (10.43.161.216) To
 EX13D47UWC001.ant.amazon.com (10.43.162.39)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 04:29:00PM +0530, Bhupesh Sharma wrote:
> Changes since v4:
> =================
> - v4 for sm8250 can be seen here: https://lore.kernel.org/linux-arm-msm/20211013105541.68045-1-bhupesh.sharma@linaro.org/
> - v1 for sm8150 qce enablement can be seen here: https://lore.kernel.org/linux-arm-msm/20211013165823.88123-1-bhupesh.sharma@linaro.org/
> - Merged the sm8150 and sm8250 enablement patches in the same patchset,
>   as per suggestions from Bjorn.
> - Dropped a couple of patches from v4, as these have been picked by
>   Bjorn already via his tree.
> - Addressed review comments from Vladimir, Thara and Rob.
> - Collect Reviewed-by from Rob and Thara on some of the patches from the
>   v4 patchset.
> 
> Changes since v3:
> =================
> - v3 can be seen here: https://lore.kernel.org/linux-arm-msm/20210519143700.27392-1-bhupesh.sharma@linaro.org/
> - Dropped a couple of patches from v3, on basis of the review comments:
>    ~ [PATCH 13/17] crypto: qce: core: Make clocks optional
>    ~ [PATCH 15/17] crypto: qce: Convert the device found dev_dbg() to dev_info()
> - Addressed review comments from Thara, Rob and Stephan Gerhold.
> - Collect Reviewed-by from Rob and Thara on some of the patches from the
>   v3 patchset.
> 
> Changes since v2:
> =================
> - v2 can be seen here: https://lore.kernel.org/dmaengine/20210505213731.538612-1-bhupesh.sharma@linaro.org/
> - Drop a couple of patches from v1, which tried to address the defered
>   probing of qce driver in case bam dma driver is not yet probed.
>   Replace it instead with a single (simpler) patch [PATCH 16/17].
> - Convert bam dma and qce crypto dt-bindings to YAML.
> - Addressed review comments from Thara, Bjorn, Vinod and Rob.
> 
> Changes since v1:
> =================
> - v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20210310052503.3618486-1-bhupesh.sharma@linaro.org/ 
> - v1 did not work well as reported earlier by Dmitry, so v2 contains the following
>   changes/fixes:
>   ~ Enable the interconnect path b/w BAM DMA and main memory first
>     before trying to access the BAM DMA registers.
>   ~ Enable the interconnect path b/w qce crytpo and main memory first
>     before trying to access the qce crypto registers.
>   ~ Make sure to document the required and optional properties for both
>     BAM DMA and qce crypto drivers.
>   ~ Add a few debug related print messages in case the qce crypto driver
>     passes or fails to probe.
>   ~ Convert the qce crypto driver probe to a defered one in case the BAM DMA
>     or the interconnect driver(s) (needed on specific Qualcomm parts) are not
>     yet probed.
> 
> Qualcomm crypto engine is also available on sm8150 and sm8250 SoCs.
> The qce block supports hardware accelerated algorithms for encryption
> and authentication. It also provides support for aes, des, 3des
> encryption algorithms and sha1, sha256, hmac(sha1), hmac(sha256)
> authentication algorithms.
> 
> Tested the enabled crypto algorithms with cryptsetup test utilities
> on sm8150-mtp, sa8155p-adp, sm8250-mtp and RB5 boards (see [1]) and
> also with crypto self-tests, including the fuzz tests
>  (CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y).
> 
> [1]. https://linux.die.net/man/8/cryptsetup
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>

Extremely random drive-by. Bjorn pointed this series at me today and
I verified that it works and works well on sm8250. I agree with the
cleanups suggested but otherwise a very enthusiastic:

Tested-by: Jordan Crouse <jorcrous@amazon.com>

One nitpick possibly for the documentation somewhere. When I tried this
on my own I was using the reg base from the downstream kernel which is
obviously wrong. Perhaps a line somewhere in the bindings about
how you calculate the base address may help future porting efforts.

Jordan
