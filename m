Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB756A205
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiGGMcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiGGMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FC322559E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657197164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VIs+6LzrSr5HlwttqwpAgHOy2YvQeXQYndH2BfxS+Zw=;
        b=L/FXzyCrMoxz02JHfmFlWJJPLGHhTGmmylQWPy0WrH1Fn/NkTwPMhqnVLmTF29DCjSlXIL
        Dw6ffmmmcqje9LEfe82cczrtr53BkwyU91+dihxFLA8q+v9yLA6UZd/Z5vkYKZ4n3MMSc3
        5q4RzGEFUyQC4y6YHO3hqSSWRQ3YrCw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-JBebleIHM3ajt5Dpsn04WQ-1; Thu, 07 Jul 2022 08:32:40 -0400
X-MC-Unique: JBebleIHM3ajt5Dpsn04WQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17A933C0E214;
        Thu,  7 Jul 2022 12:32:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D30040C141D;
        Thu,  7 Jul 2022 12:32:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220707045112.10177-2-xiubli@redhat.com>
References: <20220707045112.10177-2-xiubli@redhat.com> <20220707045112.10177-1-xiubli@redhat.com>
To:     xiubli@redhat.com
Cc:     dhowells@redhat.com, idryomov@gmail.com, jlayton@kernel.org,
        marc.dionne@auristor.com, willy@infradead.org,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        william.kucharski@oracle.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, vshankar@redhat.com
Subject: Re: [PATCH v3 1/2] netfs: do not unlock and put the folio twice
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2341365.1657197157.1@warthog.procyon.org.uk>
Date:   Thu, 07 Jul 2022 13:32:37 +0100
Message-ID: <2341366.1657197157@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xiubli@redhat.com wrote:

> URL: https://tracker.ceph.com/issues/56423

I think that should be "Link:".

David

