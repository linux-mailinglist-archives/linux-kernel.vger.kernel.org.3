Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97757A049
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiGSODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiGSODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D19F625C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658236507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=Fp6c5EjfSHb3c8O3ybPw9+FXv2us9IOGWC8Gwlu4whT7pt1lQZlj+NmHJ89Nmez3vHfDrL
        G1sydneKbW7sJFmpq+oclsJmAgrsb0qQrY8sZuk3vRQDh1BOhiQgPYEe8UWAdl5wGRChCR
        YwwQvXosmDLkbmXrdpiHi7htPq58Yuw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-agVGXtjHMQWNT-J-BTP9bw-1; Tue, 19 Jul 2022 09:15:05 -0400
X-MC-Unique: agVGXtjHMQWNT-J-BTP9bw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBD121C01B3E;
        Tue, 19 Jul 2022 13:15:04 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E4E8141511A;
        Tue, 19 Jul 2022 13:15:04 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] KVM: x86: Clean up rmap zap helpers
Date:   Tue, 19 Jul 2022 09:15:04 -0400
Message-Id: <20220719131504.2394337-1-pbonzini@redhat.com>
In-Reply-To: <20220715224226.3749507-1-seanjc@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


