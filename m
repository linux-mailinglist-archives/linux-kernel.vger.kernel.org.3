Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8353A47CFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbhLVKVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:21:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244126AbhLVKVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640168504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J3yvO4cXgbZxOlydhSiK2v9Tckc8inZjlFWlSIoyww0=;
        b=ewT25VXTbIgrEyFXhGyn1QV8Spb0Ul6Ms5B9Rf0o72IMqgbpC3cRVQtu0by9QJ+2rv2hkm
        2muvuwUBOPshtZvkCN0vi+1/cGaXlhVePJcJwiVlJPFLi+jO8Uu3XBAqNcVuXr1xJmgfO1
        zBbJg7ObjNKAf2HJutBf2VaZ+EgzSpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-3KUcni5SOvazGs4afVTvLw-1; Wed, 22 Dec 2021 05:21:39 -0500
X-MC-Unique: 3KUcni5SOvazGs4afVTvLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0364A100C612;
        Wed, 22 Dec 2021 10:21:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F7C94E2CD;
        Wed, 22 Dec 2021 10:21:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 968651800616; Wed, 22 Dec 2021 11:21:35 +0100 (CET)
Date:   Wed, 22 Dec 2021 11:21:35 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 03/10] drm/bochs: Replace module-init boiler-plate
 code with DRM helpers
Message-ID: <20211222102135.fhtfkinp2u6yjwx3@sirius.home.kraxel.org>
References: <20211222082831.196562-1-javierm@redhat.com>
 <20211222082831.196562-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222082831.196562-4-javierm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:28:24AM +0100, Javier Martinez Canillas wrote:
> -static int __init bochs_init(void)
> -{
> -	if (drm_firmware_drivers_only() && bochs_modeset == -1)
> -		return -EINVAL;

Also cleanup bochs_modeset?  I guess its not used any more after this
patch ...

take care,
  Gerd

