Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2334AD686
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356854AbiBHL0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356137AbiBHKPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:15:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCA3C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:15:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C186F1F383;
        Tue,  8 Feb 2022 10:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644315306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmBoCspThb0e3/6sT933uzB0WbHZ0YSRYCjWmTB8oEw=;
        b=xwK4FNK4oRgULGk+hEaIWl2DMi2wGLEGEdRjGGURmkv8te32jqOeOWas55XHJ7GAnkdosR
        k/VH5rlFrqrZVJe2hJ+Q7S5ORY2sj+nTaoBdMs003KaXJqB3nX25IOcb7F/h6JHNGNuibn
        jzVV+JyHg459j+fzgitn7McurWs5N1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644315306;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmBoCspThb0e3/6sT933uzB0WbHZ0YSRYCjWmTB8oEw=;
        b=Ox3NpwQAyyjdALliT+ueZqIpO+SUsJHjvMMhM5ihNNl7k8zulyFpvPEwjNcDs7J9SYcxfd
        HZRjbledr9cbOpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6553713C08;
        Tue,  8 Feb 2022 10:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Dz3fFKpCAmLGcwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 08 Feb 2022 10:15:06 +0000
Date:   Tue, 8 Feb 2022 11:15:04 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/memory_hotplug: remove obsolete comment of
 __add_pages
Message-ID: <YgJCqAToVBk2G3fq@localhost.localdomain>
References: <20220207133643.23427-1-linmiaohe@huawei.com>
 <20220207133643.23427-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207133643.23427-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:36:40PM +0800, Miaohe Lin wrote:
> Since commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
> memory to zones until online"), there is no need to pass in the zone.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Yeah, I am with David here, "Reasonably generic function for adding
memory" does not really tell me much about that function.
 

-- 
Oscar Salvador
SUSE Labs
