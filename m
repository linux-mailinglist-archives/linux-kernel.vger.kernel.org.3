Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3343851055D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbiDZR2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbiDZR2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:28:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0DE6EC53
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vfRkVAtV3G5IkNtoVB8bVNNwfFhVbkwsBLWlhIjDXaE=; b=HMELUTbDvYMdOqZ/dwe55fiJhS
        tXNK6SdTCKhBcioTz3H1USb8N/qgJERdxRW2GTu4OcDRngvl13JPkFCv3cTgtS6OKYIPDiM14Qto3
        aourlpBKKy7SRqKCMk+z8GSfqouLMiBAPtRK9QkwR04DL88LUS/rtxQl5M7D+/qxvvQjb+gHglHhB
        +PUlHsQB5X8YyIshDqwRRg7u1WAguYV8M068obisavqAnryh1A9Mo6uhD+9hqIFol57dp1/trEK3w
        b+JZCYA3LhpIiuIV9DtXwKDckwG2ZFcnEL8Il6KVa1BnypH6IDYEbXSQUoDDMIK0VICFaTr8AluVF
        jMudo1CQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njOvi-009qwL-OH; Tue, 26 Apr 2022 17:24:50 +0000
Date:   Tue, 26 Apr 2022 18:24:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, pmladek@suse.com, ying.huang@intel.com,
        dave.hansen@intel.com
Subject: Re: [PATCH v2 2/2] mm: Covert sysfs input to bool using kstrtobool()
Message-ID: <Ymgq4gmpWREnWwdh@casper.infradead.org>
References: <20220426170040.65487-1-jvgediya@linux.ibm.com>
 <20220426170040.65487-2-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426170040.65487-2-jvgediya@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:30:40PM +0530, Jagdish Gediya wrote:
> Sysfs input conversion to corrosponding bool value e.g. "false" or "0"
> to false, "true" or "1" to true are currently handled through strncmp
> at multiple places. Use kstrtobool() to convert sysfs input to bool
> value.
> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
