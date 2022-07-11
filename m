Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0AF570A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiGKS4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiGKSz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:55:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7B1286E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52434B81132
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D5CC34115;
        Mon, 11 Jul 2022 18:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657565755;
        bh=L3b2HnXYmHknXBKUaJPrMF4QkdOGqDLajKgoOtVkjlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7Kjxl5MxvsRvKtb4A4NADuhI2CgsrPAj2WYcqT92r5P/2ZwPcqbSTDRbLcKFuhpk
         whpMrok4pvy9RpsMf6vz6v/nfsEFRPSuOyd0+nJhs+cYlcykPiR1NbZCKzqP7VP92p
         HWAa7WFI7mNKmbh8jrop0CSPFmeJblQgXyzt1UDE=
Date:   Mon, 11 Jul 2022 20:55:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org
Subject: Re: [GIT PULL] CoreSight changes for v5.20
Message-ID: <YsxyJjxxTZXrdG35@kroah.com>
References: <20220711170853.1136768-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711170853.1136768-1-suzuki.poulose@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 06:08:53PM +0100, Suzuki K Poulose wrote:
> Hi Greg,
> 
> Please find the CoreSight updates for v5.20 below. Kindly consider pulling.
> 
> Thanks
> 	Suzuki
> 
> 
> 
> The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:
> 
>   Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git  tags/coresight-next-v5.20

Pulled and pushed out, thanks.

greg k-h
