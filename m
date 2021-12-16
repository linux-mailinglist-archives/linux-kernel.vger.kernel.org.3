Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083C1476A74
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhLPGgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhLPGgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:36:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C318C061574;
        Wed, 15 Dec 2021 22:36:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3909A61C11;
        Thu, 16 Dec 2021 06:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DEDC36AE2;
        Thu, 16 Dec 2021 06:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639636577;
        bh=neU9K+dVdRN9HYvVjoIapl4HfMVGMGGHHK9OM8vGk9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFcnYOgRfdBfISm46BAT8cSFrqfRG1QkFwb1Gx2T5yoaanL83Tdi0won7+pwl9NBW
         Ew6Z5aOHaClbdfACdrx3CBtdU1sDlN4jG53sNC3TKXkl1duV6a0921hCjoZojXx3GE
         EYADMd3o0SN9It835KWhYxQ0A+QD2eTqijNOqE0TKKWiWP2MZFQAiP5jxnMUVJB0F6
         44GXU63DUbKbtIdBXfuUIC0Z3lYY/LuZWJ3qYDkRzok9PkKzcQmFhVMW7vGD2nQBbA
         qXIPT5D+SDtgWQb5I9VV1LFFPeLRLEt9jGZ+YNyhE8cXlIvgI3S6WDMLtALID2b4Yd
         onD7YnQHVt7VQ==
Date:   Thu, 16 Dec 2021 12:06:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add
 bindings for SM8450
Message-ID: <YbreXVkMoOcoeHAA@matsya>
References: <20211213131450.535775-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213131450.535775-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-21, 18:44, Vinod Koul wrote:
> Document the compatible string for USB phy found in Qualcomm SM8450 SoC

Applied all, thanks

-- 
~Vinod
