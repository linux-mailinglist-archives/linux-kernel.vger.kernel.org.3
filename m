Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9031A507B53
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357820AbiDSU4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243270AbiDSU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:56:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71F4162D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=jDnUu5HQLqvJ6wxwfTSp7zh2te
        O+HWJdA/9H8lb8MF5UYkkdj/dzPyU5FQh2uf9fn9JczFuOjVA7ehghka8HsKrg1UsDanzRN1d8VIx
        PvnPHHth9b1p2/O2nevhJFSai5DgXuiH6RJvvVID9wAs0X8gXzvuW3TGKtTGaEpa3iZa0DbkklSgO
        R+KRJTltdWXyHYQhN75XusqINOURz8oSFkGgqoMPT6moLEtQ2eTEiwENHOoWBpScaFumK8rhyNVb2
        sECG9sdX6TsnBeE/H+bLHO72ZBXimBsuLvMSAYWeklqxiTmmx3pkfP+ZzCQcLnIyeUOHwtJO6HFHm
        Ly7EMWdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngur2-006uzP-Nl; Tue, 19 Apr 2022 20:53:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56005300091;
        Tue, 19 Apr 2022 22:53:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 35CD5212B0C79; Tue, 19 Apr 2022 22:53:44 +0200 (CEST)
Message-ID: <20220419204109.520779286@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 19 Apr 2022 22:41:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, brgerst@gmail.com,
        jiangshanlai@gmail.com, Andrew.Cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 0/2] x86: A few random cleanups
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,BODY_EMPTY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



