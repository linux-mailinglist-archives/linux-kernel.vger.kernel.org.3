Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4092459B29C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiHUHlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHUHlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:41:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7785D25E9E;
        Sun, 21 Aug 2022 00:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35D1AB80BAA;
        Sun, 21 Aug 2022 07:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659CFC433D6;
        Sun, 21 Aug 2022 07:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661067679;
        bh=y3EQmrCRvOIK4lLTgsmHPPPjHbSf6rANMY+EUT4oGSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoogUdm/tjfKxGzQ9QOP+dq307DTEkwPZ5QnL52wmRTtcIkQFF2XBV20oz+mv3xZd
         sFuvVqo3TKWiQjcG66aJN0LPIF2avAgbyLUtsjAG47p/pYisXfKldknDHuQp+I71Db
         wPO0Oxfl35iORGUTvy/aTZjzjN2ewyFhJqY83oshHMrF8y/ubHylbvO6kGA/cDby8G
         cdlNmUFIIdkWr6TIf8GzNuAIxS5J2lRuLB1LL5PnVwnvV+DW5LjLKdJQiZI5xMmrb9
         0sucJH1Cj90xZw9SjLaG35ICHu1PZQL6kC5/OLd04ygjlpz5x76NSVb2dhEIKgxSyz
         iA3BexBOTyjZQ==
Date:   Sun, 21 Aug 2022 15:41:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 0/8] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and vpu
 blk ctrl
Message-ID: <20220821074111.GN149610@dragon>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
 <b8b01610-ba76-913d-d195-b11ab8925fd9@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b01610-ba76-913d-d195-b11ab8925fd9@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 09:35:17AM +0800, Peng Fan wrote:
> Hi Shawn,
> 
> Ping..

I think Marco is requesting some information about HRV?

Shawn
