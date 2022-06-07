Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6527E53F546
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 06:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiFGEu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 00:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiFGEuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:50:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F319DD2457
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 21:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ED87B81CA0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65C0C385A5;
        Tue,  7 Jun 2022 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654577420;
        bh=lvKuaWgcwr9ep3pA6nWz4hg/HfWPjExkyzheB0QJgcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anJkvbIYc81/T2uiEndRwlM1EhCoiITy6Wy8PdLqQHOKpBBOAGr55Kd4Jll5ds7Uo
         DQddwOWprwSWD2z1wNmgGHx6dWDPMLYf3ATzgAANxef2htSSmq+0Y5PX+emk1rChj0
         vMgt8zrxrqM9NSC2IFL2P9qPO4TMQ98ZaKIZ0FOQ=
Date:   Tue, 7 Jun 2022 06:50:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     broonie@kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, hao.wu@intel.com, trix@redhat.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v1] regmap: add generic indirect regmap support
Message-ID: <Yp7ZCWq3yjNcMM4N@kroah.com>
References: <20220607013755.594554-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607013755.594554-1-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:37:55PM -0400, Tianfei Zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> This patch adds support for regmap APIs that are intended to be used by
> the drivers of some devices which support generic indirect register access,
> for example PMCI (Platform Management Control Interface) device, HSSI
> (High Speed Serial Interface) device in FPGA.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/base/regmap/Kconfig                   |   3 +
>  drivers/base/regmap/Makefile                  |   1 +
>  .../base/regmap/regmap-indirect-register.c    | 133 ++++++++++++++++++
>  include/linux/regmap.h                        |  12 ++
>  4 files changed, 149 insertions(+)
>  create mode 100644 drivers/base/regmap/regmap-indirect-register.c

Don't we need users of these before we can take them?

thanks,

greg k-h
