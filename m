Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E889E465281
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351377AbhLAQLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:11:17 -0500
Received: from relay04.th.seeweb.it ([5.144.164.165]:34381 "EHLO
        relay04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351358AbhLAQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:11:14 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A46701F4B5;
        Wed,  1 Dec 2021 17:07:51 +0100 (CET)
Subject: Re: [PATCH 2/3] clk: qcom: Add display clock controller driver for
 SM6125
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211130212137.25303-1-martin.botka@somainline.org>
 <20211130212137.25303-2-martin.botka@somainline.org>
 <20211201154642.24j5emibojfel2vr@SoMainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <e9dacf69-c354-aba1-da17-0bbad9ad9c0a@somainline.org>
Date:   Wed, 1 Dec 2021 17:07:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201154642.24j5emibojfel2vr@SoMainline.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/12/21 16:46, Marijn Suijten ha scritto:
> On 2021-11-30 22:21:33, Martin Botka wrote:
>> Add support for the display clock controller found on SM6125
>> based devices. This allows display drivers to probe and
>> control their clocks.
>>
>> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> 
> This got lost in the pipeline:
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

