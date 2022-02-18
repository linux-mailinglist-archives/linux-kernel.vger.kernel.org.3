Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDF4BAEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiBRAvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:51:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiBRAvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:51:44 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E6B64
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:51:21 -0800 (PST)
Received: from [192.168.1.101] (abxk63.neoplus.adsl.tpnet.pl [83.9.4.63])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D4ABD3F3BC;
        Fri, 18 Feb 2022 01:51:18 +0100 (CET)
Message-ID: <0a48c21d-7acc-04cb-208e-68779145883c@somainline.org>
Date:   Fri, 18 Feb 2022 01:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] clk: qcom: gcc-msm8994: Remove NoC clocks
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220217232408.78932-1-konrad.dybcio@somainline.org>
 <20220218001628.3FF4DC340E8@smtp.kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220218001628.3FF4DC340E8@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.02.2022 01:16, Stephen Boyd wrote:
> Quoting Konrad Dybcio (2022-02-17 15:24:08)
>> Just like in commit 05cf3ec00d460b50088d421fb878a0f83f57e262
>> ("clk: qcom: gcc-msm8996: Drop (again) gcc_aggre1_pnoc_ahb_clk")
>> adding NoC clocks turned out to be a huge mistake, as they cause a lot of
>> issues at little benefit (basically letting Linux know about their
>> children's frequencies), especially when mishandled or misconfigured.
>>
>> Adding these ones broke SDCC approx 99 out of 100 times, but that somehow
>> went unnoticed. To prevent further issues like this one, remove them.
>>
>> This commit is effectively a revert of 74a33fac3aab77558ca0d80c9935
>> (clk: qcom: gcc-msm8994: Add missing NoC clocks) with ABI preservation.
>>
>> Fixes: 74a33fac3aab ("clk: qcom: gcc-msm8994: Add missing NoC clocks")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Is boot broken on msm8994? I can take this for clk-fixes then.

It technically boots, but depending on the board (different phones took this differently)
storage may or may not work.. So I guess picking it up in -fixes would be fair..

Konrad
