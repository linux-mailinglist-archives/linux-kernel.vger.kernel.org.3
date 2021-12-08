Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0B46DB5C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbhLHSoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbhLHSoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:44:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A60C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZVzT81CqQrQGX+cWwoW6wmslcdMp/xonpKJhk/m6HpU=; b=O1X/WrKbZ2sOgFV+MHBXIgf1O9
        eXV45ws6AAGzghsrtaPU3CSeO+y/uSNhTGJDLSuc9PXuGDnOCx3XoUwWMfUN0ezA4fBpvNXUeBR1p
        U+yYtGvzvEoocJMaVluB09YvaFcWZlXE5z6M35arktxt4HYylcV0tji6LqJjA90r3Aj2WX30p1cBP
        cO23JMtSg30xl77ejYvNNZMozd/5nK5x/zSITxIzCexKnv3jcmaaSczS8ZlFsZz8xGk9J+UEFiKU6
        FS+QttJ37uWtsGn+upzQH4/ot0ADXga9Nvj/C5Ycx38uQpznMGSCE+Nn7FINcPkBivwhnFLdQiyEt
        r0JtoHbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv1ro-000E8k-Vq; Wed, 08 Dec 2021 18:40:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEC15300348;
        Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A3E6229AF612C; Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Message-ID: <20211208183655.251963904@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Dec 2021 19:36:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org
Subject: [RFC][PATCH 0/5] refcount: Improve code-gen
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Improves the refcount_t code-gen; I've still got to go through the latest thing
Linus suggested, but figured I should get these patches out to see if there's
other concerns etc..



