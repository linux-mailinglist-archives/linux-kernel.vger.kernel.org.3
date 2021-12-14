Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB8F473C93
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhLNFan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:30:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42666 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhLNFam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:30:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6F40B817DF;
        Tue, 14 Dec 2021 05:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5ECC34606;
        Tue, 14 Dec 2021 05:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639459839;
        bh=IYPOLv65X73Tdje2BosI68msb7zvwqfKcT2QKqRWjqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewvQa+mmyh2OWwJPlFKEEb66w17DFmTuoq3ecU7d2VSV/qPDUmIyJdXYtg2LwCIfW
         4I3jkuGsMNGGkr7dd3Q+Zi1ntpHWY11rYkgkAqo4mQyjzYC4crosnWLmTl1eS2pO7b
         gFTFgl6FiRMDeolNt4RVUfEx4odVkgDvBq9tLUSmNti5VnrKZZQfiTVDcNodySQBYg
         NtqRU29X+S7xK9ma2bGgUGBNKWWNgzey2crVPkHAUczT7skrUfDXoIUjG33PywDIgT
         NyWtHpFxn28zz/L5HMtHZp38U9edw5XYzqRMhuLmllBAdwsumrXwhqKoTpp13eSZq2
         6uNfyMJZ3D7HQ==
Date:   Tue, 14 Dec 2021 11:00:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 1/4] soc: qcom: rpmhpd: sm8450: Add the missing .peer
 for sm8450_cx_ao
Message-ID: <Ybgr+1CUWXluJGcF@matsya>
References: <1639063917-9011-1-git-send-email-quic_rjendra@quicinc.com>
 <1639063917-9011-2-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639063917-9011-2-git-send-email-quic_rjendra@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-21, 21:01, Rajendra Nayak wrote:
> sm8450_cx and sm8450_cx_ao should be peers of each other, add the
> missing .peer entry for sm8450_cx_ao

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
