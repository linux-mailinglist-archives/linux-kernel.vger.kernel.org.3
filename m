Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3374F1D9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378763AbiDDVj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380495AbiDDUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:20:07 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A169F33EB0;
        Mon,  4 Apr 2022 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1649103490; i=@motorola.com;
        bh=HjU38nkBnog1s1+qEhVPWweGItlXZ0yZ/MkTX/2KKcY=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=JgxHpzXeRX/rEomq+ceeQwd2OF5dFASmLTkx26pv8MT/4AIPg2vezlmBGGVygv/vH
         Xuj107OJZxTk7rmVjlPemvaM/2sh5VM1ySvmszMxkmleGDFAEJiq+eUN0cmr8ECHpc
         MetP6tMMHy7ALrwmcvUgCeB8XEpQ4UeuYeTx3t5e4D+tkPGqJAiAEvUPwB+BBXCNQX
         cyQZcmWmuDB2aBB4kGyQkiBfs24F6S67m5XZgdiQnW7k5fmwqoPff8PlO7ikr/+Re7
         +krbywpJyYX2Ycx/952q25W/Kh3OjAzE7kqy/DvXFrPJp1U7nKy3+eKRIzjuM2RuYq
         y97Vjl0zUU/4A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRWlGSWpSXmKPExsUyYU+Ds25jkHe
  SQfNsIYupjYwWx9qesFvM2Rxt8eRAO6NF8+L1bBadE5ewWyxsW8JicXnXHDaLRctamS0ezr7K
  aPH2znQWB26PnbPusnvM7pjJ6rF5hZbHplWdbB77565h91jcN5nV4/MmOY9D29+wBXBEsWbmJ
  eVXJLBmPP5XWPCDr+L73z2sDYzTeLoYuTiEBKYxSey985wZwlnEJPFh+gGmLkZODhYBFYlN3T
  +ZQWw2ATWJBa9XgdkiAhoSJzf/YAexmQX+M0l0f3QBsYUFQiVmTp7ECGLzCihLnH54khXEFhL
  IlJizv5cFIi4ocXLmExaIXi2JG/9eAu3iALKlJZb/4wAJcwrYSrx9tIxlAiPvLCQds5B0zELo
  WMDIvIrRJqkoMz2jJDcxM0fX0MBA19DQBEgb6hoZGuolVukm6pUW65anFpfoGukllhfrpRYX6
  xVX5ibnpOjlpZZsYgRGR0pR6uUdjDP6f+odYpTkYFIS5T3j6p0kxJeUn1KZkVicEV9UmpNafI
  hRhoNDSYL3uy9QTrAoNT21Ii0zBxipMGkJDh4lEV5xR6A0b3FBYm5xZjpE6hSjopQ4768AoIQ
  ASCKjNA+uDZYcLjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5tUHmcKTmVcCN/0V0GImoMXv
  zniCLC5JREhJNTBN+mQj6qo1jWcfS8ycCd8Y/l5U3bTD+I1lWOmHB1aS8TPPPdlyUGDri+UZb
  /4uiuQ/KVK2cKqYy6EJ0wI6v31RPxL7osRe/EP5rBLV8xl/NJze+WzuiZIy5YrWsdr1Sbvf+v
  GH37dnF6adMpmwLfmHnEvxue/K1yutJF5H2mk8rvTpbbM8sds7/MaVLwGr2Bdv1xHa69jJvEa
  Q/Sbf46lb43WCFrDks2cI73E0uZ+90X922pdjU++0v1lwpv3bot4IJjn7K0v4Gm3unTj+5NKf
  ZTPmMzuLFgdrpPs0yJstuaiww+PLabfWZSyKMyyz93qkf7hxdy+rvxT791cqF8UOq6d9kfidv
  PyJ0A6BL6yxSizFGYmGWsxFxYkAbteYz4kDAAA=
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-15.tower-636.messagelabs.com!1649103488!14751!1
X-Originating-IP: [144.188.128.67]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1481 invoked from network); 4 Apr 2022 20:18:09 -0000
Received: from unknown (HELO ilclpfpp01.lenovo.com) (144.188.128.67)
  by server-15.tower-636.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Apr 2022 20:18:09 -0000
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4KXMXb5SCYzfBZq;
        Mon,  4 Apr 2022 20:18:07 +0000 (UTC)
Received: from p1g3 (unknown [10.45.5.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4KXMXb19QPzf6f0;
        Mon,  4 Apr 2022 20:18:07 +0000 (UTC)
Date:   Mon, 4 Apr 2022 15:17:48 -0500
From:   Dan Vacura <w36195@motorola.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Carlos Bilbao <bilbao@vt.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: allow changing interface name via
 configfs
Message-ID: <YktSbDcPLhaUycE+@p1g3>
References: <20220401160447.5919-1-w36195@motorola.com>
 <f4377408-ace7-a041-084f-5863bcfb7184@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4377408-ace7-a041-084f-5863bcfb7184@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 01:13:02PM +0700, Bagas Sanjaya wrote:
> On 01/04/22 23.04, Dan Vacura wrote:
> > Add a configfs entry, "function_name", to change the iInterface field
> > for VideoControl. This name is used on host devices for user selection,
> > useful when multiple cameras are present. The default will remain "UVC
> > Camera".
> > 
> > Signed-off-by: Dan Vacura <w36195@motorola.com>
> > ---
> > Changes in v2:
> > - remove stable cc
> > 
> >   .../ABI/testing/configfs-usb-gadget-uvc       |  1 +
> >   Documentation/usb/gadget-testing.rst          |  1 +
> >   drivers/usb/gadget/function/f_uvc.c           |  4 +-
> >   drivers/usb/gadget/function/u_uvc.h           |  1 +
> >   drivers/usb/gadget/function/uvc_configfs.c    | 41 +++++++++++++++++++
> >   5 files changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> > index 889ed45be4ca..611b23e6488d 100644
> > --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
> > +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> > @@ -7,6 +7,7 @@ Description:	UVC function directory
> >   		streaming_maxburst	0..15 (ss only)
> >   		streaming_maxpacket	1..1023 (fs), 1..3072 (hs/ss)
> >   		streaming_interval	1..16
> > +		function_name		string [32]
> >   		===================	=============================
> 
> Since you mention that default function_name is "UVC Camera", why don't you
> mention it in the documentation?

Good question. The rest of the file didn't contain any default values
and I wasn't sure what the process is for keeping things like this in
sync between source and documentation. Looking through most of the other
usb function files I don't see any mention of the hardcoded default
values either, so maybe it's intentional to not include.

> 
> -- 
> An old man doll... just what I always wanted! - Clara
