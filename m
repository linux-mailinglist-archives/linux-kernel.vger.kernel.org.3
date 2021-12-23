Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA99B47E551
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244097AbhLWPDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:03:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:23071 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239868AbhLWPD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640271807; x=1671807807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aD1mewvXbqqunsX5Xqpz33bfhSDk3Xx9zQNCwf7UKxU=;
  b=j/ArrE0qthurwIM91GDQBKzDsT5QTfl5NOWGtq07g9TzIWDvQzn1NBdE
   2PT0oR4+rBZHjwZr3j/fOZJOaooUHHAwsbMpHoNQLRFSGDPpsf3ze87NF
   O2RcAC0kQ1fea+3096DcqOfLM9iHmCqukwx2YUQ8svvEzHZW0+1wrLz+H
   9I/HZQ3+3h/SqGdK6+gXwydDYEh3y91zmBdfh79c8sy3SrmeS98dPdIlf
   XlZKKDgjoWt5IpCKlW1XSEtcq0Etns1Zlw1iK7X+URHQO7ZGzJ9I/5Daj
   oK9O2pkNLBICtybAO/shlEMgBmr34iX8H3Hr9xbYpyrpKZ5KQPq8yR753
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="228134927"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="228134927"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 07:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="614220192"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.147])
  by fmsmga002.fm.intel.com with SMTP; 23 Dec 2021 07:03:19 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 23 Dec 2021 17:03:19 +0200
Date:   Thu, 23 Dec 2021 17:03:19 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        airlied@linux.ie, alexandre.torgue@foss.st.com,
        benjamin.gaignard@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com, marex@denx.de,
        linux-imx@nxp.com, intel-gfx@lists.freedesktop.org,
        tzimmermann@suse.de, s.hauer@pengutronix.de,
        rodrigo.vivi@intel.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, yannick.fertre@foss.st.com,
        linux-kernel@vger.kernel.org, philippe.cornu@foss.st.com,
        mcoquelin.stm32@gmail.com, dmitry.baryshkov@linaro.org,
        shawnguo@kernel.org
Subject: Re: [PATCH v2 1/6] =?iso-8859-1?Q?drm=2Fpl?=
 =?iso-8859-1?Q?ane=3A_Make_format=5Fmod=5Fsupported_truly=A0optional?=
Message-ID: <YcSPt+81fuzteeCu@intel.com>
References: <20211222090552.25972-1-jose.exposito89@gmail.com>
 <20211222090552.25972-2-jose.exposito89@gmail.com>
 <YcRkB7uWyt4EbcZm@intel.com>
 <PIq2EEI7giz2rOuv2cfySbdxwht8AaCye140X5C7NejjXT6kD67E3E28uvg4Ebhob12EJUBtAxGPFNOgZwSWLYEfMtdhRNt3mR8bBGBJmU4=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PIq2EEI7giz2rOuv2cfySbdxwht8AaCye140X5C7NejjXT6kD67E3E28uvg4Ebhob12EJUBtAxGPFNOgZwSWLYEfMtdhRNt3mR8bBGBJmU4=@emersion.fr>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 01:42:32PM +0000, Simon Ser wrote:
> On Thursday, December 23rd, 2021 at 12:56, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> 
> > > -	/* If we can't determine support, just bail */
> > > -	if (!plane->funcs->format_mod_supported)
> > > -		goto done;
> > > -
> > >  	mod = modifiers_ptr(blob_data);
> > >  	for (i = 0; i < plane->modifier_count; i++) {
> > >  		for (j = 0; j < plane->format_count; j++) {
> > > -			if (plane->funcs->format_mod_supported(plane,
> > > +			if (!plane->funcs->format_mod_supported ||
> > > +			    plane->funcs->format_mod_supported(plane,
> > >  							       plane->format_types[j],
> > >  							       plane->modifiers[i])) {
> >
> > So instead of skipping the whole loop you just skip doing anything
> > inside the loop? Can't see how that achieves anything at all.
> 
> No, the check is skipped when the function isn't populated by the driver.

Ah right. So we advertise all modifiers in that case. Looks like
drm_plane_check_pixel_format() does support that model, so seems OK.

Another related thing that might be worth checking is whether
drivers generally do anything to validate the modifiers in
the addfb2 ioctl. Looks like i915 and amdgpu are the only ones
to use drm_any_plane_has_format() for that, so all the other
drivers must either be checking it manually (or they're just
potentially broken when handed unexpected modifiers by evil
userspace).

-- 
Ville Syrjälä
Intel
