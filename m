Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0E4E2B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349854AbiCUPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243001AbiCUPNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:13:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC00BBB0BB;
        Mon, 21 Mar 2022 08:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E6ABB81748;
        Mon, 21 Mar 2022 15:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19D8C340E8;
        Mon, 21 Mar 2022 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647875547;
        bh=9Y12UFEf0Mf9nHunCW2p4Tl8F6I/gFgWOZD/wYfYOMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiriLh88bvOpCG0mZJ+XfNYOghNqemH6z0HFKHjpn01CIZL/8uy+fBu3RL2yZ/DeF
         eTvaFEST5+o9GuwG+/3fLNQMcCBLr0QnRiknPKr6YO6N/KUFRqGcuEmD2G3AFDLFXb
         b1A+5kJX6i2qDaa/J6EsuhGCfiWarZKgshXRXuZAzbioZMKnhryUdH14Kd8Sekcoqf
         wpJoFWDsQKMOmn0qTiSBbBHUTp3CHAQS7pBwsy/it0aq3Hwh/of1ahxnzo/+8jDEzq
         mOFsqnVuGbkbc6bT6JmC5XNEYsNSmuiVx0e6ypoJsd9ZaNQZkNw2V+UrJd8T8tT1qA
         35UMMnX5ChagA==
Date:   Mon, 21 Mar 2022 23:12:23 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com,
        angelogioacchino.delregno@collabora.com, yc.hung@mediatek.com
Subject: Re: [PATCH v3 4/6] ASoC: mediatek: mt8195: rename card controls
Message-ID: <YjiV18IjpPMZrwvB@google.com>
References: <20220321072312.14972-1-trevor.wu@mediatek.com>
 <20220321072312.14972-5-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321072312.14972-5-trevor.wu@mediatek.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:23:10PM +0800, Trevor Wu wrote:
> In order to be able to reuse the same configurations in user space,
> rename the controls to generic names.
> 
> "Headphone Jack" -> "Headphone"
> "Speakers" -> "Ext Spk"
> "Left Speaker" -> "Left Spk"
> "Right Speaker" -> "Right SPk"
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
