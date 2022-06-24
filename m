Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B355355A159
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiFXSzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:55:49 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91981A19;
        Fri, 24 Jun 2022 11:55:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 54F5831A;
        Fri, 24 Jun 2022 18:55:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 54F5831A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656096948; bh=iMM6E9TOMBSB4mE/oc18Rn0KNys0P8Y37p9/4Pd3Sm0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ic5apTY/sloGCyUxOokNtgo/A6ABwNnOHl5ZfOm6M7Jh4FqKl1y0I3L1RP8WCCfWK
         RyU8UeUEC9Ec/1H7WecBNjKoZTSepszFT1HKNlGEWLZ0/5l9kHequsoqosnu49qVYz
         yRucFkWMh4KY+2G722QkWcUxzDJ2BFx2iEUmyIwPAuBkoCRcJL1L5OAl2nHQgQciH0
         YeXy3LefngGmkHf/WhKzhpczfjHEK9uWdkzW85u54kWB9qkfoShIvrFUhoB7t0Gfxs
         cCHZ14xbZvnPyUP/rSdq+csCi9ukeZ7HXL6iS3fQum69aW20aHOX+K84m211+WS5Pg
         KZsryzvni/5Mw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] docs: rename Documentation/vm to Documentation/mm
In-Reply-To: <20220622132258.457734-1-rppt@kernel.org>
References: <20220622132258.457734-1-rppt@kernel.org>
Date:   Fri, 24 Jun 2022 12:55:47 -0600
Message-ID: <877d556gcs.fsf@meer.lwn.net>
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

Mike Rapoport <rppt@kernel.org> writes:

> From: Mike Rapoport <rppt@linux.ibm.com>
>
> so it will be consistent with code mm directory and with
> Documentation/admin-guide/mm and won't be confused with virtual
> machines.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

So this seems like a good idea to me.  I'm guessing it should probably
go through -mm, otherwise I see myself explaining lots of conflicts to
Linus when the time comes...anybody disagree?

Acked-by: Jonathan Corbet <corbet@lwn.net>

THanks,

jon
