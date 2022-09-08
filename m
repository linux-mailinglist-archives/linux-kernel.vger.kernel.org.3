Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798375B20D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiIHOjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiIHOjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:39:13 -0400
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDF2EB84A;
        Thu,  8 Sep 2022 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1087; q=dns/txt; s=iport;
  t=1662647946; x=1663857546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8NCt0KDXjpoYpVNujujYHgf2bPDgDdq5z15sk5PL364=;
  b=K1+sS1g6CN1MqBI9TCNzfQVObB0Zqe7HQK0exVuvXJAhOwMsFkQeXwrS
   FYn2oYng6NwCRlIqWDbRmINsp9ILD0K896KcRs9Oq+F/K4YAII9LLgxMC
   zE8gvzM/NWqVkscKA+D5LPeLRGOtFoyeUiYlhplbhMCPIoEKUwsOkEDCg
   o=;
X-IPAS-Result: =?us-ascii?q?A0ANAABH/RljmJNdJa1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYMkVT5FA4xqhkyCKJFgiyiBJQNUCwEBAQ0BATkJBAEBgVODMgKEZ?=
 =?us-ascii?q?gIlNAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQcEFAEBAQEBAQEBHRkFD?=
 =?us-ascii?q?hAnhWgNhkMBAgM6PxALGC5XBhOCfQGDIAMQpjd4gTOBAYNQAYRMgV8GFBCBG?=
 =?us-ascii?q?QGQHiccgUlEhAg3PohRggwiBJdwNwNFHkIDC0I1GAMUAwUkBwMZDyMNDQQWB?=
 =?us-ascii?q?wwDAwUlAwICGwcCAgMCBhUFAgJNOAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWA?=
 =?us-ascii?q?gYEBAQEFQIQCAIIJhcHEzMZAQVZEAkhHA4aDQUGEwMgbQVFDygyNTkrHRsKg?=
 =?us-ascii?q?Q4qKBUDBAQDAgYTAwMiAhAsMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJ?=
 =?us-ascii?q?jwHWToBBAMDECI9BgMJAwIkE0eBOSgFAw8ZlyOCTlIrIIJXommdH4E1g1yBR?=
 =?us-ascii?q?olnlGFMEahkLZZajTmaAAIEBgUCFoFhOoFbMxoIGxWCbgEBMhM+GQ+OOYhth?=
 =?us-ascii?q?WokMQIBOAIGCwEBAwmKUgEB?=
IronPort-Data: A9a23:2am4p6i9A6Xi3RsXr9gjnN9wX161ihAKZh0ujC45NGQN5FlHY01je
 htvWWHVO/6PZzOhfY0ibI6/8EwO68WAyIQySAZtqSozE3hjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+lH1dOKJQUBUjclkfJKkYAL/En03FFQMpBsJ00o5wbZo2t4w27BVPivU0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pDTU2FFEYUd6EPdgKMq
 0kv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOjzAazhHe3JrXO9IaMll1mgyplexLi
 49Cn6KdagolHo3lzbF1vxlwS0mSPIVc87PBZHO4q8HWlhSAeHr3yPIoB0YzVWEa0r8oWicVq
 rpJc3ZUMk/ra+GemNpXTsFgj8IiIc30NasUu2prynfSCvNOrZXrEv+VuoAGjWlh7ixINcTzd
 c0iRGFDVTDJQhh9HFgcWJURxvj90xETdBUB+A7K+sLb+VP7yA13zaioM9fPfNGObdtak1zep
 W/c+Wn9RBYAO7S3zTuD72LpheXSnCf3cJwdGaf+9fNwhlCXgGsJB3U+U1e2uvCkjki/VshEA
 0MT/SUqoO4580nDZtz8VB2xpDiAvRsYc99ZCe499gDLzKfIiy6cD3MNTj9bb80Ot8IsQzEuk
 FiTkLvU6SdHqraZTzeW8a2Z6GrrfyMUNmQFIyQDSGPp/uUPvqk11QztX+9DGpKPzYf6Mw/d4
 D2GjAgX0uB7YdEw6423+lXOgjSJr5fPTxIo6gi/Yo5Dxl4iDGJCT9H1gWU3/cqsP67CFAjd4
 yJsd9y2qbFQUsnXy0RhVc1XRNmUC+C53CowaLKFN6Mg/DSk4XK4eoY4DNpWexoxYp9sldMEn
 CbuVe55/pRfOj6harV6JtvoTc8r1qPnU9/iU5g4j+aigLAsJWdrHwk3NSZ8OlwBdmB3zcnT3
 r/ALa6R4Y4yU/gP8dZPb751PUUX7i4/33jPYpvw0g6q17GTDFbMF+lfbQTTMrtisvLbyOkwz
 zq5H5bao/m4eLCuChQ7DaZPRbz3BSFhXMuv+5A/mhCre1Y6SAnN9MM9MZt4K9A6wMy5Z8/D/
 2q2XQdD2UHjiHjcQThmmVg9AI4Dqa1X9CphVQR1ZA7A8yF6Pe6HsvxFH7NpJuZPyQCW5aMuJ
 xXzU5/eUq0np/Wu02l1UKQRW6Q4L0321FnUYnT9CNX9FrY5LzH0FhbfVlOH3EEz4uCf7KPSf
 5XIOtvnfKc+
IronPort-HdrOrdr: A9a23:z4M1cauNnmr+pW9bnrYxFoWj7skDTdV00zEX/kB9WHVpmwKj+P
 xGuM5rsCMc6QxhOk3I9urrBEDtex7hHNtOkO0s1NSZLWrbUQmTTb2KhLGKq1bd8m/FltK1vp
 0PT0ERMrHN5HFB/KHHCM3SKadY/DFBm5rY49vj8w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="927776969"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Sep 2022 14:39:03 +0000
Received: from zorba ([10.25.130.54])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 288Ecxgh010907
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 8 Sep 2022 14:39:01 GMT
Date:   Thu, 8 Sep 2022 07:38:59 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        xe-linux-external@cisco.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC-PATCH] Makefile: dts: include directory makefile for
 DTC_FLAGS
Message-ID: <20220908143859.GF4320@zorba>
References: <20220907230339.271633-1-danielwa@cisco.com>
 <CAK7LNAQSUkWz9hvEmB1wSCMJ0Do209QZOgAxO=oSK6HQa7XgTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQSUkWz9hvEmB1wSCMJ0Do209QZOgAxO=oSK6HQa7XgTg@mail.gmail.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.130.54, [10.25.130.54]
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 04:08:06PM +0900, Masahiro Yamada wrote:
> On Thu, Sep 8, 2022 at 8:03 AM Daniel Walker <danielwa@cisco.com> wrote:
> >
> > The current Makefile will drop the DTC_FLAGS depending on how you
> > build. For example,
> >
> > make dtbs
> >
> > includes correct DTC_FLAGS. However if you run,
> >
> > make nvidia/tegra210-p2371-2180.dtb
> >
> > The DTC_FLAGS are dropped. This appears to be caused by the top level
> > Makefile not including the Makefile from the directory where the dts lives.
> >
> > This normally doesn't matter because most dts files have nothing added
> > from the Makefile. This changes when you have overlays, and the
> > DTC_FLAGS modifier is mandatory for the dtb to work correctly.
> 
> 
> I recently fixed another issue of single target builds.
> https://patchwork.kernel.org/project/linux-kbuild/patch/20220906061313.1445810-2-masahiroy@kernel.org/
> 
> 
> It fixed your issue as well.
> 
> 

Yeah, it fixes the issue I was seeing. Are you planning to resubmit this or is
the v2 the final version ?

Daniel
