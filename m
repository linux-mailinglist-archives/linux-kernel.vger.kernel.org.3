Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7693D46EC19
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbhLIPuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:50:07 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:42047 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbhLIPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:50:05 -0500
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 127FA200DE;
        Thu,  9 Dec 2021 16:46:29 +0100 (CET)
Message-ID: <d87429f0-bd56-880f-9606-6812bc69d445@somainline.org>
Date:   Thu, 9 Dec 2021 16:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2 09/13] arm64: dts: qcom: sm8450: add interconnect nodes
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211209103505.197453-1-vkoul@kernel.org>
 <20211209103505.197453-10-vkoul@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211209103505.197453-10-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 11:35, Vinod Koul wrote:
> And the various interconnect nodes found in SM8450 SoC and use it for
> UFS controller.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 80 ++++++++++++++++++++++++++++
>   1 file changed, 80 insertions(+)

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

