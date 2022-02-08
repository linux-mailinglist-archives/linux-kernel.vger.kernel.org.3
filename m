Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E1D4AE1B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385550AbiBHTAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353620AbiBHTAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1FBC0612C3;
        Tue,  8 Feb 2022 11:00:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B6CE4CE1C17;
        Tue,  8 Feb 2022 19:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8A4C004E1;
        Tue,  8 Feb 2022 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346808;
        bh=DcrrQTlZTFvVz/EDWSALpPw5JloWhfX2vgl1EPRJutc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hR+Cu0n37NGv4o3gQsLXlcwOn1h8pz1PZ3Bh7qogE85jr2ruCgQinKPMzObK2YUL5
         Bqzj9RXmPZHIHVObJONomS/jUn5llZhU/K5IHHu8q8Ke7escn8k78N+boLinx2D6S5
         lsrcMHyqmhk7mX+0h5aB4iR/iKRHNEEZWBplq+MTAbskTn4npsSxn6TrMaru6oT7ff
         jwUvHqHGVsBkmggLibpSV7HJq8JOZmkfPBzz6Tg/H2bte7XHGR4lalul5LTS+ndROR
         td+3vSIpzt+6Vu12Vi57iSLYw87q8AxR9tAUBuKft+bVHJJ3LJT/5+L/AuzPSxmqV1
         vOn61dDPeI+hw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20220204155241.576342-1-vincent.whitchurch@axis.com>
References: <20220204155241.576342-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH 0/2] regulator: Add support for TPS6286x
Message-Id: <164434680631.1135477.3942083403967758360.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 19:00:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2022 16:52:39 +0100, Vincent Whitchurch wrote:
> TI's TPS62864/TPS6286/TPS62868/TPS62869 are high-frequency synchronous
> step-down converters controlled via I2C.  There are differences in the
> electrical characteristics and packaging between the variants, but the
> register interfaces are identical.
> 
> This series adds basic support for these chips.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: Add bindings for TPS62864x
      commit: 2f04aa69ab5c5c40d2e3e51fd73ce2ecb651e9ba
[2/2] regulator: Add support for TPS6286x
      commit: e2a01b4e8806087743e5ee42f9dcedfc741d4112

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
