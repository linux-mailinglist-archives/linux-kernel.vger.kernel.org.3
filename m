Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09DF569A11
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiGGFxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGGFx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:53:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9C8E0F0;
        Wed,  6 Jul 2022 22:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43CB8B81FF8;
        Thu,  7 Jul 2022 05:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B05CC3411E;
        Thu,  7 Jul 2022 05:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657173204;
        bh=Hm0V5AZBxOdfjJJarJ/m/nrDDbAsODcvlXQWn0EIiOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVvMjKCfEFUbNtcCMVEzfXq62PvzKMDmP0aQUctWM2koFjwdDZSbGxaFwiaCC9Cb8
         8uEGzrmZk8JtpVrOQEDcNRPQax5zi94s6NoH7xj3EOyneiKKRMRJRWTqWVRI/u6SVs
         rQQ9v30rn8MFIBSaHZkZE4QLEOaRnULb94qGF0KG6CWuIuhnnZVHhbRIBzd3HiyjsB
         nAJmkWjV4cj1FcbFioj2p0AAw9gmAT5jwVbcvAjVl3yQXCdbmNiVwEUXfCFaac4Ws7
         3/9TlWWGvzQoEVjTXgT3DsIF/QVwqpprxz4BimHYGsYlpZ9jNmLqE6f3PjqpV8J8S8
         F8U8CHHOzBR4Q==
Date:   Thu, 7 Jul 2022 11:23:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the phy-next tree
Message-ID: <YsZ00HwryKI++qTa@matsya>
References: <20220707153941.668cd6d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707153941.668cd6d5@canb.auug.org.au>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-07-22, 15:39, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the phy-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/phy/qualcomm/phy-qcom-qmp-combo.c: In function 'qcom_qmp_phy_combo_vreg_init':
> drivers/phy/qualcomm/phy-qcom-qmp-combo.c:2004:9: error: 'Return' undeclared (first use in this function)
>  2004 |         Return 0;
>       |         ^~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-combo.c:2004:9: note: each undeclared identifier is reported only once for each function it appears in
> drivers/phy/qualcomm/phy-qcom-qmp-combo.c:2004:15: error: expected ';' before numeric constant
>  2004 |         Return 0;

Thanks I have fixed that up and pushed updated tree



-- 
~Vinod
