Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED4495B32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379181AbiAUHwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:52:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379255AbiAUHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642751491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75bkqyZxoBCmGyx86nkpZvbmutNaowP1ANxplH0ep9s=;
        b=R8HQzcWWeTZa7DVJTuFu+VzEVUoqB7qgpTJ5hVcpHc2MFBouRnf7fQzETVUywOXR8urtAc
        lsXuJGTr/u7DlqvYIdLsR6r38HxIZ4bEIalHJREuDOyb3H47+L616Qy5Ra2JhKkizl2D3b
        wstUaAfpCfKx0yvizUxcpi/gj05DbC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-RKgcfT-AMYe4TlXbrK2S7Q-1; Fri, 21 Jan 2022 02:51:26 -0500
X-MC-Unique: RKgcfT-AMYe4TlXbrK2S7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDE0C1091DA2;
        Fri, 21 Jan 2022 07:51:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E78F16A54;
        Fri, 21 Jan 2022 07:51:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B7DAF18003A7; Thu, 20 Jan 2022 12:51:35 +0100 (CET)
Date:   Thu, 20 Jan 2022 12:51:35 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Sven Schnelle <svens@stackframe.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
Message-ID: <20220120115135.f5l4sxbskzgf6ckl@sirius.home.kraxel.org>
References: <YeG8ydoJNWWkGrTb@ls3530>
 <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de>
 <87bl0amc6s.fsf@x1.stackframe.org>
 <20220118103323.4bae3a7d@eldfell>
 <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org>
 <CAMuHMdWV+-+Jr7HggbfH_GEDcdep4pJLiMG+15jxBvQ91BCS0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWV+-+Jr7HggbfH_GEDcdep4pJLiMG+15jxBvQ91BCS0w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > fbcon could do the same, i.e. render to fbdev in a 60Hz timer instead of
> > doing it synchronously.
> 
> Hopefully only the parts of the screen which need a redraw?

Sure.  drm fbdev emulation with shadow framebuffer tracks changes and
only flushes dirty areas to the real framebuffer.

fbcon could do the same when implementing lazy rendering, keeping track
of the chars/attrs which did actually change and only render those to
the (emulated or real) fbdev.

take care,
  Gerd

