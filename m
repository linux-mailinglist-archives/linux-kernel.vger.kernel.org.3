Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E3575709
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiGNVd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGNVdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:33:24 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C6A6EE9B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:33:23 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10bffc214ffso4107823fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Yo6/rROZQGIxEhZTOj29hnmvSjlzd/7XvdKvwMO2Wo=;
        b=d+78ytvtSLtq87rZM5EZR8bCaSdAtH3Gslg5YBVTbH2d+wMsV+1IlYByo3PcW12whi
         aGhnXnar++EzBRFP8mxORg1bqUJuWt3IIEoJX2sBzqf3eDTkEpgMC3N35550UzqfvL7z
         5UM9hNxRh0WMaEEuZKX9oKqSVkIRbiKay0ak0lyMeIsIk4wcYmpXNxGa1huwGweUataQ
         JkOUkW3nAfO4RWQP7Ahgz3U/SjykNRb0ulIEtp27JKzO2AccLHVEzy5jxsQWMkYzh8te
         CG3mXaO4V9VwvO4zV1GGCs7hVG+Eevn1nen7QFFPet1o3TSgMgxYU5wK8hQNvOlpWbsj
         avNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Yo6/rROZQGIxEhZTOj29hnmvSjlzd/7XvdKvwMO2Wo=;
        b=cA/r3+btDMHt1Hs2ozxP/JiNnQL7g7bRKroM9QPHytCxh52M3qUapWCAdnbIhTN5aM
         9CzcAF33NzKzQqfDVyuiKqKG/waBORIvsM6mGLAzTjCCx8NylUi8t2eoAI2I9OUR/mfp
         z8ZofJnU7yZ0I02912KBFKfBvIBcsFob9T370lBpEj/cJi5mmP+R0lm8A5KfF8Oob3Ge
         ERPT1eyPB6gY9zm/gKjov8NAlD7PK164QL4tEeScBiMK1/RCIZJVsEUhJ2iBWJt0Ow6q
         6t//RcUDJZmyzZdlYNKUArVW6JfDZhpzznV8bj8/zShTEuJ8ufXfYmKXa4y+Q/My08Do
         wtAw==
X-Gm-Message-State: AJIora8DKSJt9hjNi+eVRu46Tqj7QNj0Ci7fKEy2u+OD0+lEcowXAbyH
        tO3LNZBCl6I7lYcc6x34+v0Ycp3Jv4Vbnw==
X-Google-Smtp-Source: AGRyM1sB+weFOV/9uNLsegfMFpWw0jegOf5PGesdjXfm1hvl8t2vJhFb7EsoS8nUfxJR4+bH431oIg==
X-Received: by 2002:a05:6870:d0d4:b0:10d:4a2:2c0e with SMTP id k20-20020a056870d0d400b0010d04a22c0emr1280611oaa.232.1657834402130;
        Thu, 14 Jul 2022 14:33:22 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id q1-20020a9d6541000000b0061c74e8d0b5sm1138367otl.76.2022.07.14.14.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:33:21 -0700 (PDT)
Date:   Thu, 14 Jul 2022 14:33:20 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH v4 RESEND] drivers/base: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <YtCLoMlYzjgBqhia@yury-laptop>
References: <20220714183021.2924119-1-pauld@redhat.com>
 <YtBvQUzRn5idNA5J@yury-laptop>
 <YtCFjZJFpQCgBiyF@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtCFjZJFpQCgBiyF@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 05:07:25PM -0400, Phil Auld wrote:
> Hi Yury,
> 
> On Thu, Jul 14, 2022 at 12:32:17PM -0700 Yury Norov wrote:
> > On Thu, Jul 14, 2022 at 02:30:21PM -0400, Phil Auld wrote:
> > > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > > This breaks userspace code that retrieves the size before reading the file. Rather
> > > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > > comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> > > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960
> > > (8192 * 5). In order to get near that you'd need a system with every other CPU on one
> > > node or something similar. e.g. (0,2,4,8, ... ).
> > 
> > My python says:
> >         >>> len(str(list(range(0, 8194, 2))).replace(" ", ''))
> >         19931
> > 
> > Where the list looks like:
> >         [0,2,4,6,8,10,...,8190,8192]
> >         
> > So excluding open and close braces, max length of the cpu list is
> > 19929 bytes, which is almost3 times smaller than your estimation
> > (8192 * 7 = 57344).
> > 
> > 
> > For NR_CPUS == 16x8192:
> >         >>> len(str(list(range(0, 8194 * 16, 2))).replace(" ", '')) - 2
> >         403308
> >         >>> 8192 * 16 * 7
> >         917504
> > 
> > For NR_CPUS == 128x8192:
> >         >>> len(str(list(range(0, 8194 * 128, 2))).replace(" ", '')) - 2
> >         3639774
> >         >>> 8192 * 16 * 7
> >         7340032
> > 
> > Looks like it 2x overestimates for large lists, and 4x for standard
> > 256-bit mask.
> 
> Thanks! It's totally possible my math is wrong. But I'm not seeing a
> suggestion here. What would you like the formula to be?
> 
> I don't have any attachment to the numbers that are in there now. I'm not
> surprised it's 2x since it counts all of them. I could just divide it by 2
> I suppose.

Agree.

Actually, I accidentally removed the sentence below from the previous email:

I think there's no simple formula for this, so dividing by 2 would
probably be a simplest solution. 
 
> > Before, it was possible to fit ~1800 cpus into 4k page, after - 585.
> >
> 
> I don't understand this part. Nothing I did changes how the files are
> actually built I think.

I just meant that we'll significantly increase requirements for the
size.
 
> > > To simplify the math and support
> > > larger NR_CPUS in the future we are using NR_CPUS * 7. We also set it to a min of
> > > PAGE_SIZE to retain the older behavior for smaller NR_CPUS. The cpumap file wants to
> > > be something like NR_CPUS/4 + NR_CPUS/32, for the ","s so for simplicity we are using
> > > NR_CPUS/2.
> > 
> > This again overestimates almost twice. In this case, NR_CPUS * 9/32 - 1
> > is a precise value, if I didn't screw up. Why don't you just use it?
> >
> 
> I was just keeping it simple since it's used twice. But I can do it this way. 
> 
> 
> Cheers,
> Phil
> 
> > > Add a set of macros for these values to cpumask.h so they can be used in multiple places.
> > > Apply these to the handful of such files in drivers/base/topology.c as well as node.c.
> > > 
> > > On an 80 cpu 4-node sytem (NR_CPUS == 8192)
> > > 
> > > before:
> > > 
> > > -r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
> > > -r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap
> > > 
> > > after:
> > > 
> > > -r--r--r--. 1 root root 57344 Jul 13 11:32 /sys/devices/system/node/node0/cpulist
> > > -r--r--r--. 1 root root  4096 Jul 13 11:31 /sys/devices/system/node/node0/cpumap
> > > 
> > > CONFIG_NR_CPUS = 16384
> > > -r--r--r--. 1 root root 114688 Jul 13 14:03 /sys/devices/system/node/node0/cpulist
> > > -r--r--r--. 1 root root   8192 Jul 13 14:02 /sys/devices/system/node/node0/cpumap
> > > 
> > > Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
> > > Fixes: bb9ec13d156 ("topology: use bin_attribute to break the size limitation of cpumap ABI")
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > ---
> > > 
> > > v2: Fix cpumap size calculation. Increase multiplier for cpulist size.
> > > 
> > > v3: Add comments in code.
> > > 
> > > v4: Define constants in cpumask.h. Move comments there. Also fix
> > > topology.c.
> > > 
> > > 
> > >  drivers/base/node.c     |  4 ++--
> > >  drivers/base/topology.c | 32 ++++++++++++++++----------------
> > >  include/linux/cpumask.h | 16 ++++++++++++++++
> > >  3 files changed, 34 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > index 0ac6376ef7a1..eb0f43784c2b 100644
> > > --- a/drivers/base/node.c
> > > +++ b/drivers/base/node.c
> > > @@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
> > >  	return n;
> > >  }
> > >  
> > > -static BIN_ATTR_RO(cpumap, 0);
> > > +static BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
> > >  
> > >  static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> > >  				   struct bin_attribute *attr, char *buf,
> > > @@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> > >  	return n;
> > >  }
> > >  
> > > -static BIN_ATTR_RO(cpulist, 0);
> > > +static BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
> > >  
> > >  /**
> > >   * struct node_access_nodes - Access class device to hold user visible
> > > diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> > > index ac6ad9ab67f9..89f98be5c5b9 100644
> > > --- a/drivers/base/topology.c
> > > +++ b/drivers/base/topology.c
> > > @@ -62,47 +62,47 @@ define_id_show_func(ppin, "0x%llx");
> > >  static DEVICE_ATTR_ADMIN_RO(ppin);
> > >  
> > >  define_siblings_read_func(thread_siblings, sibling_cpumask);
> > > -static BIN_ATTR_RO(thread_siblings, 0);
> > > -static BIN_ATTR_RO(thread_siblings_list, 0);
> > > +static BIN_ATTR_RO(thread_siblings, CPUMAP_FILE_MAX_BYTES);
> > > +static BIN_ATTR_RO(thread_siblings_list, CPULIST_FILE_MAX_BYTES);
> > >  
> > >  define_siblings_read_func(core_cpus, sibling_cpumask);
> > > -static BIN_ATTR_RO(core_cpus, 0);
> > > -static BIN_ATTR_RO(core_cpus_list, 0);
> > > +static BIN_ATTR_RO(core_cpus, CPUMAP_FILE_MAX_BYTES);
> > > +static BIN_ATTR_RO(core_cpus_list, CPULIST_FILE_MAX_BYTES);
> > >  
> > >  define_siblings_read_func(core_siblings, core_cpumask);
> > > -static BIN_ATTR_RO(core_siblings, 0);
> > > -static BIN_ATTR_RO(core_siblings_list, 0);
> > > +static BIN_ATTR_RO(core_siblings, CPUMAP_FILE_MAX_BYTES);
> > > +static BIN_ATTR_RO(core_siblings_list, CPULIST_FILE_MAX_BYTES);
> > >  
> > >  #ifdef TOPOLOGY_CLUSTER_SYSFS
> > >  define_siblings_read_func(cluster_cpus, cluster_cpumask);
> > > -static BIN_ATTR_RO(cluster_cpus, 0);
> > > -static BIN_ATTR_RO(cluster_cpus_list, 0);
> > > +static BIN_ATTR_RO(cluster_cpus, CPUMAP_FILE_MAX_BYTES);
> > > +static BIN_ATTR_RO(cluster_cpus_list, CPULIST_FILE_MAX_BYTES);
> > >  #endif
> > >  
> > >  #ifdef TOPOLOGY_DIE_SYSFS
> > >  define_siblings_read_func(die_cpus, die_cpumask);
> > > -static BIN_ATTR_RO(die_cpus, 0);
> > > -static BIN_ATTR_RO(die_cpus_list, 0);
> > > +static BIN_ATTR_RO(die_cpus, CPUMAP_FILE_MAX_BYTES);
> > > +static BIN_ATTR_RO(die_cpus_list, CPULIST_FILE_MAX_BYTES);
> > >  #endif
> > >  
> > >  define_siblings_read_func(package_cpus, core_cpumask);
> > > -static BIN_ATTR_RO(package_cpus, 0);
> > > -static BIN_ATTR_RO(package_cpus_list, 0);
> > > +static BIN_ATTR_RO(package_cpus, CPUMAP_FILE_MAX_BYTES);
> > > +static BIN_ATTR_RO(package_cpus_list, CPULIST_FILE_MAX_BYTES);
> > >  
> > >  #ifdef TOPOLOGY_BOOK_SYSFS
> > >  define_id_show_func(book_id, "%d");
> > >  static DEVICE_ATTR_RO(book_id);
> > >  define_siblings_read_func(book_siblings, book_cpumask);
> > > -static BIN_ATTR_RO(book_siblings, 0);
> > > -static BIN_ATTR_RO(book_siblings_list, 0);
> > > +static BIN_ATTR_RO(book_siblings, CPUMAP_FILE_MAX_BYTES);
> > > +static BIN_ATTR_RO(book_siblings_list, CPULIST_FILE_MAX_BYTES);
> > >  #endif
> > >  
> > >  #ifdef TOPOLOGY_DRAWER_SYSFS
> > >  define_id_show_func(drawer_id, "%d");
> > >  static DEVICE_ATTR_RO(drawer_id);
> > >  define_siblings_read_func(drawer_siblings, drawer_cpumask);
> > > -static BIN_ATTR_RO(drawer_siblings, 0);
> > > -static BIN_ATTR_RO(drawer_siblings_list, 0);
> > > +static BIN_ATTR_RO(drawer_siblings, CPUMAP_FILE_MAX_BYTES);
> > > +static BIN_ATTR_RO(drawer_siblings_list, CPULIST_FILE_MAX_BYTES);
> > >  #endif
> > >  
> > >  static struct bin_attribute *bin_attrs[] = {
> > > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > > index fe29ac7cc469..007acdb462bd 100644
> > > --- a/include/linux/cpumask.h
> > > +++ b/include/linux/cpumask.h
> > > @@ -1071,4 +1071,20 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
> > >  	[0] =  1UL							\
> > >  } }
> > >  
> > > +/* 
> > > + * Provide a valid theoretical max size for cpumap ands cpulist sysfs files to 
> > 
> > s/ands/and
> > 
> > > + * avoid breaking userspace which may allocate a buffer based on the size 
> > > + * reported by e.g. fstat.
> > > + *
> > > + * For cpumap NR_CPUS/2 is a simplification of NR_CPUS/4 + NR_CPUS/32. 
> > > + *
> > > + * For cpulist 7 is (ceil(log10(NR_CPUS)) + 1) allowing for NR_CPUS to be up to 
> > > + * 2 orders of magnitude larger than 8192. This covers a worst-case of every 
> > > + * other cpu being on one of two nodes for a very large NR_CPUS.
> > > + *
> > > + *  Use PAGE_SIZE as a minimum for smaller configurations. 
> > > + */
> > > +#define CPUMAP_FILE_MAX_BYTES  (((NR_CPUS >> 1) > PAGE_SIZE) ? NR_CPUS >> 1 : PAGE_SIZE)
> > > +#define CPULIST_FILE_MAX_BYTES  (((NR_CPUS * 7) > PAGE_SIZE) ? NR_CPUS * 7 : PAGE_SIZE)
> > > +
> > >  #endif /* __LINUX_CPUMASK_H */
> > > -- 
> > > 2.31.1
> > 
> 
> -- 
