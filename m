Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B51356639A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiGEHDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGEHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:03:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A612AE7;
        Tue,  5 Jul 2022 00:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00DF361616;
        Tue,  5 Jul 2022 07:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB602C341C7;
        Tue,  5 Jul 2022 07:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657004622;
        bh=MZfYY2zprLDztN1wjBWuIWgVqQUQo1+aoghwhMGFGOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SG4d3d7n4oyST5978bGWa9JR9MpbBX59JivkJoEYUUBM597zMVR9eihd3oTXDrtLO
         Nq382uTMLOngjp33RZ71UpWmcxkDO4eP5thXMy4lWvSzfeGvlyCaye6EuG96lWTKSu
         L8dqGc8CxH9HKrCydS+lZSpozWOpJIiv3+viZ7FoiheWDp5PYknYIC5IWT0fvZuhCl
         6HTzmc9cRsfI26K60+U2c4zur4EZcO08U7VqGqdsFSClhyedinWQs76C2a2KVJJMNb
         l6mFXQTKjRwpILuBfZm1V4HUjUNSPTI/xJ45KNL+NQ/gUHucwAiErWJn6TEwCY9MPK
         FzPBr27BaypxQ==
Date:   Tue, 5 Jul 2022 12:33:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] phy: qcom-qmp: pipe clock cleanups
Message-ID: <YsPiSoIGO+lXNnmV@matsya>
References: <20220623113314.29761-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623113314.29761-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-22, 13:33, Johan Hovold wrote:
> Here are some follow-up cleanups after the recent driver split.

Applied, thanks

-- 
~Vinod
