Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29CB564970
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 21:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiGCTHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 15:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiGCTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:07:13 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3811A2BC8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=HRTHbdEC25JTA3hhXk6GM1ejYcGnX3MDfn1vFAY7xy4=;
        b=TiE6BfYu9zZBfTX3VDz8QgM2QWlNmjwGH2w6WWqmFmgnnV3p7LdmJpqZnlopZ8Dnq75BZ8pUm2UUw
         5Enozos34l11xBsILyUKYZSHtLmgu3gsvUrKcFl9IQ8LYWqFmnsa7q/Aqse04vzXEkJFiyGFXdFvnr
         WtlvEd1NXR0jrnK3lrvNzlAMIY1j7U5Ga5EuLlbHqVo0I4eI6aoZvokKCsYhWfuhkRoQS9ishTgzIq
         wVqC6EBVCfwU7xkfdS8YMynYeXP6EMkMl4svbOKyQiP6NKv/42gggbBSpfhDOE1hqvnkPaTEwid3Yb
         /mPPjiYcP0HCid8qvE7PKK5wBmO3D6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=HRTHbdEC25JTA3hhXk6GM1ejYcGnX3MDfn1vFAY7xy4=;
        b=VwEBqW74E4mZC0dwzG+CO0d2R5U3ZIkYVji1XlpBIASWd0fNU1fOz0cJZjC+VN7biCoGV7jxBXN87
         j6LyNLRAA==
X-HalOne-Cookie: a74eb6fc82b130e0f59d2fba78d5128a6abedfd9
X-HalOne-ID: 56558546-fb03-11ec-a917-d0431ea8a290
Received: from mailproxy2.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 56558546-fb03-11ec-a917-d0431ea8a290;
        Sun, 03 Jul 2022 19:07:09 +0000 (UTC)
Date:   Sun, 3 Jul 2022 21:07:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     linus.walleij@linaro.org, thierry.reding@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: nt35510: Remove duplicate 'the' in two places.
Message-ID: <YsHo3Km5clGdUk/S@ravnborg.org>
References: <20220621140151.14404-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621140151.14404-1-jiangjian@cdjrlc.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiang,

On Tue, Jun 21, 2022 at 10:01:51PM +0800, Jiang Jian wrote:
> file: ./drivers/gpu/drm/panel/panel-novatek-nt35510.c
> line: 193,214,253
> * amplification for the the step-up circuit:
> changed to
> * amplification for the step-up circuit:
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Thanks - applied to drm-misc (drm-misc-next).

	Sam
