Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC0353E0CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiFFFDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFFFDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:03:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D7B2C5DAA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 21:43:41 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2560KgbX013268;
        Mon, 6 Jun 2022 04:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6zhhzeHxXAOMQz5XGKts0jYo52r235YeZxvi49FXyWQ=;
 b=LeCiJfyyRPD8j2dX0Q5pembWMV6Ae6i0B/KTVofJOG7bMYNGbw1dTmL1qSH+ga8KElHt
 SPaTW7ROLxhO4l2Fzto4LV4lVldMmYg01NM1x+qqz0wD8Ow+lcrDyEqooYB9fq6wd9kt
 7EeaJovGOnw9Wfw0uD08FmqIWMEbU3AsbVeWyxYNyp0oxpQTc+sAufdLAZonitDqJQhl
 GqNqJ5YUQvhUWF2jR1CKpIrnAvy1KEhsYA6di0J+QyMziGNu439Q9jmX3qs6LP+YCfz+
 +z8O4O++4+4SUfwzzETs++kivMPeOcqrXPX5CqUynJDmoo7d4TySx5mN6ORbjod/06tY vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gggtjqq5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 04:07:38 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25647beK012595;
        Mon, 6 Jun 2022 04:07:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gggtjqq4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 04:07:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25645dTN006502;
        Mon, 6 Jun 2022 04:07:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3gfy199t83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 04:07:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25647XeB52298076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 04:07:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35FF952050;
        Mon,  6 Jun 2022 04:07:33 +0000 (GMT)
Received: from [9.43.83.177] (unknown [9.43.83.177])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 696545204F;
        Mon,  6 Jun 2022 04:07:27 +0000 (GMT)
Message-ID: <a7d3829e-8bc5-d7a8-5e9e-a7943bb50740@linux.ibm.com>
Date:   Mon, 6 Jun 2022 09:37:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v4 7/7] mm/demotion: Demote pages according to
 allocation fallback order
Content-Language: en-US
To:     Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-8-aneesh.kumar@linux.ibm.com>
 <b102d5773bffd6391283773044f756e810c1f044.camel@intel.com>
 <046c373a-f30b-091d-47a1-e28bfb7e9394@linux.ibm.com>
 <9f6e60cc8be3cbde4871458c612c5c31d2a9e056.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <9f6e60cc8be3cbde4871458c612c5c31d2a9e056.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jbC8yOk8SUxDAu8J9Cl5SQQVHKRBxL9S
X-Proofpoint-ORIG-GUID: qeGq60ZRtLgXGPf6EZj5KAuEoUqZO_j5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_01,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060021
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 6:13 AM, Ying Huang wrote:
> On Fri, 2022-06-03 at 20:39 +0530, Aneesh Kumar K V wrote:
>> On 6/2/22 1:05 PM, Ying Huang wrote:
>>> On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
>>>> From: Jagdish Gediya <jvgediya@linux.ibm.com>
>>>>
>>>> currently, a higher tier node can only be demoted to selected
>>>> nodes on the next lower tier as defined by the demotion path,
>>>> not any other node from any lower tier.  This strict, hard-coded
>>>> demotion order does not work in all use cases (e.g. some use cases
>>>> may want to allow cross-socket demotion to another node in the same
>>>> demotion tier as a fallback when the preferred demotion node is out
>>>> of space). This demotion order is also inconsistent with the page
>>>> allocation fallback order when all the nodes in a higher tier are
>>>> out of space: The page allocation can fall back to any node from any
>>>> lower tier, whereas the demotion order doesn't allow that currently.
>>>>
>>>> This patch adds support to get all the allowed demotion targets mask
>>>> for node, also demote_page_list() function is modified to utilize this
>>>> allowed node mask by filling it in migration_target_control structure
>>>> before passing it to migrate_pages().
>>>
>>
>> ...
>>
>>>>     * Take pages on @demote_list and attempt to demote them to
>>>>     * another node.  Pages which are not demoted are left on
>>>> @@ -1481,6 +1464,19 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>>>>    {
>>>>    	int target_nid = next_demotion_node(pgdat->node_id);
>>>>    	unsigned int nr_succeeded;
>>>> +	nodemask_t allowed_mask;
>>>> +
>>>> +	struct migration_target_control mtc = {
>>>> +		/*
>>>> +		 * Allocate from 'node', or fail quickly and quietly.
>>>> +		 * When this happens, 'page' will likely just be discarded
>>>> +		 * instead of migrated.
>>>> +		 */
>>>> +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
>>>> +			__GFP_NOMEMALLOC | GFP_NOWAIT,
>>>> +		.nid = target_nid,
>>>> +		.nmask = &allowed_mask
>>>> +	};
>>>
>>> IMHO, we should try to allocate from preferred node firstly (which will
>>> kick kswapd of the preferred node if necessary).  If failed, we will
>>> fallback to all allowed node.
>>>
>>> As we discussed as follows,
>>>
>>> https://lore.kernel.org/lkml/69f2d063a15f8c4afb4688af7b7890f32af55391.camel@intel.com/
>>>
>>> That is, something like below,
>>>
>>> static struct page *alloc_demote_page(struct page *page, unsigned long node)
>>> {
>>> 	struct page *page;
>>> 	nodemask_t allowed_mask;
>>> 	struct migration_target_control mtc = {
>>> 		/*
>>> 		 * Allocate from 'node', or fail quickly and quietly.
>>> 		 * When this happens, 'page' will likely just be discarded
>>> 		 * instead of migrated.
>>> 		 */
>>> 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>>> 			    __GFP_THISNODE  | __GFP_NOWARN |
>>> 			    __GFP_NOMEMALLOC | GFP_NOWAIT,
>>> 		.nid = node
>>> 	};
>>>
>>> 	page = alloc_migration_target(page, (unsigned long)&mtc);
>>> 	if (page)
>>> 		return page;
>>>
>>> 	mtc.gfp_mask &= ~__GFP_THISNODE;
>>> 	mtc.nmask = &allowed_mask;
>>>
>>> 	return alloc_migration_target(page, (unsigned long)&mtc);
>>> }
>>
>> I skipped doing this in v5 because I was not sure this is really what we
>> want.
> 
> I think so.  And this is the original behavior.  We should keep the
> original behavior as much as possible, then make changes if necessary.
> 

That is the reason I split the new page allocation as a separate patch. 
Previous discussion on this topic didn't conclude on whether we really 
need to do the above or not
https://lore.kernel.org/lkml/CAAPL-u9endrWf_aOnPENDPdvT-2-YhCAeJ7ONGckGnXErTLOfQ@mail.gmail.com/

Based on the above I looked at avoiding GFP_THISNODE allocation. If you 
have experiment results that suggest otherwise can you share? I could 
summarize that in the commit message for better description of why 
GFP_THISNODE enforcing is needed.

>> I guess we can do this as part of the change that is going to
>> introduce the usage of memory policy for the allocation?
> 
> Like the memory allocation policy, the default policy should be local
> preferred.  We shouldn't force users to use explicit memory policy for
> that.
> 
> And the added code isn't complex.
> 

-aneesh
