Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2642349B19B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350666AbiAYKYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbiAYKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0CC061757;
        Tue, 25 Jan 2022 02:20:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94EC561635;
        Tue, 25 Jan 2022 10:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C82C340E5;
        Tue, 25 Jan 2022 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106028;
        bh=lHbr/XHtohtZv4WPTENAycbeFslCLLfzxFh1ho8lZgs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jNURRxl14bETE3BtGe0qCU395qFA0Kx4q6IVWgyK/MP8hKX4rlXVC450RpYifAgLz
         amsiHAMzJptke7eXPMElmmUibwYuTkiiHS12MYNgibT4EA53R+/sjxRu1/QEDz7NsQ
         cALJlDqk01DZrmCrWMoxpTa82MG52ARTYO78I5TEgLqzeIIYP0vmP/dG98s6+jfc5+
         UM6K7JGVNdJEJyQA82toL6u0W/GcV6+Z+yPAAByqH0iQ/p75ek0OO46M0UFUlrm3vZ
         +yp2kHGc2nbY6Iz6JIUF4sB59Z9WfPjOIoirIeVEexhehBLt9qD7deWiz2OadueUDh
         Y7l2TQuJs3s6A==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        devicetree@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Andy Liu <andy-liu@ti.com>, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1642298336.git.daniel.beer@igorinstitute.com>
References: <cover.1642298336.git.daniel.beer@igorinstitute.com>
Subject: Re: [PATCH v3 0/2] ASoC: add support for TAS5805M digital amplifier
Message-Id: <164310602619.74844.8879999031786613742.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2022 14:58:56 +1300, Daniel Beer wrote:
> This pair of patches implements support for the TAS5805M class D audio
> amplifier. This driver, and the example configuration in the device-tree
> file, were originally based on a 4.19 series kernel and have been
> modified slightly from the tested version.
> 
> This resubmission differs from v2 as follows:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: add support for TAS5805M digital amplifier
      commit: 2e5a74c68d601b11a496f91f76fa7bb236d10bd0
[2/2] ASoC: dt-bindings: add bindings for TI TAS5805M.
      commit: b8aec7a4a01b75973c22f004377a48593a3fef03

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
