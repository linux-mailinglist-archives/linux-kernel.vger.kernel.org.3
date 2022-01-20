Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21696494B42
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiATJ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiATJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:58:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C998FC061574;
        Thu, 20 Jan 2022 01:58:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC08ECE2021;
        Thu, 20 Jan 2022 09:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE085C340E0;
        Thu, 20 Jan 2022 09:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642672700;
        bh=Xxq5aLpv8t8fNarJZbI/Km4DZZQq0/24lSFnByBK9PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ApGY9VNcbLV+DNdcVHc4w5AOHMw8guDiIfemUrxGKmuKr0hGkuUFxAdZiYHFZhPJH
         RkMgDb4TJ0scWJZfe478BJWHZYH7WiDwvccS2p0vBi63eDW119NgcPfWfPrRJtWDu2
         5zOMKfearsNMlstJ51hb6zNcHG7jv1QKnG6Wg23s=
Date:   Thu, 20 Jan 2022 10:58:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <YekyOVAjI0EE7VYz@kroah.com>
References: <20220120093615.2026590-1-xji@analogixsemi.com>
 <20220120093615.2026590-2-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120093615.2026590-2-xji@analogixsemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 05:36:15PM +0800, Xin Ji wrote:
> Add driver for analogix ANX7411 USB Type-C DRP port controller.
> 
> Reported-by: kernel test robot <lkp@intel.com>

The test robot did not report this to ask for a new driver :(
