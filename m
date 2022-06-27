Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B619655E0B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiF0NyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiF0NyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:54:10 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7075B3E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:54:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 58A315C012B;
        Mon, 27 Jun 2022 09:54:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 27 Jun 2022 09:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1656338048; x=
        1656424448; bh=q+1sB2EjKcE1D8Tt+wDoAsTfPMB0jI+HIrgtAgz1Z1g=; b=u
        AU0K7dyq3nxoLFHI3xDzu49j1PDXSwgSsjbljTcWvmYNuyYRNeR8CGqMMNT7s0Xv
        I4b1dzobXDJjgfF1Z0L3TMxJnZd8lQiGgkGlQJEJ3HfE88P8WQfB3296N/9Qm20o
        ck6WNphZlECVXYGr8iXxAEPHCOrbEqBP57wkBgoKzPTOUZE2I/xdVAdh2CIOJviA
        ggpcXdAcW8iTykevTd49ok2w331wvac/XYALg9Pd4VlfM78KtYOPCPRzpl8ZnKyf
        yPHZB6N4vcZO3+FL22x6Jmt3j6Zi713ZJt7fd9riqkRIJ2vcvPhsuSIQWKqeyo/+
        scgfTjG05n8a7MCXZb30w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656338048; x=
        1656424448; bh=q+1sB2EjKcE1D8Tt+wDoAsTfPMB0jI+HIrgtAgz1Z1g=; b=x
        kgDm3Amu09zG7ZzoMOs7HaZ3HgMl7Xx2I8Q9sXfp09vhbPnmm5gP+tggPZRJ1dLm
        9D7Z/FLNEylOpCqIqjC1TMs4tWakCC35zqbh1zKN96LJFEgJjVx5JP0/Piklj92P
        Hx3TFn8N4HJQSR19D2nN9T/tSE91COqcF+VS78jULbKATSfegboASYehkpMJXUsd
        kbeQIYxxv2kYOofhlbUPRZ/+KUbUTxzxj/NmHjgVLpU+Y3o3Uk0pmpAvtTRghwZl
        0fCZKKCwPs8aGA/8ZWHmcxHZ4sOqti/z3bgUZogjQVS7KwhPitJ7IBg3ZoxzJVGi
        sqDqKKHyBFdarLpViyxsg==
X-ME-Sender: <xms:f7a5Yl__QZ45XXNciEE-EHfpSbjqICr2xeUosPjLWdW06k-EIpDB0w>
    <xme:f7a5YpsxE8OTwNij8ipVjJdUpPJhXqMo0sIHkotay8jen_AlYSBkdOD5TF26EAIcp
    -FjopIg4NuwuMjdm5E>
X-ME-Received: <xmr:f7a5YjC5AWpevjipQ-5CmeAF3W1ERBBRh87CbwbBqsCaMlf4X6zI_oc6ct9dLZ_V3-Tvr8ms2wm1SWaBGIBGut235s-GhV1uIc2FvfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeghedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvges
    tggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeeuieeggffhffffieefheduie
    euvdetgeeufeffvefgtedvffehheekffevudefieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:f7a5YpdlQExR2mTP8LWISu9VymKMOYA7FMAVC82nw8cD4zUD7PK2Xw>
    <xmx:f7a5YqOvKChoRShS060Qm7AS9cOs_M0wxivCV2_TAEsR_z6bNsEsmg>
    <xmx:f7a5YrnWSWx07H9HeJoC7MC6e79r06WTcLLgJJr4dvetKfjpGhFD1A>
    <xmx:gLa5YpdY6Dq9v5Q2MIchgn7_BEjVKqe4ejKt_krUnQe87MAv0hSMMA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 09:54:07 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     farooqui_saud@hotmail.com
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wens@csie.org,
        linux-sunxi@lists.linux.dev, jernej.skrabec@gmail.com,
        samuel@sholland.org, daniel@ffwll.ch
Subject: Re: [PATCH v2] drm/sun4i: Return if frontend is not present
Date:   Mon, 27 Jun 2022 15:54:03 +0200
Message-Id: <165633801993.372965.3420512862905584546.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <PA4P189MB1421E93EF5F8E8E00E71B7878BB29@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
References: <20220622075725.y6ws22ielpc4pmxw@houat> <PA4P189MB1421E93EF5F8E8E00E71B7878BB29@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 13:59:17 +0500, Saud Farooqui wrote:
> Added return statement in sun4i_layer_format_mod_supported()
> in case frontend is not present.
> 
> 

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
