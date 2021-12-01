Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D32465171
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350865AbhLAPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:25:53 -0500
Received: from relay07.th.seeweb.it ([5.144.164.168]:56187 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350851AbhLAPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:25:52 -0500
Received: from [192.168.1.101] (83.6.166.111.neoplus.adsl.tpnet.pl [83.6.166.111])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DFE233F737;
        Wed,  1 Dec 2021 16:22:29 +0100 (CET)
Message-ID: <5d764f15-df20-68d0-4c8f-35dbde6bcd84@somainline.org>
Date:   Wed, 1 Dec 2021 16:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 11/15] arm64: dts: qcom: sm8450: add spmi node
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-12-vkoul@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211201072915.3969178-12-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.12.2021 08:29, Vinod Koul wrote:
> Add the spmi bus as found in the SM8450 SoC
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

