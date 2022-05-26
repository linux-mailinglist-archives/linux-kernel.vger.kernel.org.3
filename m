Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6083F534DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiEZLIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiEZLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:08:30 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D3C966A;
        Thu, 26 May 2022 04:08:29 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 345161C0B8F; Thu, 26 May 2022 13:08:28 +0200 (CEST)
Date:   Thu, 26 May 2022 13:08:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dmitry.torokhov@gmail.com, matthias.bgg@gmail.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3]  MediaTek Helio X10 MT6795 - MT6331 PMIC Keys
Message-ID: <20220526110827.GC5138@localhost>
References: <20220524093505.85438-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524093505.85438-1-angelogioacchino.delregno@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series performs some cleanups in mtk-pmic-keys and adds support for
> the MT6331 PMIC's keys.
> 
> Adding support to each driver in each subsystem is done in different
> patch series as to avoid spamming uninteresting patches to maintainers.
> 
> This series depends on another two series series [1], [2] named
> "MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper" and
> "MediaTek Helio X10 MT6795 - MT6331/6332 PMIC MFD integration"
> 
> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

Please cc phone-devel with phone stuff...

...and thanks for all the work. I guess we still don't have an android
phone with basic phone functionality working on mainline...?

Best regards,
							Pavel
-- 
