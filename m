Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699064B97A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiBQEVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:21:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiBQEVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:21:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B532A4176;
        Wed, 16 Feb 2022 20:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA8D61DA9;
        Thu, 17 Feb 2022 04:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3010C340E9;
        Thu, 17 Feb 2022 04:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645071665;
        bh=JCJ5zo28ggwBwwlByO8PafXAV2figIzScUg43ZiQpuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJsgc9yCx/gLzgA4pQpA9qyIIWUG998w6GIBM7G0sj9P+hyROIagoeTTuUS66B/vq
         9bnLqmWS36xrVR70ykn/M6/1KhgKnPzm/WSa3a5kky5vQnz1rTV8bbWyXAoQBzJmHF
         9nzP3EW0MQMekyaCAwcrrarELRMVvyzSw7MVC+x6jaESTEPACoL2BpMkrO4epafOXJ
         9uZjiPAQdieW7smd+fUB9Yo7nQvsM5wvb3NFJfOumqY7sL/srQlqqnExifARf3NIQD
         c/IBnUlZIWqeP1K4URxsY0jDvPQuonxY9MM27lyrDHoKy0raUQDqhlMG4k7LCAhZuK
         jhPUpEvf/ABCw==
Date:   Thu, 17 Feb 2022 09:51:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [REPOST PATCH v4 04/13] drm/msm/disp/dpu1: Add support for DSC
 in pingpong block
Message-ID: <Yg3NLVBQij0feTMv@matsya>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-5-vkoul@kernel.org>
 <a65a62ab-427f-3a5a-b633-2c457f797dab@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65a62ab-427f-3a5a-b633-2c457f797dab@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-22, 11:49, Abhinav Kumar wrote:
> 
> 
> On 2/10/2022 2:34 AM, Vinod Koul wrote:
> > In SDM845, DSC can be enabled by writing to pingpong block registers, so
> > add support for DSC in hw_pp
> > 
> > Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> 
> For the sake of uniformity, please use
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

This one has been carry fwd from few versions back :) will update
everywhere...

-- 
~Vinod
