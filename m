Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5264E5C85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346945AbiCXA6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243273AbiCXA6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:58:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57571559B;
        Wed, 23 Mar 2022 17:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E80F2618F6;
        Thu, 24 Mar 2022 00:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACF7C340E8;
        Thu, 24 Mar 2022 00:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648083408;
        bh=56vaE5jbiPpw7MVnANHxMK6Guy2/JixLTTS08O3G2BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPSU4HvK4hOdpWGvKvRUp6oCwLtPlazGX4xUwQM1cIVgX9oUYZW2LQIWlIau0W8QW
         VavLtjNIDISByHRmgKPCYQ+wuFmTfgnEHELT9dZKRau/fut1ay3QTPjYUcffxizfvg
         iY26zm9V/Dcp30PLMpvtaKrEbxCDLxeAbSp++RGJCyIOhyfYNrpmkA2FpVrkIo07aO
         pabHz+aew5bG8U9q7T3RLImqkKKYgtrcblr9p805MDhZFjBlwPjc7NNZ+Tft7p+qJ/
         5jzm2ESZEohUxCnVjjSEC8pBu4dGHYb6iukxo394BfNk0RJcBt5DZAibFFR4hM8Q0f
         RkaqxPz5LoclA==
Date:   Thu, 24 Mar 2022 08:56:43 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v6 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
Message-ID: <YjvByyiuPWrVAFTW@google.com>
References: <20220323164442.921-1-jiaxin.yu@mediatek.com>
 <20220323164442.921-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323164442.921-3-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 12:44:40AM +0800, Jiaxin Yu wrote:
> MT8192 platform will use rt1015 or rt105p codec, so through the
> snd_soc_of_get_dai_link_codecs() to complete the configuration
> of dai_link's codecs.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Except the name: speaker-codec vs. speaker-codecs.  Have replied to the DT
bindings patch in the same series.
