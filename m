Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBED94EB525
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiC2VXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiC2VXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:23:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B740208C1F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648588922; x=1680124922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mDcgvX/h6B7v98FYhQ39tPkbP4Y4kBYKg+LfZnynRu8=;
  b=HUyHfwlvKURUhNSYOzjTdd/JdEDIWzsEAWi377/XmvPZhVmTNkrurw+x
   Hz3yugV30U5wv9y+PHNRVTbCHoS1lNxnf11eyJNKvK7gPT+XkVLtG6MHG
   4a9PjWej30qWKU/L1NJ2F9lm4UNEDskGWpeLE/+7lUwj4GpgxjYsPWJQR
   FHuEs7BgtZoSKwXFh+EOI5LTUDUjZxhggvyttAhrjFq2ELQRBrnpmGmYu
   xRGolFUYIAVCzY/lIAdPzoXL4dfnS+i4LzzG4cya+jEdaPrHyoREA0eWS
   MqruBPnWHRir7ChPYVQN+1ilt41KTUkgIA8QNDgnlYmVOQsmsPE4rzJ+f
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284281890"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="284281890"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 14:22:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="639495937"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 14:22:01 -0700
Date:   Tue, 29 Mar 2022 14:24:26 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Muhammad Usama Anjum <musamaanjum@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: Remove redundant else branches.
Message-ID: <20220329212426.GA1171538@alison-desk>
References: <20220329140904.GA3566@ubuntu>
 <20220329200053.GA1170989@alison-desk>
 <CAMWRUK4ti6QxA4JWbG_XwZHwQwWUKYu+HvVHvEBX-k82oaEP6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMWRUK4ti6QxA4JWbG_XwZHwQwWUKYu+HvVHvEBX-k82oaEP6g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:59:52PM -0700, Sevinj Aghayeva wrote:
> Hi Alison,
> 
> Thanks for the feedback! Please see inline.
> 
> On Tue, Mar 29, 2022 at 12:58 PM Alison Schofield <
> alison.schofield@intel.com> wrote:
> 
> > Hi Sevinj,
> >
> > You can do this to make sure your commit msg 'looks' similar to
> > others in the file:
> >
> > $git log --pretty=oneline --abbrev-commit
> >
> > d6ad258ae15d staging: rtl8723bs: Remove redundant else branches.
> > 24e65aac9457 staging: rtl8723bs: remove rf type branching (fourth patch)
> > 167fc30e8e51 staging: rtl8723bs: remove unused macros
> > d7361874468f staging: rtl8723bs: fix camel case in struct wlan_bcn_info
> > 6994aa430368 staging: rtl8723bs: fix camel case in struct ndis_802_11_ssid
> >
> > That tells me the 'Remove' should not start with an uppercase and
> > there should be no period at the end of line. Note that I look at this
> > per patch, because different drivers and subsystems have different
> > conventions. The point is to try to discern the prevailing style,
> > and follow it.
> >
> 
> Got it. The few examples that I saw in other places were using
> grammatically formatted sentences, but I'll take the subsystem conventions
> into account.
> 
> 
> > Please check the get_maintainers instruction in the first patch tutorial.
> > I only got this:
> >
> > $ git show HEAD | perl scripts/get_maintainer.pl --separator ,
> > --nokeywords --nogit --nogit-fallback --norolestats
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> > linux-staging@lists.linux.dev,linux-kernel@vger.kernel.org
> 
> 
> My bad! I ran get_maintainer.pl without those options and got those a lot
> more email addresses.
> 
> 
> >
> >
> >
> > On Tue, Mar 29, 2022 at 07:09:04AM -0700, Sevinj Aghayeva wrote:
> >
> > Please state the 'why' of this patch. ie something like:
> > Adhere to Linux kernel coding style.
> >
> > > This patch fixes the following checkpatch.pl warning:
> > The phrases 'This patch' is frowned upon as unecessarily wordy.
> > Perhaps simply:
> > Reported by checkpatch:
> >
> 
> Okay. I think we should update the https://kernelnewbies.org/PatchPhilosophy
> because I took "This patch..." from there.

Yeah, there's a lot of 'This patch...' and 'Fixes...' and some other
stuff that has fallen out of favor. 
I just made a small edit getting rid of a 'Fixes' subject line.

How about if you update this example:
Subject: [OPW kernel] [PATCH] Staging: rtl8192e: Fix printk() warning style
with your patch right here..once it is done!

Thanks!
Alison

> 
> 
> >
> > You have another patch in flight with similar things to update.
> > Please post a v2 of that one that addresses the feedback given
> > here.
> >
> 
> That one has already landed. Is it okay if I send v2 just for this patch?

Did you see it applied already?

>
> Thanks!
> 
>



> >
> > I thought both patches had good scope in that they addressed multiple
> > instances of the same issue in a single file.
> >
> > Thanks!
> > Alison
> >
> > >
> > > WARNING: else is not generally useful after a break or return
> > >
> > > Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> > > ---
> > >  .../staging/rtl8723bs/core/rtw_ieee80211.c    | 32 ++++++++-----------
> > >  1 file changed, 13 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > > index b449be537376..27de086903e2 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > > +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > > @@ -94,16 +94,14 @@ bool rtw_is_cckratesonly_included(u8 *rate)
> > >
> > >  int rtw_check_network_type(unsigned char *rate, int ratelen, int
> > channel)
> > >  {
> > > -     if (channel > 14) {
> > > +     if (channel > 14)
> > >               return WIRELESS_INVALID;
> > > -     } else { /*  could be pure B, pure G, or B/G */
> > > -             if (rtw_is_cckratesonly_included(rate))
> > > -                     return WIRELESS_11B;
> > > -             else if (rtw_is_cckrates_included(rate))
> > > -                     return  WIRELESS_11BG;
> > > -             else
> > > -                     return WIRELESS_11G;
> > > -     }
> > > +     /* could be pure B, pure G, or B/G */
> > > +     if (rtw_is_cckratesonly_included(rate))
> > > +             return WIRELESS_11B;
> > > +     if (rtw_is_cckrates_included(rate))
> > > +             return WIRELESS_11BG;
> > > +     return WIRELESS_11G;
> > >  }
> > >
> > >  u8 *rtw_set_fixed_ie(unsigned char *pbuf, unsigned int len, unsigned
> > char *source,
> > > @@ -151,11 +149,10 @@ u8 *rtw_get_ie(u8 *pbuf, signed int index, signed
> > int *len, signed int limit)
> > >               if (*p == index) {
> > >                       *len = *(p + 1);
> > >                       return p;
> > > -             } else {
> > > -                     tmp = *(p + 1);
> > > -                     p += (tmp + 2);
> > > -                     i += (tmp + 2);
> > >               }
> > > +             tmp = *(p + 1);
> > > +             p += (tmp + 2);
> > > +             i += (tmp + 2);
> > >               if (i >= limit)
> > >                       break;
> > >       }
> > > @@ -199,9 +196,8 @@ u8 *rtw_get_ie_ex(u8 *in_ie, uint in_len, u8 eid, u8
> > *oui, u8 oui_len, u8 *ie, u
> > >                               *ielen = in_ie[cnt+1]+2;
> > >
> > >                       break;
> > > -             } else {
> > > -                     cnt += in_ie[cnt+1]+2; /* goto next */
> > >               }
> > > +             cnt += in_ie[cnt+1]+2; /* goto next */
> > >       }
> > >
> > >       return target_ie;
> > > @@ -697,9 +693,8 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8
> > *wps_ie, uint *wps_ielen)
> > >                       cnt += in_ie[cnt+1]+2;
> > >
> > >                       break;
> > > -             } else {
> > > -                     cnt += in_ie[cnt+1]+2; /* goto next */
> > >               }
> > > +             cnt += in_ie[cnt+1]+2; /* goto next */
> > >       }
> > >
> > >       return wpsie_ptr;
> > > @@ -748,9 +743,8 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16
> > target_attr_id, u8 *buf_att
> > >                               *len_attr = attr_len;
> > >
> > >                       break;
> > > -             } else {
> > > -                     attr_ptr += attr_len; /* goto next */
> > >               }
> > > +             attr_ptr += attr_len; /* goto next */
> > >       }
> > >
> > >       return target_attr_ptr;
> > > --
> > > 2.25.1
> > >
> > >
> >
> 
> 
> -- 
> 
> Sevinj.Aghayeva
