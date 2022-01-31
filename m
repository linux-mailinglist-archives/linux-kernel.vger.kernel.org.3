Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494DD4A4054
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358270AbiAaKih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:38:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35518 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358262AbiAaKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:38:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73F9C21106;
        Mon, 31 Jan 2022 10:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643625515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7peciV+pyhp1QQ5XkM4kzPTkKUJk2zmVIBLwqfr9WDo=;
        b=AwFLUn7+Hnvkr5gDdg63IGQTlPUd2sIBAqSqgVUFdBctKrVf9VgIN2gJjmCM/IjtvSxhP8
        erXT3090ZyEV4JpCDVDU1Wnirhonxk6QwxQWBrs8YMFuVhG/Vxsbq7601lvN4dEG0PqmNG
        dYOSR24vrjNFkpNN/wL5PFL1WE/g6ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643625515;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7peciV+pyhp1QQ5XkM4kzPTkKUJk2zmVIBLwqfr9WDo=;
        b=dgCLAx1SvHNDdPxkgvP+PUvbeGQKXo4eOSqBvoESG6MMkeHPh+WjuOCMsLdfd/JY903cbp
        RTyYyZdBkUq/hWCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E41C013B24;
        Mon, 31 Jan 2022 10:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D1IzNCq892E7MQAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 31 Jan 2022 10:38:34 +0000
Date:   Mon, 31 Jan 2022 11:38:33 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1 1/2] drivers/base/node: rename link_mem_sections() to
 register_memory_block_under_node()
Message-ID: <20220131103832.GA18027@linux>
References: <20220128152620.168715-1-david@redhat.com>
 <20220128152620.168715-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128152620.168715-2-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:26:19PM +0100, David Hildenbrand wrote:
> Let's adjust the stale terminology, making it match
> unregister_memory_block_under_nodes() and
> do_register_memory_block_under_node(). We're dealing with memory block
> devices, which span 1..X memory sections.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Makes sense

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
