Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C4D5124B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbiD0Vqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiD0Vqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:46:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA0B90CED;
        Wed, 27 Apr 2022 14:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1199B82AC2;
        Wed, 27 Apr 2022 21:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EF9C385A7;
        Wed, 27 Apr 2022 21:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651095814;
        bh=VsDx9yNbJhTBwkE2mj7Zjsj6YSBkvaaPCEpYyfmHl/g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PvCHxaJpxPqJ37By5sZzYGLeGoZEfel2HtTjnWVM3cxayeHwIwf1+RoFlwbuThrfA
         tp3mmcp5ljQKuu41GksrK8Dbv24EgNdFYzPWBxcCvt5t3MJyLc9wyd3mCJ4kx+Qae+
         pKxjeAplVH2y7iDyndXkXLUJklA5WTZWlQqyW+tg9UmKg0DmoQe5iV5XfI0/m967BY
         +bMillZMXaOVdofWRvYq95seKda5YG21qLnygrveRiCYaWkFtWs2EvaL6k1VsjUNi0
         t4lHXh9OJCOdq5tpNN9v8l7JArMeveEvtcTgPbby+N1OrrLhaldlIKMBUzJf40FJN/
         uyUG1/wjous9Q==
Message-ID: <b079a211-d387-7958-bbe2-c41cac00d269@kernel.org>
Date:   Thu, 28 Apr 2022 00:43:28 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm6350: Add interconnect support
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220422144021.232993-1-luca.weiss@fairphone.com>
 <20220422144021.232993-5-luca.weiss@fairphone.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220422144021.232993-5-luca.weiss@fairphone.com>
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

On 22.04.22 17:40, Luca Weiss wrote:
> Add all the different NoC providers that are found in SM6350 and
> populate different nodes that use the interconnect properties.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Newer SoCs seem to have switched to using #interconnect-cells = <2>;
> Is this something that should be done for all new implementations as
> well? The 'tag' in the second cell seems to be 0 for all cases in
> mainline except CPU.

Yes, it's recommended to use #interconnect-cells = <2> (if you care about
power management). This is to support different bandwidth configurations
that are toggled by RPMh, depending on the power state of the CPU.

Thanks,
Georgi
