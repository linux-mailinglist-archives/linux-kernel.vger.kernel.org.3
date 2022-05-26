Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0C534DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241177AbiEZLDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347103AbiEZLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:03:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD4FCEBA8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=l0JDWcxKFxHcxczdCvM4u4vwfT02MEZH+w09brnPEXU=; b=RefF+MjnWt0h6B2pH5ve/dDzGx
        Bakmfl5z57kznIueQubX3BaW5E8nEjMbjz2hHUsxXPiRr7cx4aybBxvKyXKO37rIxBcxTHj4jkf4X
        g7lT5A+mK3GDQC26lgzKqtdpOzBRHaIcn22nHgjY8XjZxF3lylnM3eCv90T9gtKsKtGf5lptlXOW4
        jE4Mbot1Fno5UgamUbPOT8Okh1ORAQ4T0m963V6vzBtBcxsqqUkSeE6ssbtWoxOltIDUSLRIiTY3h
        UUwiP+o02+FhrF6PZNXeSwKj/UTJTZ+dRTwND4qj3BiXF2Pf3g4sVC7V3TaTUXVUuAVuCPfURMlN5
        UIQG7C6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuBGX-001Bjp-5k; Thu, 26 May 2022 11:02:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 966C530040C;
        Thu, 26 May 2022 13:02:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 668B720294892; Thu, 26 May 2022 13:02:50 +0200 (CEST)
Message-ID: <20220526105252.440440893@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 May 2022 12:52:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mark.rutland@arm.com
Subject: [PATCH 0/7] x86: Address various objtool complaints
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A few objtool fixes that I mean to include in a late pull.

