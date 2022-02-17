Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70214B98CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiBQGJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:09:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiBQGI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:08:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF03C7D6A;
        Wed, 16 Feb 2022 22:08:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC820611DE;
        Thu, 17 Feb 2022 06:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B79C340EB;
        Thu, 17 Feb 2022 06:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645078123;
        bh=ztO5z3iN5cSQeK67iLz7hEoXVaNMQ6S4MlmQnptMOE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qc/7GbYzvU09UZz+yxyXWiOptXJNDq7P54syRgq4lWSiMsPTpBknuklYTbnVbhq6U
         ERaMrs4RGGjz5FXF7IG8YTLCFVwYeqHeqOkjpFjXxx3FTBczkFg60a4PgbFdsajBUh
         ZNFcOOi0mGH0u+siIItZcnv/LUJ/rsb4JsA89DQ5HnLjuUTNF07SVUlwwkQrYFF84x
         Z9gzEWGUi2EXE3aAG2YJMmez+3frj2dJElqFXGvOTbzX7PRZVVFZQKWTMJLfoCb6ix
         iu3KN5iay3/C6VQ9Dx1VYsTyWGNgRL16/SHJr7VLvK/1b8zV4BS1WYMk8TYAxMeGV0
         w5npvCwMkd21A==
Date:   Thu, 17 Feb 2022 11:38:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org
Subject: Re: [Freedreno] [REPOST PATCH v4 07/13] drm/msm/disp/dpu1: Add
 support for DSC in encoder
Message-ID: <Yg3mZumErAgUzkhy@matsya>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-8-vkoul@kernel.org>
 <fd837ed4-1ff5-a87e-26ef-a84d899606ac@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd837ed4-1ff5-a87e-26ef-a84d899606ac@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-22, 11:54, Abhinav Kumar wrote:

> > +/**
> > + * dpu_encoder_helper_get_dsc - get DSC blocks mask for the DPU encoder
> > + *   This helper function is used by physical encoder to get DSC blocks mask
> > + *   used for this encoder.
> 
> This looks slightly misaligned to me or not sure if its my mail client.
> Please check it once.

This looks fine in code as well as in mutt for me.. Maybe client issue

-- 
~Vinod
