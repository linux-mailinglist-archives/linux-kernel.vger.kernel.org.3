Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2186F567063
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiGEOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiGEOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:09:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830C2495B;
        Tue,  5 Jul 2022 06:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EB78B817EF;
        Tue,  5 Jul 2022 13:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8350EC341C7;
        Tue,  5 Jul 2022 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657029518;
        bh=VVD07kOjhoc+i6PpyHwX5tJlDjRaF03eVFpkcqGqTDw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=sa2DhL1iEX9TcCGrGV7N2HisuS9Yfj87KzztR2RnH+Mxu201rhd3sxmN35L2fMs2F
         4t+ZutWgA4Xy8KRx1vZoB6JAp2L/LsUCJBO67FulUuMLVmV8NWiaDvINp2cLZA4WyP
         637JxZF6QI2lBZTmbx8/vjd++d/Y5SLV/agruYnvttdzhYmgPIW67oBYhWMLzP673g
         oUitB6N9Nsuixk6ymG/aLYUKD9OrpNQpreAz09vyDRNtM5xyAVgED3/odKriIXpvDQ
         aWOta2jrS+QsZXogCL309mI6EjASWKH9+R80Yw0cLhsmdGiFMRTCn+8mHzkQyfng6J
         fgLXBseYkg2zw==
Message-ID: <0746dc54-5acd-4032-0f90-4662af0d0107@kernel.org>
Date:   Tue, 5 Jul 2022 16:58:33 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] interconnect: qcom: msm8939: Use icc_sync_state
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220416012634.479617-1-leo.yan@linaro.org>
 <20220705073138.GA180752@leoy-ThinkPad-X240s>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220705073138.GA180752@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5.07.22 10:31, Leo Yan wrote:
> Hi Georgi, Bjorn,
> 
> On Sat, Apr 16, 2022 at 09:26:34AM +0800, Leo Yan wrote:
>> It's fashion to use the icc_sync_state callback to notify the framework
>> when all consumers are probed, so that the bandwidth request doesn't
>> need to stay on maximum value.
>>
>> Do the same thing for msm8939 driver.
> 
> Ping for this patch.  This patch is needed for enabling ICC driver on
> msm8939, I verified it based on Bryan O'Donoghue's DT binding patches.
> 
> Please see the branch which contains complete patches:
> https://git.linaro.org/people/leo.yan/linux.git/log/?h=v5.19-rc4%2bicc_sleep_clock_v2
> 

Ok, thanks for verifying it. Merged.

BR,
Georgi
