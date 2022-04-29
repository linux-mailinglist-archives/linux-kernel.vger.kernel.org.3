Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB75147CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358111AbiD2LQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348440AbiD2LQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:16:28 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC01084A0F;
        Fri, 29 Apr 2022 04:13:09 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 23TBCsVB015716;
        Fri, 29 Apr 2022 20:12:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 23TBCsVB015716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651230775;
        bh=0rEwR6BYZgaztnPXmwwafDP4NoWonitM1xGxICaeBY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=16oe5IoXIzUwnZwMiMrAizUxovcGU/QRELb01cuWql9dc9nWCGqB/dffOlrdQLjq2
         WfbkSMboFquLy6EJeIjMixa2Nl209dtb/RNZZjnyvrBSr9VV1qJEcOdw6410NChBtH
         rvxL96zwYkAO1B62PaTEkRwh0Bz4PeoY25FWGsc6YJe+BoPigu54MUCGhsr9cIXAf4
         syxxXtBAvive04Bd21AHGMgS9u+0eCgpUwOSWjmIr5/gULOmMEyCbNAALC/5Z4ftmx
         nfjTcaZ8uDbNYeEInaFhEAn+TKs8UIRZawN5g5skcHnArE+U/RtMB5QS4iocdK23g/
         2l2ipGB/cMxDw==
X-Nifty-SrcIP: [209.85.216.42]
Received: by mail-pj1-f42.google.com with SMTP id e24so6849117pjt.2;
        Fri, 29 Apr 2022 04:12:54 -0700 (PDT)
X-Gm-Message-State: AOAM533C1Nnd/wPIySRifrvfdMvw1waVwlNzH0/6sJyeVH05vKGFnDR6
        Qt8mDCCxGJ0u7v+OTf3MMOA8uuTjU8jA2MznCHY=
X-Google-Smtp-Source: ABdhPJyaVvrrSmKxfFQCt7R/5NC2Ep03y+deY/gOyXjadhcGvO6t7cAptY4CJWEhXafMOOXDoH9hxvdqSe0dsUhWXFs=
X-Received: by 2002:a17:902:f54e:b0:15e:6c3f:5b5 with SMTP id
 h14-20020a170902f54e00b0015e6c3f05b5mr5322079plf.99.1651230773716; Fri, 29
 Apr 2022 04:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220413092331.203284-1-chenlifu@huawei.com>
In-Reply-To: <20220413092331.203284-1-chenlifu@huawei.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 29 Apr 2022 20:11:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR8UZQ6rrEEL+8dGaGjSCSyKvCzuwnyy55Nw1SMkNr6PQ@mail.gmail.com>
Message-ID: <CAK7LNAR8UZQ6rrEEL+8dGaGjSCSyKvCzuwnyy55Nw1SMkNr6PQ@mail.gmail.com>
Subject: Re: [PATCH v3 -next] scripts: add compare-config utility
To:     Chen Lifu <chenlifu@huawei.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 6:24 PM Chen Lifu <chenlifu@huawei.com> wrote:
>
> This is an alternative utility to compare two .config files.

This explains why this cannot get into the kernel tree.
We do not need two utilities to do the same thing.

> Unlike
> existing utilities "diffconfig" in the kernel tree, it prints detailed
> results in table style, and support config name prefix so that it can be
> used elsewhere. It is useful sometimes, for example, to analyze .config
> files through tables, or to compare Buildroot .config.

Then, why don't you add --prefix option to the existing scripts/diffconfig?




> With grep and awk, it can print similar results like "diffconfg" as well.
>
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
> Changes in v3:
> - Add -D option, a combination of -C -O -N, and set it as default mode
>
> Changes in v2:
> - Add config name prefix support
>
>  scripts/compare-config | 203 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100755 scripts/compare-config
>
> diff --git a/scripts/compare-config b/scripts/compare-config
> new file mode 100755
> index 000000000000..f770a1b02170
> --- /dev/null
> +++ b/scripts/compare-config
> @@ -0,0 +1,203 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# An utility to compare two .config files and print the results in table style.
> +#
> +
> +import sys
> +import argparse
> +import traceback
> +
> +def args_parser():
> +    comment = ("An utility to compare two .config files and "
> +               "print the results in table style.")
> +    parser = argparse.ArgumentParser(description = comment,
> +                                     formatter_class =
> +                                         argparse.RawTextHelpFormatter)
> +    parser.add_argument(dest = "old_file", nargs = "?",
> +                        metavar = "old-file",
> +                        default = ".config.old",
> +                        help = "specify old .config file "
> +                               "(default: .config.old)")
> +    parser.add_argument(dest = "new_file", nargs = "?",
> +                        metavar = "new-file",
> +                        default = ".config",
> +                        help = "specify new .config file "
> +                               "(default: .config)")
> +    parser.add_argument("-S", dest = "S", action = "store_true",
> +                        help = "print configs that exist in both files "
> +                               "and are equal")
> +    parser.add_argument("-C", dest = "C", action = "store_true",
> +                        help = "print configs that exist in both files "
> +                               "but are not equal")
> +    parser.add_argument("-O", dest = "O", action = "store_true",
> +                        help = "print configs that only exist in old-file")
> +    parser.add_argument("-N", dest = "N", action = "store_true",
> +                        help = "print configs that only exist in new-file")
> +    parser.add_argument("-D", dest = "D", action = "store_true",
> +                        help = "a combination of -C -O -N, it's the default mode")
> +    parser.add_argument("-y", dest = "y", action = "store_true",
> +                        help = "print configs that are y")
> +    parser.add_argument("-n", dest = "n", action = "store_true",
> +                        help = "print configs that are n (not set)")
> +    parser.add_argument("-m", dest = "m", action = "store_true",
> +                        help = "print configs that are m")
> +    parser.add_argument("-v", dest = "v", action = "store_true",
> +                        help = "print configs that are "
> +                               "string/hex/int value")
> +    parser.add_argument("--old", dest = "old", action = "store_true",
> +                        help = "filter configs base on old-file")
> +    parser.add_argument("--new", dest = "new", action = "store_true",
> +                        help = "filter configs base on new-file")
> +    parser.add_argument("-p", "--prefix", dest = "prefix",
> +                        action = "store", default = "CONFIG_",
> +                        help = "config name prefix (default: CONFIG_)")
> +    return parser
> +
> +def usage():
> +    args_parser().parse_args(["-h"])
> +
> +def parse_args():
> +    args = args_parser().parse_args()
> +    setattr(args, "doptions", diff_options(args))
> +    setattr(args, "voptions", value_options(args))
> +    old = args.old or not args.new
> +    new = args.new or not args.old
> +    args.old = old
> +    args.new = new
> +    return args
> +
> +def diff_options(args):
> +    doptions = []
> +    if args.S: doptions.append("S")
> +    if args.C or args.D: doptions.append("C")
> +    if args.O or args.D: doptions.append("O")
> +    if args.N or args.D: doptions.append("N")
> +    if len(doptions) == 0:
> +        doptions = ["C", "O", "N"]
> +    return doptions
> +
> +def value_options(args):
> +    voptions = set()
> +    if args.y: voptions.add("y")
> +    if args.n: voptions.add("n")
> +    if args.m: voptions.add("m")
> +    if args.v: voptions.add("v")
> +    if len(voptions) == 0:
> +        voptions = {"y", "n", "m", "v"}
> +    return voptions
> +
> +def test_value(val, voptions):
> +    if val is None: return False
> +    if val in voptions: return True
> +    return (not val in {"y", "n", "m"}) and ("v" in voptions)
> +
> +def format_exception():
> +    es = ""
> +    exc_type, exc_value, exc_traceback = sys.exc_info()
> +    exc_str = traceback.format_exception(exc_type, exc_value, exc_traceback)
> +    for s in exc_str:
> +        es += s
> +    return es
> +
> +def read_line(line, prefix):
> +    line = line.strip()
> +    if line.endswith(" is not set"):
> +        beg = line.find(prefix)
> +        if beg == -1: return None, None
> +        name, val = line[beg:-10].rsplit(" ", 1)
> +        return name.strip(), "n"
> +    if line.startswith(prefix):
> +        if line.find("=") == -1: return None, None
> +        name, val = line.split("=", 1)
> +        return name.strip(), val.strip()
> +    return None, None
> +
> +def read_file(filename, prefix):
> +    configs = {}
> +    with open(filename, "r", encoding = "utf-8") as f:
> +        for line in f:
> +            name, val = read_line(line, prefix)
> +            if not name is None: configs[name] = val
> +    return configs
> +
> +def compare_config(args):
> +    result = {"S": {}, "C": {}, "O": {}, "N": {}}
> +    try:
> +        old_configs = read_file(args.old_file, args.prefix)
> +        new_configs = read_file(args.new_file, args.prefix)
> +        while len(old_configs) > 0:
> +            name, old_val = old_configs.popitem()
> +            new_val = new_configs.pop(name, None)
> +            if new_val is None:
> +                result["O"][name] = (old_val, None)
> +            elif old_val == new_val:
> +                result["S"][name] = (old_val, new_val)
> +            else:
> +                result["C"][name] = (old_val, new_val)
> +        while len(new_configs) > 0:
> +            name, new_val = new_configs.popitem()
> +            result["N"][name] = (None, new_val)
> +    except:
> +        print(format_exception())
> +        usage()
> +    return result
> +
> +def filter_output(result, args):
> +    output = {"S": {}, "C": {}, "O": {}, "N": {}}
> +    for opt in args.doptions:
> +        for name, val in result[opt].items():
> +            if (args.old and test_value(val[0], args.voptions) or
> +                args.new and test_value(val[1], args.voptions)):
> +                old_val = "-" if val[0] is None else val[0]
> +                new_val = "-" if val[1] is None else val[1]
> +                output[opt][name] = (old_val, new_val)
> +    return output
> +
> +def print_table(output, args):
> +    name_max_len = 8
> +    old_max_len  = 8
> +    new_max_len  = 8
> +    name_list = sum([list(output[opt].keys()) for opt in args.doptions], [])
> +    if len(name_list) > 0:
> +        name_max_len = len(max(name_list, key = len))
> +    val_list = sum([list(output[opt].values()) for opt in args.doptions], [])
> +    if len(val_list) > 0:
> +        old_max_len = len(max([val[0] for val in val_list], key = len))
> +        new_max_len = len(max([val[1] for val in val_list], key = len))
> +    diff_max_len = len(max([diff_types[opt] for opt in args.doptions], key = len))
> +    header = ["NAME", "DIFF", "OLD", "NEW"]
> +    # table row format
> +    row = ("{{:{}}}\t{{:{}}}\t{{:{}}}\t{{:{}}}"
> +           .format(min(max(name_max_len, len(header[0])), 40),
> +                   min(max(diff_max_len, len(header[1])), 40),
> +                   min(max(old_max_len,  len(header[2])), 40),
> +                   min(max(new_max_len,  len(header[3])), 40)))
> +    print(row.format(header[0], header[1], header[2], header[3]))
> +    for opt in args.doptions:
> +        for name, val in sorted(output[opt].items()):
> +            print(row.format(name, diff_types[opt], val[0], val[1]))
> +
> +def print_summary(output, args):
> +    diff_max_len = len(max([diff_types[opt] for opt in args.doptions], key = len))
> +    # summary line format
> +    line = "{{:{}}}: {{}}".format(max(diff_max_len, 8))
> +    print("\nSummary:")
> +    print(line.format("Old-file", args.old_file))
> +    print(line.format("New-file", args.new_file))
> +    total = 0
> +    for opt in args.doptions:
> +        count = len(output[opt])
> +        print(line.format(diff_types[opt], count))
> +        total += count
> +    print(line.format("Total", total))
> +
> +def print_result(result, args):
> +    output = filter_output(result, args)
> +    print_table(output, args)
> +    print_summary(output, args)
> +
> +diff_types = {"S": "Same", "C": "Changed", "O": "Old-only", "N": "New-only"}
> +args = parse_args()
> +result = compare_config(args)
> +print_result(result, args)
> --
> 2.35.1
>


-- 
Best Regards
Masahiro Yamada
