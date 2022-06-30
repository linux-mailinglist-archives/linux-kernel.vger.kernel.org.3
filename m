Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124D2562161
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiF3Rhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiF3Rhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:37:37 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA233FD92;
        Thu, 30 Jun 2022 10:37:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9CBA44B7;
        Thu, 30 Jun 2022 17:37:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9CBA44B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656610656; bh=+LbHLvKEiiEc8pj4i9ditdVLj0AsUDpF6czmKDRAGAQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ERFEf+hW4cBKgwZDsBfjGL1+pMPjSmjGy3n4+MMUybl0YPcR9mdt0i4Pfh/rdtzsK
         LXcN6qfiEKibZTLo0ApKZxP5wvduy+2n1tBkKVFCxCiD+1qy4JM8qW+dKTk0pqv83m
         iR/RE0MArmMNaB6RzHzqIHQEpzQMSGYPgvksSgr8nfvanui/XiGxOMfL0ZVQwiPhUm
         ERjvy1NdBOucCtkzB0eLfy83X1ZIVpdvgOY5lzC5rfGRPzZFVj0016MeJvcXpPJU3C
         +fQpxF0Jigtm6sDt44GZ92PLBNxiORwD+Fb7Xf+wnifXdSSbJxlQaXNgcb59dlwoQR
         MctSHX7LQJx+w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: align Italian documentation
In-Reply-To: <20220628111603.603357-1-federico.vaga@vaga.pv.it>
References: <20220628111603.603357-1-federico.vaga@vaga.pv.it>
Date:   Thu, 30 Jun 2022 11:37:36 -0600
Message-ID: <87pmiqnjbz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Translation for the following patches
>
> commit df05c0e9496c ("Documentation: Raise the minimum supported version of LLVM to 11.0.0")
> commit 333b11e541fe ("Documentation: Add minimum pahole version")
> commit 6d6a8d6a4ed0 ("docs: Update Sphinx requirements")
> [...]

Applied, thanks.

jon
