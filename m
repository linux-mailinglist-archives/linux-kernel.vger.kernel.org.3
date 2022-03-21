Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEDE4E22B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbiCUI7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345572AbiCUI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECA7813F8DE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647853028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uci3HA9GPnhiDusLig/4Rq9y/rWimdNaal1vysJDnfo=;
        b=iPs7blpXKTPu7lu66wHMqc9bBfP+T5jcHsfTLeosaLVtsjKFv/I6l07L1KuYhgYgtIBJ+D
        PCyCR4l5+rVbLTkCJy4fHQCoWdjEqsyV8EJV1AI+TNQo8IRWA1kdv7/UnGMw1ZtEPbnr74
        a0zGtGGfEzYphWBXP12Bo6r0QgPq6k4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-fnEgZZucMe23SE6PJ9eMYw-1; Mon, 21 Mar 2022 04:57:04 -0400
X-MC-Unique: fnEgZZucMe23SE6PJ9eMYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDFEC1044560;
        Mon, 21 Mar 2022 08:57:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 330AD1417201;
        Mon, 21 Mar 2022 08:57:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000035b9c05daae8a5e@google.com>
References: <000000000000035b9c05daae8a5e@google.com>
To:     syzbot <syzbot+ce865a1a714eca006986@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, christophe.jaillet@wanadoo.fr,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in __do_kernel_fault (2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <978187.1647853022.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 21 Mar 2022 08:57:02 +0000
Message-ID: <978188.1647853022@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git 6d39b096627f0a1eb6e14f049d8ae3c93e0290f2

