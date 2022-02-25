Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3FB4C40D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbiBYJBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiBYJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:01:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371022399D2;
        Fri, 25 Feb 2022 01:01:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA7D461CDE;
        Fri, 25 Feb 2022 09:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4543C340F1;
        Fri, 25 Feb 2022 09:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645779673;
        bh=GCmgH9QxIie0Lmk0KfGGmFnY6Rs9w8GpqnAT9TcjK5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PY2HzAPBzy7DU+rIcW20j8VXOXmHbdyIeVKtnUI+sS0uLFAUJvKj2NpybLrwxLVuJ
         Q6BSeqLv0P4EWaWpQjq6Jx6eKkAJ3SBYoryAWx7BvV/gUYCpfi+YThAiyn5S3+ewq+
         7ht8EFSOCpJTntniHuh1wrn3QFkQdn9FAqPoiC76uxf2EHL9/EorChGusD/C07PQFr
         QNKvTetMr4vHTGGN+5KYyy5c+dhDSKetW+YkXmM/Mbbkq/SlM9NXvfHn5EHOBDWEvS
         5iRSjwWTbIFTehM90Me8fDHU8ZD17iVbYlMrfcRtML/wnaTZq/ZkparoDEQL+cDo5G
         FZpKhZq/2Fnug==
Date:   Fri, 25 Feb 2022 14:31:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Min Guo <Min.Guo@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/1] dt-bindings: phy: mediatek,tphy: Add compatible
 for MT8192
Message-ID: <Yhia1QX2j8mXwEqB@matsya>
References: <20220224130822.11292-1-allen-kh.cheng@mediatek.com>
 <20220224130822.11292-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224130822.11292-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-22, 21:08, Allen-KH Cheng wrote:
> Add MT8192 compatible to the Mediatek T-PHY dt-binding.

Applied, thanks

-- 
~Vinod
