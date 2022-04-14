Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE8B5017A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359289AbiDNPmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352708AbiDNPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:17:42 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA7D95493
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:03:16 -0700 (PDT)
Received: from [192.168.1.101] (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 82EBD3F769;
        Thu, 14 Apr 2022 17:03:14 +0200 (CEST)
Message-ID: <b20bc969-96e6-5368-e3f5-ba2748dae2a0@somainline.org>
Date:   Thu, 14 Apr 2022 17:03:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: Fixes tag needs some work in the qcom tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220414074005.18cb9ed7@canb.auug.org.au>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220414074005.18cb9ed7@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.04.2022 23:40, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   5827e2830467 ("arm64: dts: qcom: msm8994: Fix sleep clock name")
> 
> Fixes tag
> 
>   Fixes: 9204da57cd65 ("arm64: dts: qcom: msm8994: Provide missing "xo_board" and "sleep_clk" to GCC")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 4dd1ad619274 ("arm64: dts: qcom: msm8994: Provide missing "xo_board" and "sleep_clk" to GCC")
Yes, precisely this. Sorry for that, I probably forgot to rebase my local tree before checking that commit hash..

Bjorn, could you please fix that up directly in your tree?

Konrad
> 
> Also, please keep all the commit message tags together at the end of
> the commit message.
> 
