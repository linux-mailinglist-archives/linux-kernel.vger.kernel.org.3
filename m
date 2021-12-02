Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F41A46605F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356452AbhLBJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:33:13 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39200 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240976AbhLBJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:33:10 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B21RQ3r001056;
        Thu, 2 Dec 2021 03:29:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=wgplOco1gTNLi7j9jA29YuWEbyN1+PaPlyT6/Tq52fk=;
 b=UX5/88zs6ro9ZhZ8Qt7LwzfLMzK9PdpyEvyie+1FDnj9mHvUImyaQ/yFc12eHiQhJ2Ou
 YWOtetu6pH7gCvUJ8BiwlN9PAZXJfPfkiQxbxqVP6nMLb3Fm83s04SZozq2FE3v93Jc2
 zHFTF26t8tXgIgkSB3b8O8MkozHHbc/J8GaXm3iFiS9Wi/ySTkj+/BpXr8sDNd1xmKkG
 OJr6oPvJLhvswEoR8g0sxjS+VrtMZpyM0+9dtOMUA4WAF8PapZzOj2Spr5aL7IMX8g1S
 ppxKuuFS1WJo7u/qOJPTvR4MH2Dblx7ZlnuCwEAGTPFMGnsZ55Oddw6JzW/KGjb+yvwL LQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cp6c89en3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Dec 2021 03:29:34 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 09:29:32 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 2 Dec 2021 09:29:32 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C0D0E2A9;
        Thu,  2 Dec 2021 09:29:32 +0000 (UTC)
Date:   Thu, 2 Dec 2021 09:29:32 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20211202092932.GJ18506@ediswmail.ad.cirrus.com>
References: <20211202082554.2c370ddd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211202082554.2c370ddd@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: MntsE6S0V35gcw73uBRuNkIjdnxBk3KY
X-Proofpoint-GUID: MntsE6S0V35gcw73uBRuNkIjdnxBk3KY
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 08:25:54AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   043c0a6278ca ("firmware: cs_dsp: Move lockdep asserts to avoid potential null pointer")
> 
> Fixes tag
> 
>   Fixes: fb2f364fb5b9 ("firmware: cs_dsp: Add lockdep asserts to interface functions")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 5065cfabec21 ("firmware: cs_dsp: Add lockdep asserts to interface functions")

Sorry yeah that will be my fault, not sure how I managed to stuff
that up, but will try to be more careful.

Thanks,
Charles
