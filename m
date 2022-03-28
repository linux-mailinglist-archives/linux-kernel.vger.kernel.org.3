Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A284E9688
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbiC1M2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242484AbiC1M14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E0A6766A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648470375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTjwmJF+3k+khwx6D8oLjFZKu5VissWtc8nbGOTpT9Q=;
        b=aoH5JcWUfYBtXOITCfejw/HeM7W89q+2pnc0oOa9VCB3XpHuuhOW4n/6jY5K5ufau1DRB3
        AnkEMOSZR3ydR9BpYxPUgsZdmZubksVUK4U/AoXdL5Zh2ddBZ97i2MHpWd0s5q+EMw2uUz
        fjDpNMUX9VSmxze57wRFW8Dia2JWuZw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645--5RnXKeuOIybH1S_rZd2zA-1; Mon, 28 Mar 2022 08:26:09 -0400
X-MC-Unique: -5RnXKeuOIybH1S_rZd2zA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 303B3299E743;
        Mon, 28 Mar 2022 12:26:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A28697AC3;
        Mon, 28 Mar 2022 12:25:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <TYZPR01MB3935D1963BFD458E85412E4DF81B9@TYZPR01MB3935.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB3935D1963BFD458E85412E4DF81B9@TYZPR01MB3935.apcprd01.prod.exchangelabs.com>
To:     kushagra765@outlook.com
Cc:     dhowells@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        balbi@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        mcgrof@kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: [ PATCH ] Documentation: fixed doc-build warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2581030.1648470339.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 28 Mar 2022 13:25:39 +0100
Message-ID: <2581031.1648470339@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kushagra765@outlook.com wrote:

> @@ -256,7 +256,6 @@ struct fscache_cookie *fscache_acquire_cookie(struct=
 fscache_volume *volume,
>  =

>  /**
>   * fscache_use_cookie - Request usage of cookie attached to an object
> - * @object: Object description
>   * @will_modify: If cache is expected to be modified locally
>   *
>   * Request usage of the cookie attached to an object.  The caller shoul=
d tell
> @@ -272,7 +271,6 @@ static inline void fscache_use_cookie(struct fscache=
_cookie *cookie,
>  =

>  /**
>   * fscache_unuse_cookie - Cease usage of cookie attached to an object
> - * @object: Object description
>   * @aux_data: Updated auxiliary data (or NULL)
>   * @object_size: Revised size of the object (or NULL)
>   *

Just deleting these lines is the wrong thing to do.  They should instead
mention the cookie parameter.

David

