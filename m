Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D564AD11D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347013AbiBHFiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347038AbiBHFif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:38:35 -0500
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D9FC03E968;
        Mon,  7 Feb 2022 21:34:50 -0800 (PST)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 3704080D59;
        Tue,  8 Feb 2022 05:34:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 8911B20024;
        Tue,  8 Feb 2022 05:34:23 +0000 (UTC)
Message-ID: <dd4150af8858115c96ebab690182190556669050.camel@perches.com>
Subject: Re: [PATCH V6 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
From:   Joe Perches <joe@perches.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Mon, 07 Feb 2022 21:34:22 -0800
In-Reply-To: <d52b50f3b704280e476e60417323c98f45baf54a.camel@linux.intel.com>
References: <20220208005444.487209-1-david.e.box@linux.intel.com>
         <20220208005444.487209-2-david.e.box@linux.intel.com>
         <103681860759d72b1acf712eed334b1d4ef6b7d5.camel@perches.com>
         <d52b50f3b704280e476e60417323c98f45baf54a.camel@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9bmhhg7au4o3rkbkfsrjtm3ti5u7dj3q
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 8911B20024
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18nGjmqsA11IvQ+pY/sUSKZek1OHKssEwQ=
X-HE-Tag: 1644298463-572210
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 18:54 -0800, David E. Box wrote:
> On Mon, 2022-02-07 at 17:40 -0800, Joe Perches wrote:
> > On Mon, 2022-02-07 at 16:54 -0800, David E. Box wrote:
> > > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > > activating additional silicon features. Features are enabled through a
> > > license activation process.  The SDSi driver provides a per socket, sysfs
> > > attribute interface for applications to perform 3 main provisioning
> > > functions:
[]
> > > +static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info
> > > *info,
> > > +			      size_t *data_size)
> > > +{
> > > +	struct device *dev = priv->dev;
> > > +	u32 total, loop, eom, status, message_size;
> > []
> > > +		if (packet_size > SDSI_SIZE_MAILBOX) {
> > > +			dev_err(dev, "Packet size to large\n");
> > 
> > too
> 
> Sorry, I'm missing the question here. If it's whether packet_size could also not
> be a multiple of sizeof(u64) the answer here is yes. But I don't see how that
> matters. packet_size is a value read from the hardware. This is just a sanity
> check.

just a to/too typo.

"Packet size too large\n"


