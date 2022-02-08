Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC00A4AD149
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbiBHFzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbiBHFzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:55:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49834C0401DC;
        Mon,  7 Feb 2022 21:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644299732; x=1675835732;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hB8ZdgEN7x8JNCd2gvp3JSiGkG5Iwv8cQ5qYdVOM6l8=;
  b=cSJ7G+XubQ9DFD/BacwZUzIwnChHlZ5r17TmdGKraX8nOvNinPyq6ngE
   nPqP2vavc0KWkt/7sZACLR6/nTobB45utK9cZJjx+s/JDjrYW7BiBbnKo
   3KUSg3xHaFgKLRmbFzg2g3l/rYVyhUpGdjUPB4/lCLis5MCHoSQkEGB21
   uu5SQiNJH9ltdN8xv6/G0Tf3BpN1Pu5OJyKgvQD7UMhfDH0TGs840zuw1
   SpluE/UVl+UBHy89DKPr9KzKA5EMfoQjjqXwdvV++D9bScy9NEfhXb8Gh
   Mfla0DDDfMZfskpnnIB9B2uMqw3/j4KV1DBmbwvldcpHf+OEKssdOqDvH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="249088180"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="249088180"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 21:55:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="567739156"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2022 21:55:31 -0800
Received: from cbaldes-mobl.amr.corp.intel.com (unknown [10.212.183.65])
        by linux.intel.com (Postfix) with ESMTP id 7BAC5580970;
        Mon,  7 Feb 2022 21:55:31 -0800 (PST)
Message-ID: <89dacc424a729c247f6431e393b89dbf8901c4c8.camel@linux.intel.com>
Subject: Re: [PATCH V6 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Joe Perches <joe@perches.com>, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Mon, 07 Feb 2022 21:55:31 -0800
In-Reply-To: <dd4150af8858115c96ebab690182190556669050.camel@perches.com>
References: <20220208005444.487209-1-david.e.box@linux.intel.com>
         <20220208005444.487209-2-david.e.box@linux.intel.com>
         <103681860759d72b1acf712eed334b1d4ef6b7d5.camel@perches.com>
         <d52b50f3b704280e476e60417323c98f45baf54a.camel@linux.intel.com>
         <dd4150af8858115c96ebab690182190556669050.camel@perches.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 21:34 -0800, Joe Perches wrote:
> On Mon, 2022-02-07 at 18:54 -0800, David E. Box wrote:
> > On Mon, 2022-02-07 at 17:40 -0800, Joe Perches wrote:
> > > On Mon, 2022-02-07 at 16:54 -0800, David E. Box wrote:
> > > > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism
> > > > for
> > > > activating additional silicon features. Features are enabled through a
> > > > license activation process.  The SDSi driver provides a per socket,
> > > > sysfs
> > > > attribute interface for applications to perform 3 main provisioning
> > > > functions:
> []
> > > > +static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct
> > > > sdsi_mbox_info
> > > > *info,
> > > > +			      size_t *data_size)
> > > > +{
> > > > +	struct device *dev = priv->dev;
> > > > +	u32 total, loop, eom, status, message_size;
> > > []
> > > > +		if (packet_size > SDSI_SIZE_MAILBOX) {
> > > > +			dev_err(dev, "Packet size to large\n");
> > > 
> > > too
> > 
> > Sorry, I'm missing the question here. If it's whether packet_size could also
> > not
> > be a multiple of sizeof(u64) the answer here is yes. But I don't see how
> > that
> > matters. packet_size is a value read from the hardware. This is just a
> > sanity
> > check.
> 
> just a to/too typo.
> 
> "Packet size too large\n"

Doh!

> 
> 

