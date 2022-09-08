Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4CD5B1539
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiIHG5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiIHG53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:57:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8768B9E88E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:57:28 -0700 (PDT)
Date:   Thu, 8 Sep 2022 08:57:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662620247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RHn8si5PmXHIaxPIvTOMBG6EmHguGpgxrwmoGepmRLU=;
        b=DqD3ViUQ4/OrHOPtl+uFoCiN1mKOqA7oo2PO8WOBL98f5JCA5SiiePFZWLzNd2rc8hdHle
        +xLESIPJLgX64xefwlZJX24AQb/DWBpO5Dj8wnvS/5h4JyxO2Lbinydy5OL8jBoSytkdkL
        7z0hfviGJeKYWAoloOZLijRUqlIRNKacexKAPGx57RPX3og5DW9Q+3oAmn4LJiP+oul/3o
        QJu4ukeObsHBcuz9FHz3IIL5V1sr7fR2GH3BWzYdwEcjolXLfCwqQj2F9K0E0p1qIQt2uC
        dQv36SjUA5X2m8X1zc9eE6M4GVS44vzfdq7wdkLyohEh3UBHW49USFF2UpSphQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662620247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RHn8si5PmXHIaxPIvTOMBG6EmHguGpgxrwmoGepmRLU=;
        b=i3Ftc6r7WgJ2F6ujGC0RhPo8Mza1uy+Y11fYKIke2YG4ktifIJVe5CD821vkhn66dGWnRn
        DKKEG+BaJ65ucTCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking: Detect includes rwlock.h outside of spinlock.h
Message-ID: <YxmSVaRpjrYpf5zT@linutronix.de>
References: <YweemHxJx7O8rjBx@linutronix.de>
 <YxmNsnCPSPt1SJcz@linutronix.de>
 <20220908025047-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220908025047-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-08 02:54:33 [-0400], Michael S. Tsirkin wrote:
> 
> This needs to be merged by locking maintainers IMHO, not by me.

I'm aware. This was directed towards will/peterz :)

Sebastian
