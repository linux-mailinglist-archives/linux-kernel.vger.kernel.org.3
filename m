Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2855B115B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIHAgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiIHAfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:35:44 -0400
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1714FD1E36;
        Wed,  7 Sep 2022 17:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1404; q=dns/txt; s=iport;
  t=1662597317; x=1663806917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RIBVDKUd2eWG+7DSM2KXpHjUNSr7Biv7xJk7pancMFY=;
  b=cxCb0WJakiVAFJrWNjnbrhc9mdKfs0O+bELP/V/ZtaQSVPcmVtty3mUv
   vLoMoh5zVr7GZeN6aVmvmo2YskdDq0jPTpAlN48dbQ9sDMGKltVi2yBF3
   LWoxg3ErfuBiboOHXKVs9eXq6HNcmiMjxG9nUKNawa5Nn/j0tcmQUYRjf
   c=;
X-IPAS-Result: =?us-ascii?q?A0AFAABXOBljmJNdJa1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYN5PkWMbYZMgiUDgROQS4snFIERA1QLAQEBDQEBQgQBA?=
 =?us-ascii?q?YUGAoRlAiU0CQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwQUAQEBAQEBA?=
 =?us-ascii?q?QEdGQUOECeFdYZDAQIDJxM/EAsOCi5XBhOCfYMhA6YReIEBMoEBiB2BZRQQg?=
 =?us-ascii?q?RkBkB4nHIFJRIEVgnM3PoQLH4Qngi4El183A0UeQgMLQzYYAxQDBSQHAxkPI?=
 =?us-ascii?q?w0NBBYHDAMDBSUDAgIbBwICAwIGFQUCAk04CAQIBCskDwUCBy8FBC8CHgQFB?=
 =?us-ascii?q?hEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBVkQCSEcDhoNBQYTAyBtBUUPKDI1O?=
 =?us-ascii?q?SsdGwqBDiooFQMEBAMCBhMDAyACECwxFAQpExItBytzCQIDImcFAwMEKCwDC?=
 =?us-ascii?q?SEfBygmPAdZOgEEAwMQIj0GAwkDAiRagTwrBQMQGZkHexOBcaIEghWeVINcg?=
 =?us-ascii?q?UaeSEwRqGWXB6JdhFsCBAYFAhaBYTqBWzMaCBsVgyJRGQ+OOY5XJDE7AgYLA?=
 =?us-ascii?q?QEDCYgKgkgBAQ?=
IronPort-Data: A9a23:x/Uc1KjXQFnoVdVdklJ3fwsCX161lBAKZh0ujC45NGQN5FlHY01je
 htvWjvQPv6OZTb0LthyOoy38xlS6J7SnYJmSQFury42Fn5jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+lH1dOKJQUBUjclkfJKkYAL/En03FFQMpBsJ00o5wbZo2tEw3LBVPivU0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pDTU2FFEYUd6EPdgKMq
 0kv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOjzAazhHe3JrXO9I/NAB3shy4luxb4
 /kSvpifZCIABpzDzbF1vxlwS0mSPIVc87PBZHO4q8HWlhSAeHr3yPIoB0YzVWEa0r8oWicVq
 rpJc3ZUMk/ra+GemNpXTsFgj8IiIc30NasUu2prynfSCvNOrZXrEv6TvIMEgmZp7ixINfz5Z
 usrVCRrVg3FRUFSHV1KGbgMn9790xETdBUB+A7K+sLb+VP7yA13zaioM9fPfNGObdtak1zep
 W/c+Wn9RBYAO7S3xTeb83mhmvXCkAvlV48IUr617PhnhBuU3GN7IAcRX1v4reWRiUOkXd9bb
 UsO9UIGtaE06EGvT8K7Vhukp3iFuQM0WN1WCPA+6wbLwa3Riy6XHG8bRzhNLtgnr9MeSjkj1
 1vPlNTsbQGDq5WPQn6bs7yTtz73YHFTJm4ZbihCRgwAizX+nG0tpjGSCfZaOZ+8svfeNW77x
 x+niQEGtrpG2KbnyJ6H1VzAhjutoL3AQQg0+hjbUwqZAuVROdXNi2uAtAWz0BpQEGqKZgLb7
 SRbwaBy+MhLXM/SzHbSKAkYNOvxj8tpJgEwlrKG83MJzTWm+3e5cZtX5lmSz282b55UIFcFj
 KIv0D69CbdJN3esKKRweY/0Up1sxqn7HtOjXffRBjavXnSTXFLWlM2NTRfAt4wIrKTKufpjU
 Xt8WZ3wZUv28Yw9kFKLqx41iNfHPBwWy2LJXozcxB+6y7eYb3P9Ye5bbgHTMb1lt/ja8Vq9H
 zNj2y2ilkU3vArWP3m/zGLvBQxiwYUTXMqv8JUHKoZv3CI/RD1xYxMu/V/RU9U1w/sK/gs51
 nq8QURfgEHunmHKLB7iV5yQQO2HYHqLllpiZXZEFQ/xgxALON/zhI9BLMFfVed8q4ReIQtcE
 qNtlzOoWKofE1wqOl01MPHAkWCVXE3z2lrVZXT1OGNXklwJb1Whx+IItzDHrEEmZhdbf+Nuy
 1F8/ms3maY+ejk=
IronPort-HdrOrdr: A9a23:an81FqmNaqI7eoayaflwmlnZSE3pDfIX3DAbv31ZSRFFG/FwWf
 rAoB0+726QtN9xYgBDpTnuAsO9qB/nmKKdpLNhWYtKPzOW21dATrsC0WKK+VSJcBEWtNQ86U
 4KScZD4bPLYWSSpPyKhzVR170bsaC6GGfCv5a580tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,298,1654560000"; 
   d="scan'208";a="931144691"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Sep 2022 00:35:13 +0000
Received: from zorba ([10.25.130.54])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 2880ZBqb032497
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 8 Sep 2022 00:35:12 GMT
Date:   Wed, 7 Sep 2022 17:35:10 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Message-ID: <20220908003510.GE4320@zorba>
References: <20220907230709.271889-1-danielwa@cisco.com>
 <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.130.54, [10.25.130.54]
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 06:54:02PM -0500, Frank Rowand wrote:
> On 9/7/22 18:07, Daniel Walker wrote:
> > This warning message shows by default on the vast majority of overlays
> > applied. Despite the text identifying this as a warning it is marked
> > with the loglevel for error. At Cisco we filter the loglevels to only
> > show error messages. We end up seeing this message but it's not really
> > an error.
> > 
> > For this reason it makes sense to demote the message to the warning
> > loglevel.
> > 
> > Cc: xe-linux-external@cisco.com
> > Signed-off-by: Daniel Walker <danielwa@cisco.com>
> > ---
> >  drivers/of/overlay.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index bd8ff4df723d..4ae276ed9a65 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c
> > @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
> >  	}
> >  
> >  	if (!of_node_check_flag(target->np, OF_OVERLAY))
> > -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
> > +		pr_warn("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
> >  		       target->np, new_prop->name);
> >  
> >  	if (ret) {
> 
> NACK
> 
> This is showing a real problem with the overlay.

What's the real problem ?

Daniel
