Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB057B96B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbiGTPUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbiGTPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:20:15 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066402654
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=S4TzN2QwGGFIPf6yd0NbI+BY/9ToE6mosqfhMARTTuw=;
        b=hW0mljlcaonVaYqhI8ZhUM7D9+oZb4V0dcdRapU2QieKUgSD5vdYJBqS/GnbZ6ntG6GlBHhKEBQOk
         aiC9/STBnmbfjTCSLPNpSFpP6fx7OL9ATxmg3/bsBE9WxxBRBs3cG4GDZRDjUwUQSP6aivAyat9IPD
         2F17mZH4a5A2gweiPFfoIqTg5/6nuSpF+B975wZNVA84WeEfVhVMuwY+6DkiE58yw+koNYlBldfpMu
         vVDPpPW+FVzk3NvCt1as+fOfIA66ZiGR3aF6j4X3Fj/4TWpUDQUiLOTEZ/5klR662cVjo6cnzNu+G6
         4SmD1PmjWvlbmbc0h6qUoVi5hJcrV+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=S4TzN2QwGGFIPf6yd0NbI+BY/9ToE6mosqfhMARTTuw=;
        b=/UWa+i8a5IePqP4fhE0Lsdnk8OBI5LFW63Zcu92HEG2/4iKeKhArAHBIERmUjx+SLUnq2q49ZKSFP
         VsYByifDg==
X-HalOne-Cookie: b38db88aab713baeb873c9c0aba4c01aa4661cc4
X-HalOne-ID: 70ad7243-083f-11ed-823f-d0431ea8bb10
Received: from mailproxy4.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 70ad7243-083f-11ed-823f-d0431ea8bb10;
        Wed, 20 Jul 2022 15:20:08 +0000 (UTC)
Date:   Wed, 20 Jul 2022 17:20:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND 2/2] drm/virtio: kms: use drm managed resources
Message-ID: <YtgdJ5ZQAseMWk37@ravnborg.org>
References: <20220720140214.199492-1-dakr@redhat.com>
 <20220720140214.199492-3-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720140214.199492-3-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

On Wed, Jul 20, 2022 at 04:02:14PM +0200, Danilo Krummrich wrote:
> Allocate driver structures with drm managed resource allocators in order
> to cleanup/simplify the drm driver .release callback.
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

This patch is already applied to drm-misc (drm-misc-next) as
90caf42527a40d09e0eed9fcbca08d757f4fd493

	Sam
