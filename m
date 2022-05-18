Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF6152BD83
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiEROSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiEROSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:18:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EB837A9F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:18:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso3306458wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uRB17nidVW26jr8o4l5ZtFyeDQd2FTjdLFiWuW+RPyA=;
        b=KmLOOTVcbqQRyb8+1HuMHMqxR02lGQytcyYgc7IFOmgaxvycWdMCuiJkMxmw716zsy
         hcpEjMvVIAydjDtnrQiYeDSauvtDPut3HbqDeCRO8QHLsbtrqFFjr40Z3Fb2YA13PVB2
         YRvMSRQtRiCMkx2gymxE9sPBYilSrR9lnHLEHhvs9j+BIkgd1gydobf/rhS52Xanzvwg
         GljIIyCfJbJi2LAGZl1uAGaP5+WnjU39uLo2xXOS/7c+EskavTWnbQFVi3sncSTdd/cy
         TaWDu3L8dN9niMgQlQ1eVCLahZrgXR930b/2E/zWQB3R7CadNGBl6OOcY3CS0jZtQFvG
         66mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uRB17nidVW26jr8o4l5ZtFyeDQd2FTjdLFiWuW+RPyA=;
        b=OE8fqCQwttx0KAQwCmvGeIOwvl1/5osDQApQxLjL0tOfEy62Fe1Rmj2JUk4dcKNmPf
         ajp5PXSzvE2MEqTtHjrVl4xj44inPwhtaNv2LBi1NXMOOdcsypXW3dV8zaJzjfkXDMy4
         s9cVfshcXg0s7eGVjtD9JG6ZgWCrGFqQohCzyd4B1tqhlgA1grHE9mi+0I7BjZpSYyn6
         gSIpVKn9aG1hhiDYXDrLg7aPZyDM/e3FPKYQzTu4CU52sO6kSrHTE58l6Ec+NrAiWbaK
         U/tUXvP3yc/4AgNbmHxqvyFFk516T0Z6vM5rlH+XrYgMGTy+ia62vw7obkAu2M39jf8V
         R4Qg==
X-Gm-Message-State: AOAM533Ozy9UQLXdzWv3vD276eOBQqbKG2IvA5b2KOcBp8AopghITKbb
        67GaC29MUjqWFOAkoRRLIyH5Tna6H5AjOi9TUSAsE5cH2jo=
X-Google-Smtp-Source: ABdhPJz+ThUnfycbhum5XYEN+FFshTvPwB6BZfCO6pHU90IQQ2z4WrB2mZ0J6yXp+MlRv9Ud4AQvzKI0riLqQiO5gQw=
X-Received: by 2002:a05:600c:4f86:b0:394:970a:7182 with SMTP id
 n6-20020a05600c4f8600b00394970a7182mr153608wmq.149.1652883483030; Wed, 18 May
 2022 07:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220512170008.1301613-2-xiehuan09@gmail.com> <202205130923.SJJN7oez-lkp@intel.com>
 <20220518224849.b195cc2380fde43c593d79c5@kernel.org>
In-Reply-To: <20220518224849.b195cc2380fde43c593d79c5@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Wed, 18 May 2022 22:17:50 +0800
Message-ID: <CAEr6+EDZ3ekYqWzz-0pmR8C5D_mdWdvHoE2dhycSox=hFKh+8g@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] trace: Add trace any kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Masami,

Thank you for your reminder, I feel very strange, this patch series
was always  based on:
https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/core

These compile errors may be because other branches have not merged
into Tom's patches.
Steve told me before that this patch series should rely on Tom's patch.


On Wed, May 18, 2022 at 9:48 PM Masami Hiramatsu <mhiramat@kernel.org> wrot=
e:
>
> Hi Jeff,
>
> Can you fix these errors, since these looks real bugs.
>
> Thank you,
>
> On Fri, 13 May 2022 10:01:48 +0800
> kernel test robot <lkp@intel.com> wrote:
>
> > Hi Jeff,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on rostedt-trace/for-next]
> > [also build test WARNING on v5.18-rc6 next-20220512]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/trace-I=
ntroduce-objtrace-trigger-to-trace-the-kernel-object/20220513-010820
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-t=
race.git for-next
> > config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/2=
0220513/202205130923.SJJN7oez-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 95=
19dacab7b8afd537811fc2abaceb4d14f4e16a)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/3c91aa291a0fe8b=
28b02a14827b0c4ca3ebda601
> >         git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
> >         git fetch --no-tags linux-review Jeff-Xie/trace-Introduce-objtr=
ace-trigger-to-trace-the-kernel-object/20220513-010820
> >         git checkout 3c91aa291a0fe8b28b02a14827b0c4ca3ebda601
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash kernel/trace/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    kernel/trace/trace_object.c:259:13: error: incompatible function poi=
nter types initializing 'int (*)(struct seq_file *, struct event_trigger_op=
s *, struct event_trigger_data *)' with an expression of type 'int (struct =
seq_file *, struct event_trigger_data *)' [-Werror,-Wincompatible-function-=
pointer-types]
> >            .print                  =3D trace_object_trigger_print,
> >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >    kernel/trace/trace_object.c:260:12: error: incompatible function poi=
nter types initializing 'int (*)(struct event_trigger_ops *, struct event_t=
rigger_data *)' with an expression of type 'int (struct event_trigger_data =
*)' [-Werror,-Wincompatible-function-pointer-types]
> >            .init                   =3D event_object_trigger_init,
> >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >    kernel/trace/trace_object.c:261:12: error: incompatible function poi=
nter types initializing 'void (*)(struct event_trigger_ops *, struct event_=
trigger_data *)' with an expression of type 'void (struct event_trigger_dat=
a *)' [-Werror,-Wincompatible-function-pointer-types]
> >            .free                   =3D trace_object_trigger_free,
> >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >    kernel/trace/trace_object.c:266:13: error: incompatible function poi=
nter types initializing 'int (*)(struct seq_file *, struct event_trigger_op=
s *, struct event_trigger_data *)' with an expression of type 'int (struct =
seq_file *, struct event_trigger_data *)' [-Werror,-Wincompatible-function-=
pointer-types]
> >            .print                  =3D trace_object_trigger_print,
> >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >    kernel/trace/trace_object.c:267:12: error: incompatible function poi=
nter types initializing 'int (*)(struct event_trigger_ops *, struct event_t=
rigger_data *)' with an expression of type 'int (struct event_trigger_data =
*)' [-Werror,-Wincompatible-function-pointer-types]
> >            .init                   =3D event_object_trigger_init,
> >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >    kernel/trace/trace_object.c:268:12: error: incompatible function poi=
nter types initializing 'void (*)(struct event_trigger_ops *, struct event_=
trigger_data *)' with an expression of type 'void (struct event_trigger_dat=
a *)' [-Werror,-Wincompatible-function-pointer-types]
> >            .free                   =3D trace_object_trigger_free,
> >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >> kernel/trace/trace_object.c:335:61: warning: format specifies type '=
long' but the argument has type 'unsigned int' [-Wformat]
> >                    pr_err("the size of the %s should be:%ld\n", field->=
name, sizeof(void *));
> >                                                         ~~~            =
      ^~~~~~~~~~~~~~
> >                                                         %u
> >    include/linux/printk.h:489:33: note: expanded from macro 'pr_err'
> >            printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> >                                   ~~~     ^~~~~~~~~~~
> >    include/linux/printk.h:446:60: note: expanded from macro 'printk'
> >    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS=
__)
> >                                                        ~~~    ^~~~~~~~~=
~~
> >    include/linux/printk.h:418:19: note: expanded from macro 'printk_ind=
ex_wrap'
> >                    _p_func(_fmt, ##__VA_ARGS__);                       =
    \
> >                            ~~~~    ^~~~~~~~~~~
> >    kernel/trace/trace_object.c:356:3: error: implicit declaration of fu=
nction 'event_trigger_unregister' [-Werror,-Wimplicit-function-declaration]
> >                    event_trigger_unregister(cmd_ops, file, glob+1, trig=
ger_data);
> >                    ^
> >    kernel/trace/trace_object.c:356:3: note: did you mean 'event_trigger=
_register'?
> >    kernel/trace/trace.h:1650:12: note: 'event_trigger_register' declare=
d here
> >    extern int event_trigger_register(struct event_command *cmd_ops,
> >               ^
> >    kernel/trace/trace_object.c:370:64: error: too few arguments to func=
tion call, expected 7, have 4
> >            ret =3D event_trigger_register(cmd_ops, file, glob, trigger_=
data);
> >                  ~~~~~~~~~~~~~~~~~~~~~~                                =
  ^
> >    kernel/trace/trace.h:1650:12: note: 'event_trigger_register' declare=
d here
> >    extern int event_trigger_register(struct event_command *cmd_ops,
> >               ^
> >    1 warning and 8 errors generated.
> >
> >
> > vim +335 kernel/trace/trace_object.c
> >
> >    296
> >    297        static int
> >    298        event_object_trigger_parse(struct event_command *cmd_ops,
> >    299                               struct trace_event_file *file,
> >    300                               char *glob, char *cmd, char *param=
_and_filter)
> >    301        {
> >    302                struct event_trigger_data *trigger_data;
> >    303                struct objtrace_trigger_data *obj_data;
> >    304                struct ftrace_event_field *field;
> >    305                char *objtrace_cmd, *arg;
> >    306                char *param, *filter;
> >    307                int ret;
> >    308                bool remove;
> >    309
> >    310                remove =3D event_trigger_check_remove(glob);
> >    311
> >    312                /*
> >    313                 * separate the param and the filter:
> >    314                 * objtrace:add:OBJ[:COUNT] [if filter]
> >    315                 */
> >    316                ret =3D event_trigger_separate_filter(param_and_f=
ilter, &param, &filter, true);
> >    317                if (ret)
> >    318                        return ret;
> >    319
> >    320                objtrace_cmd =3D strsep(&param, ":");
> >    321                if (!objtrace_cmd || strcmp(objtrace_cmd, "add"))=
 {
> >    322                        pr_err("error objtrace command\n");
> >    323                        return -EINVAL;
> >    324                }
> >    325
> >    326                arg =3D strsep(&param, ":");
> >    327                if (!arg)
> >    328                        return -EINVAL;
> >    329
> >    330                field =3D trace_find_event_field(file->event_call=
, arg);
> >    331                if (!field)
> >    332                        return -EINVAL;
> >    333
> >    334                if (field->size !=3D sizeof(void *)) {
> >  > 335                        pr_err("the size of the %s should be:%ld\=
n", field->name, sizeof(void *));
> >    336                        return -EINVAL;
> >    337                }
> >    338
> >    339                if (remove && !field_exist(file, cmd_ops, field->=
name))
> >    340                        return -EINVAL;
> >    341
> >    342                obj_data =3D kzalloc(sizeof(*obj_data), GFP_KERNE=
L);
> >    343                if (!obj_data)
> >    344                        return -ENOMEM;
> >    345
> >    346                obj_data->field =3D field;
> >    347                obj_data->tr =3D file->tr;
> >    348                snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN=
, objtrace_cmd);
> >    349
> >    350                trigger_data =3D event_trigger_alloc(cmd_ops, cmd=
, param, obj_data);
> >    351                if (!trigger_data) {
> >    352                        kfree(obj_data);
> >    353                        return -ENOMEM;
> >    354                }
> >    355                if (remove) {
> >    356                        event_trigger_unregister(cmd_ops, file, g=
lob+1, trigger_data);
> >    357                        kfree(obj_data);
> >    358                        kfree(trigger_data);
> >    359                        return 0;
> >    360                }
> >    361
> >    362                ret =3D event_trigger_parse_num(param, trigger_da=
ta);
> >    363                if (ret)
> >    364                        goto out_free;
> >    365
> >    366                ret =3D event_trigger_set_filter(cmd_ops, file, f=
ilter, trigger_data);
> >    367                if (ret < 0)
> >    368                        goto out_free;
> >    369
> >    370                ret =3D event_trigger_register(cmd_ops, file, glo=
b, trigger_data);
> >    371                if (ret)
> >    372                        goto out_free;
> >    373
> >    374                return ret;
> >    375
> >    376         out_free:
> >    377                event_trigger_reset_filter(cmd_ops, trigger_data)=
;
> >    378                kfree(obj_data);
> >    379                kfree(trigger_data);
> >    380                return ret;
> >    381        }
> >    382
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks,
JeffXie
