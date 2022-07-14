Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB4574B18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbiGNKsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiGNKsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:48:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106651406;
        Thu, 14 Jul 2022 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XohSnVoV4/1lapZbhGBzX2/x+DHxkPY5UG2ab+3neEw=; b=MziSggPty3ej2uD1YfMBwconmS
        1f1LjggwlXHkmCjf8EvrkcJMFYuZfMo5gyndLt+GS3m29klzYZ5UB8iwXY3bwd9GkrpLlh8iwg+Qh
        PIGGXMO84HlmxCTwDm4slMY9WEM+2rzr4a8ROntmdlPdm9n/30UL90FzecQW2wvgOBgMvGHHGNUu4
        ZL1x0+aiMDgDqx7DEBpcsHJQ0PutUzPfUBzRJ+JQO7ek+fLfsRIASxtvBX1eTyoMMotaTM2+V2mQ5
        dZ7wtIpu1dE2GtcyQzLlMWfYG6fFK5jq8biA/YFvZutry/xjboDsRCCT5BQ2eqOcCw64h8dgd2/La
        br7+6K5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBwOI-003oqI-VN; Thu, 14 Jul 2022 10:48:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E26E6980120; Thu, 14 Jul 2022 12:48:17 +0200 (CEST)
Date:   Thu, 14 Jul 2022 12:48:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix spelling mistake "teh " -> "the"
Message-ID: <Ys/0cXFRssinOqRE@worktop.programming.kicks-ass.net>
References: <20220714102856.22512-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714102856.22512-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:28:56AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a WARN_FUNC message. Fix it.

That was so on purpose... :-)
