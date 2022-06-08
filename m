Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60002542CAD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiFHKKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiFHKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:09:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C356FA3B;
        Wed,  8 Jun 2022 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654682045; x=1686218045;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Cd8pbVH0sEmGPZUUgfp1h3i8osc5+Du509bEtizTrWg=;
  b=C6Vcdb/fAd1MkkkHeMs5rlUzdUA//45Ev6PFlA1XtAg+l4swdsR7fn0Z
   vNIifRFcf/pInw/bhcKXBGRa/Uu+Icz9t20PhndfYZ5GbjHmwg1s/Mcpf
   8CEAQBPAp+VoUQeWEl+6Tkh2R5KQQYx4QUTw5AFVJ7QfOH499Gxv8EccA
   FrrpZqrK3UH65JZbmX4nxhf3a/O/hj3oCPEnNzAFFLo7zz2B710Owt/vs
   va502N7B0MlXdVYVk4HuhEVTSrGnWQXuLNXcl45F+bGqJBQ+oerRQ7bgh
   L5GMnLP7YzAu3Z4SwrBf7USpd9U4gSkFSIBr5RAEpYPqznsFe+tdbNuNJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="276866313"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="276866313"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:54:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="636721443"
Received: from bmichals-mobl.ger.corp.intel.com ([10.252.57.131])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:54:03 -0700
Date:   Wed, 8 Jun 2022 12:54:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/36] tty/vt: consolemap: define UNI_* macros for
 constants
In-Reply-To: <ab9bf4c2-48ed-1a14-9788-8a1672e29849@suse.cz>
Message-ID: <dd7830f1-be51-29a-b77-64a5f4c34a6a@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-3-jslaby@suse.cz> <59e0ae93-c7b-2087-75f8-4da0de918250@linux.intel.com> <ab9bf4c2-48ed-1a14-9788-8a1672e29849@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1421660256-1654678483=:1676"
Content-ID: <9d3b502f-879d-19b7-99db-1cce7bf934c@linux.intel.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1421660256-1654678483=:1676
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <94ebc639-5988-436d-3f10-ca604d4f30eb@linux.intel.com>

On Wed, 8 Jun 2022, Jiri Slaby wrote:

> On 07. 06. 22, 15:21, Ilpo Järvinen wrote:
> > On Tue, 7 Jun 2022, Jiri Slaby wrote:
> > 
> > > The code uses constants for sizes of dictionary substructures on many
> > > places. Define 3 macros and use them in the code, so that loop bounds,
> > > local variables and the dictionary always match. (And the loop bounds
> > > are obvious now too.)
> > > 
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > 
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > > -			for (k = 0; k < 64; k++) {
> > > +			for (k = 0; k < UNI_ROW_GLYPHS; k++) {
> > >   				glyph = p2[k];
> > >   				if (glyph >= 0 && glyph < MAX_GLYPH
> > >   					       && q[glyph] < 32)
> > 
> > Probably unrelated to this change but what's that < 32? It seems to appear
> > twice related to the inverse mapping (and you didn't end up naming it).
> 
> That's ascii C0 test _IMO_.

Ok, that's what I though it must be. But then this code seems even more 
odd to me, why it sets the inverse again but only if it's a control 
character...

Maybe this gives some hint why but it's unintelligible to me:
			/* prefer '-' above SHY etc. */
Both that quoted - and soft hyphen (SHY) are >= 32. So it kind of matches 
to what the if does, but it completely fails to explain why preference is 
the different way around with the control chars.

Btw, for set_inverse_transl(), q -> inv rename would still be useful on 
top of the other variable renames.

-- 
 i.
--8323329-1421660256-1654678483=:1676--
