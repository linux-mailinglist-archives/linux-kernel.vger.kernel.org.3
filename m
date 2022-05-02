Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917ED516DEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384371AbiEBKOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384385AbiEBKNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:13:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AE56305;
        Mon,  2 May 2022 03:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA2061230;
        Mon,  2 May 2022 10:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25B6C385AF;
        Mon,  2 May 2022 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651486224;
        bh=TMRGhDsQ5rlUJNgc/r4GHPu8kNEPVqY0brpK4SH6Z4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ammL2rugX2l643ddfB4/HsVMRNkcmuAcjYQirLhDVjU1GT4dSxbv0oAb4IlAQh0au
         1y9UYsfTZOhUPGiaOfUgiW9cD9HyN558tJFO2zQCg7cij+BymxfjMKk2PximvXXKC/
         MdTv+cg1OKsTIW2mxrxIKWx2txT+YcWnWBJeYDMyT+WKPefZUmoy6YgwaJRVhf+6bl
         WLDEBH2JqffsBuQYd8b9V/8MFj9wVC0bDh+ssR94no3JR4o0i2An+xaN0+SRmvJx71
         6HN2fCHb3tpzzCOg7uncUmAd+usYzhDN0ZoA8QwM9zobDgMasvJU2Pl+D3klWBI2kI
         OXQbdXs+W0lZg==
Date:   Mon, 2 May 2022 15:40:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: qcom-qmp: fix phy-descriptor kernel-doc typo
Message-ID: <Ym+uC0eDP97q+lyy@matsya>
References: <20220420152331.5527-1-johan+linaro@kernel.org>
 <20220420152331.5527-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420152331.5527-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-22, 17:23, Johan Hovold wrote:
> Fix misspelled "clock" in the description of the pipe_clk field in the
> PHY-descriptor kernel-doc comment.

Applied, thanks

-- 
~Vinod
