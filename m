Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA7596F25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiHQNAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiHQNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32244DB75;
        Wed, 17 Aug 2022 06:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EEF761219;
        Wed, 17 Aug 2022 13:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AA4C433D6;
        Wed, 17 Aug 2022 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660741250;
        bh=eJPAJZU70L2ilq52vd1h8TJ0iuDcOSuXeEn2TlaFfew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVcxSjwd8bgaSr9uua0yrMIcgUBjDeXJn1JTvriQr+BT+sMg+Uf4T9eAF4lvlKvmh
         T3+fqWsxj6X/iMeET9P2VQRjX4AyHtxdg+bdjXM3/LcZcXhhzV4cIo5deyoQs4gj5D
         o9Ks86ottBzF/NIKfaY8EgpUCnaIVz/OG6JhaDrbr2ZhxFTZ/SNo+0SHjA7TjK1F70
         lhd6RPbowq1hF/BeLTZFWnXfZN11nXWSa39OhF9qIx+dEQJE0cV9RlP9VwjKmAv9UH
         3rCXBsVXOqHndGjBnzBXIUk4j+yMxK5nbya/eh6UHCS5Sc7sm6i6RrWgAm2agfB7qi
         OiErztjEXIWsw==
Date:   Wed, 17 Aug 2022 21:00:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Bind the backlight controller to
 the LCD panel
Message-ID: <20220817130044.GD149610@dragon>
References: <1657815915-1872-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1657815915-1872-1-git-send-email-michal.vokac@ysoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 06:25:15PM +0200, Michal Vokáč wrote:
> Add connection between the backlight controller and LCD panel.
> With that the backlight is automatically switched on when the panel
> is on or switched off when the panel is blanked.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied, thanks!
