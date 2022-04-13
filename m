Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF64FF549
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiDMK5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiDMK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:57:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B425A15C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75DD9B821DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F3AC385A4;
        Wed, 13 Apr 2022 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649847310;
        bh=dFm1wyKu10QMvm3Wr7qBRB92zACCEpo2u5gPlOnXCdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNqr58yFVPSQ71lRauNoO5lETAbXYUa8GTDtcg2dYHmFV2g2Gf+YoJJMKs1fDCWT8
         urxzGuXb4Mmxvt6A7+yClA1vaxCEqQM+Tp8EetPK/DxXCtaAJDQp5sQ+WizWcmrJZa
         kpDelMAHTwEUdPBYpbH6QXHR655FaOgz28xtUpLUcJxUgPdSLw0xyRNlJENWulZlvu
         7irtPP2RQbClP7U6PER1IgMLMdbQYawQ9MzDh8p7871Tbut1113h4HaIaKFhAw2BK6
         4zHfyacF2duQFbikFycXp3lVu5p8G/8XhYwbORwDEc+geo4GKU1kL65AkmRdMNTKvq
         TbLttlnlCuzww==
Date:   Wed, 13 Apr 2022 16:25:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: ti: Add missing pm_runtime_disable() in
 serdes_am654_probe
Message-ID: <YlasCq2IKMfcafvx@matsya>
References: <20220105090225.20507-1-linmq006@gmail.com>
 <20220301025853.1911-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301025853.1911-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-22, 02:58, Miaoqian Lin wrote:
> The pm_runtime_enable() will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
> Add missing pm_runtime_disable() for serdes_am654_probe().

Applied, thanks

-- 
~Vinod
