Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD4F544AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244671AbiFILrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245025AbiFILrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:47:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23692DECCB;
        Thu,  9 Jun 2022 04:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F717B82D34;
        Thu,  9 Jun 2022 11:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D99C34114;
        Thu,  9 Jun 2022 11:45:27 +0000 (UTC)
Message-ID: <67af0e81-3cd1-d606-9165-ddbaa237a642@xs4all.nl>
Date:   Thu, 9 Jun 2022 13:45:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RESEND,V2,0/2] Enable hardware jpeg encoder for MT8186
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, kyrie wu <kyrie.wu@mediatek.com>,
        srv_heupstream@mediatek.com
References: <20220609114151.19509-1-irui.wang@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220609114151.19509-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Irui,

On 6/9/22 13:41, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> This series adds support for MT8186 hardware jpeg encoding.
> 
> This series has been tested with both MT8186.
> Encoding worked for this chip.
> 
> Patches 1 Adds jpeg encoder dt-bindings for mt8186
> 
> Patches 2 set bit mask for jpegenc to support 34bits iova space,
> 	which means iova rangement from 0 to 16GB.

I already made a pull request using the previous v2, and added Rob's
Reviewed-by tag manually. So I'll mark this RESEND v2 series as Superseded in
patchwork.

Regards,

	Hans

> 
> Changes compared with v1:
> --rebase on latest media_stage tree
> 
> kyrie wu (2):
>   media: media: jpegenc: add mediatek,mt8186-jpgenc compatible
>   media: media: jpegenc: set bit mask for jpegenc
> 
>  .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml    | 6 ++++++
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c        | 3 +++
>  2 files changed, 9 insertions(+)
> 
