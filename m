Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470E1579263
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiGSFXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiGSFXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:23:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52C029C9F;
        Mon, 18 Jul 2022 22:23:10 -0700 (PDT)
X-UUID: 4e8846fb173b4eccb21f85352c42b6a4-20220719
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:24a99d57-fe52-4693-b06a-2ab937f7a3d0,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:0229dbd7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4e8846fb173b4eccb21f85352c42b6a4-20220719
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2079981862; Tue, 19 Jul 2022 13:23:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 19 Jul 2022 13:23:06 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 19 Jul 2022 13:23:06 +0800
Message-ID: <2893728a294ef13bdeba9e587083b82fb794cc68.camel@mediatek.com>
Subject: Re: [for-next][PATCH 13/23] USB: mtu3: tracing: Use the new
 __vstring() helper
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue, 19 Jul 2022 13:23:06 +0800
In-Reply-To: <20220715173944.386743d8@gandalf.local.home>
References: <20220714164256.403842845@goodmis.org>
         <20220714164330.311734558@goodmis.org>
         <1267b234b09280b9b475cfe2bb32580e967e2dac.camel@mediatek.com>
         <20220715173944.386743d8@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-15 at 17:39 -0400, Steven Rostedt wrote:
> On Fri, 15 Jul 2022 14:32:05 +0800
> Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> 
> > Can you help to remove macro "MTU3_MSG_MAX" and one blank line
> > after it
> > in this file, this macro is not used anymore after apply this
> > patch.
> 
> Care to send me a patch, and I'll just include it in my series?
Seems no need add another patch, just modify this patch as below:

diff --git a/drivers/usb/mtu3/mtu3_trace.h
b/drivers/usb/mtu3/mtu3_trace.h
index a09deae1146f..03d2a9bac27e 100644
--- a/drivers/usb/mtu3/mtu3_trace.h
+++ b/drivers/usb/mtu3/mtu3_trace.h
@@ -18,18 +18,16 @@

 #include "mtu3.h"

-#define MTU3_MSG_MAX   256
-
 TRACE_EVENT(mtu3_log,
        TP_PROTO(struct device *dev, struct va_format *vaf),
        TP_ARGS(dev, vaf),
        TP_STRUCT__entry(
                __string(name, dev_name(dev))
-               __dynamic_array(char, msg, MTU3_MSG_MAX)
+               __vstring(msg, vaf->fmt, vaf->va)
        ),
        TP_fast_assign(
                __assign_str(name, dev_name(dev));
-               vsnprintf(__get_str(msg), MTU3_MSG_MAX, vaf->fmt, *vaf-
>va);
+               __assign_vstr(msg, vaf->fmt, vaf->va);
        ),
        TP_printk("%s: %s", __get_str(name), __get_str(msg))
 );
> 

remove below two lines
"
-#define MTU3_MSG_MAX   256
-
"
Thanks

> -- Steve

