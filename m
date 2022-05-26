Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C818535674
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348692AbiEZXmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbiEZXmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4FE24F05
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD66161CC1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BEFC385A9;
        Thu, 26 May 2022 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653608536;
        bh=yQJ4zavB9f3K4+BfWm2Qw1RauU5GGuYOj7hmO7crWm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=giVBFwhqwxtG/izeki3MYV9D4MotXELKXmGIHX2gkRovI6w9m5uTMlYfqlLkRxAG7
         4BaNlQGeJnLGAwcNn7WCdI2hPK56ucUPDSVtrk6VUK39t3YYjXz2YSQHFaJAaOgu2C
         HOMZ6rZ4tK0M3yFRoEDkbrQs0Fk3TCKIDNNBDzxNRh3TsSCmGfteX2FBZMYS0PPQaT
         h2EfvVYDQGfksVy7a1b+rI65gTExHljbqeZKugkqcSyakJ0oRs9pIBZXpDTXzaxGW6
         3wvoZ+6ct1Wjjjx3qEN1VSDcn/znsbAMI8apsDwMGI8rIN99s8K4YU3b/aSlpRG4LL
         n8i7ByljFGUnA==
Date:   Fri, 27 May 2022 08:42:12 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/4] trace: Add trace any kernel object
Message-Id: <20220527084212.337e8f7dda680c7bc179173a@kernel.org>
In-Reply-To: <CAEr6+EDZ3ekYqWzz-0pmR8C5D_mdWdvHoE2dhycSox=hFKh+8g@mail.gmail.com>
References: <20220512170008.1301613-2-xiehuan09@gmail.com>
        <202205130923.SJJN7oez-lkp@intel.com>
        <20220518224849.b195cc2380fde43c593d79c5@kernel.org>
        <CAEr6+EDZ3ekYqWzz-0pmR8C5D_mdWdvHoE2dhycSox=hFKh+8g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Wed, 18 May 2022 22:17:50 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

>  Hi Masami,
> 
> Thank you for your reminder, I feel very strange, this patch series
> was always  based on:
> https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> ftrace/core
> 
> These compile errors may be because other branches have not merged
> into Tom's patches.
> Steve told me before that this patch series should rely on Tom's patch.

OK, when you send the next version, please describe this in the cover
mail and point Tom's series if it is not merged yet.

Thank you,

> 
> 
> On Wed, May 18, 2022 at 9:48 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Jeff,
> >
> > Can you fix these errors, since these looks real bugs.
> >
> > Thank you,
> >
> > On Fri, 13 May 2022 10:01:48 +0800
> > kernel test robot <lkp@intel.com> wrote:
> >
> > > Hi Jeff,
> > >
> > > Thank you for the patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on rostedt-trace/for-next]
> > > [also build test WARNING on v5.18-rc6 next-20220512]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220513-010820
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
> > > config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220513/202205130923.SJJN7oez-lkp@intel.com/config)
> > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://github.com/intel-lab-lkp/linux/commit/3c91aa291a0fe8b28b02a14827b0c4ca3ebda601
> > >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> > >         git fetch --no-tags linux-review Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220513-010820
> > >         git checkout 3c91aa291a0fe8b28b02a14827b0c4ca3ebda601
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    kernel/trace/trace_object.c:259:13: error: incompatible function pointer types initializing 'int (*)(struct seq_file *, struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct seq_file *, struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
> > >            .print                  = trace_object_trigger_print,
> > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    kernel/trace/trace_object.c:260:12: error: incompatible function pointer types initializing 'int (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
> > >            .init                   = event_object_trigger_init,
> > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >    kernel/trace/trace_object.c:261:12: error: incompatible function pointer types initializing 'void (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'void (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
> > >            .free                   = trace_object_trigger_free,
> > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >    kernel/trace/trace_object.c:266:13: error: incompatible function pointer types initializing 'int (*)(struct seq_file *, struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct seq_file *, struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
> > >            .print                  = trace_object_trigger_print,
> > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    kernel/trace/trace_object.c:267:12: error: incompatible function pointer types initializing 'int (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
> > >            .init                   = event_object_trigger_init,
> > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >    kernel/trace/trace_object.c:268:12: error: incompatible function pointer types initializing 'void (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'void (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
> > >            .free                   = trace_object_trigger_free,
> > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > >> kernel/trace/trace_object.c:335:61: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
> > >                    pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
> > >                                                         ~~~                  ^~~~~~~~~~~~~~
> > >                                                         %u
> > >    include/linux/printk.h:489:33: note: expanded from macro 'pr_err'
> > >            printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> > >                                   ~~~     ^~~~~~~~~~~
> > >    include/linux/printk.h:446:60: note: expanded from macro 'printk'
> > >    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
> > >                                                        ~~~    ^~~~~~~~~~~
> > >    include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
> > >                    _p_func(_fmt, ##__VA_ARGS__);                           \
> > >                            ~~~~    ^~~~~~~~~~~
> > >    kernel/trace/trace_object.c:356:3: error: implicit declaration of function 'event_trigger_unregister' [-Werror,-Wimplicit-function-declaration]
> > >                    event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
> > >                    ^
> > >    kernel/trace/trace_object.c:356:3: note: did you mean 'event_trigger_register'?
> > >    kernel/trace/trace.h:1650:12: note: 'event_trigger_register' declared here
> > >    extern int event_trigger_register(struct event_command *cmd_ops,
> > >               ^
> > >    kernel/trace/trace_object.c:370:64: error: too few arguments to function call, expected 7, have 4
> > >            ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
> > >                  ~~~~~~~~~~~~~~~~~~~~~~                                  ^
> > >    kernel/trace/trace.h:1650:12: note: 'event_trigger_register' declared here
> > >    extern int event_trigger_register(struct event_command *cmd_ops,
> > >               ^
> > >    1 warning and 8 errors generated.
> > >
> > >
> > > vim +335 kernel/trace/trace_object.c
> > >
> > >    296
> > >    297        static int
> > >    298        event_object_trigger_parse(struct event_command *cmd_ops,
> > >    299                               struct trace_event_file *file,
> > >    300                               char *glob, char *cmd, char *param_and_filter)
> > >    301        {
> > >    302                struct event_trigger_data *trigger_data;
> > >    303                struct objtrace_trigger_data *obj_data;
> > >    304                struct ftrace_event_field *field;
> > >    305                char *objtrace_cmd, *arg;
> > >    306                char *param, *filter;
> > >    307                int ret;
> > >    308                bool remove;
> > >    309
> > >    310                remove = event_trigger_check_remove(glob);
> > >    311
> > >    312                /*
> > >    313                 * separate the param and the filter:
> > >    314                 * objtrace:add:OBJ[:COUNT] [if filter]
> > >    315                 */
> > >    316                ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
> > >    317                if (ret)
> > >    318                        return ret;
> > >    319
> > >    320                objtrace_cmd = strsep(&param, ":");
> > >    321                if (!objtrace_cmd || strcmp(objtrace_cmd, "add")) {
> > >    322                        pr_err("error objtrace command\n");
> > >    323                        return -EINVAL;
> > >    324                }
> > >    325
> > >    326                arg = strsep(&param, ":");
> > >    327                if (!arg)
> > >    328                        return -EINVAL;
> > >    329
> > >    330                field = trace_find_event_field(file->event_call, arg);
> > >    331                if (!field)
> > >    332                        return -EINVAL;
> > >    333
> > >    334                if (field->size != sizeof(void *)) {
> > >  > 335                        pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
> > >    336                        return -EINVAL;
> > >    337                }
> > >    338
> > >    339                if (remove && !field_exist(file, cmd_ops, field->name))
> > >    340                        return -EINVAL;
> > >    341
> > >    342                obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
> > >    343                if (!obj_data)
> > >    344                        return -ENOMEM;
> > >    345
> > >    346                obj_data->field = field;
> > >    347                obj_data->tr = file->tr;
> > >    348                snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
> > >    349
> > >    350                trigger_data = event_trigger_alloc(cmd_ops, cmd, param, obj_data);
> > >    351                if (!trigger_data) {
> > >    352                        kfree(obj_data);
> > >    353                        return -ENOMEM;
> > >    354                }
> > >    355                if (remove) {
> > >    356                        event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
> > >    357                        kfree(obj_data);
> > >    358                        kfree(trigger_data);
> > >    359                        return 0;
> > >    360                }
> > >    361
> > >    362                ret = event_trigger_parse_num(param, trigger_data);
> > >    363                if (ret)
> > >    364                        goto out_free;
> > >    365
> > >    366                ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
> > >    367                if (ret < 0)
> > >    368                        goto out_free;
> > >    369
> > >    370                ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
> > >    371                if (ret)
> > >    372                        goto out_free;
> > >    373
> > >    374                return ret;
> > >    375
> > >    376         out_free:
> > >    377                event_trigger_reset_filter(cmd_ops, trigger_data);
> > >    378                kfree(obj_data);
> > >    379                kfree(trigger_data);
> > >    380                return ret;
> > >    381        }
> > >    382
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://01.org/lkp
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks,
> JeffXie


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
