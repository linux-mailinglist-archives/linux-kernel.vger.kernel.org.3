Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC746962F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243693AbhLFNHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:07:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52540 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbhLFNG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:06:58 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B6D3EKo018270;
        Mon, 6 Dec 2021 07:03:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638795794;
        bh=0uXZVlilRjmfuVbVJcOeLN7sGQK38p00jhOzsoctBxc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qfPqM481sK31Rn/Ao6yKvkr2MPMPnPczEJHgtyu2LF85cgzM3WWhhyBMuqv+AKqe9
         nLKxYuz1nqDrJnDE5aTUUpZz9d0iiZUFc7tA5bNpYPd02Z538pxpcSx/OCUGlBA7VJ
         8GK26nQguvGQxvP01F5GNcJhILFLXArJtwN8nxxA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B6D3Ete037113
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:03:14 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Dec 2021 07:03:14 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Dec 2021 07:03:14 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B6D3BIA033372;
        Mon, 6 Dec 2021 07:03:11 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64-main: add timesync router node
Date:   Mon, 6 Dec 2021 18:32:37 +0530
Message-ID: <163879570035.16658.15303939764691195299.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202173114.9936-1-christian.gmeiner@gmail.com>
References: <20211202173114.9936-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian Gmeiner,
 
On Thu, 2 Dec 2021 18:30:18 +0100, Christian Gmeiner wrote:
> The Time Sync Event Router (TIMESYNC_INTRTR0) implements a set of
> multiplexers to provide selection of active CPTS time sync events for
> routing to CPTS capable modules.
> 
> This patch adds DT node TIMESYNC_INTRTR0 using "pinctrl-single" bindings.
> 
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/1] arm64: dts: ti: k3-am64-main: add timesync router node
      commit: 44226253e6514b8ef3ddc8710055548d22a230f0
 
All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.
 
You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.
 
If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.
 
Please add any relevant lists and maintainers to the CCs when replying
to this mail.
 
[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

