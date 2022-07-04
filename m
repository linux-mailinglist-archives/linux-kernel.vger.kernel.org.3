Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DCD565CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiGDRZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiGDRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:25:56 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC025101FE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:25:54 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 837DB20566;
        Mon,  4 Jul 2022 19:25:51 +0200 (CEST)
Message-ID: <4002b566-e2a4-311a-c8ea-06b870676d55@somainline.org>
Date:   Mon, 4 Jul 2022 19:25:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ipq8074: add reset to SDHCI
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        bhupesh.sharma@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220704143554.1180927-1-robimarko@gmail.com>
 <20220704143554.1180927-2-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220704143554.1180927-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.07.2022 16:35, Robert Marko wrote:
> Add reset to SDHCI controller so it can be reset to avoid timeout issues
> after software reset due to bootloader set configuration.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
