Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7F251F4BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiEIGky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiEIGha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:37:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F7416A134
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DD460F24
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B48C385AB;
        Mon,  9 May 2022 06:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652078007;
        bh=+A/eYgl7HZZwEPuWOCcBdPtKm4G+Gnd+d5DfAahMbzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWxZLlR/aKi+U2YSTpIf2e/4GefVjQpu8L3OzO2VI/MxzHN5KZ8/h+7QmB5rPbkPU
         xcPjSKhTUmk9hp+IAyQOTOIuabloO1DjxdpbUgEemg8YwEpKrbbzpHnTlBqKIkz3IL
         rvTxjMFsRaJSYpOLwBfIK8ZxYXI1yqFA/lbYQnajVgKBgudwo6opeXl2pRlIeWoEhB
         PnG5BPGbuqrt/KRzGYY1znCk3Y7n7Aun4kLRYcuzfcgZwm4W1A3dr5b3Zbq+f1hDH0
         pqksRnLywYTysgMg6QyMhmzdTFWOItzd/r0TCQHTBIQhRo4BMctcU97jw9DPR2uxR2
         NcmdYBJcuIA/Q==
Date:   Mon, 9 May 2022 12:03:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH v2] soundwire: qcom: adjust autoenumeration timeout
Message-ID: <Yni1sr0R34C+bR6X@matsya>
References: <20220506084705.18525-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506084705.18525-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-05-22, 09:47, Srinivas Kandagatla wrote:
> Currently timeout for autoenumeration during probe and bus reset is set to
> 2 secs which is really a big value. This can have an adverse effect on
> boot time if the slave device is not ready/reset.
> This was the case with wcd938x which was not reset yet but we spent 2
> secs waiting in the soundwire controller probe. Reduce this time to
> 1/10 of Hz which should be good enough time to finish autoenumeration
> if any slaves are available on the bus.

Applied, thanks

-- 
~Vinod
