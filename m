Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114C855F573
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiF2FAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2FAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40291DA65;
        Tue, 28 Jun 2022 22:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FFAB60F81;
        Wed, 29 Jun 2022 05:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7494C34114;
        Wed, 29 Jun 2022 05:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656478808;
        bh=LzISrZ8nawMpb8hJijKZtkKzjzGJ15T7qX5GvMY7oiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVx7YZs4x7vexbi+1+THxjafiRTSvaILsUm0Sj3CSwUrugrohLYMtolLOwoCdXSL3
         ZqONu9hS7VAlynL84rwny0h2JAI/oWglqHxS6SKs3Js6yzfsUeJt5nKzNVQGRiL1J5
         7HyIm3vGLAnuA8B21Crwe88BJr5Sf+AdIAjMdh7cvSvtRculfhBS2Pp7ZpjCjy3wRx
         fT3SSTUDtAQ6hZvRAJShf8+sszlfwh8IOHwCtixYwnn+l3ZhhpHNiYPGXpfCZCjh2U
         pIwdUTCOT48ANgQ4xGVhgc/ZcoPucxwmVdm71z2GHfMjRA0RRAeuXHWJiNdDy4Rq3y
         gLol19pyRWAKQ==
Date:   Wed, 29 Jun 2022 10:30:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Subject: Re: [PATCH v5 0/2] Add software clock gating requirement check
Message-ID: <YrvcVOo+f3+W4aoz@matsya>
References: <1654863815-3970-1-git-send-email-quic_srivasam@quicinc.com>
 <YrQfs7HUIOV5x8Ub@matsya>
 <7b532c96-e36b-207e-532c-8b41f7106831@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b532c96-e36b-207e-532c-8b41f7106831@quicinc.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-06-22, 18:01, Srinivasa Rao Mandadapu wrote:
> 
> On 6/23/2022 1:39 PM, Vinod Koul wrote:
> Thanks for your time Vinod!!!
> > On 10-06-22, 17:53, Srinivasa Rao Mandadapu wrote:
> > > This patch set is to add software clock gating requirement check
> > This fails to apply for me, please rebase on sdw-next and resend
> > 
> > Thanks
> 
> It seems one patch is missing in your branch, which accepted by Mark brown.

Ok. Pls send on -next and if there are conflicts we can coordinate with
Mark.

-- 
~Vinod
