Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3544A4A4631
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359521AbiAaLup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:50:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351376AbiAaLkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643629228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogH8tr5MmhLoSwHbiS34920WI1vsm1WsqaDgKI7Z30c=;
        b=WCwLCjzy4J0K1pdlQFP2N1wZGM7qVvIWWcnupCqZ9lv06oAUmMjXhHvCgXUTLEFE7Ef/1d
        h26AIagtWvwERh0J/ruFbQK8fjZSgHiT2CuAShQE4JOkD6cu9XqiKXLYznGljnJ3RxlyK1
        OcDujB5JriLreHY9ICbz4vAufxHrRuA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-JpulIxEPN9mN6VNYdGTbig-1; Mon, 31 Jan 2022 06:40:27 -0500
X-MC-Unique: JpulIxEPN9mN6VNYdGTbig-1
Received: by mail-wr1-f71.google.com with SMTP id s25-20020adfa299000000b001d8d032255fso4678958wra.14
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ogH8tr5MmhLoSwHbiS34920WI1vsm1WsqaDgKI7Z30c=;
        b=xHD7tpfCE0pb2IoQ7sLv1iCK56PZbhXmqJV/OAQA9Zd5wwbybFYZwPQboY2bieQQa/
         96b3YY8kv4P/4Q6njSmNYDAlJMVEgA4eXoQnGEhfAoGUcQRWauj7djuBzVvYlmrsIv0o
         gmRETYE3lwZTfkN8SCm0UAKjYvcmNalU5KXURvdFUy7We3wdf5b6ezd5yYpgeN5CMGg3
         BsJb/TYN6Q28ITJoYbJq168NyztfYxjRR8jpP2OXk8CDpiuLB+nbvk7nMuO5X3k7ckM7
         5Be+4UtpGjg/uBHSFom9HsVvbGXNNBx6A2M2WXFl5wWRmb0FQk0H7YTuNAE2MfvVwfjF
         WI9w==
X-Gm-Message-State: AOAM532w46fO8nNPMKMgs/qDC0LlTnV80TADG99jzSt74GslpMxIz/Am
        lNenYXCffejZduEF6yzAomz9zTrm48bhDDN7MA4yt7lKzMI87wKnmin8wRYs+nRmwA0/xSewicw
        45uyeFUAWEAN6I3otkuE56A/D
X-Received: by 2002:adf:ec88:: with SMTP id z8mr16622998wrn.451.1643629226094;
        Mon, 31 Jan 2022 03:40:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJ8j4HMMvBrlazNr+erVXlYYgB0uAMFAO9IPuslT9L8r/fxEe19qSF8JXMWQWKAX8XvbQPdQ==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr16622972wrn.451.1643629225838;
        Mon, 31 Jan 2022 03:40:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:b200:f007:5a26:32e7:8ef5? (p200300cbc709b200f0075a2632e78ef5.dip0.t-ipconnect.de. [2003:cb:c709:b200:f007:5a26:32e7:8ef5])
        by smtp.gmail.com with ESMTPSA id g4sm12997018wrd.111.2022.01.31.03.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 03:40:25 -0800 (PST)
Message-ID: <5788c8f5-8c2a-45c1-c374-1bf87c189c86@redhat.com>
Date:   Mon, 31 Jan 2022 12:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rafael Parra <rparrazo@redhat.com>
References: <20220128152620.168715-1-david@redhat.com>
 <20220128152620.168715-3-david@redhat.com> <20220131112909.GB18027@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/2] drivers/base/memory: determine and store zone for
 single-zone memory blocks
In-Reply-To: <20220131112909.GB18027@linux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.22 12:29, Oscar Salvador wrote:
> On Fri, Jan 28, 2022 at 04:26:20PM +0100, David Hildenbrand wrote:
>> For memory hot(un)plug, we only really care about memory blocks that:
>> * span a single zone (and, thereby, a single node)
>> * are completely System RAM (IOW, no holes, no ZONE_DEVICE)
>> If one of these conditions is not met, we reject memory offlining.
>> Hotplugged memory blocks (starting out offline), always meet both
>> conditions.

Thanks for the review Oscar!

> 
> This has been always hard for me to follow, so bear with me.
> 
> I remember we changed the memory-hotplug policy, not long ago, wrt.
> what we can online/offline so we could get rid of certain assumptions like
> "there are no holes in this memblock, so it can go" etc.

Yes, end of 2019 via c5e79ef561b0 ("mm/memory_hotplug.c: don't allow to
online/offline memory blocks with holes").

> 
> AFAIR, we can only offline if the memory
> 
> 1) belongs to a single node ("which is always the case for
>    hotplugged-memory, boot memory is trickier")
> 2) does not have any holes
> 3) spans a single zone
> 
> These are the only requeriments we have atm, right?

The most prominent core requirements, yes, leaving memory notifiers out
of the picture.

3) implies 1) as zones are per-node.

> 
> By default, hotplugged memory already complies with they all three,
> only in case of ZONE_DEVICE stuff we might violate 2) and 3).
> 
>> There are three scenarios to handle:
> ...
> ...
> 
>> @@ -225,6 +226,9 @@ static int memory_block_offline(struct memory_block *mem)
>>  	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
>>  	int ret;
>>  
>> +	if (!mem->zone)
>> +		return -EBUSY;
> 
> Should not we return -EINVAL? I mean, -EBUSY reads like this might be a
> temporary error which might get fixed later on, but that isn't the case.
> 
>> @@ -234,7 +238,7 @@ static int memory_block_offline(struct memory_block *mem)
>>  					  -nr_vmemmap_pages);
>>  
>>  	ret = offline_pages(start_pfn + nr_vmemmap_pages,
>> -			    nr_pages - nr_vmemmap_pages, mem->group);
>> +			    nr_pages - nr_vmemmap_pages, mem->zone, mem->group);
> 
> Why not passing the node as well?

The zone implies the node, and the prototype now matches the one of
online_pages(). So if we'd ever want to change that we should do it for
both functions, but I don't necessarily see the need for it.


> 
>> +static struct zone *early_node_zone_for_memory_block(struct memory_block *mem,
>> +						     int nid)
>> +{
>> +	const unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>> +	const unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
>> +	struct zone *zone, *matching_zone = NULL;
>> +	pg_data_t *pgdat = NODE_DATA(nid);
> 
> I was about to complain because in init_memory_block() you call
> early_node_zone_for_memory_block() with nid == NUMA_NODE_NODE, but then
> I saw that NODE_DATA on !CONFIG_NUMA falls to contig_page_data.
> So, I guess we cannot really reach this on CONFIG_NUMA machines with nid
> being NUMA_NO_NODE, right? (do we want to add a check just in case?)
> 

Yes, on CONFIG_NUMA this is only called via memory_block_set_nid().
memory_block_set_nid() is only available with CONFIG_NUMA and calling
memory_block_set_nid() with NUMA_NO_NODE would be a BUG.

(before sending this out I even had a BUG_ON() in memory_block_set_nid()
to verify that, but I removed it because BUG_ON's are frowned-upon.)


-- 
Thanks,

David / dhildenb

