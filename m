Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81204583BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiG1KOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiG1KOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E9F565560
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659003238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cRquouMZ72XSevzpz4XHT0m3YbEnzXxom7ZqAfoxxsU=;
        b=XFMM76GljQ+YMbqFFLQk+BEK2hvC40RJWmSbm3VD1sN/2WJU85jY6oOeDUI+fLFEjm3V2W
        2Ylh+3QctcMw/ajONdF5Pv1k0S4dSXgGsMugIuljmZzPN24+yRQlIyDlFLwoSpbi3onRs1
        ine8JOV17qg6U8kEZS/qWr5w9vg5tIA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-21pW1NJ5Poe1rZSJWc6qmg-1; Thu, 28 Jul 2022 06:13:54 -0400
X-MC-Unique: 21pW1NJ5Poe1rZSJWc6qmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FCA8811E75;
        Thu, 28 Jul 2022 10:13:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E76262166B26;
        Thu, 28 Jul 2022 10:13:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YstqXEPmPV2YUfWN@kernel.org>
References: <YstqXEPmPV2YUfWN@kernel.org> <20220704025248.3695-1-zeming@nfschina.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dhowells@redhat.com, Li zeming <zeming@nfschina.com>,
        jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@nfschina.com
Subject: Re: [PATCH] keys/keyctl: Fix typo in string
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2687695.1659003230.1@warthog.procyon.org.uk>
Date:   Thu, 28 Jul 2022 11:13:50 +0100
Message-ID: <2687696.1659003230@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Please, add
> 
> Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")

Since it's not a bugfix, I wouldn't put that in.  It doesn't need backporting.

David

