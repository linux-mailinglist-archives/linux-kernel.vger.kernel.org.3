Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6154B6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbiFNQsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344744AbiFNQre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1C752980B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655225250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsUXNxFSBPJLxuuSCdHvqhX854mWpjHL8UsxKW4ByL0=;
        b=KlTsjbgC8raCy71ldxfc4h70Nl1mAr60TXoZn6dLbwUaFfanl2pyiHTo6RcHhm6LAU9Kkt
        Gf29lE4yitM9Ii/uB9bhaabho7Ju8kC4KThYY/nb9Jm9rVEo88LNR5WsW/aKQuRGA0UQ0M
        BdoUu6osfMq9xOFbVdoXJbkH5LwA5XM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-MS9h4F77NrizwH_ULY9kHA-1; Tue, 14 Jun 2022 12:47:25 -0400
X-MC-Unique: MS9h4F77NrizwH_ULY9kHA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D210B299E75E;
        Tue, 14 Jun 2022 16:47:24 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C66E492CA2;
        Tue, 14 Jun 2022 16:47:24 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Tom Rix <trix@redhat.com>,
        kvm@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>
Subject: Re: [PATCH] KVM: SVM: Hide SEV migration lockdep goo behind CONFIG_DEBUG_LOCK_ALLOC
Date:   Tue, 14 Jun 2022 12:47:04 -0400
Message-Id: <20220614164703.1619648-1-pbonzini@redhat.com>
In-Reply-To: <20220613214237.2538266-1-seanjc@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

For what it's worth, GCC also produces the warning with "make W=1".

Paolo


