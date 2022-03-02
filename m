Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8272E4CA9A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbiCBPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbiCBPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:50:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE02F56C06;
        Wed,  2 Mar 2022 07:49:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75B76B82085;
        Wed,  2 Mar 2022 15:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D87BC340F3;
        Wed,  2 Mar 2022 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236154;
        bh=T6WtGOV8QSur6KSw5nWl1mBfGIGN1n9aFmbvLWtyoiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxcqV+I2z+qdbocu8s7GdZLwYqh/njg0GGAjWRQLwH11bp9gNvjAXGqhKtPJUoK15
         jkVtYwC06Xv/bMriMC+KOa4SthTh7tqNmENjo9xeO4IBdNLlNs8g+yt+92taaSHU2t
         AU2Y1Z7kfwhvrbAMWv4uPAGhFxJIhfk4g1ZTL7yXSxErLh/ZNxm+lqaMuxGVF8UKCJ
         9rFDebRC8Hbf0a8c+FysQ/sA5T0BhdhiO6zKi+tc5YubN8kdJ3ZPAvRoGEIt+Zhg9V
         PwuBE2Nggow9GVh/IRtUo8Kk+zeDelF9UaQYLhFYMUfgEtpQkyfi9Q3QBZJqZVBga7
         5llHZnErtLx7w==
Date:   Wed, 2 Mar 2022 21:19:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v6 2/3] soundwire: qcom: constify static struct
 qcom_swrm_data global variables
Message-ID: <Yh+R9kcqytMhhiWU@matsya>
References: <1646224982-3361-1-git-send-email-quic_srivasam@quicinc.com>
 <1646224982-3361-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646224982-3361-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-22, 18:13, Srinivasa Rao Mandadapu wrote:
> The qcom_swrm_data structures is only required for setting soundwire params,
> so make the qcom_swrm_data structure const to allow the compiler
> to put it in read-only memory and avoid unintentional modifications.

Applied, thanks

-- 
~Vinod
