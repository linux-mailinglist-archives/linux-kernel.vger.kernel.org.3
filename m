Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4894FC3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349055AbiDKSGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349050AbiDKSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:06:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB437BE8;
        Mon, 11 Apr 2022 11:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54BA160FD2;
        Mon, 11 Apr 2022 18:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275CEC385A4;
        Mon, 11 Apr 2022 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649700273;
        bh=MuQab/xaawBX0nLDyPNsiNOXlr4TZ0C1l+8XGJX/Rzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMWzoBKSQFwn5Xn+Jo9g5l8lpG/gy5gTwOoLzQnS34q7A5xpbxHssn9jFccKe6Zfh
         QxWkxp3QcgstyPxAmpblD2IVLfvLjOPCMehsLYCld6BjnfLm/i9Oahdks1S8ca0DPT
         s2KpeXE9p4/wiDNBOsFwzjRUP36Vdevb4hPEz0/RB38ZBKrJ6QFgLzo6FDlJbJI4xL
         dZj+0q7zLT7BsVlGqjZQ1e6xC3cPu4gHJQ+t0wlDHzL8ihsgruWyAlAoJ7gGe2jLly
         2pUd3K4Ye5piIXxsnOZgApkiUZ9ZIQsb1xAafiEk0I8Glog+Byk9zDhC1QOZHVPbxa
         DDBFYu8QTxCdQ==
Date:   Mon, 11 Apr 2022 23:34:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] phy: qcom-qmp: Add SM6350 UFS PHY support
Message-ID: <YlRtra5AZAw2NWMT@matsya>
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-4-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321133318.99406-4-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-22, 14:33, Luca Weiss wrote:
> The SM6350 UFS PHY is compatible with the one from SDM845. Add a
> compatible for that.

Applied, thanks

-- 
~Vinod
