Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFDE557263
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiFWE7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiFWE5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:57:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD734756F;
        Wed, 22 Jun 2022 21:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7888B821B2;
        Thu, 23 Jun 2022 04:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC0FC3411B;
        Thu, 23 Jun 2022 04:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655959448;
        bh=GiBHzoGfkipz/v643+wSbiX4mhbpHZf0nub0KVMQK+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KanINqfJ+ygzUTNtgkYp1S9yg9nvuyWGDKtaEppDGP8cmEPywU3FVIu6mCbZibv3/
         l3CHIwEcv3ypLur+DKMN6KEszoh2+qkh8iJ6jO7aFqCxkUrAjJi7X5vByUrT7cqlXb
         QLbT+21+w7a07ECK+vPtyVSElgl4FZan30lGJxWWtaHS3qEaXF4kRxbm0Xmx6SNxhE
         vYGBvbwfKsdx8GJvzgJfEodJ3hIMjaso5B11MYtnspfGRBsj00D32UG6fKHJrw3/Q8
         uHMQxcd5oEjv3c8j6zcui0mvx9upuRxxnj2DiGr0at0CiiyUK2N9+YjhBVeWtp+bZo
         auXmlGlKBjT4w==
Date:   Thu, 23 Jun 2022 10:14:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 5/6] dt-bindings: clock: Add Qcom SM8350 DISPCC
 bindings
Message-ID: <YrPvkV+yMsjLBKKp@matsya>
References: <20220622232846.852771-1-robert.foss@linaro.org>
 <20220622232846.852771-6-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622232846.852771-6-robert.foss@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-22, 01:28, Robert Foss wrote:
> From: Jonathan Marek <jonathan@marek.ca>
> 
> Add sm8350 DISPCC bindings, which are simply a symlink to the sm8250
> bindings. Update the documentation with the new compatible.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

But, this should be patch 2, before the driver one please

-- 
~Vinod
