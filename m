Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB757511701
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiD0MUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiD0MUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5333D489;
        Wed, 27 Apr 2022 05:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8BFA619F1;
        Wed, 27 Apr 2022 12:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DE1C385A9;
        Wed, 27 Apr 2022 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651061847;
        bh=cfgh7Wb560mKp9MUdbD9T6uPA3TRHqxPZgTmSnaDhEk=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=n1J94SppjAv5wHSxxe39PLSHfvYctqiNRGF4TRVlc4S1gu+cGjcQENrDquMxTpRvJ
         zkRGafADlPfeVAFA2ENv/F26I+kSnGi2YikFRDtCKhiR2Vx+EeErqx+WTQsj83m1m1
         1VM6l6thbHG1LZUshPaI+mPI80SX5iciAbh3vU+HaRNZ41IRH4FyFD50djj1qxe79a
         4mOwG97O0o7NXZj62XYof44noq0VJ6iYSIJOA31RFXLuRhMCgq+O3l5cTR0qiuFLpA
         Y/epgo/X6y/hDq1f22Be15DrUPGC4E0hXYreJjJJ9rJ0NNsUOEF6oKsUmss2myyod6
         NU5kSA7FsdR1g==
Message-ID: <12570c36-d005-f51c-654b-01d52c50205c@kernel.org>
Date:   Wed, 27 Apr 2022 15:17:21 +0300
MIME-Version: 1.0
From:   Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH 1/3] interconnect: qcom: constify qcom_icc_desc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220412102623.227607-1-krzysztof.kozlowski@linaro.org>
 <b96fd335-df13-6657-c2ff-38ff677555a4@linaro.org>
Content-Language: en-US
In-Reply-To: <b96fd335-df13-6657-c2ff-38ff677555a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.22 18:25, Krzysztof Kozlowski wrote:
> On 12/04/2022 12:26, Krzysztof Kozlowski wrote:
>> struct qcom_icc_desc is not modified so it can be made const for safety.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   drivers/interconnect/qcom/msm8916.c |  6 +++---
>>   drivers/interconnect/qcom/msm8939.c |  8 ++++----
>>   drivers/interconnect/qcom/msm8974.c | 12 ++++++------
>>   drivers/interconnect/qcom/qcm2290.c | 12 ++++++------
>>   drivers/interconnect/qcom/qcs404.c  |  6 +++---
>>   drivers/interconnect/qcom/sc7180.c  | 26 +++++++++++++-------------
>>   drivers/interconnect/qcom/sc7280.c  | 24 ++++++++++++------------
>>   drivers/interconnect/qcom/sdm660.c  | 12 ++++++------
>>   drivers/interconnect/qcom/sm8150.c  | 22 +++++++++++-----------
>>   drivers/interconnect/qcom/sm8250.c  | 22 +++++++++++-----------
>>   drivers/interconnect/qcom/sm8350.c  | 20 ++++++++++----------
>>   drivers/interconnect/qcom/sm8450.c  | 22 +++++++++++-----------
> 
> Hi folks,
> 
> Any comments here?

Thanks for the patches! I had actually some of these changes in my local tree
for a long time. Do you want to send a follow-up patch also for sc8280xp?

BR,
Georgi
