Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA970472AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhLMK5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:57:34 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:24644 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLMK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1639393046;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=pNlLchiryFPV0JpGdypTM5H2qm4RvvG0iKChVGJKSiE=;
    b=A6uNJM2ZpDPKt2ysMNP/NGZuHCjqjTi9Z3+s5R5M4Q+ua7Se8n35Xi5rUaG0UbTd9Z
    a9I2pLkoFMbsn8TzlWnSVYqC9oq1MNUxP+mTUprfr4vSbmtw711hVYzFSev5IJ9Xtnp6
    lZFu+7nD7+Fs7r6OiI+dRRQY0/7m0M+sjPyokeFU+FojyWSOuYyT8pz1Po0E/3d4Y1hY
    ykXhRkl6J/yYrRZT/5Dh9iXqLdNDZ/P/oq92p2aa/XFL9h+muTHEYstHgZr5cJCtfFue
    Vi3HAwN6TV/zmceResUfF/t0WCTYnOqLr4B4eRyh8t3kIUOBHF3E/XmWoU0mpRQ3A/uv
    zlqw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKw5+aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.35.3 SBL|AUTH)
    with ESMTPSA id j080d2xBDAvPInT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 13 Dec 2021 11:57:25 +0100 (CET)
Date:   Mon, 13 Dec 2021 11:57:22 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 5/8] dt-bindings: misc: add property to support
 non-secure DSP
Message-ID: <YbcnEp5+4y5qXC60@gerhold.net>
References: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
 <20211209120626.26373-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209120626.26373-6-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 12:06:23PM +0000, Srinivas Kandagatla wrote:
> From: Jeya R <jeyr@codeaurora.org>
> 
> Add property to set DSP domain as non-secure.
> 
> ADSP/MDSP/SDSP are by default secured, where as CDSP can be either be
> secured/unsecured.

Wouldn't it be easier to avoid the negation and add a "qcom,secure-domain"
property instead? Given PATCH 8/8 ("arm64: dts: qcom: add non-secure
domain property to fastrpc nodes") it looks like you are intentionally
breaking DT compatibility here, but this patch does not justify why this
is necessary.

Thanks,
Stephan
