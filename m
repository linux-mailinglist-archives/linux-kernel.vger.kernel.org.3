Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABEE55A061
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiFXR0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiFXR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:27 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D34315816
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=YImQrOCjpI1Pf4sniYSIQE78QxCL87Zrr2ZodYXVNnY=;
        b=fWqRVZB/Piz7vR6GT/pFrKYPjNsODm6Lt5B5pbB2athdA4enwZe3cwndBcrnJ57M6ATcujp0kKW2S
         F6fM7giyCy9Eh1wtt9/qJRhGx2q7M8tLUenHtxp2qOh/9dtEarCJJcJCpYgFrHU3kLAUqx6xlAk2hW
         70PpcGcRobBymntLPaACuMV0fd5rBXAsNsmR3OMe5ki6m1TsvkwaAPK8HgZfdjLmdpC6brj1laBfET
         IqcPFOkzGb1JR0K7XH4FVH5btEvWwMgBg2tNiNr8kWwTgCqfciZjWE6pHIncd9tFNOaIoAD22KMoN+
         RfT6/ejTF77vupkcDkBHddZGHkF8W7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=YImQrOCjpI1Pf4sniYSIQE78QxCL87Zrr2ZodYXVNnY=;
        b=0aamlKaxWOlroxmiYOuL5/s5MGru3Ba31/MhPmFhmYdTmN8Rn2J7h0+f9Zgt2oxQkHzfCsZIhEUVg
         8SIHF1ECA==
X-HalOne-Cookie: 96a8abf5ab4b9e66dba2a4c7a0ea66e15d8eb3a2
X-HalOne-ID: 9728a25b-f3e2-11ec-a916-d0431ea8a290
Received: from mailproxy4.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 9728a25b-f3e2-11ec-a916-d0431ea8a290;
        Fri, 24 Jun 2022 17:25:06 +0000 (UTC)
Date:   Fri, 24 Jun 2022 19:25:05 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     paul@crapouillou.net, airlied@linux.ie, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ingenic: Use resource_size function on resource
 object
Message-ID: <YrXzccaCsBpPHTYw@ravnborg.org>
References: <20220624013159.88646-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624013159.88646-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

On Fri, Jun 24, 2022 at 09:31:59AM +0800, Jiapeng Chong wrote:
> This was found by coccicheck:
> 
> ./drivers/gpu/drm/ingenic/ingenic-drm-drv.c:1149:35-38: WARNING: Suspicious code. resource_size is maybe missing with res.
> 
Nice one, now I have to go back and fix my code as well.

> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
