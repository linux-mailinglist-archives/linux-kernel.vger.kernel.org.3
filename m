Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF458575EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiGOKCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiGOKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:01:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D2820E2;
        Fri, 15 Jul 2022 03:01:52 -0700 (PDT)
X-UUID: e1c9e414b54a42229a9da0864b48474c-20220715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:7f7a5a44-ee65-407c-8b52-013836a82498,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:42321533-b9e4-42b8-b28a-6364427c76bb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e1c9e414b54a42229a9da0864b48474c-20220715
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1999131225; Fri, 15 Jul 2022 18:01:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 15 Jul 2022 18:01:44 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 15 Jul 2022 18:01:44 +0800
Message-ID: <962e59c25e981676014157cd111db9e16e237339.camel@mediatek.com>
Subject: Re: [for-next][PATCH 13/23] USB: mtu3: tracing: Use the new
 __vstring() helper
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri, 15 Jul 2022 18:01:44 +0800
In-Reply-To: <20220714164330.311734558@goodmis.org>
References: <20220714164256.403842845@goodmis.org>
         <20220714164330.311734558@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-14 at 12:43 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of open coding a __dynamic_array() with a fixed length (which
> defeats the purpose of the dynamic array in the first place). Use the
> new
> __vstring() helper that will use a va_list and only write enough of
> the
> string into the ring buffer that is needed.
> 
> Link: 
> https://urldefense.com/v3/__https://lkml.kernel.org/r/20220705224750.354926535@goodmis.org__;!!CTRNKA9wMg0ARbw!w8nx66BKDTtyusp5i2pyzOGNb-QyxIAWjoZwmSQY0zzor_rqvBgUm5__vKK98ApKcDic$
>  
> 
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/usb/mtu3/mtu3_trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_trace.h
> b/drivers/usb/mtu3/mtu3_trace.h
> index 1b897636daf2..ef3c17e2f8a6 100644
> --- a/drivers/usb/mtu3/mtu3_trace.h
> +++ b/drivers/usb/mtu3/mtu3_trace.h
> @@ -25,11 +25,11 @@ TRACE_EVENT(mtu3_log,
>  	TP_ARGS(dev, vaf),
>  	TP_STRUCT__entry(
>  		__string(name, dev_name(dev))
> -		__dynamic_array(char, msg, MTU3_MSG_MAX)
> +		__vstring(msg, vaf->fmt, vaf->va)
>  	),
>  	TP_fast_assign(
>  		__assign_str(name, dev_name(dev));
> -		vsnprintf(__get_str(msg), MTU3_MSG_MAX, vaf->fmt, *vaf-
> >va);
> +		__assign_vstr(msg, vaf->fmt, vaf->va);
>  	),
>  	TP_printk("%s: %s", __get_str(name), __get_str(msg))
>  );

After apply this patch, encounter an issue, please check it

 irq/254-1120100-137     [000] d..1.   266.549473: mtu3_u2_common_isr:
(00000004)   RESET
 irq/254-1120100-137     [000] d..1.   266.629399: mtu3_log:
11201000.usb: link speed super-speed
 irq/254-1120100-137     [000] d..1.   266.629662: mtu3_log:
11201000.usb: ep0_state SETUPr-speed
 irq/254-1120100-137     [000] d..1.   266.629668: mtu3_handle_setup:
setup - 00 05 001c 0000 0000
 irq/254-1120100-137     [000] d..1.   266.629722: mtu3_log:
11201000.usb: ep0_state SETUPr-speed

without this patch:
 irq/254-1120100-135     [000] d..1.  1407.425550: mtu3_u2_common_isr:
(00000004)   RESET
 irq/254-1120100-135     [000] d..1.  1407.475295: mtu3_log:
11201000.usb: link speed super-speed
 irq/254-1120100-135     [000] d..1.  1407.477469: mtu3_log:
11201000.usb: ep0_state SETUP
 irq/254-1120100-135     [000] d..1.  1407.477476: mtu3_handle_setup:
setup - 00 05 001f 0000 0000
 irq/254-1120100-135     [000] d..1.  1407.477518: mtu3_log:
11201000.usb: ep0_state SETUP

the second and third lines with this patch:
 irq/254-1120100-137     [000] d..1.   266.629399: mtu3_log:
11201000.usb: link speed super-speed

 irq/254-1120100-137     [000] d..1.   266.629662: mtu3_log:
11201000.usb: ep0_state SETUPr-speed

"r-speed" seems the remain of last log;





