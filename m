Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955CF55940A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFXHS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFXHSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:18:55 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57806647BC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:18:51 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so1309791otk.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TlCklXqXir+UR5t7qk7lKX7NWbT2pDB/489tY0Ei/lA=;
        b=T+gq6JuT5nQ06hgLvArGTAiVKwENDq4hRSLXFsagTHYICMKvtt6t89qiUO4tvltGsV
         OWe9Mh3AIFDyyhjKoMbyUeq/PuwCuC2nbjQ9oyQ75YrMUIpWjput+SWKDVJOruzqY1K/
         +ImFg48zAaufC0Ja/vlG5Xb6bzpGUJuA+F1TgEDg/A9+/rafZXBcIZvrS9W0oaW380/T
         tgGoR1KIhSLkBJGCkBM4QqVP1DU6w5jp8WUed3CdlGljY79oqlpd4x/A7fnhUAk9+mkD
         nTU3Q2lqn933JbxWHjVKdQXL075Zk4sihan8lldsPRfA2SdtyQApoP+4OFxaf2U0lm9z
         pf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TlCklXqXir+UR5t7qk7lKX7NWbT2pDB/489tY0Ei/lA=;
        b=rSgsHdWl0GjpyD7AB+4DpbpzRfZYYTLkYJ3xPpzLn/YqKLPKPTWNjF+i3AXV/4gwwZ
         2oIdqzQGh447uCQ8sMiJ+IWkEf4wkJkg9jBh2pbU7SMyoByqGNeIHa9iegeW7I0Y7xkn
         p2vCC1c7MHf8FujOLHq5ldExA/2akWE5t/QbjK1M7p1/IDu7gcdzzIqptHxp1rErFLkf
         bOYTmA1bvq+ZdAd5X1VQuES0qGxe1XcRGyZ1wbOYYK38XqDLiyk1FiK84T497E+Qkyrb
         E2NBe0/el8hX67nSSbmTKvC3J91eFM9+gXYxYyAJ06tSPUIMfr92qbMn/XDDvPNzf7Cn
         xSgQ==
X-Gm-Message-State: AJIora9c5elxtk6TzSnju8pdZoPBzz6vs4sAMjFJWREAJ1yjRzIWKhPp
        eOVmHL3IWIuwGrE7P0BAq9ylNCnNUvc=
X-Google-Smtp-Source: AGRyM1snaUJxUjb5wrRsmmLAQLqK+mPMkAGmPKC1jmjCeNtoQscdDMz5Q444HxsO7WbSqOzQo5d3yA==
X-Received: by 2002:a05:6830:2390:b0:60c:20cf:5946 with SMTP id l16-20020a056830239000b0060c20cf5946mr5540783ots.88.1656055130589;
        Fri, 24 Jun 2022 00:18:50 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id l17-20020a05687014d100b000f349108868sm1330505oab.44.2022.06.24.00.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 00:18:50 -0700 (PDT)
Date:   Fri, 24 Jun 2022 02:18:48 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 2/4] memblock tests: add verbose output to memblock
 tests
Message-ID: <YrVlWD5qJnr9OTik@bertie>
References: <cover.1655889641.git.remckee0@gmail.com>
 <004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com>
 <YrPsUrJ5R5UaIGBS@kernel.org>
 <YrQIkswtqUAz9cUt@bertie>
 <YrR7XuV3Yoi4e2mf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrR7XuV3Yoi4e2mf@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 09:40:30AM -0500, Mike Rapoport wrote:
> On Thu, Jun 23, 2022 at 01:30:42AM -0500, Rebecca Mckeever wrote:
> > On Wed, Jun 22, 2022 at 11:30:10PM -0500, Mike Rapoport wrote:
> > > On Wed, Jun 22, 2022 at 04:29:07AM -0500, Rebecca Mckeever wrote:
> > > > Add and use functions for printing verbose testing output.
> > > > 
> > > > If the Memblock simulator was compiled with VERBOSE=1:
> > > >   prefix_push() appends the given string to a prefix string that will be
> > > >     printed in the test functions.
> > > >   prefix_pop() removes the last prefix from the prefix string.
> > > >   prefix_reset() clears the prefix string.
> > > >   test_fail() prints a message after a test fails containing the test
> > > >     number of the failing test and the prefix.
> > > >   test_pass() prints a message after a test passes containing its test
> > > >     number and the prefix.
> > > >   test_print() prints the given formatted output string.
> > > > 
> > > > If the Memblock simulator was not compiled with VERBOSE=1, these
> > > > functions do nothing.
> > > > 
> > > > Add the assert wrapper macros ASSERT_EQ(), ASSERT_NE(), and ASSERT_LT().
> > > > If the assert condition fails, these macros call test_fail() before
> > > > executing assert().
> > > > 
> > > > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > > > ---
> > > >  tools/testing/memblock/tests/alloc_api.c      | 241 ++++++++----
> > > >  .../memblock/tests/alloc_helpers_api.c        | 135 +++++--
> > > >  tools/testing/memblock/tests/alloc_nid_api.c  | 371 ++++++++++++------
> > > >  tools/testing/memblock/tests/basic_api.c      | 365 ++++++++++++-----
> > > >  tools/testing/memblock/tests/common.c         |  58 +++
> > > >  tools/testing/memblock/tests/common.h         |  54 +++
> > > >  6 files changed, 880 insertions(+), 344 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> > > > index d1aa7e15c18d..96df033d4300 100644
> > > > --- a/tools/testing/memblock/tests/alloc_api.c
> > > > +++ b/tools/testing/memblock/tests/alloc_api.c
> > > 
> > > ...
> > > 
> > > > @@ -729,6 +820,12 @@ static int alloc_no_memory_check(void)
> > > >  
> > > >  int memblock_alloc_checks(void)
> > > >  {
> > > > +	static const char func_testing[] = "memblock_alloc";
> > > > +
> > > > +	prefix_reset();
> > > > +	prefix_push(func_testing);
> > > > +	test_print("Running %s tests...\n", func_testing);
> > > 
> > > Why not 
> > > 
> > > 	test_print("Running memblock_alloc tests...\n");
> > > 
> > > ?
> > > 
> > > (applies to other cases below)
> > 
> > Both prefix_push() and test_print() are using that string, and I thought
> > it made sense to use a constant instead of hard coding the string in both
> > places. Is it better to hard code the string in this case?
> 
> Oh, missed that.
> I'd drop static, it doesn't really matter here.
>  
Will do.
> > > > +
> > > >  	reset_memblock_attributes();
> > > >  	dummy_physical_memory_init();
> > > 
> > > ...
> > > 
> > > > diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
> > > > index 963a966db461..f6eaed540427 100644
> > > > --- a/tools/testing/memblock/tests/alloc_helpers_api.c
> > > > +++ b/tools/testing/memblock/tests/alloc_helpers_api.c
> > > 
> > > ...
> > > 
> > > > @@ -378,6 +423,12 @@ static int alloc_from_min_addr_cap_check(void)
> > > >  
> > > >  int memblock_alloc_helpers_checks(void)
> > > >  {
> > > > +	static const char func_testing[] = "memblock_alloc_from";
> > > > +
> > > > +	prefix_reset();
> > > > +	prefix_push(func_testing);
> > > > +	test_print("Running %s tests...\n", func_testing);
> > > > +
> > > >  	reset_memblock_attributes();
> > > >  	dummy_physical_memory_init();
> > > >  
> > > > diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> > > > index 6390206e50e1..601f4a7ee30d 100644
> > > > --- a/tools/testing/memblock/tests/alloc_nid_api.c
> > > > +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> > > 
> > > ...
> > > 
> > > > @@ -1150,6 +1263,12 @@ static int alloc_try_nid_low_max_check(void)
> > > >  
> > > >  int memblock_alloc_nid_checks(void)
> > > >  {
> > > > +	static const char func_testing[] = "memblock_alloc_try_nid";
> > > > +
> > > > +	prefix_reset();
> > > > +	prefix_push(func_testing);
> > > > +	test_print("Running %s tests...\n", func_testing);
> > > > +
> > > >  	reset_memblock_attributes();
> > > >  	dummy_physical_memory_init();
> > > >  
> > > > @@ -1170,5 +1289,7 @@ int memblock_alloc_nid_checks(void)
> > > >  
> > > >  	dummy_physical_memory_cleanup();
> > > >  
> > > > +	prefix_pop();
> > > > +
> > > >  	return 0;
> > > >  }
> > > > diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> > > > index a7bc180316d6..f223a9a57be7 100644
> > > > --- a/tools/testing/memblock/tests/basic_api.c
> > > > +++ b/tools/testing/memblock/tests/basic_api.c
> > > > @@ -4,21 +4,30 @@
> > > >  #include "basic_api.h"
> > > >  
> > > >  #define EXPECTED_MEMBLOCK_REGIONS			128
> > > > +#define FUNC_ADD					"memblock_add"
> > > > +#define FUNC_RESERVE					"memblock_reserve"
> > > > +#define FUNC_REMOVE					"memblock_remove"
> > > > +#define FUNC_FREE					"memblock_free"
> > > >  
> > > >  static int memblock_initialization_check(void)
> > > >  {
> > > > -	assert(memblock.memory.regions);
> > > > -	assert(memblock.memory.cnt == 1);
> > > > -	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
> > > > -	assert(strcmp(memblock.memory.name, "memory") == 0);
> > > > +	prefix_push(__func__);
> > > >  
> > > > -	assert(memblock.reserved.regions);
> > > > -	assert(memblock.reserved.cnt == 1);
> > > > -	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
> > > > -	assert(strcmp(memblock.reserved.name, "reserved") == 0);
> > > > +	ASSERT_NE(memblock.memory.regions, NULL);
> > > > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > > > +	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
> > > > +	ASSERT_EQ(strcmp(memblock.memory.name, "memory"), 0);
> > > >  
> > > > -	assert(!memblock.bottom_up);
> > > > -	assert(memblock.current_limit == MEMBLOCK_ALLOC_ANYWHERE);
> > > > +	ASSERT_NE(memblock.reserved.regions, NULL);
> > > > +	ASSERT_EQ(memblock.reserved.cnt, 1);
> > > > +	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
> > > > +	ASSERT_EQ(strcmp(memblock.reserved.name, "reserved"), 0);
> > > > +
> > > > +	ASSERT_EQ(memblock.bottom_up, false);
> > > > +	ASSERT_EQ(memblock.current_limit, MEMBLOCK_ALLOC_ANYWHERE);
> > > > +
> > > > +	test_pass();
> > > > +	prefix_pop();
> > > >  
> > > >  	return 0;
> > > >  }
> > > > @@ -40,14 +49,19 @@ static int memblock_add_simple_check(void)
> > > >  		.size = SZ_4M
> > > >  	};
> > > >  
> > > > +	prefix_push(__func__);
> > > > +
> > > >  	reset_memblock_regions();
> > > >  	memblock_add(r.base, r.size);
> > > >  
> > > > -	assert(rgn->base == r.base);
> > > > -	assert(rgn->size == r.size);
> > > > +	ASSERT_EQ(rgn->base, r.base);
> > > > +	ASSERT_EQ(rgn->size, r.size);
> > > > +
> > > > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > > > +	ASSERT_EQ(memblock.memory.total_size, r.size);
> > > >  
> > > > -	assert(memblock.memory.cnt == 1);
> > > > -	assert(memblock.memory.total_size == r.size);
> > > > +	test_pass();
> > > > +	prefix_pop();
> > > >  
> > > >  	return 0;
> > > >  }
> > > > @@ -69,18 +83,27 @@ static int memblock_add_node_simple_check(void)
> > > >  		.size = SZ_16M
> > > >  	};
> > > >  
> > > > +	prefix_pop();
> > > > +	prefix_push("memblock_add_node");
> > > > +	prefix_push(__func__);
> > > 
> > > I think there is no need to change the prefix from memblock_add to
> > > memblock_add_node here.
> > > 
> > > ok 3 : memblock_add: memblock_add_node_simple_check: passed
> > > 
> > > provides enough information.
> > >
> > 
> > Will do.
> > 
> > > > +
> > > >  	reset_memblock_regions();
> > > >  	memblock_add_node(r.base, r.size, 1, MEMBLOCK_HOTPLUG);
> > > >  
> > > > -	assert(rgn->base == r.base);
> > > > -	assert(rgn->size == r.size);
> > > > +	ASSERT_EQ(rgn->base, r.base);
> > > > +	ASSERT_EQ(rgn->size, r.size);
> > > >  #ifdef CONFIG_NUMA
> > > > -	assert(rgn->nid == 1);
> > > > +	ASSERT_EQ(rgn->nid, 1);
> > > >  #endif
> > > > -	assert(rgn->flags == MEMBLOCK_HOTPLUG);
> > > > +	ASSERT_EQ(rgn->flags, MEMBLOCK_HOTPLUG);
> > > > +
> > > > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > > > +	ASSERT_EQ(memblock.memory.total_size, r.size);
> > > >  
> > > > -	assert(memblock.memory.cnt == 1);
> > > > -	assert(memblock.memory.total_size == r.size);
> > > > +	test_pass();
> > > > +	prefix_pop();
> > > > +	prefix_pop();
> > > > +	prefix_push(FUNC_ADD);
> > > >  
> > > >  	return 0;
> > > >  }
> > > 
> > > -- 
> > > Sincerely yours,
> > > Mike.
> > 
> > Thanks,
> > Rebecca
> 
> -- 
> Sincerely yours,
> Mike.
