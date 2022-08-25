Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0958D5A15CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbiHYPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbiHYP3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4432F29C8C;
        Thu, 25 Aug 2022 08:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D537A61A9D;
        Thu, 25 Aug 2022 15:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71700C433C1;
        Thu, 25 Aug 2022 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661441313;
        bh=yCSWcIUCKCOA6MMpiNJwvLfN/Tz2iXUZrtxQZzARvVM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OB8M8VdqBA5/gL3RkdgXULgOTU5OvOINujqH1KsNmJ1Pl/JCrJMFqQRNCrMlJ2aqG
         VwQHlGB1iuApC00fo0LeKUS5/F+416tXtJhXqQyY6MG+tLLktsv7Exme2KFYyvDkMk
         hEVVWWnbPq8uRoAVVN9gkL9rLC6JxLkDRKQGsNt53/27kUVCdqqzJ1ybqS/lGPNcUV
         T5CQJGdpZ68DuxXCSuxrJvM7dp18/iRs3v+H6IbrCbyatTSAPnhH3CLDe6w8cIcWez
         TttFxW35ay1HXVU4V3xTCojfh1WfffXQTynlhvRd+HetkKbah33m7mZQWBtSOP+YP1
         uiCsCuGzFyooQ==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        daniel@zonque.org, zealci@zte.com.cn,
        linux-arm-kernel@lists.infradead.org, ye.xingchen@zte.com.cn
In-Reply-To: <20220825072828.229294-1-ye.xingchen@zte.com.cn>
References: <20220825072828.229294-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] spi: pxa2xx: Remove the unneeded result variable
Message-Id: <166144131010.526920.17919210573110791735.b4-ty@kernel.org>
Date:   Thu, 25 Aug 2022 16:28:30 +0100
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

On Thu, 25 Aug 2022 07:28:28 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value clk_prepare_enable() directly instead of storing it in
> another redundant variable.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Remove the unneeded result variable
      commit: d294e99cdc823f368530b8169e33a599fa2a1afe

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
