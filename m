Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE55F4BEF34
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiBVBgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:36:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiBVBgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:36:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4572E24F19;
        Mon, 21 Feb 2022 17:35:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CFAA4210F7;
        Tue, 22 Feb 2022 01:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645493740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwiR4YqQHWTnyf8/p5OxQjzD8KArDMsS+IQIZpS4a6g=;
        b=eDzbWYmT9E+hHwQd3nmlNkYh4PsgHKB50Dqki5QT+oAVMGIlitYeQm/N+RRgqkKE1ayKfA
        370Bo3/EmGPbiXv9GBS2mf+OhTbSwAnl8fOH9IkxaSPJBmDXB8AaTF9K4nsEaOx+RnjTk7
        GuiWv5+sNfx9np5rpCPHRZyAFRykK7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645493740;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwiR4YqQHWTnyf8/p5OxQjzD8KArDMsS+IQIZpS4a6g=;
        b=f4Age2TN2CzpbL2S4NXMDRrzYcEDxZFncEe0dcObQrsDAjyf/1wyq1VRK+BcJCIdaNy3Pp
        bIZgBwrLpNC4YmAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8CC613519;
        Tue, 22 Feb 2022 01:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sVpuLOw9FGLuPQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 22 Feb 2022 01:35:40 +0000
Message-ID: <c19d1ff8-ab19-a118-17e6-bbf74059954b@suse.cz>
Date:   Tue, 22 Feb 2022 02:35:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: linux-next: manual merge of the slab tree with the origin tree
Content-Language: en-US
To:     broonie@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220222010824.3406817-1-broonie@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220222010824.3406817-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/2022 2:08 AM, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the slab tree got a conflict in:
> 
>   mm/slab.h
> 
> between commit:
> 
>   07f910f9b7295 ("mm: Remove slab from struct page")
>   d122019bf061c ("mm: Split slab into its own type")
>   4b5f8d9a895ad ("mm/memcg: Convert slab objcgs from struct page to struct slab")
> 
> from the origin tree and commit:
> 
>   b9059d7a5face ("mm: Split slab into its own type")
>   90fbf2f30c38f ("mm/memcg: Convert slab objcgs from struct page to struct slab")

Weird, these commits are old and unreachable, this is from before the merge
window. The slab tree for-next is here, Stephen has been incorporating it for
some time:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=for-next

Same thing with your other mail wrt mm/zsmalloc.c

> 
> from the slab tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> [I took the origin versions]

