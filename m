Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F74FF10A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiDMH5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiDMH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CB722BE4;
        Wed, 13 Apr 2022 00:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46C40616DE;
        Wed, 13 Apr 2022 07:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3ACC385A4;
        Wed, 13 Apr 2022 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649836513;
        bh=1f4mcJkQt1lTjW13r8eX0mTCdHXvLFxIhJXVjQ6xG/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDzRpSw9RoegUV+FlhIx87nLVc9FcoPmGnlAyqNHhN7gCAgnWihbcoIgUXRxQ90NA
         1a19XVozvZvi9wJ/DfNDpJLFtYBi4Xmfj/qoBMGXNXIgXWs5t4jblAlpVNxFCQ8oGy
         cCWHNlMjgP4ASUkXyQaYdY63nsvl9vWYILROyR6cBU+rNbfZcUG3Vi6G7wUwNyOZIm
         I60RyVaCWqttaLqAIoIujs0aGmWetneUfAUo55dN0GSDyoHHy+KlDIN0gwZgTUqK7I
         wXLMW+kcnjVD9NJwauUmIbC/02OU+TFf0KVAbobftNnzLbhfSVIqnRn7qY0mflEttK
         ZMYvzKzTYkY8w==
Date:   Wed, 13 Apr 2022 13:25:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, krzk+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for USB3 PHY on SDX65
Message-ID: <YlaB3WBb8Dz3RLNC@matsya>
References: <1649740652-17515-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649740652-17515-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-22, 10:47, Rohit Agarwal wrote:
> This series adds USB3 PHY support for SDX65 platform. The USB3 PHY is of
> type QMP and revision 5.0.0.

Applied, thanks

-- 
~Vinod
