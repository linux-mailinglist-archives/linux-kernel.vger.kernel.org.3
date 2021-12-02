Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0534B465D40
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345325AbhLBEQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbhLBEQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:16:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D544C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 20:12:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05C36B8214D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 04:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1738C00446;
        Thu,  2 Dec 2021 04:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638418357;
        bh=WrbRr7hfiIN1K0T0/WmtBkJD3RopCcS33dkDOpBXrUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDyM5T68r09ajTEZKtBfOjBS9r9CD+0mzhRhM9YY32oUy3jqqF6MPgMfL/7sdBSq8
         vwjmSAn1GD30YGO6FNm+LcZj3G+pu73kLJB/uyJBXLNqHIYyMOttxFxMTaltZIrn6s
         PNsHj+yZ2/bQTG3GS6/UkBy89TeiR+GJzCbKiR0KU+JMhaO6Rd6QyZEcqnQB76ILav
         DTnle9VaWpmmQa8qwCQDYxhSnDJ3P4l7EBpHRvlq6GDU4UUSz5QTojkkSVIb/3n/gd
         tcwTTU5VPetky1VhyyntMZg/fnUHWjAI7EXTBantsa1jljLzKa2qq1nJePwcoa71LZ
         0euLpIRXsr4CA==
Date:   Thu, 2 Dec 2021 09:42:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy fixes for v5.16
Message-ID: <YahHsaJVCkxAm+hI@matsya>
References: <YaB7jK+ADoUQHWjh@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaB7jK+ADoUQHWjh@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 26-11-21, 11:45, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to recieve bunch of fixes for generic phy subsystem. These
> contain mostly kernel-doc warning fixes along with couple of driver
> fixes.
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-5.16

Did you miss this one or something else...

> 
> for you to fetch changes up to f0ae8685b2858fc1dabf5ea743642abb5f242375:
> 
>   phy: HiSilicon: Fix copy and paste bug in error handling (2021-11-23 10:42:13 +0530)
> 
> ----------------------------------------------------------------
> phy: fixes for 5.16
> 
> Fixes for:
>  - kernel-doc warnings for various drivers
>  - error handling fix for HiSilicon driver
>  - name fix for zynqmp phy
>  - property name fix in stm32 phy
> 
> ----------------------------------------------------------------
> Amelie Delaunay (1):
>       phy: stm32: fix st,slow-hs-slew-rate with st,decrease-hs-slew-rate
> 
> Dan Carpenter (1):
>       phy: HiSilicon: Fix copy and paste bug in error handling
> 
> Liam Beguin (1):
>       dt-bindings: phy: zynqmp-psgtr: fix USB phy name
> 
> Randy Dunlap (1):
>       phy: ti: report 2 non-kernel-doc comments
> 
> Vinod Koul (6):
>       phy: mvebu-cp110-utmi: Fix kernel-doc warns
>       phy: qualcomm: qmp: Add missing struct documentation
>       phy: qualcomm: usb-hsic: Fix the kernel-doc warn
>       phy: ti: tusb1210: Fix the kernel-doc warn
>       phy: qualcomm: ipq806x-usb: Fix kernel-doc style
>       phy: ti: omap-usb2: Fix the kernel-doc style
> 
>  .../devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml |  2 +-
>  drivers/phy/hisilicon/phy-hi3670-pcie.c            |  4 ++--
>  drivers/phy/marvell/phy-mvebu-cp110-utmi.c         |  4 ++--
>  drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        | 26 ++++++++++++----------
>  drivers/phy/qualcomm/phy-qcom-qmp.c                |  3 +++
>  drivers/phy/qualcomm/phy-qcom-usb-hsic.c           |  2 +-
>  drivers/phy/st/phy-stm32-usbphyc.c                 |  2 +-
>  drivers/phy/ti/phy-am654-serdes.c                  |  2 +-
>  drivers/phy/ti/phy-j721e-wiz.c                     |  2 +-
>  drivers/phy/ti/phy-omap-usb2.c                     |  6 ++---
>  drivers/phy/ti/phy-tusb1210.c                      |  2 +-
>  11 files changed, 30 insertions(+), 25 deletions(-)
> 
> Thanks
> -- 
> ~Vinod



> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy


-- 
~Vinod
