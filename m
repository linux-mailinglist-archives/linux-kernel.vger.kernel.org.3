Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57DF52355C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244633AbiEKOZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiEKOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:25:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4AD40914
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=TDQU1UGI09RlXaAf1o727CVhHO69kh+DBTvWQI/Upls=; b=BJcALieOwlUWH2ydJVzc3iJOXy
        +mfUCNJQ5QvQwd/oR6Aa9QRl48BDFVLQHhKHQHH+jZmUt71ANm/AbT/5QYhxt3XXhd8Lldir1eX6b
        Ht/XhwZi4kx7N96eNAzJH6gHgo/lu1Tc5dAgK2JeOJggis/HHyUHhaUo15P3E1FEa2UGoosK8h7WK
        97A6mQ4/xmLL5m6WenddPkGvL2ebibIv+XL2QxWSjz8m/NELcxceKDSFDzKJtQj5FPEu+ikvtRTfZ
        //TnAOe74ac9FShTC89oLxapHG/NK+4I+e3NbpNonLUDBrc5AGv3Iv9aJFAlQRYk9khdl+/P4sp8v
        JhDYedow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nonH5-00DBu3-1R; Wed, 11 May 2022 14:25:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 362B73004B5;
        Wed, 11 May 2022 16:25:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1A6DB20245607; Wed, 11 May 2022 16:25:09 +0200 (CEST)
Message-ID: <20220511142037.353492804@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 11 May 2022 16:20:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH 0/5] perf/x86: Some cleanups
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While staring at the code recently I collected some cleanups.

