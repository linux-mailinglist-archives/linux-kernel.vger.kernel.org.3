Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79784E5FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348712AbiCXHqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbiCXHqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:46:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AF4972BD;
        Thu, 24 Mar 2022 00:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FECAB82228;
        Thu, 24 Mar 2022 07:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE70C340EC;
        Thu, 24 Mar 2022 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648107919;
        bh=BnVHS6h5Gh84trbMb8OgFB+LCVYnDXlcMEKuxFAbQcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLutvu2QgVXaYjMT9E6LteYKjL0MKAyLoZowrNBoFir1ic9GvP5pxB8Qn+2krNKsT
         e1nlqE+9Bxi+0O3yEKZlZAGGVG82yli47FYUoYtax9xqqFh2rz96FWGBaZ5yU51wLI
         IkIMjFwjwpyNOziCmgcUrchi+2Sls7dW24IYek69lHVfmNdarcIh051zIU47N+5Q1F
         mLUnF3S6L/VLwxyL7tckyP/ZL+0xGa6McgkCyET9q1abHUFUWANes+Pr4ehah0j46m
         PhjzhAHi/9qhbAyijiH7i+11LmXPxdatS8iuWtRQZ/aeU+zusa3p8PAIUymuuILivI
         7IaVWPk3AYkhw==
Date:   Thu, 24 Mar 2022 15:45:14 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com,
        angelogioacchino.delregno@collabora.com, miles.chen@mediatek.com,
        yc.hung@mediatek.com
Subject: Re: [PATCH v4 2/6] ASoC: mediatek: mt8195: merge machine driver
Message-ID: <Yjwhiv5Go2d62JkJ@google.com>
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
 <20220324053851.27350-3-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324053851.27350-3-trevor.wu@mediatek.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 01:38:47PM +0800, Trevor Wu wrote:
> Because most functions can be reused in different codec combinations,
> mt8195 machine drivers are combined to one common file.
> 
> The model and compatible string are used to decide which codecs are
> being used.
> 
> As a result, We can prevent from copy-paste functions when new codec
> combination is introduced.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
