Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B44465181
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350916AbhLAP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:27:55 -0500
Received: from relay08.th.seeweb.it ([5.144.164.169]:55085 "EHLO
        relay08.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhLAP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:27:54 -0500
Received: from [192.168.1.101] (83.6.166.111.neoplus.adsl.tpnet.pl [83.6.166.111])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 46A6F3F737;
        Wed,  1 Dec 2021 16:24:32 +0100 (CET)
Message-ID: <2256af7c-272a-b4ff-b1ad-d503a051fd64@somainline.org>
Date:   Wed, 1 Dec 2021 16:24:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 13/15] arm64: dts: qcom: sm8450: Add rpmhpd node
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-14-vkoul@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211201072915.3969178-14-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.12.2021 08:29, Vinod Koul wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> This adds RPMH power domain found in SM8450 SoC
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 52 ++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

