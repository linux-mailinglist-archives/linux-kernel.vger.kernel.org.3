Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26DB4D7F67
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbiCNKGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiCNKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:06:34 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD337ABE;
        Mon, 14 Mar 2022 03:05:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1FC03E4;
        Mon, 14 Mar 2022 11:05:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647252323;
        bh=TgQpynA3sNDvzLkdzcaiX1oGtz52GKp9OsGryTmpIL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=felOGIIpz2e+6Mytoc5OSsKB+NceR0UO2ECrIgen5ZC3RAUxVefUpAMVI8cAI4Lax
         ZtgG1jhGiij3z9W9FFKuFpWdWtp2kN4aNBD/7g0n1U5ZUekXKkeD5ovVRi2ijZXGPd
         X0cs/eSj+CsPKfwyEvaJg9Er0uluCV78EGOLR6GA=
Date:   Mon, 14 Mar 2022 12:05:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Zhou Qingyang <zhou1615@umn.edu>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 61/64] media: platform: rename ti-vpe/ to ti/vpe/
Message-ID: <Yi8TUYsHj2Iv4zPy@pendragon.ideasonboard.com>
References: <cover.1647242578.git.mchehab@kernel.org>
 <fecdb3d1e4fffbb5c3e0003a7d403ef9669ca026.1647242579.git.mchehab@kernel.org>
 <20220314095350.mbvjs7alqoz4vvml@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220314095350.mbvjs7alqoz4vvml@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

On Mon, Mar 14, 2022 at 03:23:50PM +0530, Pratyush Yadav wrote:
> On 14/03/22 08:55AM, Mauro Carvalho Chehab wrote:
> > As the end goal is to have platform drivers split by vendor,
> > rename ti-vpe/ to ti/vpe/.
> 
> I submitted a patch to do something similar [0]. I think it is a better 
> one because there are actually 2 separate IP drivers here: CAL and VPE. 
> My patch puts them both in their own directories, and a later patch 
> introduces a 3rd driver, j721e-csi2rx.
> 
> So I would like to see my patch's directory structure being used.

I like your directory structure. Mauro, could you incorporate [0] in
your series ?

> Nacked-by: Pratyush Yadav <p.yadav@ti.com>
> 
> [0] https://patchwork.linuxtv.org/project/linux-media/patch/20220121142904.4091481-11-p.yadav@ti.com/
> 
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

-- 
Regards,

Laurent Pinchart
