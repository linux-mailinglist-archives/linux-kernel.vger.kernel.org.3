Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A643F517CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 06:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiECEoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiECEot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:44:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED7F3BA5C;
        Mon,  2 May 2022 21:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 735A0CE0B37;
        Tue,  3 May 2022 04:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFE9C385A4;
        Tue,  3 May 2022 04:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651552873;
        bh=o4fSZenVv3IR0ZYe0wGqW4keWer+IQxT8wcn98+zb2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLLMZSs2suvqXYm4aMTmjxCRi78bSWLwqlE3x7AUghRtMR0CJwSFsF9nRO/A/4aps
         GrMs+JbPybZjHJ8EDYQ6ZUMVglsUCBc0+sjFi5buOLiyfvDTqnqn8m9cbn7Jd7tXK3
         wKmuPShikaDgGrOzryTq3GIbDDc4FetZV+n5T68OUMyTNRBIr9Q4l4l2eEp+1CC0c+
         91T7Psi7GgI1zPFXX3Tdx1TRGEeuOdBvj8w4zujZGLTNaMfMwFn9B6kT8x66pvPG3m
         y8eVgwwpsvpg0jytjHtGsqaO4XdcfXKDYiMqOhxiE7lmAuy9WjzOLzC+9/KUEQTgjN
         cmTQyl5uZqM3w==
Date:   Tue, 3 May 2022 10:11:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] phy: qcom-qmp: fix leaks on probe errors
Message-ID: <YnCyZJpdTJOC2lDX@matsya>
References: <20220427063243.32576-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427063243.32576-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-04-22, 08:32, Johan Hovold wrote:
> Here are two more fixes addressing resource leaks on probe errors (e.g.
> probe deferral) and a related cleanup.

Applied, thanks

-- 
~Vinod
