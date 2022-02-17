Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6C4B979F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiBQEUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:20:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiBQEUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:20:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93982A416F;
        Wed, 16 Feb 2022 20:20:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2244761DA6;
        Thu, 17 Feb 2022 04:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15D7C340E9;
        Thu, 17 Feb 2022 04:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645071633;
        bh=aufa0nh+h9c3kdylk4TIafeWU4s1oDv8HmfjdC9MZeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsiHFCKNC8FjTqTL2vhM1wRiRzIPkhab8+taGIvE+0q/yZXQVJtJ8QW1/yV2f/zqW
         xRQ2bM7zPM3nIOdV2lFz+K24nunsMUNoFMN0lPK1SjCbxLBqagyi6AxLaIwjlEew6I
         /rsjxd1uXZgtfYGg4WfsAa3K2J83xCnVvv4iTdRaoZBkGzWNsZhqYrleZP5ONZsXKJ
         d873EMaP0IqznWNgz7Y1GplT/Kh+uB7J/EEwIQkkg/qMwDeA9L7Hb4gTQHtaT/3GsL
         fTyI4a+gcVZ0UMWUXOI2a+k4ahuHDR+w8zALCwavXhD9JBtZhUk3uQhFqCyd3aZ2pU
         JEYRNG/olryMw==
Date:   Thu, 17 Feb 2022 09:50:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [REPOST PATCH v4 03/13] drm/msm/disp/dpu1: Add support for DSC
Message-ID: <Yg3NDelctH5YP2jA@matsya>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-4-vkoul@kernel.org>
 <8de66b66-5f02-600e-aa4c-bf2dad37487f@quicinc.com>
 <a75893b8-f868-845b-2da2-1a2840a83caa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a75893b8-f868-845b-2da2-1a2840a83caa@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-22, 22:46, Dmitry Baryshkov wrote:
> On 16/02/2022 21:57, Abhinav Kumar wrote:
> > 
> > 
> > On 2/10/2022 2:34 AM, Vinod Koul wrote:
> > > Display Stream Compression (DSC) is one of the hw blocks in dpu, so add
> > > support by adding hw blocks for DSC
> > > 
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > 
> > Somehow second patch of this series is not showing up on patchwork in
> > your REPOST.
> > 
> > It jumps from 1 to 3.
> 
> patch 2: https://patchwork.freedesktop.org/patch/473356/?series=99959&rev=1

yeah it seems to be there.. As well os arm-msm and dri-devel on k.org
pw....Problem with QC delivery...?
-- 
~Vinod
