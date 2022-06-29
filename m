Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE18E55FAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiF2Ihh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiF2Ihb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:37:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F93C721
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656491851; x=1688027851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AyjMVTaQTJCbb9rBYdh6t7GNExFz5BIYwoEuevlJ+Cg=;
  b=ZltiPlY0wyup6akN1PbwUcV73Z8qcTyPtGb/Dq5sePRAPmWsJWqC0TSe
   70w760zXpkfBMWR4rn2qryI+mcrYxsqIU5+p9mRvPYEHiHA//Wp/Zgy1j
   vBxxSUULKGNQPaMEQ2jmNh9j2Exb40OKag1SdSWbRh+lsutaao9sgC7Qj
   GKDyccW65Dgo5o7aFaNsdKHHBHTsSwbtdmxCHM337mnyALPs34M9B7SM1
   1iso9TcNRECR28AvRwpzsGCyZ6ocrV0pJy9Q3wrQVrv6iO6JdDpSh3sCE
   TJc52XR5+5vZOIMxIjdphJtL62tnQZrJYFQ1zTAyOfc4s41fBNWerUc9x
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="283066558"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="283066558"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 01:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="588228562"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 01:37:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 01:37:13 -0700
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15]) by
 ORSMSX602.amr.corp.intel.com ([10.22.229.15]) with mapi id 15.01.2308.027;
 Wed, 29 Jun 2022 01:37:13 -0700
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Tvrtko Ursulin" <tvrtko.ursulin@linux.intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 13/14] mei: debugfs: add pxp mode to devstate in
 debugfs
Thread-Topic: [PATCH v3 13/14] mei: debugfs: add pxp mode to devstate in
 debugfs
Thread-Index: AQHYii6cshzBS1Jzdke8w99Tn+SqLa1mD+iw
Date:   Wed, 29 Jun 2022 08:37:13 +0000
Message-ID: <c23228be48c0416fbec7937c6008a204@intel.com>
References: <20220619133721.523546-1-alexander.usyskin@intel.com>
 <20220619133721.523546-14-alexander.usyskin@intel.com>
 <Yrm4aZa4y6nwJBva@kroah.com>
In-Reply-To: <Yrm4aZa4y6nwJBva@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Sun, Jun 19, 2022 at 04:37:20PM +0300, Alexander Usyskin wrote:
> > From: Tomas Winkler <tomas.winkler@intel.com>
> >
> > CC: Vitaly Lubart <vitaly.lubart@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>=20
> We can not take patches without any changelog text, you know this :(

Okay, will add some more info.=20
>=20
> > ---
> >  drivers/misc/mei/debugfs.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
> > index 1ce61e9e24fc..4074fec866a6 100644
> > --- a/drivers/misc/mei/debugfs.c
> > +++ b/drivers/misc/mei/debugfs.c
> > @@ -86,6 +86,20 @@ static int mei_dbgfs_active_show(struct seq_file
> > *m, void *unused)  }  DEFINE_SHOW_ATTRIBUTE(mei_dbgfs_active);
> >
> > +static const char *mei_dev_pxp_mode_str(enum mei_dev_pxp_mode
> state)
> > +{ #define MEI_PXP_MODE(state) case MEI_DEV_PXP_##state: return
> #state
> > +	switch (state) {
> > +	MEI_PXP_MODE(DEFAULT);
> > +	MEI_PXP_MODE(INIT);
> > +	MEI_PXP_MODE(SETUP);
> > +	MEI_PXP_MODE(READY);
>=20
> Just spell out the case and return lines, don't create macros for no good
> reason please.

We use those print macros paradigm consistently int the code, the macro has=
 a very limited scope.
We are aware of wrong sides of macros but this just little of synthetic sug=
ar  no some wild usage.
We believe it helps readability, and it keeps the code consistent.

Other usages:

hbm.c:#define MEI_HBM_STATUS(status) case MEI_HBMS_##status: return #status
hbm.c:#define MEI_CL_CS(status) case MEI_CL_CONN_##status: return #status
hbm.c:#define MEI_HBM_STATE(state) case MEI_HBM_##state: return #state
init.c:#define MEI_DEV_STATE(state) case MEI_DEV_##state: return #state
init.c:#define MEI_PG_STATE(state) case MEI_PG_##state: return #state


Thanks
Tomas

