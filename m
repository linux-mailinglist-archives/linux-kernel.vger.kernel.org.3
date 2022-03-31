Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAB44ED9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiCaM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiCaM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C00B12128D7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648731371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5Mnqs3Bznl24t2qlJcxuDZWOB6J1u0XCG3i9ntUXvk=;
        b=AUseyBSRzqPmwx1hMLSP+NGwtPsSePI9X1d4FrqsUN8naNFQHJpeNPgwXOP1QJsOk2CrN6
        PqJmieNbVQlMZpn2qWm5+8/zBfEsOkOFraAwLzQTABeNrvt8C5Y0fEaGLhcDPcRfPM2Sz7
        avffnxKYQ+g9tAWcs2ETLo8HLmDKZeI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-uknW2jpbOmGLSUJ6dizTRg-1; Thu, 31 Mar 2022 08:56:08 -0400
X-MC-Unique: uknW2jpbOmGLSUJ6dizTRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE54880346F;
        Thu, 31 Mar 2022 12:56:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1623DC15D42;
        Thu, 31 Mar 2022 12:56:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220317021249.31655-1-yang.lee@linux.alibaba.com>
References: <20220317021249.31655-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] certs: Fix some kernel-doc comments
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3118063.1648731366.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 31 Mar 2022 13:56:06 +0100
Message-ID: <3118064.1648731366@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Li <yang.lee@linux.alibaba.com> wrote:

>  /**
> - * Allocate a struct key_restriction for the "builtin and secondary tru=
st"
> - * keyring. Only for use in system_trusted_keyring_init().
> + * get_builtin_and_secondary_restriction - Allocate a struct key_restri=
ction
> + * for the "builtin and secondary trust" keyring. Only for use in
> + * system_trusted_keyring_init().
>   */
>  static __init struct key_restriction *get_builtin_and_secondary_restric=
tion(void)

Better to just turn the "/**" into "/*" for this one.  It's not a function
that should necessarily appear in API docs.

David

