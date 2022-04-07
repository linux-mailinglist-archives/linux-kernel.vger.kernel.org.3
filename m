Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B09A4F6F5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 02:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiDGA6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 20:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiDGA6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE85FC9B68;
        Wed,  6 Apr 2022 17:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44CCB61D73;
        Thu,  7 Apr 2022 00:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC90C385A3;
        Thu,  7 Apr 2022 00:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649292993;
        bh=Xy8Cf+XOsCMJS3zqWOHPAsptjXbizJteN5uf2mtD8SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/NP4XCYxnKR/NalBRnfLkM/AJVcg2nyj5fYgQbFmk1Qrs7IVRMsA6vzxAQ5xTW/Y
         WiIxkBssB90B65WU/GOX9TeYNSX1hIqWmlVamDSh3qmCAyp1g/jHZNArymA9tiPLu5
         o/1xzrHbeQ6S2YIX7MuKOcEcbsKOiFIKLN+Gh9Q2S1ujZq+FwqyMEP/9yxkZ1IlOIF
         dJujodSyADUe0RPCuFbHEMexeZk6MXaHNUO4j0o3WljwCYv/G95EhchO0gPAV2p5fp
         ziclcxhSYKQ5Fyld8zuLAGXQSnB8j32ArLZXOtk994cNya8tySUMtjgTHHKaCEjFsH
         DF5Y7gPe9VqpQ==
Date:   Thu, 7 Apr 2022 00:56:29 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, nfraprado@collabora.com,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v9 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
Message-ID: <Yk42vX7gSZp9l8yW@google.com>
References: <20220406100514.11269-1-jiaxin.yu@mediatek.com>
 <20220406100514.11269-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406100514.11269-3-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 06:05:12PM +0800, Jiaxin Yu wrote:
> MT8192 platform will use rt1015 or rt1015p codec, so through the
> snd_soc_of_get_dai_link_codecs() to complete the configuration
> of dai_link's codecs.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
