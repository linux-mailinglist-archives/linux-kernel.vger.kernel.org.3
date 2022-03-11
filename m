Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DFE4D6567
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350110AbiCKPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350043AbiCKPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:55:09 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF6414A6C5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:53:44 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22BEUCEe002318;
        Fri, 11 Mar 2022 09:53:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=b4QiXZG/thFbq+m+ebbSVj3W8CFNFrkYYo6odJwuMpU=;
 b=Dgzd+bcRFHeUaVhrEEADbqve57F45PV/SeoPl8kkk1j98OTVkeDXWX/2YJSN9r6z6jMs
 IUlq2UqLux+UcrgWamyy+CIvk7IzahF7OdyO/9bZqDzJExcgeg5hDEOaZ2wIgHCygDD8
 S0pmXuKwXU2DPzjoLAerSJYEXMU2Z2ILqacDh3J02LH2yVo6jdVX16dT/uNHSfaUr3P7
 eJ2kZzcv5kFd4Jg/zQktr1C+f8MT2JUDnbzXGneM1nmmiPDB5blOLaRcCuaZa83477MU
 IgJWIVz2KCHijgeYHvZzGk7VnRTEpEHWWRA9AIXKVAXE9BoSAS0VKen8qUN5KgJRLX2v uw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3em656rq8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Mar 2022 09:53:16 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Mar
 2022 15:53:15 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 11 Mar 2022 15:53:14 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E5451B1A;
        Fri, 11 Mar 2022 15:53:14 +0000 (UTC)
Date:   Fri, 11 Mar 2022 15:53:14 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
CC:     <dan.carpenter@oracle.com>, <vkoul@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: soc-compress: Change the check for codec_dai
Message-ID: <20220311155314.GK38351@ediswmail.ad.cirrus.com>
References: <20220310030041.1556323-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220310030041.1556323-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: k6M34B6HZjYCISxFO619goEskfvufoYP
X-Proofpoint-GUID: k6M34B6HZjYCISxFO619goEskfvufoYP
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:00:41AM +0800, Jiasheng Jiang wrote:
> It should be better to reverse the check on codec_dai
> and returned early in order to be easier to understand.
> 
> Fixes: de2c6f98817f ("ASoC: soc-compress: prevent the potentially use of null pointer")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
