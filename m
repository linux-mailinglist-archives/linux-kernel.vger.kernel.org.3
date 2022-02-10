Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6884B08FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbiBJI5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:57:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiBJI5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:57:05 -0500
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 00:57:05 PST
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD6D4A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:57:05 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220210084833epoutp037f053b6e6801e65287b9d78d91f32938~SYH9T_F8G3184331843epoutp03D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:48:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220210084833epoutp037f053b6e6801e65287b9d78d91f32938~SYH9T_F8G3184331843epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644482913;
        bh=KcWEqHF9nH1fZ8q/x1XxY2SexomZ3sxRtUBKXEsjkb4=;
        h=Date:Subject:Reply-To:From:To:CC:In-Reply-To:References:From;
        b=DshZ+ZINaQiyAxWmRDOJ3Qlbl5nhXFmoAMh70HjV53yZ8z7azxMzsVhMaJ4Lq3YuM
         PKN7J/O7Fl2+ZaddHhSa8YyUzR57JFNIfhkKnrLgDkacrruqOMo3sHPDOCpawcgkK0
         ZIXxmthirLzM+Pn1+pl8UAoNIIaSl1nJ8x/VxIkc=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220210084833epcas5p4ccf8d4cf288fb6bf3f5d71d545222398~SYH8sHlBE0116901169epcas5p4c;
        Thu, 10 Feb 2022 08:48:33 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-86-6204d16170ad
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.CF.06423.161D4026; Thu, 10 Feb 2022 17:48:33 +0900 (KST)
Date:   Thu, 10 Feb 2022 14:18:23 +0530
Message-ID: <436367503.2691559.1644482903367@mail-kr5-0>
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] kallsyms: print module name in %ps/S case when
 KALLSYMS is disabled
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     Vimal Agrawal <avimalin@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        Aaron Tomlin <atomlin@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YgTKqoRIwahzWyh0@alley>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20220210084823epcms5p4aa4b02982ca806b52c5078aa7d9ec76e
Content-Type: multipart/mixed;
        boundary="----=_Part_2691558_779447602.1644482903367"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmum7iRZYkg1nzuC3mrF/DZtHbNJ3J
        4sj8NawWDw5eZ7d4v6yH0eLyrjlsFo9nzWOzuLviBpPFjQlPGS1Wzl/OaPH/8VdWi30dD5gs
        dm9cxGZx/M5TJotDJ+cyWjR+vs9o0XLH1EHQY828NYwesxsusnjsnHWX3aNl3y0gceQtq8em
        VZ1sHidm/GbxmHcy0ONCV7bH+31X2Tz6tqxi9Fi/5SqLx5kFR9g9Pm+SC+CL4rJJSc3JLEst
        0rdL4MpofPmBseCQRsWf43INjBeUuhg5OSQETCSOndjBBmILCexmlFi6oRDEZhFQlXi9/z1Y
        nFfAQmJr7xamLkYOIFtQ4u8OYZCwsECcxPL5E1ghWhUlLsxYwwhSIixgIPFrqwZImE1AT2LV
        rj0sILaIgIfEn+0fgGwuDmaBt6wSm/oPskCcwCsxo/0plC0tsX35VkYQmxPohKnPPrFBxEUl
        bq5+yw5jvz82nxHCFpFovXeWGcIWlHjwczdUXEZi9eZesGUSAt2MEuvf7YVyZjBK9DyaBtVh
        LrF+ySqoqS4S5389BoszC4RJHN97C6pGVmLqqXVMEHE+id7fT5hgrt4xD8ZWlWi5uYEV5oPP
        Hz9CfeMhMbFnNiMkhL4zStw9JD+BUX4WIhxnIdkGYctLbH87hxmkhFlAU2L9Ln2IsJrElP4v
        bBC2mURD+1QWCFtRYkr3Q/YFjOyrGCVTC4pz01OLTQsM81LL9YoTc4tL89L1kvNzNzGC06yW
        5w7Guw8+6B1iZOJgPMSoAtT+aMPqC4xSLHn5ealKIryn6pmThHhTEiurUovy44tKc1KLDzFK
        c7AoifOeTt+QKCSQnliSmp2aWpBaBJNl4uCUamBqnOvsXXVz8x9xli1nFffpHZqe9CCivE3o
        sRhHvdKvouwLd7nt9AwXpSfO0I5dkGWSuJjZfd/ZH3OZ1ikwme5U2xWwYbNh8mXjlUZPzsvK
        acxzPhT5/+/jifwbb3+2V4rhtVib+9lmetLs65f3nTTztSh8+eHo33/u62NFLr6/XzyfIyiq
        90n6kixN49SiV8fO9EwXtTfbHKintGplvvZVl/DZabWSsSrR38WbOXb5R3I+vJLOw5naouxo
        EPQz98SZKDFzvS5Tt7Rru6UkKmx5Qy9YLOxs3CDsYPIp96ZZ/MUnT1sbnOy/+a9SSjJi8Vo8
        84GX5CaLq8ePBt3RbTrD/eTk3bz+dYnZgoHRG5RYijMSDbWYi4oTAcRs0rguBAAA
X-CMS-RootMailID: 20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc
References: <YgTKqoRIwahzWyh0@alley>
        <20220201040044.1528568-1-maninder1.s@samsung.com>
        <20220209114038.GA8279@pathway.suse.cz>
        <YgRH7hwFC2AGISdP@bombadil.infradead.org>
        <CGME20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc@epcms5p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2691558_779447602.1644482903367
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

Hi All,

Thanks for your inputs.

> On Wed 2022-02-09 15:02:06, Luis Chamberlain wrote:
> > On Wed, Feb 09, 2022 at 12:40:38PM +0100, Petr Mladek wrote:
> > > > --- a/include/linux/kallsyms.h
> > > > +++ b/include/linux/kallsyms.h
> > > > @@ -163,6 +163,33 @@ static inline bool kallsyms_show_value(const struct cred *cred)
> > > >          return false;
> > > >  }
> > > >  
> > > > +#ifdef CONFIG_MODULES
> > > > +static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
> > > > +{
> > > > +        struct module *mod;
> > > > +        unsigned long offset;
> > > > +        int ret = 0;
> > > > +
> > > > +        preempt_disable();
> > > > +        mod = __module_address(value);
> > > > +        if (mod) {
> > > > +                offset = value - (unsigned long)mod->core_layout.base;
> > > > +                snprintf(sym, size - 1, "0x%lx+0x%lx [%s]",
> > > > +                                (unsigned long)mod->core_layout.base, offset, mod->name);
> > > > +
> > > > +                sym[size - 1] = '\0';
> > > > +                ret = 1;
> > > > +        }
> > > > +
> > > > +        preempt_enable();
> > > > +        return ret;
> > > > +}
> > > 
> > > It looks too big for an inlined function. Anyway, we will need
> > > something even more complex, see below.
> > 
> > Interesting, these observations might apply to Vimal's work as well [0].
> > 
> > [0] https://lkml.kernel.org/r/YgKyC4ZRud0JW1PF@bombadil.infradead.org
>  
> Honestly, I am not sure what is the best practice. My understanding is
> that inlined functions are used primary for speed up at runtime.
>  

Main reason of making it inline was:
(1) kallsysm.c was not getting compiled(with disabled config), so could not add defination there.
(2) lib/vsnprintf.c was not correct place to define new function of kallsyms(fill_minimal_module_info)
(3) I thought static int will be part of each .c file which includes kallsyms.h and compiler can make noise for unused functions,
and also increase code size, where as static inline will be added only if some code is calling that function otherwise will be discarded.

But as peter said better version will be to make a new defination of __sprint_symbol (probably in kernel/module.c)
to handle all cases of %ps/S/B/b when KALLSYSMS is disabled.

I will try to prepare changes and share V2 patch.

Thanks,
Maninder Singh
------=_Part_2691558_779447602.1644482903367
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBSZTogW1BBVENIIDEvMV0g
a2FsbHN5bXM6IHByaW50IG1vZHVsZSBuYW1lIGluICVwcy9TIGNhc2Ugd2hlbiBLQUxMU1lNUyBp
cyBkaXNhYmxlZA0KICAgICAgRnJvbSAgICAgICA6IG51bGwNCiAgICAgIFNlbnQgRGF0ZSAgOiAy
MDIyLTAyLTEwIDEzOjUwICBHTVQrNTozMA0KICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogICAgICAgICAg
ICAgICAgICBOYW1lICAgICAgICAgICAgICAgIFR5cGUgICAgICAgICAgSm9iIFRpdGxlICAgICAg
ICAgICAgICAgICAgICAgICBEZXB0LiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDb21w
YW55ICAgICAgICAgICAgICAgIA0KICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogICAgICBtY2dyb2ZAa2Vy
bmVsLm9yZyAgICAgICAgICAgICAgVE8NCiAgICAgIGF2aW1hbGluQGdtYWlsLmNvbSAgICAgICAg
ICAgICBDQw0KICAgICAgTWFuaW5kZXIgU2luZ2ggICAgICAgICAgICAgICAgIENDICAgICAgICAg
U3RhZmYgRW5naW5lZXIgICAgICAgICAgICAgU3lzdGVtIFMvVyBHcm91cCAvU1JJLURlbGhpICAg
ICAgICAgICAgICAgU2Ftc3VuZ8KgRWxlY3Ryb25pY3PCoA0KICAgICAgcm9zdGVkdEBnb29kbWlz
Lm9yZyAgICAgICAgICAgIENDDQogICAgICBzZW5vemhhdHNreUBjaHJvbWl1bS5vcmcgICAgICAg
Q0MNCiAgICAgIGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmkuLi4gICBDQw0KICAgICAgbGludXhA
cmFzbXVzdmlsbGVtb2VzLmRrICAgICAgIENDDQogICAgICBha3BtQGxpbnV4LWZvdW5kYXRpb24u
b3JnICAgICAgQ0MNCiAgICAgIHdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tICAgICBDQw0KICAg
ICAgbWJlbmVzQHN1c2UuY3ogICAgICAgICAgICAgICAgIENDDQogICAgICBzd2JveWRAY2hyb21p
dW0ub3JnICAgICAgICAgICAgQ0MNCiAgICAgIG9qZWRhQGtlcm5lbC5vcmcgICAgICAgICAgICAg
ICBDQw0KICAgICAgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyAgIENDDQogICAgICB3aWxs
QGtlcm5lbC5vcmcgICAgICAgICAgICAgICAgQ0MNCiAgICAgIGNhdGFsaW4ubWFyaW5hc0Bhcm0u
Y29tICAgICAgICBDQw0KICAgICAgVmFuZWV0IE5hcmFuZyAgICAgICAgICAgICAgICAgIENDICAg
ICAgICAgQXNzb2NpYXRlIEFyY2hpdGVjdCAgICAgICAgU3lzdGVtIFMvVyBHcm91cCAvU1JJLURl
bGhpICAgICAgICAgICAgICAgU2Ftc3VuZyBFbGVjdHJvbmljcw0KICAgICAgYXRvbWxpbkByZWRo
YXQuY29tICAgICAgICAgICAgIENDDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg==

------=_Part_2691558_779447602.1644482903367--
