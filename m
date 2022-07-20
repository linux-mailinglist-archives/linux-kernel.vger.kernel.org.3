Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4BF57BCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiGTRaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiGTRaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:30:01 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FC16D546
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=sdCd3kj16b9Yv+eRtEWDNXSnNK4TcrFZzY9OWD3GAwI=;
        b=tBd8pH8/aqWF6x+tkPSfX7mk7Z/EJhJihKu6EXNrex+0K9v4+dzgqHeAQmQ5oroEGNz+HIqkeTkWc
         Pv5GjyCQUvwwyvgo+Cd6YHXzcl/9MQRYJq0rfkRJveKmd47lzn0B2ia6ptwtqfA9IvKH76RKiverwn
         V+vxVndUKPEVXw69wnCPA4hpJF6PT1Rxj49MtGpp57AMQJdftMNH/Ij/9oaVDqSAO5kf0z14unxfHo
         BYvDr6IKr+jJsSduJwkUaz8memldrV6iBE/7goKcZOPO6DgA5Wye1QSoIanLTwjigKlgzvMY6cZbLh
         tKokXcA231dTqdBR77s6v5+4GFmaCTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=sdCd3kj16b9Yv+eRtEWDNXSnNK4TcrFZzY9OWD3GAwI=;
        b=ANUXDNNwirRb9bNdtz+c+dwdD7UNhRwllMMCrkq1J6ThP8xFOak0iDzL5FqvPOGaZOxwjAfCc/jao
         hu9yU7BBQ==
X-HalOne-Cookie: faf91dba2bacfa6772f150608f48f8f73229d226
X-HalOne-ID: 93b333c6-0851-11ed-823f-d0431ea8bb10
Received: from mailproxy2.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 93b333c6-0851-11ed-823f-d0431ea8bb10;
        Wed, 20 Jul 2022 17:29:58 +0000 (UTC)
Date:   Wed, 20 Jul 2022 19:29:56 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v5 4/4] drm/todo: remove task to rename CMA
 helpers
Message-ID: <Ytg7lLFs0CjviNAE@ravnborg.org>
References: <20220720153128.526876-1-dakr@redhat.com>
 <20220720153532.527458-2-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720153532.527458-2-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 05:35:32PM +0200, Danilo Krummrich wrote:
> Both, GEM and FB, CMA helpers were renamed to "GEM DMA" and "FB DMA",
> hence the task can be removed.
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

It is good to see that someone picks up a task fro the todo list!
Thanks for doing this tedious job.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
