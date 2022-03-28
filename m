Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440154E961F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbiC1MCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiC1MCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E35F7116B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648468850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8JEjp+FthiL8lHysdzrmz7vwpEPMAj+opMQ2JKadI4=;
        b=XMI58VAoc3BTPmq88wAgZHEKQ4WPVXzFjJUm25Wzrv8V5w5qjeGHYL2yFsalmd8QZ+WC7t
        t9ilRVTNB9fJKa6dlp2O7mANk20T1om6HDJk3nmObH219UF4KYAnejHdFjgp3adw7YDUYF
        kh3nX/sUgTRp9pvllJcpO5Xw/v04ZKo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-dsS4xNUVNhmWZMDWgFo94g-1; Mon, 28 Mar 2022 08:00:46 -0400
X-MC-Unique: dsS4xNUVNhmWZMDWgFo94g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E084F3C1484A;
        Mon, 28 Mar 2022 12:00:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B013140265C;
        Mon, 28 Mar 2022 12:00:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <202203270732.dEGMthw5-lkp@intel.com>
References: <202203270732.dEGMthw5-lkp@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     dhowells@redhat.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:dhowells/linux-fs/afs-testing 44/45] arch/sparc/include/asm/cmpxchg_64.h:95:36: sparse: sparse: cast truncates bits from constant value (5e5ee5e5 becomes e5e5)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2579598.1648468843.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 28 Mar 2022 13:00:43 +0100
Message-ID: <2579599.1648468843@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> wrote:

> >> arch/sparc/include/asm/cmpxchg_64.h:95:36: sparse: sparse: cast trunc=
ates bits from constant value (5e5ee5e5 becomes e5e5)

Just ignore this.  The patch that triggered the objection is a debugging p=
atch
designed to track down a specific problem and is not intended for upstream=
ing.

David

