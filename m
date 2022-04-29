Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9B5142A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354779AbiD2Gyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiD2Gyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:54:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6068692B3;
        Thu, 28 Apr 2022 23:51:30 -0700 (PDT)
Date:   Fri, 29 Apr 2022 08:51:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651215088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRzozrRh87VYBCwryVh04/6Hx6ex7vN/oS+Y/xaCbtM=;
        b=UJRaGgxLoKh6czf9r26arXU5zga0sZvYvfio3kw23yWtgx6AAOmn0s5PV8tAseb67aaLNx
        gmQj8UM6crplZ/by4HFA4Q6gcVd5qgzP8OlhDbCeuWAkMC4nFga6gCE2+nQ2I+1ePpv/O0
        C3ePzbaJsZdN5ilbiAmMqXPrZ5nGn1tQDnJVa6ja4I2FjhOCuSeCZb1IJBna0QJu2FKo+6
        wgQAvCUSoPTZzge2oiS0RaKsqNQU1kDBj0+s9iktNnG1ak2CqJi2ev0jzgxwMiqamm84kL
        eGM0MwwpCikHxAKd3gFqIIhEytUg+8dv+rI5DiNk05Qd5HJRwXytLpKthnxqjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651215088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRzozrRh87VYBCwryVh04/6Hx6ex7vN/oS+Y/xaCbtM=;
        b=Doc3/tS5OTAZj5I8MKbL9nv6qfjEue89W4VnDuJRjzl2MjCJWbjUA9A91izB9MEpTs5rrK
        +YTtP6N3tjAQDzCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v4 0/4] Extend and reorganize Highmem's documentation
Message-ID: <YmuK79YPRAi0fHhH@linutronix.de>
References: <20220428212455.892-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220428212455.892-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-28 23:24:51 [+0200], Fabio M. De Francesco wrote:
> This series has the purpose to extend and reorganize Highmem's
> documentation.

Thanks.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
