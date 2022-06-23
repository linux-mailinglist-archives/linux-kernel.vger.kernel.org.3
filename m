Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B620557201
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiFWEvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiFWEtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC44578C;
        Wed, 22 Jun 2022 21:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 397AA61D9E;
        Thu, 23 Jun 2022 04:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA26EC3411B;
        Thu, 23 Jun 2022 04:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655959357;
        bh=072D4YRa+8bNhL8h0zmwyPbXZIrIvz4zrYvGCXxDlC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFAQedGsoKXIA0lMQQOWwssdFfcInsvPW/e5JDnzVZNt+Fph+NDe7mAF/242Us2T/
         IhoTU9CrmMvgQkDa9jCQkxb5zk5Q8hR/ASHwf7XpWLQeo5vjDV2EMgxAhBvoUsgR9F
         SyzQjMvcBnwFCK12fehWT5fScpkm1ISIeqPdX7jX8f8aFgRi6QfzRyXsoOZsRTIxUg
         hHuDjoT2ap+Ce357gPTxtoAdlrv2ohxS68ZwCWZQynxFx9a5Qtx3rQvkaRUcO9Pgia
         9MH9Acv7Ta+eUyD14Hz1/JDHeieg3ZLdnWiylJxDy5obMCliF5XeTQMH5Jdy32TQw6
         RVK8zH/GUNWkQ==
Date:   Thu, 23 Jun 2022 10:12:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v7 1/6] arm64: dts: qcom: sm8350: Replace integers with
 rpmpd defines
Message-ID: <YrPvOBYOIM1McgsM@matsya>
References: <20220622232846.852771-1-robert.foss@linaro.org>
 <20220622232846.852771-2-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622232846.852771-2-robert.foss@linaro.org>
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
> Replace &rpmhpd power domain integers with their respective defines
> in order to improve legibility.


Reviewed-by: Vinod Koul <vkoul@kernel.org>

This can go separately as well...

-- 
~Vinod
