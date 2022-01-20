Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EC04946B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 06:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiATFPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 00:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiATFPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 00:15:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDB2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 21:15:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id p12so23548313edq.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 21:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBZ3EI10U9UXarSM6J3+DYPKZJSi0FN5MQmJ2ljGh3A=;
        b=RH5VxPM0TvMWOkIqcGhOgztHOcerYs4FQq5+uTqXP98fHlsxqe41R8HYbBVfoEgT1e
         CgiHjjRFUf02bWKuDgI90+TsYG8vCwiNna8m7Vr8Zy+L7JdAUKlLz63E/e8j5eJFGFc5
         efezFa5Ei6YImj3Mgn0EKBeLaqFde/BMY8/4FlE1Z1rR0H1W+5GRMYj7Sy81tE7Y/T8K
         yQDHSCeDtugO9RfyKt6jnALtqbnFsFYYRzqDZPbHOJjmId/MEEY1pMcAIg2Os/ijAjMR
         ZFbkarXWFPhhShQeCSqH6mmY+XD24QZ0bXhhLLUCFMkawuLE1JwUXv1FqvE+zCKtKfjZ
         Q8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBZ3EI10U9UXarSM6J3+DYPKZJSi0FN5MQmJ2ljGh3A=;
        b=FHCvtzvIO4byesQAtjPcAekFUidGs90ZjZOAo76CTVDd5zOT91qm2fKio8AxG2M8pE
         4BnwSxbAoQY9egactJxjlC7xUQY7KuzKJC5sOCWGgkDgpx1mkQTsN5KkP8jXd8fwwm9+
         3bJY+X0QF2NDtoHjw9ryNIZ9hB5501mS6x1ICxhVBi6C0JXsobY5nMb9jVtQmZEZOxmi
         Z1uNeI3cSBES63iMrXn/MRjaCSZ56VEo0eV5ABuwAQDrGmiDoC6/oBkn0uRWLnivv7kg
         k1i9JRSnaUHaXs7NykbNekeMDA5N9e4e781hN6gmBNMeJICQ/ur0o952ZIFc3FAj3c+M
         F3JA==
X-Gm-Message-State: AOAM5300IfdeYpztoEbXTSzO01qegiI72GP4OJjsGM9BAQBVoIs7BA8i
        mqnUYkNNP6A6vXrGhP+n2nzgOVqTsJlR8zobJ4pJJtBcGGQ=
X-Google-Smtp-Source: ABdhPJyRJReKxS3lgAXIrWkKWQuSeDByJCK1TATU8l1CLwivtDAELwuiIklEZUomVNxOgcK0JEfBJvH4y/XoIVooSgY=
X-Received: by 2002:a17:907:94c6:: with SMTP id dn6mr821979ejc.477.1642655701299;
 Wed, 19 Jan 2022 21:15:01 -0800 (PST)
MIME-Version: 1.0
References: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
 <20220117194836.vj2rxr3wocrtdx7k@treble> <20220117202751.bmwvfsnqxokob6d2@treble>
 <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
 <20220118175239.lqxi2ycgeusk5pxl@treble> <CAPDLWs_mirot76g==TPRZDsB6Qn99kxw2N5V=PaDYqBLf=ZSCQ@mail.gmail.com>
 <20220119212126.aydgx62abbngumwy@treble> <20220119234303.tmebbcrg2vpnri4s@treble>
In-Reply-To: <20220119234303.tmebbcrg2vpnri4s@treble>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Thu, 20 Jan 2022 10:44:44 +0530
Message-ID: <CAPDLWs-DM64k6z3G7qgYwYm=F8piehYhLfaaXc3fDtnBBQiu=Q@mail.gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 5:13 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Jan 19, 2022 at 01:21:29PM -0800, Josh Poimboeuf wrote:
> > > $ nm -n ./oops_tryv2.ko |grep -C5 do_the_work
> > > 0000000000000000 r __func__.24215
> > > 0000000000000000 r __param_bug_in_workq
> > > 0000000000000000 D __this_module
> > > 0000000000000000 r _note_7
> > > 0000000000000000 T cleanup_module
> > > 0000000000000000 t do_the_work
> > > 0000000000000000 t do_the_work.cold
> > > 0000000000000000 b gctx
> > > 0000000000000000 T init_module
> > > 0000000000000000 t try_oops_exit
> > > 0000000000000000 t try_oops_init
> > > 0000000000000008 b t1
> > > $
> > >
> > > BTW, here's the code:
> > > https://github.com/PacktPublishing/Linux-Kernel-Debugging/tree/main/ch7/oops_tryv2
> >
> > Ok, it looks like the symbols aren't sorted like the code expects.  I
> > need to do a more robust fix.
>
> Ok, please try this instead.  This takes a much more robust approach to
> the function size calculation, using readelf to confine the symbol
> search to the section matching the original symbol.
>
> This actually has multiple fixes and cleanups, so it'll eventually be
> split up into a patch set.

Great. Am facing a few issues though:

1. Not sure if it's me but am having issues applying your patches; it
seems to fail:

$ patch -p1 --dry-run < ./fa1.patch
checking file scripts/faddr2line
Hunk #1 FAILED at 97.
Hunk #2 FAILED at 110.
Hunk #3 FAILED at 189.
3 out of 3 hunks FAILED
$

Against which ver are you generating the patch?
(Am using 5.10.60; i noticed the last commit in mainline was f5f67cc
in Nov 2018, so vanilla 5.10.60 should be fine, no?).

2. I manually applied your patch :)   This is the output I then get:

$ <...>linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x16f/0x194
awk: not an option: --bignum
bad symbol size: addr: 0x0000000000000000
$

(Not sure if this helps but am running on Ubuntu 20.04; my awk is mawk
v 1.3.4.20200120-2).

Thanks,
Kaiwan.

>
> ----
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 6c6439f69a72..1acb68927977 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -97,10 +97,11 @@ __faddr2line() {
>         local dir_prefix=$3
>         local print_warnings=$4
>
> +       local first=1
>         local func=${func_addr%+*}
>         local offset=${func_addr#*+}
>         offset=${offset%/*}
> -       local size=
> +       local user_size=
>         [[ $func_addr =~ "/" ]] && size=${func_addr#*/}
>
>         if [[ -z $func ]] || [[ -z $offset ]] || [[ $func = $func_addr ]]; then
> @@ -110,73 +111,87 @@ __faddr2line() {
>         fi
>
>         # Go through each of the object's symbols which match the func name.
> -       # In rare cases there might be duplicates.
> -       file_end=$(${SIZE} -Ax $objfile | awk '$1 == ".text" {print $2}')
> +       # In rare cases there might be duplicates, in which case we print both.
>         while read symbol; do
>                 local fields=($symbol)
> -               local sym_base=0x${fields[0]}
> -               local sym_type=${fields[1]}
> -               local sym_end=${fields[3]}
> -
> -               # calculate the size
> -               local sym_size=$(($sym_end - $sym_base))
> -               if [[ -z $sym_size ]] || [[ $sym_size -le 0 ]]; then
> -                       warn "bad symbol size: base: $sym_base end: $sym_end"
> +               local sym_addr=0x${fields[1]}
> +               local sym_size=${fields[2]}
> +               local sym_sec=${fields[6]}
> +
> +               # Get the section size:
> +               local sec_size=$(${READELF} --section-headers --wide $objfile |
> +                       sed 's/\[ /\[/' |
> +                       awk -v sec=$sym_sec '$1 == "[" sec "]" { print "0x" $6; exit }')
> +
> +               if [[ -z $sec_size ]]; then
> +                       warn "bad section size: section: $sym_sec"
>                         DONE=1
>                         return
>                 fi
> -               sym_size=0x$(printf %x $sym_size)
>
> -               # calculate the address
> -               local addr=$(($sym_base + $offset))
> -               if [[ -z $addr ]] || [[ $addr = 0 ]]; then
> -                       warn "bad address: $sym_base + $offset"
> +               # Calculate the symbol size:
> +               #
> +               # We can't use the ELF size, because kallsyms also includes the
> +               # padding bytes in its size calculation.  For kallsyms, the
> +               # size calculation is the distance between the symbol and the
> +               # next symbol in a sorted list.
> +               local size=$(${READELF} --symbols --wide $objfile |
> +                       awk -v sec=$sym_sec '$7 == sec' |
> +                       sort --key=2 |
> +                       awk --bignum -v sym_addr=${sym_addr#0x} -v sym_size=${sym_size} -v sym_name=${func} -v sec_size=${sec_size} \
> +                               '$2 == sym_addr && $3 == sym_size && $8 == sym_name { found = 1; next } \
> +                               found == 1 { size = strtonum("0x" $2) - strtonum("0x" sym_addr); if (size < sym_size) next; found = 2; print size; exit } \
> +                               END { if (found == 1) print strtonum(sec_size) }')
> +
> +               if [[ -z $size ]]; then
> +                       warn "bad symbol size: addr: $sym_addr"
>                         DONE=1
>                         return
>                 fi
> -               addr=0x$(printf %x $addr)
>
> -               # weed out non-function symbols
> -               if [[ $sym_type != t ]] && [[ $sym_type != T ]]; then
> -                       [[ $print_warnings = 1 ]] &&
> -                               echo "skipping $func address at $addr due to non-function symbol of type '$sym_type'"
> -                       continue
> +               # Calculate the specified address:
> +               local addr=$(($sym_addr + $offset))
> +               if [[ -z $addr ]] || [[ $addr = 0 ]]; then
> +                       warn "bad address: $sym_addr + $offset"
> +                       DONE=1
> +                       return
>                 fi
> +               addr=0x$(printf %x $addr)
>
> -               # if the user provided a size, make sure it matches the symbol's size
> -               if [[ -n $size ]] && [[ $size -ne $sym_size ]]; then
> +               # If the user provided a size, make sure it matches the symbol's size:
> +               if [[ -n $user_size ]] && [[ $user_size -ne $size ]]; then
>                         [[ $print_warnings = 1 ]] &&
> -                               echo "skipping $func address at $addr due to size mismatch ($size != $sym_size)"
> +                               echo "skipping $func address at $addr due to size mismatch ($user_size != $size)"
>                         continue;
>                 fi
>
> -               # make sure the provided offset is within the symbol's range
> -               if [[ $offset -gt $sym_size ]]; then
> +               # Make sure the provided offset is within the symbol's range:
> +               if [[ $offset -gt $size ]]; then
>                         [[ $print_warnings = 1 ]] &&
> -                               echo "skipping $func address at $addr due to size mismatch ($offset > $sym_size)"
> +                               echo "skipping $func address at $addr due to size mismatch ($offset > $size)"
>                         continue
>                 fi
>
> -               # separate multiple entries with a blank line
> -               [[ $FIRST = 0 ]] && echo
> -               FIRST=0
> +               # In case of duplicates, separate multiple entries with a blank line:
> +               [[ $first = 0 ]] && echo
> +               first=0
>
> -               # pass real address to addr2line
> -               echo "$func+$offset/$sym_size:"
> -               local file_lines=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
> -               [[ -z $file_lines ]] && return
> +               # Pass full address to addr2line:
> +               echo "$func+$offset/$size:"
> +               local output=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
> +               [[ -z $output ]] && continue
>
>                 if [[ $LIST = 0 ]]; then
> -                       echo "$file_lines" | while read -r line
> +                       echo "$output" | while read -r line
>                         do
>                                 echo $line
>                         done
>                         DONE=1;
> -                       return
> +                       continue
>                 fi
>
> -               # show each line with context
> -               echo "$file_lines" | while read -r line
> +               # If --list was specified, show each line with context:
> +               echo "$output" | while read -r line
>                 do
>                         echo
>                         echo $line
> @@ -189,7 +204,7 @@ __faddr2line() {
>
>                 DONE=1
>
> -       done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
> +       done < <(${READELF} --symbols --wide $objfile | awk -v fn=$func '$4 == "FUNC" && $8 == fn')
>  }
>
>  [[ $# -lt 2 ]] && usage
>
