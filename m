Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708BA5AE37C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbiIFIw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiIFIwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:52:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A695FBBC;
        Tue,  6 Sep 2022 01:52:22 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMJyy1CdHz687SK;
        Tue,  6 Sep 2022 16:51:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 10:52:20 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 6 Sep
 2022 09:52:19 +0100
Date:   Tue, 6 Sep 2022 09:52:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 03/15] cxl: Unify debug messages when calling
 devm_cxl_add_port()
Message-ID: <20220906095218.0000046c@huawei.com>
In-Reply-To: <Yxb3HQVr5BJzxedj@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-4-rrichter@amd.com>
        <20220831105945.00004668@huawei.com>
        <Yxb3HQVr5BJzxedj@rric.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 09:30:37 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 31.08.22 10:59:45, Jonathan Cameron wrote:
> > On Wed, 31 Aug 2022 10:15:51 +0200
> > Robert Richter <rrichter@amd.com> wrote:
> >   
> > > CXL ports are added in a couple of code paths using
> > > devm_cxl_add_port(). Debug messages are individually generated, but
> > > are incomplete and inconsistent. Change this by moving its generation
> > > to devm_cxl_add_port(). This unifies the messages and reduces code
> > > duplication. Also, generate messages on failure.
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>  
> > 
> > This is one for Dan etc as it is mostly a question of how verbose we want
> > the debug prints to be plus preference for caller or callee being
> > responsible for outputting this sort of message.
> > 
> > Patch looks good to me if we want to make this sort of change.  
> 
> Should I take this as a Reviewed-by?

Hmm. I guess I could go that far as its a policy decision rather than correctness

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Thanks,
> 
> -Robert

