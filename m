Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F624E1F68
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 05:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbiCUEB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiCUEBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:01:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B81FA7D;
        Sun, 20 Mar 2022 21:00:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4767F60C89;
        Mon, 21 Mar 2022 04:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48308C340E8;
        Mon, 21 Mar 2022 03:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647835199;
        bh=rcfrMRNmcGIva2FzJ8WXEWjgFGNXQHRVjZF1XPtl/r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRcKMSnHJ9F9XnbMGSSUgxWHnYrGWbB6zbWYOuqt9C/JhMOPTNUf/PpxSrPqKGrX0
         Nzewz1gbzoDa6ZiRiJk5GEv9s0dfICawGiauzSgQ7+qvkaYfEdhKnwCk1zRkDg/cBh
         N9udM8kaZwU430q4Fsmxv8EinXUtViPTKJVvfoH5SO+2XW4zjfCyzpmfLlNqpOgt7p
         UICdAwfcN0HeUvXYVGmPhuzlqQXObqdZs4+MU0jwUzEXlGZCcQOda84d+uwsIoUIeA
         /FNE3mByRgKe+LKYfnwcaMCoQ+ix2aGv0aBNOmFwPXAVElb598UXzSx9YMrK86BND4
         se7eaUbgIc9xA==
Date:   Mon, 21 Mar 2022 11:59:54 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v5 4/4] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Message-ID: <Yjf4Ogkr4MPzS0vr@google.com>
References: <20220319114111.11496-1-jiaxin.yu@mediatek.com>
 <20220319114111.11496-5-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319114111.11496-5-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 07:41:11PM +0800, Jiaxin Yu wrote:
> To support machine that only choose one of the rt5682s and rt5682 as
> headset codec, adds new compatible string "mt8192_mt6359_rt1015p_rt5682s".
> Meanwhile, using macros to simplifies card name and compatible name.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
