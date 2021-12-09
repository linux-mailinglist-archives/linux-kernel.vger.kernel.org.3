Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEDE46E7CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhLIL6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:58:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52906 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbhLIL6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:58:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2910ECE2559;
        Thu,  9 Dec 2021 11:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744D1C004DD;
        Thu,  9 Dec 2021 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639050915;
        bh=is6igi1NJQa4gUXfGMF8lFUAElSEVdfN9yuRy5gRbls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eN3fTo4YfwAW0bcX7uK8+vhYz1NGCb8+UzYKtlyjHs/uDcO4ljcT0IQGyZQc1Cu4W
         GuMIcyD/SCy6qaEIJzOhKElviDsP/nAVFw+Q7K+dF3Fp9XnL4N4sgokZa3S+1tJto5
         cq8elq5o3PQhfhsvscNIyJTKJzAFf/GL3avbxDXRke4lLS8Q4GiO6x0hjhqVh3JtQp
         oNWSsbch1o+wQY+0Ah2eMYluZETachXslAnlqzluDsvWZWhOUbeDKi0ursLy0v7e+L
         0rEeO9dMnfBbkorgrAUMCn2pmuZ145sX22E44qkzNXi4M3aIpuH06BqNxcy/hjs/z6
         anficz1s5tmPg==
Date:   Thu, 9 Dec 2021 17:25:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] phy: qcom: use struct_size instead of sizeof
Message-ID: <YbHun5KtYPH2JMP0@matsya>
References: <20211207131642.5313-1-guozhengkui@vivo.com>
 <20211209032114.9416-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209032114.9416-1-guozhengkui@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-21, 11:21, Guo Zhengkui wrote:
> Use struct_size() to get the accurate size of `clk_hw_onecell_data`
> with a variable size array, instead of sizeof(data) to get the size
> of a pointer.

Applied, thanks

-- 
~Vinod
