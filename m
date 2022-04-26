Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72E450EDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbiDZAgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiDZAgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:36:40 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 17:33:27 PDT
Received: from mx-mail6.airtel.com (mx-mail6.airtel.com [125.18.107.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E934030F79
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=airtel.com; i=@airtel.com; q=dns/txt; s=280115;
  t=1650933208; x=1682469208;
  h=mime-version:content-description:subject:to:from:date:
   reply-to:message-id:content-transfer-encoding;
  bh=WKmU9diLoIViVT+MUJnpfZk9nX1XOEcwuoCLG+q2mSs=;
  b=k7CGbD1z1hdHp7Aulcy+0YzvmkvP6osw4CVM6cR1a5BY/YpeBOxM164z
   mlJR+5IFmBAq/eeIzBcJhugApU3fvQ/4IOceuV/UwB2e+b2lb88NhPQ/W
   yEfjUOq3tfIsTQf8tViW93MwtS/cWhVX7lmemNnUpVxZD0bOrVjo6OHe1
   vv2iP6qHq5twMp2gKdVwH8/XyUdVg9eewcKTU8qveq58vsA65bs6Axjci
   M0TVgzpLg3+jvXGGUH7oV1Lc0lqrgKlJCa75Gxa3+MeTn3ve4nhaxoY2l
   PeflotlZ/K6EKNoL4hHtmtDiBjdmM7kMLLiVVKzlVYC6Bmv5BzxSZ2Wlq
   g==;
IronPort-SDR: ToeSTqqBwaR2rMhBsm6G2xdbKqYzqYroiX0T5x9NxHiNS4BkHwZtQ+ECXRHT92fkwyT3Kv/Jbi
 kdkmmX52r8dw==
IronPort-Data: A9a23:eesfDalvFx4XvIO3DuAyrCHo5gy7JkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIYXGCBOvjeYGOhctB2YY6x/RlQ6MDXz4RhTAI++SA3RC4T+ZvOCOrCIxarNUt+DCFioGGLT
 ik6QoOdRCzhZiKEzvuV3zuIQUBUjclkfJKlYAL/En03FFcMpBsJ00o5wbZl2NMw27BVPivW0
 T/Mi5yGULOa824sWo4kw/rrRMRH5amaVJsw5zTSVNgT1LPsvyB94KE3fMldG0DFrrx8RYZWc
 QphIIaRpQs19z91Yj+sfy2SnkciGtY+NiDW4pZatjTLbrGvaUXe345iXMfwZ3u7hB3Qj9VTx
 Y9T66XrQFd4M6aQkuhaahhXRnQW0a1uoNcrIFCTuNCa91fBb3bn3/RpCinaP6VBoqAqXycfs
 6ZFc1jhbTja7w6y6LOjDOxtndk4IeHiPZkDt3UmxjbcZRojacmdH/6TuIEJh1/cgOhcTPz7V
 8wmMwZvMk3HaSROBmYKEKAHybLAan7XNmcwREiujbE+52XI5AV627XrLNPUYJqBQsATl1vwj
 n7B4239BR8UNdeS4TCI9nalgu7Gmz+9U4t6PLe//LhmiUOS3UQZCRIOUl235/K+jyaWUNtFN
 0U88SM1pKM59UXtQ9/wVlu5vBasrwMfQNdVO+Yh5UeQzLCS7gqEbkAORzNbdMcttM4eSDonz
 FCEhM/oAjopu739YWia87qThT6iMC0NKWJEYyIYJSMe48PqrI0zh1TNR9JqFvftptLwEDD0h
 TuNqUAWnK0aiIsC0bSn/VHBjBqsr4fAQQdz4R/YNkq+9gp8IYO1bomw7VXz7f9fJYmQCF6bs
 z4ZmKC24u0IApillSKIBuEMAfey6p6tNzzHqV9hGt8l9inr4HPLVYBA6zh/fB9BN88FfSSvf
 FTSvwxR+ZYVMXe3K6RxC6qrDMAjy6SmB9XjVf3OaNNBb5xZcQaD+SYofkP493/2gWApnLs7f
 5ycdK6ECH8AAqMhwzu/QuIUy7Qrxwg7xCXSQ579iRW7uZKFbX6QRLstLVKDc6Yw58uspATT7
 sYaNMaQzRhbePPxbzOR8oMJK10Oa38hCvjeq8tNaOefIkxqFXM6DNfOwLwndpYjmrhc/s/C+
 WqmVVJJ4Ev4mGfLLgCDa3YlY7TqNauTtlpiZWpxYxD5nSJ+Ou5D8ZsiSnf+RpF/nMQL8BK+Z
 6BbEylcKpyjkgj6xgk=
IronPort-HdrOrdr: A9a23:5E4HxaynQpjmgfoRR6sPKrPxM+skLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN4QMEtQ4uxoWZPwPE80kKQY3WB/B8bEYOCLghrPEGgA1/qZ/9SDIVyDygc178
 4JHMYOa6yTfD0K6foW+DPZLz9J+qj5zEnCv5am854Cd3ATV0hV1XYGNu/XKDw+eCB2Qb4CUL
 aM7MtOoDStPVwRc8SAH3EAG9POotXa/aiWFSLvU3QciTWmvHeN0vrXAhKY1hARX3dk2rE561
 XIlAT/++GKr+y74gW07R6c071m3P/ajvdTDs2FjcYYbh/2jByzWYhnU7qe+BgoveCU7kowmt
 WkmWZuAy1K0QKRQoiJm2qh5+Cg6kdl15ba8y7SvZI3m720eNo4Y/Ax8L6xPCGpq3bIh+sMoJ
 6j71jpxqa/Mimw7xgVx+K4IC2CxXDE10bLr4Yo/g5iuM0lGfdskbA=
X-IronPort-AV: E=Sophos;i="5.90,289,1643653800"; 
   d="scan'208";a="164315693"
Received: from unknown (HELO DataProtection) ([10.56.9.253])
  by mx-mail6.airtel.com with ESMTP; 26 Apr 2022 06:02:00 +0530
Received: from n1va-pa-dlp06.india.airtel.itm (n1va-pa-dlp06.india.airtel.itm [127.0.0.1])
        by n1va-pa-dlp06.india.airtel.itm (Service) with ESMTP id 011C021E7150;
        Tue, 26 Apr 2022 06:01:49 +0530 (IST)
Received: from [2.56.57.221] (unknown [10.14.136.10])
        by n1va-pa-dlp06.india.airtel.itm (Service) with ESMTP id 5C4C521E7151;
        Tue, 26 Apr 2022 06:01:45 +0530 (IST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Description: Mail message body
Subject: FUNDING
To:     Recipients <ip.misuse@airtel.com>
From:   "khalid Ayad" <ip.misuse@airtel.com>
Date:   Mon, 25 Apr 2022 17:31:52 -0700
Reply-To: office1offices2@gmail.com
Message-Id: <20220426003149.011C021E7150@n1va-pa-dlp06.india.airtel.itm>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day!


I hope your day is going great!


I am a business and financial consultant working in partnership with a larg=
e Global Investor in the Gulf Region.

We have a direct mandate from our Investors to seek new business opportunit=
ies and projects for possible funding and capital financing. Our Investors =
intend to invest in viable ventures or projects which you are currently exe=
cuting or intend to embark upon as a means of expanding their global portfo=
lio in all sectors and industries.

I am open to further discussions on this subject through any medium you dee=
m appropriate.

Thanks and stay safe.
Yours Sincerely
khalid Ayad
***************************************************************************=
***************************************************************************=
*****************
This email and any files transmitted with it are confidential and intended =
solely for the use of the individual or entity to whom they are addressed. =
If you have received this email in error please notify the system manager. =
This message contains confidential information and is intended only for the=
 individual named. If you are not the named addressee you should not dissem=
inate, distribute or copy this e-mail. Please notify the sender immediately=
 by e-mail if you have received this e-mail by mistake and delete this e-ma=
il from your system. If you are not the intended recipient you are notified=
 that disclosing, copying, distributing or taking any action in reliance on=
 the contents of this information is strictly prohibited . The information =
contained in this mail is propriety and strictly confidential.
***************************************************************************=
***************************************************************************=
*****************

