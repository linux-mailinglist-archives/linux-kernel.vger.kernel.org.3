Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59616495537
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377554AbiATUFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377548AbiATUFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:05:32 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805C4C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:05:32 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b13so33691811edn.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOTxp6izNWcf7u58bVG55VYTx0rw2v8WMXA2HnEK+fE=;
        b=Znydkc0VQ2Uebq3rEmLxq5rwHK52AIfT/3LR3BYf9dLL+uAvr3ku9ho0lvRr0YPql6
         V75msQuygJZ1/Onq6Aih3zUkzBurrcP6QCJ06e2UclfOS9gNyoSzbjPlyGbeVq/Js/8/
         UPRTeIuCkPO9f3EnIj/qwDLemgr1fTIirEWms/xkSGzK79KSZ0S/oNK1eedx2754rGqX
         USkxFh6mvWa23wsOARczdlP7ZRF9k/COjwhEdM19nscb5fX3InS8hbcfYOkMOBhhSVfx
         LZU6j/BhvLOaNd9lrtdfmn1dx2qnBt6qWMRNvqidzemgajJ/B3oMSbSHNwAJPFecbDgH
         2M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOTxp6izNWcf7u58bVG55VYTx0rw2v8WMXA2HnEK+fE=;
        b=1RlYXdlD5YePoJhpFQy6GVm69AqQkMLla+zqUmOUoOurg7+I6dGmFle3IlPp3qFLp4
         jAQZIDYkjHqo31Yv1HdqqNrU+nuO+Q0xYLH++j3EixDzAiQ8JCXFpq1vzoCS48ua7iKu
         7kqO8MxyXf5A+EqkdRnQzGQ+LA/1y8iLRXFwgluhlWWkaERqJpWSdom74viP696vriW8
         8bChsp9Zgf7wf3bK/XAMckOASOVnK3V1pb0UXSqYEftasVary5eoOnxVG0luqspTFAGi
         P3tbJASmU6Fvb8ZOiqbdkELpfMUnLIMQM59MDj/iTnkS/qad8XQz+87fwnw4RQ/cl0Yn
         4L8g==
X-Gm-Message-State: AOAM532SZbPnQUjOIg/5UxmGkKZJbpg5e3UVB/tj8/DykkuT+HMrClka
        klOWncyn2prtXSpEv9dQQ82L5/i8lAJ+itIMfJy3ffHuLN4=
X-Google-Smtp-Source: ABdhPJxZ6c26JiVYo37uVQmE8HYt1b/E8KhsZ1NT/1FEsyPhe0Inf7IREuGTSEUKPZgKXSPdKMVFsyVOVPNoY8poGk4=
X-Received: by 2002:a05:6402:43ca:: with SMTP id p10mr788775edc.74.1642709130694;
 Thu, 20 Jan 2022 12:05:30 -0800 (PST)
MIME-Version: 1.0
References: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
 <20220117194836.vj2rxr3wocrtdx7k@treble> <20220117202751.bmwvfsnqxokob6d2@treble>
 <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
 <20220118175239.lqxi2ycgeusk5pxl@treble> <CAPDLWs_mirot76g==TPRZDsB6Qn99kxw2N5V=PaDYqBLf=ZSCQ@mail.gmail.com>
 <20220119212126.aydgx62abbngumwy@treble> <20220119234303.tmebbcrg2vpnri4s@treble>
 <CAPDLWs-DM64k6z3G7qgYwYm=F8piehYhLfaaXc3fDtnBBQiu=Q@mail.gmail.com> <20220120171751.gibauc4zovoskjns@treble>
In-Reply-To: <20220120171751.gibauc4zovoskjns@treble>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Fri, 21 Jan 2022 01:35:13 +0530
Message-ID: <CAPDLWs_28zYabLjsyT2gq-o6vEzidWB4mpGuUGdiYr0qb6YFWQ@mail.gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 10:48 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Jan 20, 2022 at 10:44:44AM +0530, Kaiwan N Billimoria wrote:
> > On Thu, Jan 20, 2022 at 5:13 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Wed, Jan 19, 2022 at 01:21:29PM -0800, Josh Poimboeuf wrote:
> > > > > $ nm -n ./oops_tryv2.ko |grep -C5 do_the_work
> > > > > 0000000000000000 r __func__.24215
> > > > > 0000000000000000 r __param_bug_in_workq
> > > > > 0000000000000000 D __this_module
> > > > > 0000000000000000 r _note_7
> > > > > 0000000000000000 T cleanup_module
> > > > > 0000000000000000 t do_the_work
> > > > > 0000000000000000 t do_the_work.cold
> > > > > 0000000000000000 b gctx
> > > > > 0000000000000000 T init_module
> > > > > 0000000000000000 t try_oops_exit
> > > > > 0000000000000000 t try_oops_init
> > > > > 0000000000000008 b t1
> > > > > $
> > > > >
> > > > > BTW, here's the code:
> > > > > https://github.com/PacktPublishing/Linux-Kernel-Debugging/tree/main/ch7/oops_tryv2
> > > >
> > > > Ok, it looks like the symbols aren't sorted like the code expects.  I
> > > > need to do a more robust fix.
> > >
> > > Ok, please try this instead.  This takes a much more robust approach to
> > > the function size calculation, using readelf to confine the symbol
> > > search to the section matching the original symbol.
> > >
> > > This actually has multiple fixes and cleanups, so it'll eventually be
> > > split up into a patch set.
> >
> > Great. Am facing a few issues though:
> >
> > 1. Not sure if it's me but am having issues applying your patches; it
> > seems to fail:
> >
> > $ patch -p1 --dry-run < ./fa1.patch
> > checking file scripts/faddr2line
> > Hunk #1 FAILED at 97.
> > Hunk #2 FAILED at 110.
> > Hunk #3 FAILED at 189.
> > 3 out of 3 hunks FAILED
> > $
>
> Hm, did you happen to have the older patch already applied?  This should
> be applied instead of that one.  Though it's definitely possible I
> messed the patch up somehow.
>
> When saving the patch, make sure to preserve the original whitespace.
>
> I'm adding the new patch here as an attachment, if that helps.

That helped! I think my stubbornly using Gmail perhaps caused issues
when i copy-pasted the earlier patches... thanks.
>
> > Against which ver are you generating the patch?
> > (Am using 5.10.60; i noticed the last commit in mainline was f5f67cc
> > in Nov 2018, so vanilla 5.10.60 should be fine, no?).
>
> It was against a newer kernel, but yes, applying it against 5.10.60
> should also work.
Cool.
>...
> Sorry, I didn't realize mawk was still a thing :-)
>
> Try this one?

Definitely better !
This is the o/p i now get:

$ <...>linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko
do_the_work.cold+0x68/0x126
do_the_work.cold+0x68/0x126:
delay_sec at <...>/oops_tryv2/../../convenient.h:279
$

The source file+line-no doesn't show up here though... (as it's a foo.cold()?).
(I'm unsure why the line delay_sec at <...>convenient.h:279   shows up
; i don't call this delay_sec() func directly... anyway, that's my
problem.)

Thanks.
>
> ----
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 6c6439f69a72..01f28e52f3fc 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -97,86 +97,127 @@ __faddr2line() {
>         local dir_prefix=$3
>         local print_warnings=$4
>
> -       local func=${func_addr%+*}
> +       local first=1
> +       local sym_name=${func_addr%+*}
>         local offset=${func_addr#*+}
>         offset=${offset%/*}
> -       local size=
> -       [[ $func_addr =~ "/" ]] && size=${func_addr#*/}
> +       local user_size=
> +       [[ $func_addr =~ "/" ]] && user_size=${func_addr#*/}
>
> -       if [[ -z $func ]] || [[ -z $offset ]] || [[ $func = $func_addr ]]; then
> +       if [[ -z $sym_name ]] || [[ -z $offset ]] || [[ $sym_name = $func_addr ]]; then
>                 warn "bad func+offset $func_addr"
>                 DONE=1
>                 return
>         fi
>
>         # Go through each of the object's symbols which match the func name.
> -       # In rare cases there might be duplicates.
> -       file_end=$(${SIZE} -Ax $objfile | awk '$1 == ".text" {print $2}')
> -       while read symbol; do
> -               local fields=($symbol)
> -               local sym_base=0x${fields[0]}
> -               local sym_type=${fields[1]}
> -               local sym_end=${fields[3]}
> -
> -               # calculate the size
> -               local sym_size=$(($sym_end - $sym_base))
> -               if [[ -z $sym_size ]] || [[ $sym_size -le 0 ]]; then
> -                       warn "bad symbol size: base: $sym_base end: $sym_end"
> +       # In rare cases there might be duplicates, in which case we print all
> +       # matches.
> +       while read line; do
> +               local fields=($line)
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
> +               local size
> +               local next_sym_addr
> +               local found=0
> +               while read line; do
> +                       local fields=($line)
> +                       next_sym_addr=0x${fields[1]}
> +                       local next_sym_size=${fields[2]}
> +                       local next_sym_name=${fields[7]:-}
> +
> +                       if [[ $next_sym_addr = $sym_addr ]] &&
> +                          [[ $next_sym_size = $sym_size ]] &&
> +                          [[ $next_sym_name = $sym_name ]]; then
> +                               found=1
> +                               continue
> +                       fi
> +
> +                       if [[ $found = 1 ]]; then
> +                               size=$(($next_sym_addr - $sym_addr))
> +                               [[ $size -lt $sym_size ]] && continue;
> +                               found=2
> +                               break
> +                       fi
> +               done < <(${READELF} --symbols --wide $objfile | awk -v sec=$sym_sec '$7 == sec' | sort --key=2)
> +
> +               if [[ $found = 0 ]]; then
> +                       warn "can't find symbol: sym_name: $sym_name sym_sec=$sym_sec sym_addr: $sym_addr sym_size: $sym_size"
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
> +               [[ $found = 1 ]] && size=$(($sec_size - $sym_addr))
> +
> +               if [[ -z $size ]] || [[ $size -le 0 ]]; then
> +                       warn "bad symbol size: sym_addr: $sym_addr next_sym_addr: $next_sym_addr"
> +                       DONE=1
> +                       return
>                 fi
> +               size=0x$(printf %x $size)
>
> -               # if the user provided a size, make sure it matches the symbol's size
> -               if [[ -n $size ]] && [[ $size -ne $sym_size ]]; then
> +               # Calculate the specified address:
> +               local addr=$(($sym_addr + $offset))
> +               if [[ -z $addr ]] || [[ $addr = 0 ]]; then
> +                       warn "bad address: $sym_addr + $offset"
> +                       DONE=1
> +                       return
> +               fi
> +               addr=0x$(printf %x $addr)
> +
> +               # If the user provided a size, make sure it matches the symbol's size:
> +               if [[ -n $user_size ]] && [[ $user_size -ne $size ]]; then
>                         [[ $print_warnings = 1 ]] &&
> -                               echo "skipping $func address at $addr due to size mismatch ($size != $sym_size)"
> +                               echo "skipping $sym_name address at $addr due to size mismatch ($user_size != $size)"
>                         continue;
>                 fi
>
> -               # make sure the provided offset is within the symbol's range
> -               if [[ $offset -gt $sym_size ]]; then
> +               # Make sure the provided offset is within the symbol's range:
> +               if [[ $offset -gt $size ]]; then
>                         [[ $print_warnings = 1 ]] &&
> -                               echo "skipping $func address at $addr due to size mismatch ($offset > $sym_size)"
> +                               echo "skipping $sym_name address at $addr due to size mismatch ($offset > $size)"
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
> +               echo "$sym_name+$offset/$size:"
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
> @@ -189,7 +230,7 @@ __faddr2line() {
>
>                 DONE=1
>
> -       done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
> +       done < <(${READELF} --symbols --wide $objfile | awk -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
>  }
>
>  [[ $# -lt 2 ]] && usage
