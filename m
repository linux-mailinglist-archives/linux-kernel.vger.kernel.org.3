Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2320C4A81FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349955AbiBCJwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:52:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33594 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiBCJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:52:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D1101F3A8;
        Thu,  3 Feb 2022 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643881956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bLOn4HAXkPZHEb9tPDyeDY1N8Gi6hOouq8FDKvgLLrw=;
        b=Wg8dB8Jrnul5bNu/F+Z9RTMleIZS4ejELJXXHwcvzi/A5roCngF5IlLfz+TAtpTMhgKWql
        Ff+vsH1PcdEkGhzlTAZEF8l3Q1RF+Zd3q+Y9rezHMlISAq5IleCBD90P3UHr46+7hJM0YG
        UYAkOiG42fN7Kkt3jlkL4rXoT++zXRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643881956;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bLOn4HAXkPZHEb9tPDyeDY1N8Gi6hOouq8FDKvgLLrw=;
        b=/rn9Z+Zp9bAlNUNPoHB6h6DoQjrLD6qHN8x+dY2IpVEqrioQG4WuBLjuB5MJ7TeDNxx0Nn
        0B29IMRiHSHd6fAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3077713B7F;
        Thu,  3 Feb 2022 09:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A17ICuSl+2G+RQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Feb 2022 09:52:36 +0000
Message-ID: <13e0466d-d9ec-0efd-f7df-107940636a85@suse.cz>
Date:   Thu, 3 Feb 2022 10:52:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Doug Berger <opendmb@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <fbad2233-207e-6b66-890b-ef1b1f97fdad@gmail.com>
 <Yft92aSYi9QIfKNf@linux.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Updated git tree for MM patches??
In-Reply-To: <Yft92aSYi9QIfKNf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 08:01, Mike Rapoport wrote:
> On Wed, Feb 02, 2022 at 04:21:38PM -0800, Florian Fainelli wrote:
>> Hi Andrew, Johannes,
>> 
>> The MAINTAINERS file for MEMORY MANAGEMENT lists the following git tree:
>> 
>> git://github.com/hnaz/linux-mm.git
>> 
>> however it does not look like it has been updated in the past 5 months or so
>> as master still points to 5.17-rc7-mm1
>> 
>> Is there another git tree that other memory management related subsystems
>> use for development?
> 
> AFAIK, hnaz/linux-mm was the only git mirror of mmotm series.

IIRC Michal Hocko also used to maintain one, in a different way, but that
was given up even longer ago.

linux-next seems to maintain its branch that's merged to the final next like
this:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=akpm
but that means getting the whole of next, not just mmotm. Maybe the branch
'akpm-current/current' could be also exposed separately?

> I keep a tree for memblock, but it follows Linus' tree rather than mmotm.
> I think Vlastimil's slab tree does the same.

Yeah as that's how development should be done in general, the trees should
be independent if possible.
