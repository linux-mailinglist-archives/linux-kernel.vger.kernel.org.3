Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD707562C62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiGAHMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiGAHL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15F5C6B240
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656659517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9H0KysDk28AeFuwB3uKx292zWa+OjfA0oCzCBryi4g4=;
        b=jRuMq/8X8rFKeGpz5Vzgsdr3l6tESt07dVkrhT21M9RieSYGBXpjBmur35U7fdIDgb42MM
        5+XqaOEHX3pzai7NY7QOuDcX8LR0bcAhg2fj+WCNpVB+Yud+bKZDa6WnMVQ1FDRbX0vEr5
        iQVNeO2ER9rHbxpBQ1vtw8Am3BpETrI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-hZl3QDTJPie2vX4NnfJ5Wg-1; Fri, 01 Jul 2022 03:11:52 -0400
X-MC-Unique: hZl3QDTJPie2vX4NnfJ5Wg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 337AF8001EA;
        Fri,  1 Jul 2022 07:11:52 +0000 (UTC)
Received: from localhost (unknown [10.39.193.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1F17492C3B;
        Fri,  1 Jul 2022 07:11:51 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio: VIRTIO_HARDEN_NOTIFICATION is broken
In-Reply-To: <20220630191559.16738-1-mst@redhat.com>
Organization: Red Hat GmbH
References: <20220630191559.16738-1-mst@redhat.com>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date:   Fri, 01 Jul 2022 09:11:50 +0200
Message-ID: <87iloh2top.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> This option doesn't really work and breaks too many drivers.
> Not yet sure what's the right thing to do, for now
> let's make sure randconfig isn't broken by this.
>
> Fixes: c346dae4f3fb ("virtio: disable notification hardening by default")
> Cc: "Jason Wang" <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

