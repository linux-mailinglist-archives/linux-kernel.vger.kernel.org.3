Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E39D55C501
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiF0Hga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiF0Hg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:36:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99D25FA5;
        Mon, 27 Jun 2022 00:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6360DB80F99;
        Mon, 27 Jun 2022 07:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47526C341C8;
        Mon, 27 Jun 2022 07:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656315386;
        bh=MC178vNeB4Zju2usywWfWM7BG2q0SbXzSdG8/usmYnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWb6QddHCyd2dPBqeMWS3+6ymIgB/1Ub0a77bU8MyqhpfXXTAmqsVM4uNGNjdyxyI
         5vOZB5oeVGjiY54vWSLcppralL30ReTsWOyIulow8kb85gL2XP5huDDMNZRTZZCx3n
         gopfAd8fhzKI657wWb3qgbRn2L9znhQbWmwEGXN9/ELN0Htl0nHMT8AGTWvMODWBNo
         gc9UZmDWqCsygEeo2V+bfvh/xE8p+MPKDm6wEw9MbE8vdmaP3F3j021EJAFzg9iota
         06hso1UIwq66kq1d7SstwqVf1VtkS+ffBIS9vwQd0Rw3u+atOlBwE6g5aJZIgjABC2
         +1ZXjgMQdcKsA==
Date:   Mon, 27 Jun 2022 15:36:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH v3 0/3] add bt-sco sound card support for i.MX8MQ/MM/MN
Message-ID: <20220627073619.GC819983@dragon>
References: <1655777763-21153-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655777763-21153-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:16:00AM +0800, Shengjiu Wang wrote:
> add bt-sco sound card support for i.MX8MQ/MM/MN
> 
> changes in v3:
> - move compatible property to be first
> 
> changes in v2
> - update note name of bt-sco codec
> 
> Shengjiu Wang (3):
>   arm64: dts: imx8mm-evk: add bt-sco sound card support
>   arm64: dts: imx8mq-evk: add bt-sco sound card support
>   arm64: dts: imx8mn-evk: add bt-sco sound card support

Applied, thanks!
