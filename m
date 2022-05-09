Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE3951F4B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiEIGlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbiEIGgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:36:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02A1498C3
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57D2861200
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C81C385A8;
        Mon,  9 May 2022 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652077961;
        bh=W8cliMtnerFoQoMHfNGdAtAdChXBgjuV4eR7fUqzKOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IA6KqQVJ3CIq3NTuobW1jvzyf40OZMdh91dnvWDEEEwohjTjQTu7Ofas53PDBLySx
         Fgk2yW7yy+wtiOACqXFvSQVqlCT1c2hqk4S/Up7e9e65AhYKHyzYsrEDi6L1zlEpDB
         6ZaG6RCo/kdvofN03aSZOCez2B6WxoF5pSqXOMbLCi85Ba7CYJztcUMpLXrV5MufKF
         UjKudBKl4OQengpKVDnzWrWvxECRjRi6/qrBhg60nuPoXTiAK/qFMfVyNKTyPEGDIL
         M0leKhN4IPHnNe780Nsfspa+a8ghOLupciheuGD4cFxo7g6HObfTX9W1JWRPXLoSCP
         moxEw927lLy2g==
Date:   Mon, 9 May 2022 12:02:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 0/5] soundwire: use pm_runtime_resume_and_get()
Message-ID: <Yni1hdMzehYtSJM3@matsya>
References: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-04-22, 07:56, Bard Liao wrote:
> Use pm_runtime_resume_and_get() to replace the pm_runtime_get_sync() and
> pm_runtime_put_noidle() pattern.

Applied, thanks

-- 
~Vinod
