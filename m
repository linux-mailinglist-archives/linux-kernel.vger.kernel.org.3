Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF2554056
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356061AbiFVCBI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Jun 2022 22:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344874AbiFVCBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:01:06 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083EE33883
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:01:05 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 04B3F212D2;
        Wed, 22 Jun 2022 02:01:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 1EC4A20028;
        Wed, 22 Jun 2022 02:01:00 +0000 (UTC)
Message-ID: <2795eb1388bb22122250f3886c2585a22d844106.camel@perches.com>
Subject: Re: [PATCH] drm/nouveau/mmu: Fix a typo
From:   Joe Perches <joe@perches.com>
To:     Zhang Jiaming <jiaming@nfschina.com>, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     lyude@redhat.com, kherbst@redhat.com, bskeggs@redhat.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com
Date:   Tue, 21 Jun 2022 19:00:55 -0700
In-Reply-To: <20220622015249.8390-1-jiaming@nfschina.com>
References: <20220622015249.8390-1-jiaming@nfschina.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1EC4A20028
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: imeduxfusbtqh6mhxt5pou7tpebnh9uh
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/G1juJFWadYNMhEC2gMuIwA4DXe0U4CVo=
X-HE-Tag: 1655863260-877950
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-22 at 09:52 +0800, Zhang Jiaming wrote:
> There is a typo in comments. Change 'neeed' to 'need'.
[]
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
[]
> @@ -280,7 +280,7 @@ nvkm_vmm_unref_ptes(struct nvkm_vmm_iter *it, bool pfn, u32 ptei, u32 ptes)
>  	if (desc->type == SPT && (pgt->refs[0] || pgt->refs[1]))
>  		nvkm_vmm_unref_sptes(it, pgt, desc, ptei, ptes);
>  
> -	/* PT no longer neeed?  Destroy it. */
> +	/* PT no longer need?  Destroy it. */

needed

