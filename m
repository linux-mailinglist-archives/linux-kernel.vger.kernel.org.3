Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE10A59664D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 02:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiHQAbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 20:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiHQAbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 20:31:04 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDF27755A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 17:31:02 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27H0Ux9I013350;
        Tue, 16 Aug 2022 19:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660696259;
        bh=5UKcfJpDKgD2t102Bdy4CyVh50AWcZFgMufnolMLvIU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=OCBi08HgxvApDFcws2hWkvY7aeNm1fIkDd6/OKeIrgMbg5k3Z4/h7gtxx5j8cmsrf
         6U6Uu24UpCUHHnmaaBKvTgcGzzXgwe+mgoZlSKAyEovOrv43VHqXg8xYHu8gARhs61
         1qqwRGrbS+gRDrqWZ9nS81bz+rU+ut4wY7nIh2YI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27H0UxOm059275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Aug 2022 19:30:59 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 16
 Aug 2022 19:30:58 -0500
Received: from DFLE104.ent.ti.com ([fe80::44c:e883:6f6f:384d]) by
 DFLE104.ent.ti.com ([fe80::44c:e883:6f6f:384d%17]) with mapi id
 15.01.2507.006; Tue, 16 Aug 2022 19:30:58 -0500
From:   "Lu, Kevin" <kevin-lu@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ding, Shenghao" <shenghao-ding@ti.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1 1/1] sound: Add a new kcontrol
Thread-Topic: [EXTERNAL] Re: [PATCH v1 1/1] sound: Add a new kcontrol
Thread-Index: AQHYsZhqy49mQakf3USYLiboHZi2Bq2yOTQQ
Date:   Wed, 17 Aug 2022 00:30:58 +0000
Message-ID: <37c2d0db2f4240fe80ff43504a31ebcd@ti.com>
References: <20220815112715.21617-1-luminlong@139.com>
 <YvvYbkDSodLBkD0R@sirena.org.uk>
In-Reply-To: <YvvYbkDSodLBkD0R@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.160.36]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for your patience to point out my mistakes, It will be helpful for t=
he future patch submitting.
I will take every code change carefully.

Best regards
Kevin

-----Original Message-----
From: Mark Brown <broonie@kernel.org>=20
Sent: Wednesday, August 17, 2022 1:49 AM
To: Kevin Lu <luminlong@139.com>
Cc: linux-kernel@vger.kernel.org; Ding, Shenghao <shenghao-ding@ti.com>; Lu=
, Kevin <kevin-lu@ti.com>
Subject: [EXTERNAL] Re: [PATCH v1 1/1] sound: Add a new kcontrol

On Mon, Aug 15, 2022 at 07:27:15PM +0800, Kevin Lu wrote:
> Add a new kcontrol for phase calib

This looks mostly good now - one small issue below which I'll fix up myself=
 and apply.

Please submit patches using subject lines reflecting the style for the subs=
ystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and mak=
e sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> +	ADCX140_PHASE_CALIB_SWITCH("Adcx140 Phase Calib Switch"),

We wouldn't normally put the CODEC name in the control name, it's not reall=
y relevant to users and if some disambiguation is needed it's usually bette=
r to do it in a board specific way (eg, describing the output the CODEC is =
connected to) using the support ASoC has for adding prefixes.  Better would=
 be "Phase Callibration Switch".
