Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E693533A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiEYJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiEYJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:39:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE8916587;
        Wed, 25 May 2022 02:39:14 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24P8vrrv024850;
        Wed, 25 May 2022 09:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ylJUfpWx3Yxp4kwkfQplma+hP7YJIWMMpB2tnksU+qU=;
 b=jxyGlFp271qyveXDS07cByASuS4gTfe3+2OCeYMVBp/Ry6O0semzTIic1IqIBemRC2mG
 /czhbGn+oo9vExu5gvZG8aOwx5ds94UFaDNoCJmfw8KbkmFW0ZCgzSa51ouNdMpnAaM7
 mYnNxSrHgTjzzFwwKRZolXqzfv0DPLOOqxVBPwe0Lx7JQXKwkh+G/C0RZF1ro207Z+Jp
 x80N9a8hyAtm3VL8/MyjkfPjrhWnN5E7hbaQMMvetLgMd1QZmZHG/wQCXSTQzX3Y34jG
 DLp4MaxG3u95Ue2e3yjcJSA9W8cL0asnj+Eo5bCkJXosgWlaVfTkPGWbKFv1yirMeq0J lA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9fedk9xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 09:39:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24P9cLfe021386;
        Wed, 25 May 2022 09:39:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3g93ux0wmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 09:39:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24P9cCZd27656496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 09:38:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A4DA5204E;
        Wed, 25 May 2022 09:39:03 +0000 (GMT)
Received: from osiris (unknown [9.145.37.53])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id E454C5204F;
        Wed, 25 May 2022 09:39:02 +0000 (GMT)
Date:   Wed, 25 May 2022 11:39:01 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH 0/2] s390: Kconfig: Style cleanups
Message-ID: <Yo35NdfKlGwu5Trd@osiris>
References: <20220520115708.147841-1-juergh@canonical.com>
 <YotWU/E8z2fJaqj7@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YotWU/E8z2fJaqj7@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uFZ_5owwDyhUO9Wp_FPqJ-wmAwLOvPHp
X-Proofpoint-GUID: uFZ_5owwDyhUO9Wp_FPqJ-wmAwLOvPHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_03,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 mlxlogscore=489
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205250046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:39:31AM +0200, Heiko Carstens wrote:
> On Fri, May 20, 2022 at 01:57:06PM +0200, Juerg Haefliger wrote:
> > The majority of the Kconfig files use a single tab for basic indentation
> > and a single tab followed by two whitespaces for help text indentation.
> > Fix the lines that don't follow this convention.
> > 
> > While at it:
> >   - Add trailing comments to endif/endmenu statements for better
> >     readability.
> > 
> > Juerg Haefliger (2):
> >   s390: Kconfig: Fix indentation and add comments
> >   s390: Kconfig.debug: Fix indentation
> > 
> >  arch/s390/Kconfig       | 20 ++++++++++----------
> >  arch/s390/Kconfig.debug | 12 ++++++------
> >  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> Both applied (v2 for the first patch). Thanks!

..and removed both patches again. Please make sure that your email
addresses match. That is: the email address you use for signing off
and the one you use for sending. Right now there is a mismatch when I
apply your patches in "From:" and "Signed-off-by:".

Please resend.
