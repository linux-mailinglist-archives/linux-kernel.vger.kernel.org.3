Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2C50A546
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiDUQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiDUQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3624739D;
        Thu, 21 Apr 2022 09:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA5F861D0C;
        Thu, 21 Apr 2022 16:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B061AC385A1;
        Thu, 21 Apr 2022 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650557379;
        bh=gGW2aD1FiS7/o994OIGCeUWbCVF8Zet/5/0xuKOzlak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z1qv8JOuNYeGATk1P16N6jzvaM5CJNIaFkczBUjHLlOqzzOqfHe7Rio7fsMmxC2CM
         pXe9g+UlNnk6AM88R+oAtchjgd8nr4nypdvT6SVilCIJBh5h0cXJfCgBWioJIlDA2+
         7Dmy5h3EkvqhRmP6CeTqCgYMj6HafJSoorqxAxo0=
Date:   Thu, 21 Apr 2022 18:09:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] device-core: Kill the lockdep_mutex
Message-ID: <YmGBwKEGSNqh0x8P@kroah.com>
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055522548.3745911.14298368286915484086.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165055522548.3745911.14298368286915484086.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:33:45AM -0700, Dan Williams wrote:
> Per Peter [1], the lockdep API has native support for all the use cases
> lockdep_mutex was attempting to enable. Now that all lockdep_mutex users
> have been converted to those APIs, drop this lock.
> 
> Link: https://lore.kernel.org/r/Ylf0dewci8myLvoW@hirez.programming.kicks-ass.net [1]
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

YES!!!!!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Nice work.
