Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF549084B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbiAQMH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:07:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239679AbiAQMHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642421219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjkZyvukS+eajY8g3s3P/gbb2M8cj0aCRB497Xd4F3Y=;
        b=Gc1YVVnBgT7DiYrs61DUVff0zjkVXhLg2vJH04Z3+k0OBwpA0ML/dkOzl5vLAfrj17PWCK
        ty8RzJc/ZunDHBI4Tnz3bqP2rbKXv58CavP0EaYh8SDzigevFWUpIRvwJx+my1XmJ6KT8O
        ZSvKj2Xk4QWtIg2L/w9iHnfV6a2es9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-D0Fp29XMMaCxJkB0yCT_Zw-1; Mon, 17 Jan 2022 07:06:57 -0500
X-MC-Unique: D0Fp29XMMaCxJkB0yCT_Zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD9E285B6F5;
        Mon, 17 Jan 2022 12:06:55 +0000 (UTC)
Received: from localhost (unknown [10.39.194.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 295EE2B4C7;
        Mon, 17 Jan 2022 12:06:54 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio: unexport virtio_finalize_features
In-Reply-To: <20220114195710.149933-1-mst@redhat.com>
Organization: Red Hat GmbH
References: <20220114195710.149933-1-mst@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 17 Jan 2022 13:06:53 +0100
Message-ID: <87pmoqva5e.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio_finalize_features is only used internally within virtio.
> No reason to export it.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio.c | 3 +--
>  include/linux/virtio.h  | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>

And nobody else really should use it.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

