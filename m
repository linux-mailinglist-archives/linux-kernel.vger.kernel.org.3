Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A72E55D517
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiF0Knf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiF0Knd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:43:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F0463B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:43:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 783A21F951;
        Mon, 27 Jun 2022 10:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656326609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=913pFliSOFSOwHKgY6avbycIQ9PTocqTOysVZ4q9heA=;
        b=G/gyAJ398lrS4a0YfJckO2bbsB1hhON3Bll/sjN9J45ewTrPzhvcLJPYPFt5EojoGySjaA
        8Kax7vmOeZHjfR7uFQDm8uyuVpFXdQTHgJZdXE63golMcC1HTtRR/0SRPqCHZMqz6dD7yj
        sOiWwd2MnM0Px64w0Hya53R4SoSrrlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656326609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=913pFliSOFSOwHKgY6avbycIQ9PTocqTOysVZ4q9heA=;
        b=4lt6UKfKvM8kCPomJOwGtOIy87c3zPp30BoLuSZDirrxhgQXH9XzKZ6izzs4Ti+GXGZnHh
        RJ+Xkp//0cE8DXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 653F613AB2;
        Mon, 27 Jun 2022 10:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VRcpGNGJuWJzTQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Jun 2022 10:43:29 +0000
Message-ID: <4fe7074e-e98b-5f3d-3aa4-03567d15c212@suse.cz>
Date:   Mon, 27 Jun 2022 12:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [CFP LPC 2022] Kernel Memory Management Microconference
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Linux-MM layout <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
References: <d24e9ac9-0903-3c15-c446-2962f44a360f@suse.cz>
In-Reply-To: <d24e9ac9-0903-3c15-c446-2962f44a360f@suse.cz>
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

Hi,

this is a reminder to submit your proposals as the deadline is approaching
quickly! And thanks to all who already submitted.

Vlastimil

On 5/24/22 22:48, Vlastimil Babka wrote:
> Hi,
> 
> this year there will be a brand new
> 
> 	Kernel Memory Management Microconference
> 
> co-lead by Matthew Wilcox and myself at the Linux Plumbers Conference
> (LPC), September 12-14, Dublin, Ireland, or remotely.
> 
> This microconference supplements the recently concluded LSF/MM event
> by providing an opportunity to discuss current topics with a different
> audience, in a different location, and at a different time of year.
> We would like to discuss current problems in memory management,
> for example:
> 
> 	* Multi-generational LRU vs traditional LRU
> 
> 	* Do we need three different slab allocators?
> 
> 	* How far do we take the folio conversion?
> 
> 	* Can we handle page pinning and page mapcount more
> 	  effectively?
> 
> 	* How can we effectively cache reflinked files?
> 
> 	* Can we support 1GB pages other than through hugetlbfs?
> 
> 	* How should we handle memory failures better?
> 
> Please submit your proposals at:
> 
> 	https://lpc.events/event/16/abstracts/
> 
> and select "Kernel Memory Management MC" as the track.
> Please do that by the 1st of July to allow us to plan the schedule on time.
> 
> We're looking forward to your proposals and seeing you either in Dublin
> or virtually!
> 
> Thanks,
> Vlastimil
> 

