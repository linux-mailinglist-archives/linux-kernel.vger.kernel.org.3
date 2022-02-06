Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E264AAFE3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbiBFONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 09:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiBFON3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:13:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7170BC06173B;
        Sun,  6 Feb 2022 06:13:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AB5EECE0C07;
        Sun,  6 Feb 2022 14:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F924C340E9;
        Sun,  6 Feb 2022 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644156805;
        bh=6rEPcZDOEiCqd5h93cPWysUEW/ILdSQersDA3Eqm4dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DcbA1bDNsD5FREkupR/LnejDuqnZYgVFEvdjq3BeqiyfGBmbADbQTBiP8tsnYdITW
         Ripa7CCJWKxvOq8ff1tT7LrSI3Oi4OAJO2K2447DymG1FmHk0MSj4X0h0tF3c6YQS7
         FCjB8qnaNyAqcbKzmdYB46UhxEH/9eN5liC5nUlJGpd8wMOABo1Qy0kSch0BHrYzcD
         i/E26onpyyrZQZNBpBJsRouNvOtWrqrLCL7GP4kVhkR9D9RQK0/BtX576gMo3UUSlD
         kX1PkDP9I5QZps5SpGtWjU1J6gr7mhxW5o2PDNXgtU5KvQ6OmAUdFmE9Ww/BFkivkM
         OIjfYGBWpZdCg==
Date:   Sun, 6 Feb 2022 19:43:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasad <quic_psodagud@quicinc.com>
Subject: Re: [PATCHv2 0/9] soc: qcom: llcc: Add LLCC support for SM8450 SoC
Message-ID: <Yf/XgGSHE9PwYrz0@matsya>
References: <cover.1643355594.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643355594.git.quic_saipraka@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-22, 13:17, Sai Prakash Ranjan wrote:
> This patch series adds support for LLCC on SM8450 SoC. It mainly
> consists of LLCC driver changes to incorporate newer LLCC HW found
> on SM8450 SoC and the corresponding DT bits to enable LLCC.
> Based on qcom/for-next branch.

I have tested this on SM8450 QRD and MTP

Tested-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
