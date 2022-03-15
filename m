Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175E34D99AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiCOKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347088AbiCOKwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:52:46 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254AB546AB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:50:20 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220315105015epoutp01ec82718572f51e6fe159c0b8da958d60~ciEodiHoJ1501015010epoutp01b
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:50:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220315105015epoutp01ec82718572f51e6fe159c0b8da958d60~ciEodiHoJ1501015010epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647341415;
        bh=ZuWevzFbsYXHUriHDZz7Wc7bDh940s8Anu63SP7PMd0=;
        h=Date:Subject:Reply-To:From:To:CC:In-Reply-To:References:From;
        b=QJIpk+Z5evyvNHyvPlLMtmxyImuK0l0aXTJPMlF8K/Oyj6AHZr+/JuUjBYOFG6LEw
         YlzgbbKsOFZwvjwrVaVLWWqWq8TbrzuYSXfiws3aiBKo+RwYs9qP6hl2HWvdKtg+ee
         3PVnKERnDAUK6Z4Kmak6z2zcSSsdWLB3FrhkkYgM=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220315105014epcas5p2bbd6aeceef18a1c902373292adb453a6~ciEnGu74o2259822598epcas5p2S;
        Tue, 15 Mar 2022 10:50:14 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-c9-62306f661045
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.9D.06423.66F60326; Tue, 15 Mar 2022 19:50:14 +0900 (KST)
Date:   Tue, 15 Mar 2022 16:17:40 +0530
Message-ID: <2032885049.3816543.1647341260934@mail-kr5-2>
Mime-Version: 1.0
Subject: RE: [PATCH v2] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>,
        "atomlin@redhat.com" <atomlin@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YjBq1jg9cNgEqB8T@smile.fi.intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20220315104740epcms5p57da63ebd61283cd7c41025aa3fb47103
Content-Type: multipart/mixed;
        boundary="----=_Part_3816542_2122723889.1647341260934"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTXTct3yDJYEU7m8Wc9WvYLHqbpjNZ
        HJm/htXiwcHr7BaXd81hs2iY/Z3V4vGseWwWNyY8ZbRYOX85o8X/x19ZLfZ1PGCy2L1xEZvF
        8TtPmSwOnZzLaNH4+T6jA7/H7IaLLB47Z91l92jZdwtIHHnL6rFpVSebx4kZv1k85p0M9LjQ
        le3xft9VNo++LasYPdZvucri8XmTXABPFJdNSmpOZllqkb5dAlfG/O/b2QueaVRsejufpYHx
        iVIXIyeHhICJxO3PfUxdjFwcQgK7GSU2r7zOApJgEVCVOPLmOjOIzStgKfFl91ugOAeQLSjx
        d4cwSFhYIFziwpMZbCC2kICixIUZaxhBSoQFDCR+bdUACbMJ6Ems2rUHbKKIgLnEukmL2EBW
        MQscZZXobdrLBnEDr8SM9qcsELa0xPblWxlBbE4BI4lny74xQcRFJW6ufssOY78/Np8RwhaR
        aL13lhnCFpR48HM3VFxGYvXmXhaQZRIC3YwS69/thXJmMEr0PJoG1WEusX7JKnaQqyUEXCRu
        LgJrZgZ6bPas+1CLZSWmnlrHBBHnk+j9/YQJ5ugd82BsVYmWmxtYYR74/PEj1DMeEtM29DFD
        Ancto8SJZx8YJzDKz0KE4ywk6yBseYntb+cwg5QwC2hKrN+lDxFWk5jS/4UNwjaTaGifygJh
        K0pM6X7IvoCRfRWjZGpBcW56arFpgWFearlecWJucWleul5yfu4mRnAS1fLcwXj3wQe9Q4xM
        HIyHGFWA2h9tWH2BUYolLz8vVUmE98wL/SQh3pTEyqrUovz4otKc1OJDjNIcLErivKfTNyQK
        CaQnlqRmp6YWpBbBZJk4OKUamKaWv8qT1P/kzlJypV586ZSapzwabL/Tkj4xpOm7dKcF5C9s
        vDc5q3JZiM1jia1W5zWlAvbcqPPXvhNxhNEnn1v5/imbpOPKQfcitALTl5nMvDf/4n+jKd2f
        v3T2vF304PlFe/2VBsWKYVPe1ghceMmx0nh5/GUXrTsbZGPqHupNOW7RPWljz4XOttq3PUf/
        vTE12iBzLldxTcfVJva0KVNvzbare9MrvOjUlJVvN53I3cZ3taOsfF4Oz7JpuYGxIk/0+BYq
        pUbPPnan5PueX7xs3T4RbT0vNr/YNyHsV3HsK7U1z6J4w2yeiuYt5TLlvXKiIsv+xSJv9hZf
        zY+Bj/0esijuVMo7Ov3zyriJEkosxRmJhlrMRcWJAEenAGMdBAAA
X-CMS-RootMailID: 20220315095129epcas5p230b94ea10517d148c9cae0669229b0fc
References: <YjBq1jg9cNgEqB8T@smile.fi.intel.com>
        <20220315095112.439580-1-maninder1.s@samsung.com>
        <CGME20220315095129epcas5p230b94ea10517d148c9cae0669229b0fc@epcms5p5>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3816542_2122723889.1647341260934
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

Hi,

> > +int sprint_kallsym_common(char *buffer, unsigned long address, int build_id,
> > +			    int backtrace, int symbol)
> > +{
> > +	if (backtrace)
> > +		return __sprint_symbol(buffer, address, -1, 1, build_id);
> 
> > +	else if (symbol)
> > +		return __sprint_symbol(buffer, address, 0, 1, build_id);
> > +	else
> > +		return __sprint_symbol(buffer, address, 0, 0, 0);
> 
> Redundant 'else' in both cases.
>

Ok, will change it

> > +}
> 
> ...
> 
> > +static int sprint_module_info(char *buf, char *end, unsigned long value,
> > +			     const char *fmt, int modbuildid, int backtrace, int symbol)
> 
> fmt is not used.

Yes, did not notice it.(will remove both end and gmt)

> > +{
> > +	struct module *mod;
> > +	unsigned long offset = 0;
> 
> > +	unsigned long base;
> 
> Can it be the same type as core_layout.base? Why not?
>
> > +	char *modname;
> > +	int len;
> > +	const unsigned char *buildid = NULL;
> > +
> > +	if (is_ksym_addr(value))
> > +		return 0;
> > +
> > +	if (backtrace || symbol)
> > +		offset = 1;
> 
> I would expect here to have
> 
> 	else
> 		offset = 0;
> 
> But see below.
> 
> > +	preempt_disable();
> > +	mod = __module_address(value);
> > +	if (mod) {
> > +		modname = mod->name;
> > +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> > +		if (modbuildid)
> > +			buildid = mod->build_id;
> > +#endif
> 
> > +		if (offset) {
> 
> This seems quite confusing because semantically you use offset as a boolean
> flag and offset. Why not add a boolean variable with a clear name?
>

Ok, will add 2 separate variables.

> > +			base = (unsigned long)mod->core_layout.base;
> > +			offset = value - base;
> > +		}
> > +	}
> 
> > +
> 
> Probably you can drop this blank line to group entire critical section,
> or add a blank line above.
> 
> > +	preempt_enable();
> > +	if (!mod)
> > +		return 0;
> > +
> > +	/* address belongs to module */
> > +	if (offset)
> > +		len = sprintf(buf, "0x%p+0x%lx", (void *)base, offset);
> > +	else
> 
> > +		len = sprintf(buf, "0x%lx", (void *)value);
> 
> What this casting is for? Don't you have a compilation warning?

My Bad, earlier I made patch with hashing this value also (%p), but after that
changed it to %lx to have same original behavior in case of %ps, forgot to update final patch
to remove typecast.

> 
> > +	len += fill_name_build_id(buf, modname, modbuildid, buildid, len);
> > +	return len;
> 
> 	return len + ...;
> 
> ?
> 
> > +}

Will modify patch with all changes.

Thanks,
Maninder Singh
------=_Part_3816542_2122723889.1647341260934
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBSZTogW1BBVENIIHYyXSBr
YWxsc3ltczogZW5oYW5jZSAlcFMvcy9iIHByaW50aW5nIHdoZW4gS0FMTFNZU01TIGlzIGRpc2Fi
bGVkDQogICAgICBGcm9tICAgICAgIDogbnVsbA0KICAgICAgU2VudCBEYXRlICA6IDIwMjItMDMt
MTUgMTY6MDIgIEdNVCs1OjMwDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgICAgICAgICAgICAg
IE5hbWUgICAgICAgICAgICAgICAgVHlwZSAgICAgICAgICBKb2IgVGl0bGUgICAgICAgICAgICAg
ICAgICAgICAgIERlcHQuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENvbXBhbnkgICAg
ICAgICAgICAgICAgDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIE1hbmluZGVyIFNpbmdoICAg
ICAgICAgICAgICAgICBUTyAgICAgICAgIFN0YWZmIEVuZ2luZWVyICAgICAgICAgICAgIFN5c3Rl
bSBTL1cgR3JvdXAgL1NSSS1EZWxoaSAgICAgICAgICAgICAgIFNhbXN1bmfCoEVsZWN0cm9uaWNz
wqANCiAgICAgIG1jZ3JvZkBrZXJuZWwub3JnICAgICAgICAgICAgICBDQw0KICAgICAgcG1sYWRl
a0BzdXNlLmNvbSAgICAgICAgICAgICAgIENDDQogICAgICByb3N0ZWR0QGdvb2RtaXMub3JnICAg
ICAgICAgICAgQ0MNCiAgICAgIHNlbm96aGF0c2t5QGNocm9taXVtLm9yZyAgICAgICBDQw0KICAg
ICAgbGludXhAcmFzbXVzdmlsbGVtb2VzLmRrICAgICAgIENDDQogICAgICBha3BtQGxpbnV4LWZv
dW5kYXRpb24ub3JnICAgICAgQ0MNCiAgICAgIHdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tICAg
ICBDQw0KICAgICAgVmFuZWV0IE5hcmFuZyAgICAgICAgICAgICAgICAgIENDICAgICAgICAgQXNz
b2NpYXRlIEFyY2hpdGVjdCAgICAgICAgU3lzdGVtIFMvVyBHcm91cCAvU1JJLURlbGhpICAgICAg
ICAgICAgICAgU2Ftc3VuZyBFbGVjdHJvbmljcw0KICAgICAgc3dib3lkQGNocm9taXVtLm9yZyAg
ICAgICAgICAgIENDDQogICAgICBvamVkYUBrZXJuZWwub3JnICAgICAgICAgICAgICAgQ0MNCiAg
ICAgIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgICBDQw0KICAgICAgbGludXgtbW9kdWxl
c0B2Z2VyLmtlcm5lbC4uLiAgIENDDQogICAgICBhdmltYWxpbkBnbWFpbC5jb20gICAgICAgICAg
ICAgQ0MNCiAgICAgIGF0b21saW5AcmVkaGF0LmNvbSAgICAgICAgICAgICBDQw0KICAgPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo=

------=_Part_3816542_2122723889.1647341260934--
