Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43CD4C8DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiCAOjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiCAOin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:38:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C1A45520
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:37:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8A374218A9;
        Tue,  1 Mar 2022 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646145461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NMC6gF3NNo1KNsAv5FreKzsMGoqRXBeeXx9LFBEJtYU=;
        b=gMcugiiyOkN/gK5xNGwFSVeFU8vMwg3F+cViIkKa3j9ATA6mN7xECP67E/Ye3QpNNssk1x
        qCa2Hnk29BiGDGaNEIY6v9WWxqi7x1v1mLjJyv2jGvtmLEbn4xDplA+ofgDgsCT3nECVEM
        gidy6vCmKniZBpcM5T6GuYX9cDLhUsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646145461;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NMC6gF3NNo1KNsAv5FreKzsMGoqRXBeeXx9LFBEJtYU=;
        b=JMVO4AWod6PvezkiYXtDSJdprBC5JgGwWC8ycchzB2SH9Xx4g91doigQjEj/iYzT4a5rz9
        NVj4aNoo99mlNZDA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 66657A3B94;
        Tue,  1 Mar 2022 14:37:41 +0000 (UTC)
Date:   Tue, 1 Mar 2022 15:37:41 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 04/39] objtool: Add --dry-run
In-Reply-To: <20220224151322.248747148@infradead.org>
Message-ID: <alpine.LSU.2.21.2203011537320.8402@pobox.suse.cz>
References: <20220224145138.952963315@infradead.org> <20220224151322.248747148@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022, Peter Zijlstra wrote:

> Add a --dry-run argument to skip writing the modifications. This is
> convenient for debugging.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
