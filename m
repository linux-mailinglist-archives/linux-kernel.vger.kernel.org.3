Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5584F7697
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbiDGGv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbiDGGv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:51:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB3B972DD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TRuyYrI6QIjDnm+Fxz66zclIQ9YzAEAHcGW4G3ey3AQ=; b=JKIqsbrs0eCkOAuC91zdldoZTv
        NHC/Tq07U+12KWn5KTMfqoMNRAXloZyiy9BBo15duy4MpuTaTaUZqf0hnBlJ/+0VPiGIZQULcpBgs
        xqH/8ecKY9Pl0hnr4esgOv9MCrcvNq7zsjnJPHZ/I25OdGmJZntnS3Tiz9O29YJ+1fJieoyGHyMC8
        vYSIAuVbwnyPMBWTt7QlNEiND70bzFkQ/TWmglweqg5g5NX0s0cg/utYUFLkwpJakyozd3NmlEnNx
        HMN8RAa8W/DIAk0psEphIZ9lbPXTFSt4FZWel4r/1vlqAgKgPM+6lOueYxarA27kUjl/7rNlrfBy5
        SGoTmfHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncLxg-002PpJ-Bc; Thu, 07 Apr 2022 06:49:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E863398156E; Thu,  7 Apr 2022 08:49:41 +0200 (CEST)
Date:   Thu, 7 Apr 2022 08:49:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: IBT related objtool warnings
Message-ID: <20220407064941.GH2731@worktop.programming.kicks-ass.net>
References: <314eeced310b07b50b500384741378e59168c36c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314eeced310b07b50b500384741378e59168c36c.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 10:43:33PM +0000, Edgecombe, Rick P wrote:
> Hi,
> 
> After commit:
> ed53a0d97192 x86/alternative: Use .ibt_endbr_seal to seal indirect calls
> 
> I am getting objtool "unreachable instruction" warnings.
> 
> On one system with gcc 8.4.0:
> vmlinux.o: warning: objtool: start_secondary()+0x10e: unreachable
> instruction
> 
> On another with gcc 11.2.1:
> vmlinux.o: warning: objtool: pvh_start_xen()+0x0: unreachable
> instruction

Could you try with tip/x86/urgent ?
