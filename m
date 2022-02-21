Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96CB4BE54B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358292AbiBUMro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:47:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbiBUMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:47:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2107193E9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645447637; x=1676983637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mFX5Re+ww+nx/I8dT6KLgt0oEd5/zqE+o1yVpczv6bg=;
  b=UDJAZHHyosIUzFA1jR7/6IBD43ybxE8SSDVWPhfq7O5LaW+2o6xx6L11
   +rGNcSOZFNn5FiwFvpsovtYF6oZepT80cITHNWhl6pXdTkAhelJ5tkgE9
   GrtCYGMSSVntmz4jIf3fv5C2kIY+7RiXN/4vmRwfHBVVSU/ypkVUCMuME
   qG0BuwCiQehG23TYvTIBciPiANKgtzn1rVq2it6Px1DTrbhRk5zssLvJh
   IrEHWOh4kYaTOIitsq6+LIX0qSNHIINItYVx0VBLVPmnwp0Ct4H6nGhqx
   RBMeAmzfPzojuHoMSY/TOY3qTM5/ah8+JgOYx7Bj3Plih7unelyEceQHh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314764354"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="314764354"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 04:47:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="505057193"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2022 04:47:15 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM85y-0001bW-IX; Mon, 21 Feb 2022 12:47:14 +0000
Date:   Mon, 21 Feb 2022 20:46:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [ammarfaizi2-block:rostedt/linux-trace/for-next 25/32]
 kernel/trace/trace_events_user.c:593:31: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202202212008.H48tBYrJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/for-next
head:   864ea0e10cc90416a01b46f0d47a6f26dc020820
commit: 0279400ad38d858ed68f5d787385f6122d4170b2 [25/32] user_events: Optimize writing events by only copying data once
config: x86_64-randconfig-s032-20220221 (https://download.01.org/0day-ci/archive/20220221/202202212008.H48tBYrJ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/0279400ad38d858ed68f5d787385f6122d4170b2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/for-next
        git checkout 0279400ad38d858ed68f5d787385f6122d4170b2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/trace/trace_events_user.c:409:38: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/trace_events_user.c:430:40: sparse: sparse: Using plain integer as NULL pointer
>> kernel/trace/trace_events_user.c:593:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] udata @@     got void [noderef] __user * @@
   kernel/trace/trace_events_user.c:593:31: sparse:     expected void *[assigned] udata
   kernel/trace/trace_events_user.c:593:31: sparse:     got void [noderef] __user *
   kernel/trace/trace_events_user.c:1064:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1064:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1064:16: sparse:    void *
   kernel/trace/trace_events_user.c:1122:13: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/trace_events_user.c:1122:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *buf @@     got char * @@
   kernel/trace/trace_events_user.c:1122:13: sparse:     expected void [noderef] __user *buf
   kernel/trace/trace_events_user.c:1122:13: sparse:     got char *
   kernel/trace/trace_events_user.c:1138:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1138:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1138:16: sparse:    void *
   kernel/trace/trace_events_user.c:1165:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1165:9: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1165:9: sparse:    void *

vim +593 kernel/trace/trace_events_user.c

   378	
   379	static const char *user_field_format(const char *type)
   380	{
   381		if (strcmp(type, "s64") == 0)
   382			return "%lld";
   383		if (strcmp(type, "u64") == 0)
   384			return "%llu";
   385		if (strcmp(type, "s32") == 0)
   386			return "%d";
   387		if (strcmp(type, "u32") == 0)
   388			return "%u";
   389		if (strcmp(type, "int") == 0)
   390			return "%d";
   391		if (strcmp(type, "unsigned int") == 0)
   392			return "%u";
   393		if (strcmp(type, "s16") == 0)
   394			return "%d";
   395		if (strcmp(type, "u16") == 0)
   396			return "%u";
   397		if (strcmp(type, "short") == 0)
   398			return "%d";
   399		if (strcmp(type, "unsigned short") == 0)
   400			return "%u";
   401		if (strcmp(type, "s8") == 0)
   402			return "%d";
   403		if (strcmp(type, "u8") == 0)
   404			return "%u";
   405		if (strcmp(type, "char") == 0)
   406			return "%d";
   407		if (strcmp(type, "unsigned char") == 0)
   408			return "%u";
 > 409		if (strstr(type, "char[") != 0)
   410			return "%s";
   411	
   412		/* Unknown, likely struct, allowed treat as 64-bit */
   413		return "%llu";
   414	}
   415	
   416	static bool user_field_is_dyn_string(const char *type, const char **str_func)
   417	{
   418		if (str_has_prefix(type, "__data_loc ")) {
   419			*str_func = "__get_str";
   420			goto check;
   421		}
   422	
   423		if (str_has_prefix(type, "__rel_loc ")) {
   424			*str_func = "__get_rel_str";
   425			goto check;
   426		}
   427	
   428		return false;
   429	check:
   430		return strstr(type, "char") != 0;
   431	}
   432	
   433	#define LEN_OR_ZERO (len ? len - pos : 0)
   434	static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
   435	{
   436		struct ftrace_event_field *field, *next;
   437		struct list_head *head = &user->fields;
   438		int pos = 0, depth = 0;
   439		const char *str_func;
   440	
   441		pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
   442	
   443		list_for_each_entry_safe_reverse(field, next, head, link) {
   444			if (depth != 0)
   445				pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
   446	
   447			pos += snprintf(buf + pos, LEN_OR_ZERO, "%s=%s",
   448					field->name, user_field_format(field->type));
   449	
   450			depth++;
   451		}
   452	
   453		pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
   454	
   455		list_for_each_entry_safe_reverse(field, next, head, link) {
   456			if (user_field_is_dyn_string(field->type, &str_func))
   457				pos += snprintf(buf + pos, LEN_OR_ZERO,
   458						", %s(%s)", str_func, field->name);
   459			else
   460				pos += snprintf(buf + pos, LEN_OR_ZERO,
   461						", REC->%s", field->name);
   462		}
   463	
   464		return pos + 1;
   465	}
   466	#undef LEN_OR_ZERO
   467	
   468	static int user_event_create_print_fmt(struct user_event *user)
   469	{
   470		char *print_fmt;
   471		int len;
   472	
   473		len = user_event_set_print_fmt(user, NULL, 0);
   474	
   475		print_fmt = kmalloc(len, GFP_KERNEL);
   476	
   477		if (!print_fmt)
   478			return -ENOMEM;
   479	
   480		user_event_set_print_fmt(user, print_fmt, len);
   481	
   482		user->call.print_fmt = print_fmt;
   483	
   484		return 0;
   485	}
   486	
   487	static enum print_line_t user_event_print_trace(struct trace_iterator *iter,
   488							int flags,
   489							struct trace_event *event)
   490	{
   491		/* Unsafe to try to decode user provided print_fmt, use hex */
   492		trace_print_hex_dump_seq(&iter->seq, "", DUMP_PREFIX_OFFSET, 16,
   493					 1, iter->ent, iter->ent_size, true);
   494	
   495		return trace_handle_return(&iter->seq);
   496	}
   497	
   498	static struct trace_event_functions user_event_funcs = {
   499		.trace = user_event_print_trace,
   500	};
   501	
   502	static int destroy_user_event(struct user_event *user)
   503	{
   504		int ret = 0;
   505	
   506		/* Must destroy fields before call removal */
   507		user_event_destroy_fields(user);
   508	
   509		ret = trace_remove_event_call(&user->call);
   510	
   511		if (ret)
   512			return ret;
   513	
   514		dyn_event_remove(&user->devent);
   515	
   516		register_page_data[user->index] = 0;
   517		clear_bit(user->index, page_bitmap);
   518		hash_del(&user->node);
   519	
   520		kfree(user->call.print_fmt);
   521		kfree(EVENT_NAME(user));
   522		kfree(user);
   523	
   524		return ret;
   525	}
   526	
   527	static struct user_event *find_user_event(char *name, u32 *outkey)
   528	{
   529		struct user_event *user;
   530		u32 key = user_event_key(name);
   531	
   532		*outkey = key;
   533	
   534		hash_for_each_possible(register_table, user, node, key)
   535			if (!strcmp(EVENT_NAME(user), name))
   536				return user;
   537	
   538		return NULL;
   539	}
   540	
   541	/*
   542	 * Writes the user supplied payload out to a trace file.
   543	 */
   544	static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
   545				      void *tpdata)
   546	{
   547		struct trace_event_file *file;
   548		struct trace_entry *entry;
   549		struct trace_event_buffer event_buffer;
   550	
   551		file = (struct trace_event_file *)tpdata;
   552	
   553		if (!file ||
   554		    !(file->flags & EVENT_FILE_FL_ENABLED) ||
   555		    trace_trigger_soft_disabled(file))
   556			return;
   557	
   558		/* Allocates and fills trace_entry, + 1 of this is data payload */
   559		entry = trace_event_buffer_reserve(&event_buffer, file,
   560						   sizeof(*entry) + i->count);
   561	
   562		if (unlikely(!entry))
   563			return;
   564	
   565		if (unlikely(!copy_nofault(entry + 1, i->count, i)))
   566			__trace_event_discard_commit(event_buffer.buffer,
   567						     event_buffer.event);
   568		else
   569			trace_event_buffer_commit(&event_buffer);
   570	}
   571	
   572	#ifdef CONFIG_PERF_EVENTS
   573	static void user_event_bpf(struct user_event *user, struct iov_iter *i)
   574	{
   575		struct user_bpf_context context;
   576		struct user_bpf_iter bpf_i;
   577		char fast_data[MAX_STACK_BPF_DATA];
   578		void *temp = NULL;
   579	
   580		if ((user->flags & FLAG_BPF_ITER) && iter_is_iovec(i)) {
   581			/* Raw iterator */
   582			context.data_type = USER_BPF_DATA_ITER;
   583			context.data_len = i->count;
   584			context.iter = &bpf_i;
   585	
   586			bpf_i.iov_offset = i->iov_offset;
   587			bpf_i.iov = i->iov;
   588			bpf_i.nr_segs = i->nr_segs;
   589		} else if (i->nr_segs == 1 && iter_is_iovec(i)) {
   590			/* Single buffer from user */
   591			context.data_type = USER_BPF_DATA_USER;
   592			context.data_len = i->count;
 > 593			context.udata = i->iov->iov_base + i->iov_offset;
   594		} else {
   595			/* Multi buffer from user */
   596			struct iov_iter copy = *i;
   597			size_t copy_size = min_t(size_t, i->count, MAX_BPF_COPY_SIZE);
   598	
   599			context.data_type = USER_BPF_DATA_KERNEL;
   600			context.kdata = fast_data;
   601	
   602			if (unlikely(copy_size > sizeof(fast_data))) {
   603				temp = kmalloc(copy_size, GFP_NOWAIT);
   604	
   605				if (temp)
   606					context.kdata = temp;
   607				else
   608					copy_size = sizeof(fast_data);
   609			}
   610	
   611			context.data_len = copy_nofault(context.kdata,
   612							copy_size, &copy);
   613		}
   614	
   615		trace_call_bpf(&user->call, &context);
   616	
   617		kfree(temp);
   618	}
   619	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
