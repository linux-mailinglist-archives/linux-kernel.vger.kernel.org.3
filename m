Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC504C9C77
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbiCBEfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiCBEe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:34:59 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D07AD120
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:34:13 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220302043408epoutp01b86c7fbe249dd620dd1cc85fcd24ba33~YdjiG9Qxh2797727977epoutp011
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:34:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220302043408epoutp01b86c7fbe249dd620dd1cc85fcd24ba33~YdjiG9Qxh2797727977epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646195649;
        bh=g/XYfVsdkYfK397AON93sEtRtmKsp54HrNKtm0+bHtg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=rsOCmefFGv3wRwU9fdzk4zH2UN/9ixw845opUN1lEHciKe9Y7V6Zx+ORQm0NneKki
         /OXj4fngEktPf43Y+Snmd8D4K1WZCkN/lfADTm49+vvuCvZTeONcxqdXycpR293gZQ
         DgPUEbgzCnxhquaC1NsQHdq0mHani/lQ3p8XRLFk=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220302043408epcas5p285b3e0bc75d1475527b5727e03c94b9f~YdjhbZc6h0535905359epcas5p2K;
        Wed,  2 Mar 2022 04:34:08 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-17-621ef20059ea
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.B8.46822.002FE126; Wed,  2 Mar 2022 13:26:40 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v4] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Joe Perches <joe@perches.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        "pmladek@suse.com" <pmladek@suse.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <036f47fa1f929813cc2c7672654c7be9329b1fd9.camel@perches.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220302043259epcms5p7b3b3c30e8547784f7cec4320fb171536@epcms5p7>
Date:   Wed, 02 Mar 2022 10:02:59 +0530
X-CMS-MailID: 20220302043259epcms5p7b3b3c30e8547784f7cec4320fb171536
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7bCmhi7DJ7kkgwPr2CzmrF/DZvFhrYbF
        +oXLmC1m33/MYnF51xw2i5aj7SwW/x9/ZbU4dHIuowOHx6yGXjaPnbPusnucmPGbxePLqmvM
        Hn1bVjF6rN9ylcXj8ya5APYoLpuU1JzMstQifbsErownN7IKVktVXNx4nbmB8ZhQFyMnh4SA
        icTq+S+Yuxi5OIQEdjNKbN01A8jh4OAVEJT4u0MYpEZYIEni85lfTCC2kICixIUZaxhBSoQF
        DCR+bdUACbMJ6Ems2rWHBWSMiMBnRokTC8+AzWQWmMAo8f7LflaIZbwSM9qfskDY0hLbl29l
        BLE5BTwldjXsYoSIi0rcXP2WHcZ+f2w+VFxEovXeWWYIW1Diwc/dUHEZidWbe8E2Swh0M0qs
        f7cXypnBKNHzaBpUh7nE+iWrwKbyCvhKrH32GuwiFgFViT1rmqC2uUjsfNHLBmIzC8hLbH87
        BxwSzAKaEut36UOUyEpMPbWOCaKET6L39xMmmMd2zIOxVSVabm5ghXny88ePUA97SLRf7GOH
        hPRRRokPG1sYJzAqzEIE9iwkm2chbF7AyLyKUTK1oDg3PbXYtMAoL7Vcrzgxt7g0L10vOT93
        EyM4DWl57WB8+OCD3iFGJg7GQ4wSHMxKIrwXf8okCfGmJFZWpRblxxeV5qQWH2KU5mBREuc9
        nb4hUUggPbEkNTs1tSC1CCbLxMEp1cDUciM865fs3MQVvn7BXH+SGFIO1omnvNoTJFag94Nl
        5d4djap7jia9fbj8RfBrlrv3z6xuZVNcfn3mvogEzi/qH5lzDkUujXX91mKr/punk8PiY+nP
        jILv67nan9wsMXy97OBk62ee+ve1OnwfvJx+b31cu/yOTaZKE/f+jdJwLEhhmHIm04Bn6uSv
        Erd719zk+NjhUHvXzNpzyYvTU29MPW3+Nn/2N+cbZ+ynT3yy+/7U0GoHn49zrNouzVmWcHJT
        YbW28jxBg4+XC+/VBlw8v29m9bZXonmX/IrrzvewmWtFOS3fLtdzuLTb7emEhxW7NhXpL5J2
        451u8uv1LIa9d7Qa+5z2+1Rmpe3j1f0Zq8RSnJFoqMVcVJwIAK7Yb1qyAwAA
X-CMS-RootMailID: 20220228073715epcas5p1b3166e6b673d3c8b610f7e2f5745562b
References: <036f47fa1f929813cc2c7672654c7be9329b1fd9.camel@perches.com>
        <20220228073708.1610603-1-maninder1.s@samsung.com>
        <CGME20220228073715epcas5p1b3166e6b673d3c8b610f7e2f5745562b@epcms5p7>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Mon, 2022-02-28 at 13:07 +0530, Maninder Singh wrote:
> > with commit 98e35f5894cf ("printk: git rid of [sched_delayed] message for
> > printk_deferred") printk_deferred and printk_deferred_once requires
> > LOGLEVEL in argument, but checkpatch.pl was not fixed and still reports
> > it as warning:
> > 
> > WARNING: Possible unnecessary KERN_ALERT
> > printk_deferred(KERN_ALERT "checking deferred\n");
>  
> I don't care for this patch at all.

But still it needs to be fixed, either with current suggested patch or with something else.
 
> There are many existing uses of printk_deferred both with and without a
> specific KERN_<LEVEL>.

Yes, Because earlier to this commit 98e35f5894cf, printk_deferred was expected
with KERN_WARNING by default.

-       if (in_sched)
-               text_len = scnprintf(text, sizeof(textbuf),
-                                    KERN_WARNING "[sched_delayed] ");

But now it is aligned with normal printk level handling, only printing to console from current context
is avoided  in case of deferred.
So earlier printk_deferred's should be fixed if it is meant to be printed on console with particular
level.

> printk_deferred currently always emits at LOGLEVEL_SCHED/KERN_DEFAULT.
>  
> I think it's be better to modify vprintk_emit when LOGLEVEL_SCHED
> is used and if a KERN_<LEVEL> exists in the format, use it.
> Perhaps instead:
> ---
>  kernel/printk/printk.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>  
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1ce242f34d2be..6b5baf14f6d56 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2247,7 +2247,13 @@ asmlinkage int vprintk_emit(int facility, int level,
>                  return 0;
>  
>          if (level == LOGLEVEL_SCHED) {
> -                level = LOGLEVEL_DEFAULT;
> +                level = printk_get_level(fmt);
> +                if (level) {
> +                        level -= '0';
> +                        fmt = printk_skip_level(fmt);
> +                } else {
> +                        level = LOGLEVEL_DEFAULT;
> +                }
>                  in_sched = true;
>          }
 
And I think it is already handled for printk (facility = 0).
after setting level to KERN_DEFAULT at first for in_sched case to make it normal
printk case as it is changed from vprintk_store as per the string in printk based on
current default loglevel.

int vprintk_store(int facility, int level,
                  const struct dev_printk_info *dev_info,
                  const char *fmt, va_list args)
{
...
        /* Extract log level or control flags. */
        if (facility == 0)
                printk_parse_prefix(&prefix_buf[0], &level, &flags);
..


u16 printk_parse_prefix(const char *text, int *level,
                        enum printk_info_flags *flags)
{
..
                case '0' ... '7':
                        if (level && *level == LOGLEVEL_DEFAULT)
                                *level = kern_level - '0';
                        break;
...
}

So, for printk, printk_deferred, printk_deferred_once, its level is picked if its provided.
thus level in printk_deferred is "not unnecessary".
And checkpatch.pl should not give w WARNING for this.


Thanks,
Maninder Singh
