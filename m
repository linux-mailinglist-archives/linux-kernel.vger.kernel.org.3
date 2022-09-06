Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD25ADD27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiIFCJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIFCJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:09:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113A5F1F;
        Mon,  5 Sep 2022 19:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2D23B81112;
        Tue,  6 Sep 2022 02:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBF9C433C1;
        Tue,  6 Sep 2022 02:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662430164;
        bh=OqhKXbWG5ke7d+FfI5lTae10PqHJN1Ent44NtvHaBtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ew2akOycaeTNbsadj1hHiJ8rMvhJGelayvJW+N1y/4D8QZ+mYqwUQXtx/alo3G7RE
         AYaU4T3AOnLBnDttLY9Gb+QcKfMynsS5C3uZF+iIhzqUdbsOYe9xqqq7kAVt/YQN55
         pZa/+jO3BuSHMOXYWQeMHhOwV42/wL8gj1zqhLN9RquWvwRjAYPxSNI/KbcNFDo3ya
         0hwZ1U1wnGoJ6hYu8LxtPtJ83P32RxIwj2XRuENPmBTerYkVL/Zo8/8mrOs/r4hN2S
         0ssbLuGRKfQJ8ajhAM8aaYNTfJSpFOEDWlQixI+ih5rfSMAZuTwVIGd9oIao6ONaQE
         JCVXnrbgXdWFA==
Date:   Tue, 6 Sep 2022 10:09:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V8 4/6] soc: imx: add i.MX93 media blk ctrl driver
Message-ID: <20220906020917.GM1728671@dragon>
References: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
 <20220823055215.1139197-5-peng.fan@oss.nxp.com>
 <20220904104403.GJ1728671@dragon>
 <26552553-b598-3179-40f8-170e766e3809@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26552553-b598-3179-40f8-170e766e3809@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 02:47:16PM +0800, Peng Fan wrote:
[...]
> > > +struct imx93_blk_ctrl_data {
> > > +	const struct imx93_blk_ctrl_domain_data *domains;
> > > +	const struct imx93_blk_ctrl_domain_data *bus;
> > 
> > It looks confusing to claim 'bus' as an imx93_blk_ctrl_domain_data.  I
> > would suggest you have 'related' fields directly defined in
> > imx93_blk_ctrl_data.
> 
> This would implies a bit large change to this driver.
> 
> Should I use a new V1 for the patchset or continue V9 for next version?

I think v9 is fine.

Shawn
