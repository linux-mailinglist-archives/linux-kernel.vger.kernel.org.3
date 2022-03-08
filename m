Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153BB4D169F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346493AbiCHLuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiCHLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:50:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B22E084;
        Tue,  8 Mar 2022 03:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646740171; x=1678276171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hptAeT1aRWP2UIvZ3fkUSKXBKuDV4uGYtvodri9TAc4=;
  b=fSA7nw4dIwFXAJWNA5QOX5x/1P/ZWKvBzR6j5ASQF8eHw7m1Qz+4OaoQ
   aXuEbCVXIgGsQT6Sa3yT0c/OzkREOSkRr5FK22Ws4GFCQuK4ryLP+8m0h
   82td6G00Btk2LcrHSZzxS5SE9Yf73Li/myZt0KUM/2nZfgU+A4b+MR90P
   9mcnbsguh3CFmTVUHP5F30DW/ncK61CVpwkfzOi8tJoT2PYJH0a1se6JZ
   2ANDGGaw3oOON/pddAau6HWs8rbYifOyvcUIxSpc91OD51s0roy8WdGNg
   BVVWWlItEd+OlaKQnLfbzuiBG2dUQHHM9tco4yKWqfggSsdKFpAt+nz9j
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="252236217"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="252236217"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:49:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="687896769"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Mar 2022 03:49:28 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Mar 2022 13:49:27 +0200
Date:   Tue, 8 Mar 2022 13:49:27 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] usb: typec: add TUSB320xA driver
Message-ID: <YidCx7Vi3ob8vquD@kuha.fi.intel.com>
References: <20220301132010.115258-1-alvin@pqrs.dk>
 <20220301132010.115258-4-alvin@pqrs.dk>
 <YiYYa7GkknJ+CAuL@kuha.fi.intel.com>
 <87lexlcsrj.fsf@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lexlcsrj.fsf@bang-olufsen.dk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 10:17:04PM +0000, Alvin Šipraga wrote:
> Hi Heikki,
> 
> Heikki Krogerus <heikki.krogerus@linux.intel.com> writes:
> 
> > Hi,
> >
> > On Tue, Mar 01, 2022 at 02:20:07PM +0100, Alvin Šipraga wrote:
> >> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> >> 
> >> The TUSB320LA and TUSB320HA (or LAI, HAI) chips are I2C controlled
> >> non-PD Type-C port controllers. They support detection of cable
> >> orientation, port attachment state, and role, including Audio Accessory
> >> and Debug Accessory modes. Add a typec class driver for this family.
> >> 
> >> Note that there already exists an extcon driver for the TUSB320 (a
> >> slightly older revision that does not support setting role preference or
> >> disabling the CC state machine). This driver is loosely based on that
> >> one.
> >
> > This looked mostly OK to me. There is one question below.
> >
> > <snip>
> >
> >> +static int tusb320xa_check_signature(struct tusb320xa *tusb)
> >> +{
> >> +	static const char sig[] = { '\0', 'T', 'U', 'S', 'B', '3', '2', '0' };
> >> +	unsigned int val;
> >> +	int i, ret;
> >> +
> >> +	mutex_lock(&tusb->lock);
> >> +
> >> +	for (i = 0; i < sizeof(sig); i++) {
> >> +		ret = regmap_read(tusb->regmap, sizeof(sig) - 1 - i, &val);
> >> +		if (ret)
> >> +			goto done;
> >> +
> >> +		if (val != sig[i]) {
> >> +			dev_err(tusb->dev, "signature mismatch!\n");
> >> +			ret = -ENODEV;
> >> +			goto done;
> >> +		}
> >> +	}
> >> +
> >> +done:
> >> +	mutex_unlock(&tusb->lock);
> >> +
> >> +	return ret;
> >> +}
> >
> > Couldn't that be done with a single read?
> >
> >         char sig[8];
> >         u64 val;
> >
> >         strcpy(sig, "TUSB320")
> >
> >         mutex_lock(&tusb->lock);
> >
> >         ret = regmap_raw_read(tusb->regmap, 0, &val, sizeof(val));
> >         ...
> >         if (val != cpu_to_le64(*(u64 *)sig)) {
> >         ...
> >
> > Something like that?
> 
> I think it's a bit cryptic - are you sure it's worth it just to save 8
> one-off regmap_read()s? I could also just remove this check... I see it
> mostly as a courtesy to the user in case the I2C address in his device
> tree mistakenly points to some other unsuspecting chip.
> 
> BTW, do you have any feedback on the device tree bindings of this
> series? Rob had some questions and I am not sure that my proposed
> bindings are fully aligned with the typec subsystem expectations. Any
> feedback would be welcome.

I don't think I understand DT well enough to comment. I'm not
completely sure what he's asking..

> I will wait for more comments and send a v2 in ~a week.

thanks,

-- 
heikki
