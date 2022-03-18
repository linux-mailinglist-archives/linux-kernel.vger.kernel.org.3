Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B354DD98B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiCRMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiCRMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:18:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E495F32B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:17:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25DB2B821A5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF82C340E8;
        Fri, 18 Mar 2022 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647605854;
        bh=OnT2D+KhGOVcgjdooEr27/eteK5MDnxGR9qpWpizgzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2qCOc4QJA1IQqC5gndiTkEMfCgNmoRSattuSDjefz5S+2gvcMqj0PZtp3ZE3sGwG
         GxBtop1wn1bg3yWcy5d/Kx99YvI6OMXHxqUt2S1I85/X7kmoNo4M6+L5ur/Y88DjaA
         y9Vxi3bPtfpu95it6nIulLw2Q+stA1YyL/0b2jnk=
Date:   Fri, 18 Mar 2022 12:49:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] [v2] coresight: Changes for v5.18
Message-ID: <YjRx0iGHuu5e+wv4@kroah.com>
References: <20220303230301.255049-1-suzuki.poulose@arm.com>
 <20220311104557.154755-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311104557.154755-1-suzuki.poulose@arm.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 10:45:57AM +0000, Suzuki K Poulose wrote:
> Greg,
> 
> Please find coresight updates for v5.18 below. This is an updated pull
> request which fixes the missing s-o-b tags for the committer.
> 
> Changes since previous request:
>   - Fix missing S-o-b tags for committer
>   - Added a new tag coresight-next-v5.18-v2
> 
> Thanks
> Suzuki
> 
> 
> The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:
> 
>   Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.18-v2

Pulled and pushed out, thanks.

greg k-h
