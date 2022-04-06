Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1354F5609
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbiDFF7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585596AbiDFFfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 01:35:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1909734DDD8;
        Tue,  5 Apr 2022 18:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A97F60AD0;
        Wed,  6 Apr 2022 01:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEA8C385A1;
        Wed,  6 Apr 2022 01:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649207089;
        bh=ZRlRd3gKnPMwhHGABcPERiIMz82HdvfvZFULEH0uKeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3QUpTq3qLgqgS+okjKB46lmEkQN5K2jrohyioql6n3wK0PaAYfURRz90lv2Jigui
         It7xoI18022b6ndfbDYzk3sOmWLLbwPnvCOrk3P+4YXj48666dLILFHnX9lb49kdJl
         35fnsDWO/AeR69LIyWTIHrgucqpestGuJO3h9H2om6d87AWd+dgjIJ9I8WU9c7k5va
         SO8PGrnXZLwKjEzpQ4g1Pb5+tW6c6CZstX3EbBqXgmD6Io6ZQqEOKnEybcSc1qn3pg
         18y8D2iICLlsqx9F3lFwwiqflmVWdxQcBGXHYqx3DZd+NUszTfOKZa2WwAphykzAQr
         84rTT0ERDFImw==
Date:   Wed, 6 Apr 2022 09:04:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org, festevam@gmail.com,
        krzysztof.kozlowski@canonical.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Subject: Re: [PATCH v4] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx
 audio card node
Message-ID: <20220406010442.GB129381@dragon>
References: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:56:01AM -0300, Ariel D'Alessandro wrote:
> BSH SystemMaster (SMM) S2 PRO board comes with an audio card based on
> tlv320aic31xx family codec.
> 
> The audio card exposes two playback devices, one of them using the EASRC
> (Enhanced Asynchronous Sample Rate Converter) module. Note that this
> would require SDMA and EASRC firmware in order to work.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Applied, thanks!
