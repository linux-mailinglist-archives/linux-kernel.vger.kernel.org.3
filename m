Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73027490913
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbiAQM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:57:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234259AbiAQM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642424243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFtW5j5+VVKOnv4SvkQZxdJ10EG3/bDXd5xR/QAYVgI=;
        b=OVK7S+ucd577j99ldF7Crqduhy59h/A296QDjNGR7JVnK8XJui4d+AhN9O7k0cvi5JKvzg
        hPu2RIjCK5mS4wwBDJmrfkYbJbXisgR58c4xcsffa9cDskX/GdRuZCvAAm931Hrm+JeaU+
        cL0ewXk8WY18EymsZJkRywyMCavTexI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-5nhe9x8AO5uAzsdZdyfyQQ-1; Mon, 17 Jan 2022 07:57:20 -0500
X-MC-Unique: 5nhe9x8AO5uAzsdZdyfyQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00CA11006AB7;
        Mon, 17 Jan 2022 12:57:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A80AC74EAE;
        Mon, 17 Jan 2022 12:57:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C4BE318003BF; Mon, 17 Jan 2022 13:57:16 +0100 (CET)
Date:   Mon, 17 Jan 2022 13:57:16 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
Message-ID: <20220117125716.yjwxsze35j2ndn2i@sirius.home.kraxel.org>
References: <YeG8ydoJNWWkGrTb@ls3530>
 <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> b) to include new drivers (for old hardware) if they arrive (probably happens rarely but there can be).
>    I know of at least one driver which won't be able to support DRM....

Hmm?  I seriously doubt that.  There is always the option to use a
shadow framebuffer, then convert from standard drm formats to whatever
esoteric pixel format your hardware expects.

Been there, done that.  Have a look at the cirrus driver.  The physical
hardware was designed in the early 90-ies, almost 30 years ago.  These
days it exists in virtual form only (qemu emulates it).  Thanks to the
drm driver it runs wayland just fine even though it has a bunch of
constrains dictated by the hardware design.

take care,
  Gerd

