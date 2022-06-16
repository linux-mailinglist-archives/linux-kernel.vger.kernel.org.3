Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBA654ECAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379151AbiFPVdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379218AbiFPVdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:33:32 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 14:33:31 PDT
Received: from USAT19PA22.eemsg.mail.mil (USAT19PA22.eemsg.mail.mil [214.24.22.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCFF612AB;
        Thu, 16 Jun 2022 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=mail.mil; i=@mail.mil; q=dns/txt; s=EEMSG2021v1a;
  t=1655415211; x=1686951211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DEo/Kl2hiWvMzst9BA79rVasOcb1cnduGVjmoVeD4zY=;
  b=bWnmy2cADLMUBeQ3hEhi6mcF66jPeCrqeANKkFAHzITSNlDXKuAld/MB
   3qxRNgsKUFS6HqYlyyMDmXwPtJJxbs3L2D4W7xKj+gH3wkpHX50mraS5W
   PVgHQbdwBFYu9LiQHeInxSHVGZSKjmj16lY31/yU+g4KhH2ZNvG73NjR4
   SuahQ0CRgVx6Wn2DXqIpoxmqY8LRU8ZlsPqUrU+h5h65X+SlVhUDeLwqU
   /SnbcfU77FdMYTlsqu7P2waIWvtKenWdRdhuVot0ib0GXHPb/ITWoabGo
   zw+OHYsy3ihQvakp9rY623/Y3iMNHZ/SyreMySDY4fE8/nAMQ/ceRTQdp
   g==;
X-EEMSG-check-017: 339600149|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.92,306,1650931200"; 
   d="scan'208";a="339600149"
IronPort-Data: A9a23:75snCawWmrgNjHjGu9V6t+fqxyrEfRIJ4+MujC+fZmUNrF6WrkUHz
 GMdDDyBP/beYGGhKYgiaIizoUMAvpOBnNdjHQZsrS00HyNBpPSeCIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv656yMUOZigHtIQMsacUsxKbVIiGX1JZS5LwbZj2NY22IbhX2thh
 PuqyyHhEA79s9JLGj9Mg06zgEsHUCPa5Vv0FnRnDRx6lAe2e0s9VfrzFonoR5fMebS4K8bhL
 wr1IBFVyUuCl/slIovNfr8W6STmSJaKVeSFoiI+t6RPHnGuqwRqupvXOsbwZm9QpByFssw2+
 e99uLOCFBcOY4Pjp8gCBkww/yFWZcWq+ZfKLXey9MmexE2eKj3pyvRqSkQ3OeX0+M4tWD0Ir
 6VecWtVKEnb3Ipaw5riIgVorsYqKcTweoZZtHBmyTjIFvEgHdbIQrvi4NZZ2HE1h8Qm8fP2P
 JFIN2I3NUiRC/FJEhAJLag7pcv2vVnYch1b9XKFgoA2umeGmWSd15CoarI5YOeiXs9cgkuDj
 njP/nj5BhAccteYzFKt/W+rn+7JkmX5WYsUG5W89/h3kBufy3J7IDEfS1q358K9jUe4c99eJ
 0EI+yEpqO4580nDZvz0RQG5pjijuh8CVttKGsU36Q2A1qvf5APfDW8BJhZBY9wOtck4XzUm2
 1aF2dTzClRHtLyTVGLY9bqOqz62ETYaIHVEZiIeSwYBpd75r+kbihXAR9BsOKK4isH8BTz9h
 TuNqUAWnLIVguYI2r+98FSBhCijzrDNTwgo9kDNV2Opxh12aZTjZIGy71Xfq/FaI+6kokKps
 XQLlo2b4esOVcjLkSWMRKMIHbXBC+u5DQAwSGVHR/EJnwlBMVb6FWyMyFmS/HtUD/s=
IronPort-HdrOrdr: A9a23:dTaBDK+llUsixd1tFPVuk+ACI+orL9Y04lQ7vn2ZESYlFfBxl6
 iV88jzpiWE7gr5P0tQ5OxoWZPwO080mqQFgrX5UY3OYOCighrNEGgA1/qf/9SDIVydygc178
 4JGMJD4Z/LfD1HZK7BkXaF+r0bruVvhZrJuQ6o9RZQpG9RB52IpD0JczpzWncGPDWuK6BJb6
 ah2g==
Received: from edge-mech01.mail.mil ([214.21.130.103])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 16 Jun 2022 21:32:22 +0000
Received: from UMECHPAOE.easf.csd.disa.mil (214.21.130.32) by
 edge-mech01.mail.mil (214.21.130.103) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Thu, 16 Jun 2022 21:32:22 +0000
Received: from UMECHPA68.easf.csd.disa.mil ([169.254.4.207]) by
 UMECHPAOE.easf.csd.disa.mil ([214.21.130.32]) with mapi id 14.03.0513.000;
 Thu, 16 Jun 2022 21:32:22 +0000
From:   "Finlayson, James M CIV (USA)" <james.m.finlayson4.civ@mail.mil>
To:     'Logan Gunthorpe' <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        Song Liu <song@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        "Martin Oliveira" <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        "Finlayson, James M CIV (USA)" <james.m.finlayson4.civ@mail.mil>
Subject: RE: [Non-DoD Source] [PATCH v3 15/15] md/raid5: Increase
 restriction on max segments per request
Thread-Topic: [Non-DoD Source] [PATCH v3 15/15] md/raid5: Increase
 restriction on max segments per request
Thread-Index: AQHYgbYZzZIsZ5fz0kGRNXRewB/NQK1SjPhQ
Date:   Thu, 16 Jun 2022 21:32:21 +0000
Message-ID: <5EAED86C53DED2479E3E145969315A2389D4672D@UMECHPA68.easf.csd.disa.mil>
References: <20220616191945.23935-1-logang@deltatee.com>
 <20220616191945.23935-16-logang@deltatee.com>
In-Reply-To: <20220616191945.23935-16-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [214.21.44.13]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Innocent question from position of ignorance....I see these last 15 check-i=
ns all as performance improvements.   I tend to push hard on mdraid perform=
ance, but have RAID6 needs....are these some optimizations available for RA=
ID6 and are they in process or did I just ask a silly question?

Regards,
Jim Finlayson
US Department of Defense

-----Original Message-----
From: Logan Gunthorpe <logang@deltatee.com>=20
Sent: Thursday, June 16, 2022 3:20 PM
To: linux-kernel@vger.kernel.org; linux-raid@vger.kernel.org; Song Liu <son=
g@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>; Guoqing Jiang <guoqing.jiang@lin=
ux.dev>; Stephen Bates <sbates@raithlin.com>; Martin Oliveira <Martin.Olive=
ira@eideticom.com>; David Sloan <David.Sloan@eideticom.com>; Logan Gunthorp=
e <logang@deltatee.com>
Subject: [Non-DoD Source] [PATCH v3 15/15] md/raid5: Increase restriction o=
n max segments per request

The block layer defaults the maximum segments to 128, which means requests =
tend to get split around the 512KB depending on how many pages can be merge=
d. There's no such restriction in the raid5 code so increase the limit to U=
SHRT_MAX so that larger requests can be sent as one.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c index e48c16bfe657..57=
23a497108a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8005,6 +8005,9 @@ static int raid5_run(struct mddev *mddev)
 		 */
 		blk_queue_max_hw_sectors(mddev->queue,
 			RAID5_MAX_REQ_STRIPES << RAID5_STRIPE_SHIFT(conf));
+
+		/* No restrictions on the number of segments in the request */
+		blk_queue_max_segments(mddev->queue, USHRT_MAX);
 	}
=20
 	if (log_init(conf, journal_dev, raid5_has_ppl(conf)))
--
2.30.2

