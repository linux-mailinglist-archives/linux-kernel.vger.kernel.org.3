Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BE74CB9A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiCCIzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiCCIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:55:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392421768F6;
        Thu,  3 Mar 2022 00:55:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7472B82451;
        Thu,  3 Mar 2022 08:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C85C004E1;
        Thu,  3 Mar 2022 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646297706;
        bh=kU5Q06pAx6Ke2pgUtQgshelxBuHKHAWI3QpSa9wC5UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvuGsYkKqyLhu4HoxbCPmS8D8ZmQHLQY5D4+dOgwVoidcT5Zg+gPqjBJNrykjeE/5
         ZRroooUFFL1sK8UqRkSWlcH2WjnsUKpS6gNbaHTRew7U+hC/WtmD8t4getcCZvyeTG
         B/JTk5f+9WRrYk9OceV7uvBE1/ocsiIYRt5JtklC0Un+YwMRvLsRuVmBM/nCqZChYH
         pMpKXJIZYtUcRE8fIOOb0T9GTEkT0daYKeufiBdHpqEK3Ymj+yIN5oY28UgQsUdtxz
         wemjxoJEdPHUD3bnbFzvhYrwxU1oTozoHSSGYequ5W10JV5+Y/lmcIKFp78b/QijPJ
         6Fbk7R1nmxaig==
Date:   Thu, 3 Mar 2022 16:55:02 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, perex@perex.cz, matthias.bgg@gmail.com,
        trevor.wu@mediatek.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        aaronyu@google.com
Subject: Re: [PATCH] ASoC: mediatek: mt8183: support wb bt audio
Message-ID: <YiCCZoryo9LVQEGl@google.com>
References: <20220303061147.5037-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303061147.5037-1-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 02:11:47PM +0800, Jiaxin Yu wrote:
> This patch use "bt-sco-pcm-wb" codec dai driver for wb bt audio.

If it could get chance for a respin, describe it in imperative mood.  See [1].

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
With some minor comments,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> ---
> 
> This patch depends on:
> https://patchwork.kernel.org/project/alsa-devel/patch/20220302013533.29068-1-jiaxin.yu@mediatek.com/

Actually, it doesn't depend on the patch.  They are independent.
