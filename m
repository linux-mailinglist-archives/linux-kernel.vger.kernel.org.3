Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E0D55A1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiFXTdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiFXTdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:33:21 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA6D26AF9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=A4n9ba7gyYN0ABBJdpczHxClWSBwCm9MMirtNxhj2WU=;
        b=R9Y2jlAk1Wp5xI2i2TqgQzLCxj3Yq0LiZzMzlL4KeO9v50KVdVc4hnUDjWH/aRtfMvF2pd58pbKc/
         4ldz4GqrXH4S0ecAc2EpSk5xqu34DJOxrplzomu1ORNpve5IV8LVc3J6YeH07xDPn/monxf7uor0m+
         qHyDY3tDVa/LjevkbB00756jp4DBgAWJLLEs/8uhCO96x60F7P5eSex+aQ1wt6WpYDlItkOimzI+GW
         /3E8IyREMKeMP06ki4imgorXjLWvzzzkn/U83im+qDGXk2QxULjoYzBViDkDbmEtv43d8S51YyaC+4
         626cbumYYQW6F0zJE2jmXH1L/RwWAwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=A4n9ba7gyYN0ABBJdpczHxClWSBwCm9MMirtNxhj2WU=;
        b=AfDBD7rTyxaVWlgoQzctGeKhhWt3nG2W7zFA2T+Dbh8TTlp0WMTnBybf4IeJ5eQBmlxpfNSi1QuGJ
         thAUofcAw==
X-HalOne-Cookie: 9abaa5ec99b59a2d1b4f7e25fad83e18db6c9fa8
X-HalOne-ID: 7f429d1d-f3f4-11ec-a916-d0431ea8a290
Received: from mailproxy4.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 7f429d1d-f3f4-11ec-a916-d0431ea8a290;
        Fri, 24 Jun 2022 19:33:17 +0000 (UTC)
Date:   Fri, 24 Jun 2022 21:33:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        emma@anholt.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/pl111: drop unexpected word "the" in the comments
Message-ID: <YrYRfAxsZtlBk0I6@ravnborg.org>
References: <20220621133107.3752-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621133107.3752-1-jiangjian@cdjrlc.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:31:07PM +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: drivers/gpu/drm/pl111/pl111_display.c
> line: 251
> * Note that the the ARM hardware's format reader takes 'r' from
> changed to
> * Note that the the ARM hardware's format reader takes 'r' from
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Thanks, applied to drm-misc (drm-misc-next)

	Sam
