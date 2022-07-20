Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A198857B3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiGTJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiGTJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:23:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FBF474DA;
        Wed, 20 Jul 2022 02:23:27 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K9Jj9c007765;
        Wed, 20 Jul 2022 09:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=D3AIu2wl/MlREtD6aQ7XR1OUkrCUtTWQM8wu2Sd1rpw=;
 b=HZUmBvC9gaV/DVNfbiJIj7AiWa/kkCzNkMq+cTlWadthuCydzKzTcJcxGIMMzXHpmWbO
 m676EL6bbCdQqfhBZIXIU1eeTtwyQZplQY4TzVAlWPncpugkgJhagvvoFXUq8WA10XIK
 8Z1R/b7CMfyFbZjQJOeOIlF2zH5njEQw8D9wiDyDky6RtLXHiMjmtSiY/UHiWclHy3Cs
 TIIlEYckKLfu7nQ55ue9LUlb5v7byIYwab7TUxKh+AAX1jUVV5CmoD/5lqUAEAd95+lo
 LxTe8+TSWuKEGFzPcegud8Z2Ec438xxrGwA2j8ZDgBshP7MtXYWJTodQQx7TkzT9qGwm CA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3heeyq82mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 09:23:22 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26K9NKwT002161;
        Wed, 20 Jul 2022 09:23:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3hbmy8wcrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 09:23:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26K9LVRv23855394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 09:21:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A746AE056;
        Wed, 20 Jul 2022 09:23:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE7C4AE051;
        Wed, 20 Jul 2022 09:23:16 +0000 (GMT)
Received: from osiris (unknown [9.145.148.254])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Jul 2022 09:23:16 +0000 (GMT)
Date:   Wed, 20 Jul 2022 11:23:15 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Jason Wang <wangborong@cdjrlc.com>, svens@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/delay: Fix comment typo
Message-ID: <YtfJgyVQzgkzSouS@osiris>
References: <20220715043610.17229-1-wangborong@cdjrlc.com>
 <Ytb2V3ay5qMY3yt+@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytb2V3ay5qMY3yt+@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GzKpET1ml1XKzbCOIH0EMSP9T9i4gzax
X-Proofpoint-ORIG-GUID: GzKpET1ml1XKzbCOIH0EMSP9T9i4gzax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_04,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=667 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 08:22:15PM +0200, Alexander Gordeev wrote:
> On Fri, Jul 15, 2022 at 12:36:10PM +0800, Jason Wang wrote:
> > The double `that' is duplicated in line 19, remove one.
> > 
> > Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> > ---
> >  arch/s390/lib/delay.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
> > index f7f5adea8940..c32bc8f7c1fd 100644
> > --- a/arch/s390/lib/delay.c
> > +++ b/arch/s390/lib/delay.c
> > @@ -16,7 +16,7 @@ void __delay(unsigned long loops)
> >          /*
> >           * To end the bloody studid and useless discussion about the
> >           * BogoMips number I took the liberty to define the __delay
> > -         * function in a way that that resulting BogoMips number will
> > +         * function in a way that resulting BogoMips number will
> >           * yield the megahertz number of the cpu. The important function
> >           * is udelay and that is done using the tod clock. -- martin.
> >           */
> 
> Applied, thanks!

Ahem :) That should have been actually "fixed" to "that the", instead
of removing the double "that". And by the way, just two lines above is
another obvious typo...

But seriously, the whole comment is entirely outdated and simply
wrong.  We don't use __delay() to calculate the BogoMips number, nor
does the function return a value that correlates with the megahertz
number of the cpu nowadays. It just loops a random time (where the cpu
is free to detect the pointless loop and optimize it away anyway).

So the right thing to do would be to remove the complete comment, and
maybe add a new comment - but please don't apply this patch.
